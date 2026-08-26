extends Node3D

@onready var floor_grid_map: GridMap = $"../FloorGridMap"
@onready var building_grid_map: GridMap = $"../BuildingGridMap"
@onready var prop_grid_map: GridMap = $"../PropGridMap"

enum Cell { VOID, EMPTY, ROAD, SIDEWALK, GRASS, BUILDING }

@export var seed_value := 0
@export var random_seed := true
@export_range(4, 40) var city_size := 14
@export_range(1, 4) var road_branching := 2
@export_range(0.0, 1.0, 0.05) var building_density := 0.85
@export_range(0.0, 1.0, 0.05) var tall_buildings := 0.3
@export_range(0.0, 1.0, 0.05) var park_probability := 0.35
@export_range(0.0, 1.0, 0.05) var tree_density := 0.6

@export_group("Scene objects")
@export var protected_objects: Array[Node3D] = []
@export_range(0, 4) var keep_clear := 1

var max_run := 8
var bend_chance := 0.45
var lot_max_w := 4
var lot_max_h := 3
var building_facing := "0"
const MARGIN := 2
const DIRS := [Vector2i(0, -1), Vector2i(1, 0), Vector2i(0, 1), Vector2i(-1, 0)]

const N := 1
const E := 2
const S := 4
const W := 8
const FACE := {N: 270.0, E: 0.0, S: 90.0, W: 180.0}
const CORNER := {3: 270.0, 6: 0.0, 12: 90.0, 9: 180.0}

const SIDEWALK_TILE := "14_concrete"
const GRASS_TILE := "12_grass"
const LAMP_CHANCE := 0.08

const TREE_TILES := ["01_green_large", "02_green_medium", "03_green_small", "04_green_tiny",
	"05_orange_large", "06_orange_medium", "07_orange_small", "08_orange_tiny",
	"09_blue_large", "10_blue_medium", "11_blue_small", "12_blue_tiny"]
const LAMP_TILES := ["32_lamp", "33_lamp", "34_lamp"]

const BUILDINGS := {
	"blue":   {"corner": ["01_blue_corner"], "straight": ["03_blue_straight"],
		"low": ["02_blue_short"], "tall": ["04_blue_tall"]},
	"brown":  {"corner": ["05_brown_corner"], "straight": ["07_brown_straight"],
		"low": ["06_brown_half"], "tall": ["08_brown_tall"]},
	"gray":   {"corner": ["09_gray_corner", "11_gray_half_corner"], "straight": ["12_gray_straight"],
		"low": ["10_gray_half"], "tall": []},
	"green":  {"corner": [], "straight": ["15_green_straight"],
		"low": ["13_green_half", "14_green_short"], "tall": ["16_green_tall"]},
	"orange": {"corner": ["17_orange_corner"], "straight": ["19_orange_straight"],
		"low": ["18_orange_inset"], "tall": ["20_orange_tall"]},
	"red":    {"corner": ["21_red_corner"], "straight": [],
		"low": ["22_red_half", "23_red_short"], "tall": ["24_red_tall"]},
	"yellow": {"corner": ["25_yellow_corner"], "straight": ["28_yellow_straight"],
		"low": ["27_yellow_half"], "tall": [], "deadend": ["26_yellow_deadend"]},
}

const FALLBACK := {
	"corner": ["corner", "straight", "low", "tall"],
	"straight": ["straight", "low", "tall", "corner"],
	"low": ["low", "straight", "tall", "corner"],
	"tall": ["tall", "straight", "low", "corner"],
	"deadend": ["deadend", "corner", "low", "straight"],
}

const PARKS := {
	"small": [
		[{"n": "10_grass", "r": 270}, {"n": "10_grass", "r": 180}],
		[{"n": "10_grass", "r": 0},   {"n": "10_grass", "r": 90}],
	],
	"medium": [
		[{"n": "10_grass", "r": 270}, {"n": "10_grass", "r": 180}],
		[{"n": "09_grass", "r": 180}, {"n": "09_grass", "r": 0}],
		[{"n": "10_grass", "r": 0},   {"n": "10_grass", "r": 90}],
	],
	"right_corner": [
		[null, {"n": "13_grass", "r": 180}],
		[{"n": "13_grass", "r": 270}, {"n": "11_grass", "r": 90}],
	],
	"big": [
		[{"n": "10_grass", "r": 270}, {"n": "10_grass", "r": 180}, null, null],
		[{"n": "09_grass", "r": 180}, {"n": "07_grass", "r": 180}, {"n": "09_grass", "r": 90}, {"n": "10_grass", "r": 180}],
		[{"n": "10_grass", "r": 0}, {"n": "09_grass", "r": 270}, {"n": "09_grass", "r": 270}, {"n": "10_grass", "r": 90}],
	],
}

var rng := RandomNumberGenerator.new()
var grid: Array = []
var roads: Array = []
var park_tiles := {}
var protected := {}
var required: Array = []
var colour_of := {}
var size := 0
var origin := Vector2i.ZERO
var target_low := Vector2i.ZERO
var target_high := Vector2i.ZERO
var extra_points: Array = []
var covered: Array = []

func _ready() -> void:
	build()

func build() -> void:
	if random_seed:
		seed_value = randi() % 1000000
	generate_city(seed_value, extra_points)

func protected_points() -> Array:
	var points: Array = []
	for node in protected_objects:
		if not is_instance_valid(node):
			continue
		points.append(node.global_position)
		for child in node.get_children():
			if child is Node3D:
				points.append(child.global_position)
	for item in extra_points:
		if item is Node3D:
			points.append(item.global_position)
		elif item is Vector3:
			points.append(item)
	return points

func generate_city(use_seed: int, keep_out: Array = []) -> void:
	rng.seed = use_seed
	extra_points = keep_out
	setup_grid()

	floor_grid_map.clear()
	building_grid_map.clear()
	prop_grid_map.clear()

	grow_roads()
	spread_city()
	fill_gaps()
	protect_cells()
	make_parks()
	plan_lots()
	draw_floor()
	draw_props()

func setup_grid() -> void:
	var points := protected_points()
	var low := Vector2i.ZERO
	var high := Vector2i.ZERO
	var first := true
	for world_pos in points:
		var c := gridmap_cell(world_pos)
		if first:
			low = c
			high = c
			first = false
		else:
			low.x = mini(low.x, c.x)
			low.y = mini(low.y, c.y)
			high.x = maxi(high.x, c.x)
			high.y = maxi(high.y, c.y)

	low -= Vector2i(city_size, city_size)
	high += Vector2i(city_size, city_size)

	var pad := road_branching + MARGIN + 1
	var needed: Vector2i = high - low + Vector2i(1, 1) + Vector2i(pad, pad) * 2
	size = maxi(needed.x, needed.y)
	origin = Vector2i(pad, pad) - low
	target_low = low + origin
	target_high = high + origin

	grid = []
	covered = []
	for x in size:
		var column := []
		column.resize(size)
		column.fill(Cell.VOID)
		grid.append(column)
		var flags := []
		flags.resize(size)
		flags.fill(false)
		covered.append(flags)

	roads.clear()
	park_tiles.clear()
	protected.clear()
	colour_of.clear()

	required.clear()
	for world_pos in points:
		var p := world_to_cell(world_pos)
		if in_map(p):
			required.append(p)

func shuffled(list: Array) -> Array:
	var out := list.duplicate()
	for i in range(out.size() - 1, 0, -1):
		var j := rng.randi() % (i + 1)
		var swap = out[i]
		out[i] = out[j]
		out[j] = swap
	return out

func gridmap_cell(world_pos: Vector3) -> Vector2i:
	var c := floor_grid_map.local_to_map(floor_grid_map.to_local(world_pos))
	return Vector2i(c.x, c.z)

func world_to_cell(world_pos: Vector3) -> Vector2i:
	return gridmap_cell(world_pos) + origin

func to_gridmap(p: Vector2i) -> Vector3i:
	return Vector3i(p.x - origin.x, 0, p.y - origin.y)

func in_map(p: Vector2i) -> bool:
	return p.x >= MARGIN and p.x < size - MARGIN and p.y >= MARGIN and p.y < size - MARGIN

func in_target(p: Vector2i) -> bool:
	return (p.x >= target_low.x and p.x <= target_high.x
		and p.y >= target_low.y and p.y <= target_high.y)

func is_road(p: Vector2i) -> bool:
	return in_map(p) and grid[p.x][p.y] == Cell.ROAD

func degree(p: Vector2i) -> int:
	var count := 0
	for d in DIRS:
		if is_road(p + d):
			count += 1
	return count

func is_junction(p: Vector2i) -> bool:
	return is_road(p) and degree(p) >= 3

func next_to_junction(p: Vector2i) -> bool:
	for d in DIRS:
		if is_junction(p + d):
			return true
	return false

func can_branch(p: Vector2i) -> bool:
	return degree(p) <= 2 and not next_to_junction(p)

func road_is_near(p: Vector2i) -> bool:
	return in_map(p) and covered[p.x][p.y]

func mark_covered(p: Vector2i) -> void:
	for dx in range(-road_branching, road_branching + 1):
		for dz in range(-road_branching, road_branching + 1):
			if absi(dx) + absi(dz) > road_branching:
				continue
			var q: Vector2i = p + Vector2i(dx, dz)
			if in_map(q):
				covered[q.x][q.y] = true

func find_gaps() -> Array:
	var gaps: Array = []
	for x in size:
		for z in size:
			var p := Vector2i(x, z)
			if in_map(p) and in_target(p) and not road_is_near(p):
				gaps.append(p)
	return gaps

func keep_road(cells: Array) -> bool:
	for c in cells:
		var p: Vector2i = c
		grid[p.x][p.y] = Cell.ROAD

	for c in cells:
		var p: Vector2i = c
		for dx in range(-1, 2):
			for dz in range(-1, 2):
				var q: Vector2i = p + Vector2i(dx, dz)
				if not is_road(q):
					continue
				if is_junction(q) and next_to_junction(q):
					return undo_road(cells)
				if (is_road(q + Vector2i(1, 0)) and is_road(q + Vector2i(0, 1))
						and is_road(q + Vector2i(1, 1))):
					return undo_road(cells)

	for c in cells:
		roads.append(c)
		mark_covered(c)
	return true

func undo_road(cells: Array) -> bool:
	for c in cells:
		var p: Vector2i = c
		grid[p.x][p.y] = Cell.VOID
	return false

func best_start(target: Vector2i) -> Vector2i:
	var best := Vector2i(-1, -1)
	var best_distance := 1 << 30
	var step := maxi(1, roads.size() / 150)
	var i := rng.randi() % step
	while i < roads.size():
		var p: Vector2i = roads[i]
		i += step
		if not can_branch(p):
			continue
		var d: int = absi(p.x - target.x) + absi(p.y - target.y)
		if d < best_distance:
			best_distance = d
			best = p
	return best

func road_towards(target: Vector2i) -> bool:
	var start := best_start(target)
	if start.x < 0:
		return false

	var current := start
	var cells: Array = []
	var used := {}

	for step in max_run:
		var to_target: Vector2i = target - current
		if absi(to_target.x) + absi(to_target.y) <= road_branching:
			break

		var straight: Vector2i
		var sideways: Vector2i
		if absi(to_target.x) > absi(to_target.y):
			straight = Vector2i(signi(to_target.x), 0)
			sideways = Vector2i(0, 1 if to_target.y >= 0 else -1)
		else:
			straight = Vector2i(0, signi(to_target.y))
			sideways = Vector2i(1 if to_target.x >= 0 else -1, 0)

		var direction: Vector2i = sideways if rng.randf() < bend_chance else straight
		var next: Vector2i = current + direction
		if not in_map(next) or grid[next.x][next.y] == Cell.ROAD or used.has(next):
			break

		cells.append(next)
		used[next] = true
		current = next

	if cells.size() < 2:
		return false
	return keep_road(cells)

func grow_roads() -> void:
	var start := Vector2i(size / 2, size / 2)
	grid[start.x][start.y] = Cell.ROAD
	roads.append(start)
	mark_covered(start)

	for round_number in 200:
		var gaps := find_gaps()
		if gaps.size() == 0:
			return
		var progress := false
		var attempts := 0
		for g in shuffled(gaps):
			var target: Vector2i = g
			if road_is_near(target):
				continue
			if road_towards(target):
				progress = true
			attempts += 1
			if attempts >= 300:
				break
		if not progress:
			return

func spread_city() -> void:
	for c in roads:
		var p: Vector2i = c
		for dx in range(-road_branching, road_branching + 1):
			for dz in range(-road_branching, road_branching + 1):
				if absi(dx) + absi(dz) > road_branching:
					continue
				var q: Vector2i = p + Vector2i(dx, dz)
				if in_map(q) and grid[q.x][q.y] == Cell.VOID:
					grid[q.x][q.y] = Cell.EMPTY

func fill_gaps() -> void:
	for pass_number in road_branching + 2:
		var filled := 0
		for g in find_gaps():
			var p: Vector2i = g
			if grid[p.x][p.y] != Cell.VOID:
				continue
			for d in DIRS:
				var n: Vector2i = p + d
				if in_map(n) and grid[n.x][n.y] != Cell.VOID:
					grid[p.x][p.y] = Cell.EMPTY
					filled += 1
					break
		if filled == 0:
			return

func protect_cells() -> void:
	for c in required:
		var p: Vector2i = c
		for dx in range(-keep_clear, keep_clear + 1):
			for dz in range(-keep_clear, keep_clear + 1):
				var q: Vector2i = p + Vector2i(dx, dz)
				if not in_map(q):
					continue
				if grid[q.x][q.y] == Cell.VOID:
					grid[q.x][q.y] = Cell.EMPTY
				protected[q] = true

func find_blocks(state: int) -> Array:
	var seen := {}
	var blocks: Array = []
	for x in size:
		for z in size:
			var start := Vector2i(x, z)
			if seen.has(start) or grid[x][z] != state:
				continue
			var block: Array = []
			var to_visit: Array = [start]
			seen[start] = true
			while to_visit.size() > 0:
				var p: Vector2i = to_visit.pop_back()
				block.append(p)
				for d in DIRS:
					var n: Vector2i = p + d
					if n.x < 0 or n.y < 0 or n.x >= size or n.y >= size:
						continue
					if seen.has(n) or grid[n.x][n.y] != state:
						continue
					seen[n] = true
					to_visit.append(n)
			blocks.append(block)
	return blocks

func park_fits(shape: Array, corner_cell: Vector2i) -> bool:
	var rows := shape.size()
	var cols: int = shape[0].size()
	for r in rows:
		for c in cols:
			var p: Vector2i = corner_cell + Vector2i(c, r)
			if not in_map(p) or protected.has(p) or grid[p.x][p.y] != Cell.EMPTY:
				return false
	for r in range(-1, rows + 1):
		for c in range(-1, cols + 1):
			var p: Vector2i = corner_cell + Vector2i(c, r)
			if in_map(p) and grid[p.x][p.y] == Cell.GRASS:
				return false
	return true

func stamp_park(shape: Array, corner_cell: Vector2i) -> void:
	for r in shape.size():
		for c in shape[0].size():
			var p: Vector2i = corner_cell + Vector2i(c, r)
			var tile = shape[r][c]
			if tile == null:
				grid[p.x][p.y] = Cell.SIDEWALK
			else:
				grid[p.x][p.y] = Cell.GRASS
				park_tiles[p] = tile

func make_parks() -> void:
	var free_cells: Array = []
	for x in size:
		for z in size:
			if grid[x][z] == Cell.EMPTY:
				free_cells.append(Vector2i(x, z))
	if free_cells.size() == 0:
		return

	var tries := int(free_cells.size() * park_probability * 0.3)
	for i in tries:
		var anchor: Vector2i = free_cells[rng.randi() % free_cells.size()]
		var order := ["big", "medium", "small", "right_corner"]
		if rng.randf() < 0.5:
			order = ["big", "medium", "right_corner", "small"]
		for shape_name in order:
			var shape: Array = PARKS[shape_name]
			if park_fits(shape, anchor):
				stamp_park(shape, anchor)
				break

func space_for(corner_cell: Vector2i, free: Dictionary, limit: int,
		step: Vector2i, width: int) -> int:
	var n := 0
	while n < limit:
		for i in width:
			var across := Vector2i(step.y, step.x)
			if not free.has(corner_cell + step * n + across * i):
				return n
		n += 1
	return n

func split_into_plots(block: Array) -> Array:
	var free := {}
	for c in block:
		free[c] = true

	var ordered := block.duplicate()
	ordered.sort_custom(func(a, b): return a.y < b.y if a.y != b.y else a.x < b.x)

	var plots: Array = []
	for entry in ordered:
		var corner_cell: Vector2i = entry
		if not free.has(corner_cell):
			continue

		var room_across := space_for(corner_cell, free, lot_max_w + 1, Vector2i(1, 0), 1)
		var w: int = mini(rng.randi_range(1, lot_max_w), room_across)
		if room_across - w == 1:
			w = room_across
		w = maxi(w, 1)

		var room_down := space_for(corner_cell, free, lot_max_h + 1, Vector2i(0, 1), w)
		var h: int = mini(rng.randi_range(1, lot_max_h), room_down)
		if room_down - h == 1:
			h = room_down
		h = maxi(h, 1)

		for dx in w:
			for dz in h:
				free.erase(corner_cell + Vector2i(dx, dz))
		plots.append(Rect2i(corner_cell, Vector2i(w, h)))
	return plots

func plot_faces_road(plot: Rect2i) -> bool:
	for dx in range(-1, plot.size.x + 1):
		for dz in range(-1, plot.size.y + 1):
			if dx >= 0 and dx < plot.size.x and dz >= 0 and dz < plot.size.y:
				continue
			if is_road(plot.position + Vector2i(dx, dz)):
				return true
	return false

func plot_sides(p: Vector2i, plot: Rect2i) -> int:
	var sides := 0
	if p.y == plot.position.y:
		sides |= N
	if p.x == plot.position.x + plot.size.x - 1:
		sides |= E
	if p.y == plot.position.y + plot.size.y - 1:
		sides |= S
	if p.x == plot.position.x:
		sides |= W
	return sides

func count_sides(sides: int) -> int:
	var n := 0
	for bit in [N, E, S, W]:
		if sides & bit:
			n += 1
	return n

func facing(sides: int) -> float:
	if count_sides(sides) == 1:
		return FACE[sides]
	if CORNER.has(sides):
		return CORNER[sides]
	for pair in CORNER:
		if (sides & pair) == pair:
			return CORNER[pair]
	return FACE[E]

func shape_for(sides: int, height: String) -> String:
	var n := count_sides(sides)
	if n == 4:
		return "deadend"
	if n == 3 or (n == 2 and CORNER.has(sides)):
		return "corner"
	if n == 0:
		return "tall"
	return height

func random_height() -> String:
	if rng.randf() < tall_buildings:
		return "tall"
	return "straight" if rng.randf() < 0.5 else "low"

func colours_with_height(height: String) -> Array:
	var options: Array = []
	for colour in BUILDINGS:
		var list: Array = BUILDINGS[colour].get(height, [])
		if list.size() > 0:
			options.append(colour)
	return options

func plot_colour(plot: Rect2i, height: String) -> String:
	var options := colours_with_height(height)
	if options.size() == 0:
		options = BUILDINGS.keys()

	var taken := {}
	for dx in range(-1, plot.size.x + 1):
		for dz in range(-1, plot.size.y + 1):
			if dx >= 0 and dx < plot.size.x and dz >= 0 and dz < plot.size.y:
				continue
			var c: Vector2i = plot.position + Vector2i(dx, dz)
			if colour_of.has(c):
				taken[colour_of[c]] = true

	var free_colours: Array = []
	for colour in options:
		if not taken.has(colour):
			free_colours.append(colour)
	if free_colours.size() == 0:
		free_colours = options
	return free_colours[rng.randi() % free_colours.size()]

func pick_building(colour: String, shape: String) -> String:
	var set_for_colour: Dictionary = BUILDINGS.get(colour, {})
	for option in FALLBACK.get(shape, [shape]):
		var list: Array = set_for_colour.get(option, [])
		if list.size() > 0:
			return list[rng.randi() % list.size()]
	return ""

func plan_lots() -> void:
	var library := building_grid_map.mesh_library

	for b in find_blocks(Cell.EMPTY):
		for entry in split_into_plots(b):
			var plot: Rect2i = entry

			if not plot_faces_road(plot) or rng.randf() > building_density:
				continue

			var height := random_height()
			var colour := plot_colour(plot, height)

			for dx in plot.size.x:
				for dz in plot.size.y:
					var p: Vector2i = plot.position + Vector2i(dx, dz)
					if grid[p.x][p.y] != Cell.EMPTY or protected.has(p):
						continue
					var sides := plot_sides(p, plot)
					var tile_name := pick_building(colour, shape_for(sides, height))
					var id := tile_id(library, tile_name)
					if id == -1:
						continue
					building_grid_map.set_cell_item(to_gridmap(p), id,
						rotation_index(building_grid_map,
							-(facing(sides) + float(building_facing))))
					colour_of[p] = colour
					grid[p.x][p.y] = Cell.BUILDING

	for x in size:
		for z in size:
			if grid[x][z] == Cell.EMPTY:
				grid[x][z] = Cell.SIDEWALK

func road_sides(p: Vector2i) -> int:
	var sides := 0
	if is_road(p + Vector2i(0, -1)):
		sides |= N
	if is_road(p + Vector2i(1, 0)):
		sides |= E
	if is_road(p + Vector2i(0, 1)):
		sides |= S
	if is_road(p + Vector2i(-1, 0)):
		sides |= W
	return sides

func road_tile(sides: int) -> Dictionary:
	match sides:
		1: return {"n": "32_road2", "r": 270}
		2: return {"n": "32_road2", "r": 0}
		4: return {"n": "32_road2", "r": 90}
		8: return {"n": "32_road2", "r": 180}
		5: return {"n": "01_road", "r": 0}
		10: return {"n": "01_road", "r": 90}
		3: return {"n": "04_road", "r": 270}
		6: return {"n": "04_road", "r": 0}
		9: return {"n": "04_road", "r": 180}
		12: return {"n": "04_road", "r": 90}
		7: return {"n": "05_road", "r": 0}
		11: return {"n": "05_road", "r": 270}
		13: return {"n": "05_road", "r": 180}
		14: return {"n": "05_road", "r": 90}
		15: return {"n": "06_road", "r": 0}
	return {"n": "", "r": 0}

func tile_id(library: MeshLibrary, tile_name: String) -> int:
	if library == null or tile_name == "":
		return -1
	var id := library.find_item_by_name(tile_name)
	if id == -1:
		push_error("No tile named: " + tile_name)
	return id

func rotation_index(map: GridMap, degrees: float) -> int:
	return map.get_orthogonal_index_from_basis(Basis(Vector3.UP, deg_to_rad(degrees)))

func cell_to_world(p: Vector2i) -> Vector3:
	return floor_grid_map.to_global(floor_grid_map.map_to_local(to_gridmap(p)))

func put_floor(p: Vector2i, tile_name: String, degrees: float) -> void:
	var id := tile_id(floor_grid_map.mesh_library, tile_name)
	if id != -1:
		floor_grid_map.set_cell_item(to_gridmap(p), id, rotation_index(floor_grid_map, degrees))

func draw_floor() -> void:
	for x in size:
		for z in size:
			var p := Vector2i(x, z)
			match grid[x][z]:
				Cell.VOID:
					pass
				Cell.ROAD:
					var tile := road_tile(road_sides(p))
					put_floor(p, tile["n"], -float(tile["r"]))
				Cell.GRASS:
					var g: Dictionary = park_tiles.get(p, {"n": GRASS_TILE, "r": 0})
					put_floor(p, g["n"], float(g["r"]))
				_:
					put_floor(p, SIDEWALK_TILE, 0.0)

func draw_props() -> void:
	var library := prop_grid_map.mesh_library
	for x in size:
		for z in size:
			var p := Vector2i(x, z)
			if protected.has(p):
				continue
			var tile_name := ""
			if grid[x][z] == Cell.GRASS and rng.randf() < tree_density:
				tile_name = TREE_TILES[rng.randi() % TREE_TILES.size()]
			elif grid[x][z] == Cell.SIDEWALK and rng.randf() < LAMP_CHANCE:
				tile_name = LAMP_TILES[rng.randi() % LAMP_TILES.size()]
			var id := tile_id(library, tile_name)
			if id != -1:
				prop_grid_map.set_cell_item(
					prop_grid_map.local_to_map(prop_grid_map.to_local(cell_to_world(p))), id)
