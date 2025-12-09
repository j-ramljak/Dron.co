
### **Dron.co**

---

<details open>
<summary>

### Funkcionalnosti
</summary>

- Simulacija
	- [x] letjenje (kontroler, tipkovnica) `[leon, stjepan]`
    - [x] kolizija `[leon, stjepan]`
    - [x] nošenje paketa `[jakov]`
    - [ ] efekt vjetra `[?]`
- Efekti
    - [x] "responzivne" kontrole (smooth kamera, smooth kretanje, naginjanje pri kretanju) `[stjepan]`
    - [x] stilski efekti (post processing, nebo) `[martin]`
    - [ ] rotiranje propelera `[?]`
    - [ ] audio efekti (dron, alarm, pokupljanje paketa...) `[?]`
- Modeliranje
    - [x] podloge grada `[martin]`
    - [x] građevine `[martin]`
    - [x] drveća `[martin]`
    - [x] modeli paketa `[martin]`
    - [x] glavna postaja, punjač `[martin]`
    - [ ] detalji grada (ulična rasvjeta, semafori, štandovi, klupe, vozila...) `[?]`
    - [ ] raspored grada `[?]`
    - [ ] model drona `[?]`
- Gameplay
	- [ ] dostavljanje paketa `[?]`
    - [ ] korisničko sučelje (title screen, baterija, vrijeme, death screen) `[martin]`
	- [ ] baterija `[martin]`
	- [ ] štopanje dostavljanja paketa `[?]`
	- [ ] death mechanic (sudar, prazna baterija, granice mape "no signal") `[?]`
	- [ ] oznake dostave (neki nacin da se zna kamo treba dostaviti) `[martin]`
- Dokumentacija 
	- [x] Plan projekta
	- [ ] Tehnička dokumentacija
</details>

---

<details open>
<summary>

### Linkovi
</summary>

> [!NOTE]
> Alati
> - Alat za Gantt: https://www.mermaidchart.com/play?utm_source=mermaid_live_editor
> - Dokumentacija za Mermaid: https://mermaid.js.org/syntax/gantt.html
> - Alat za WBS: https://online.visual-paradigm.com/diagrams/features/work-breakdown-structure-software/
> 
> Assets
> - Outline shader (MIT Lisence): https://godotshaders.com/shader/sobel-outline-shader/
> - Skybox (Royalty Free License): https://freestylized.com/skybox/sky_22/

</details>

---

<details>
<summary>

### Gantogrami
</summary>

```mermaid
---
config:
  theme: dark
  // gantt:
    // useWidth: 1000
---
gantt
    dateFormat DD-MM-YYYY
    todayMarker on

    section Semestar
        Početak semestra                                : milestone, 29-09-2025, 0d
        Predaja prve verzije plana projekta             : vert, rok1, 14-11-2025, 0d
        Međuispiti                                      : mi, 17-11-2025, 21d
        Završni ispiti                                  : zi, 02-02-2026, 14d
        Predaja plana rada i tehničke dokumentacije     : vert, rok2, 30-01-2026, 0d

    section Sastanci
        1. sastanak s mentoricom                        : milestone, 07-10-2025, 0d
        1. sastanak tima                                : milestone, 10-10-2025, 0d
        2. sastanak tima                                : milestone, 14-10-2025, 0d
        2. sastanak s mentoricom                        : milestone, 14-10-2025, 0d
        3. sastanak tima                                : milestone, 31-10-2025, 0d
        3. sastanak s mentoricom                        : milestone, 07-11-2025, 0d
```
```mermaid
---
config:
  theme: dark
  gantt:
    useWidth: 1200
---
gantt
    dateFormat DD-MM-YYYY
    todayMarker off

	section Dokumentacija
		Osmišljavanje teme : d1, 07-10-2025, 7d
        Određena tema projekta : milestone, 0d
        Plan projekta : 14-11-2025
        Određen plan projekta : milestone, 0d
        Tehnička dokumentacija : 23-01-2026
        Razrada plana projekta : d4, 10-01-2026, 23-01-2026
        Završetak dokumentacije projekta : milestone, 0d

    section Simulacija i efekti
        Kontrole i letjenje : 27-10-2025, 14d
        Implementirana kontrola drona : milestone, 0d
        Simulacija nošenja paketa : 14d
        Audio i vizualni efekti : 21d
        Završetak simulacija i efekta : milestone, 0d

    section Modeliranje
        Modeli detalja grada : 01-11-2025, 30d
        Model drona : 7d
        Raspored grada : 14d
        Dizajniran tlocrt grada : milestone, 0d

        Modeli građevina : 20-10-2025, 25d
        Modeli drveća : 10d
        Modeli za funkcionalnost igre : 20d
        Završeno modeliranje : milestone, 0d
        Optimizacija modela : 7d

    section Igra
        Funkcionalnost dostave paketa : i1, 10-11-2025, 14d
        Funkcionalnost baterije i punjenja : i2, after i1, 14d
        Početak, završetak, resetiranje igre : i3, after i2, 14d
        Integracija modela, fizike i logike u Godot : 14d
        Implementirana funkcionalnost igre : milestone, 0d
        Testiranje : 14d
```

>[!NOTE]
> Upute za export grafa u sliku
>
>1. Kopirati source kod grafa (sve unutar "mermaid" bloka)
>2. https://www.mermaidchart.com/play?utm_source=mermaid_live_editor
>3. `theme: neutral`
>4. Export


</details>

---

<details>
<summary>

### WBS Dijagram
</summary>

![wbs](wbs.png)
</details>

---

