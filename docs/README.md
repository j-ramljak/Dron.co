
### **Dron.co**

---

### Funkcionalnosti

- Simulacija
	- [x] kontrole
	    - [x] kontroler
	    - [x] tipkovnica
    - [x] kolizija
    - [ ] simulacija paketa
    - [ ] vjetar
- Efekti
    - [ ] Vizualni
        - [ ] rotiranje propelera
        - [x] responzivne kontrole
            - [x] glatka kamera
            - [x] glatko kretanje
            - [x] naginjanje pri kretanju/skretanju
        - [ ] Korisničko sučelje
            - [ ] Baterija
            - [ ] Title screen
            - [ ] Death screen
    - [ ] Audio
        - [ ] Zvuk motora drona
- Modeliranje
    - [ ] za grad
        - [x] podloge grada
        - [x] građevine
        - [ ] drveća/grmlje
        - [ ] detalji grada
            - [ ] ulična rasvjeta
            - [ ] prometni znakovi
            - [ ] semafor
            - [ ] kante i kontejneri za smeće
            - [ ] štandovi
            - [ ] klupe
            - [ ] ...
        - [ ] raspored grada
	- [ ] za igranje
        - [ ] model drona
        - [ ] modeli paketa
        - [ ] prepreke za dron
        - [ ] postaja za dron
- Igra
	- [ ] dostavljanje paketa
        - [ ] mjesto pokupljanja paketa
        - [ ] točke dostavljanja paketa
	- [ ] death mechanic
        - [ ] sudar
        - [ ] prazna baterija
	    - [ ] granice mape ("no signal")
	- [ ] mjerenje vremena dostavljanja paketa
	- [ ] baterija
        - [ ] pražnjenje baterije
	    - [ ] punjenje baterije
	- [ ] navigacija igraća
	    - [ ] markeri za dostavu
- Dokumentacija
	- [ ] Plan projekta
	- [ ] Tehnička dokumentacija

---

### Linkovi

> Alat za Gantt: https://www.mermaidchart.com/play?utm_source=mermaid_live_editor

> Dokumentacija za Mermaid: https://mermaid.js.org/syntax/gantt.html

> Alat za WBS: https://online.visual-paradigm.com/diagrams/features/work-breakdown-structure-software/

---

### Gantogram v1.0 (za planiranje)

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

---

### Gantogram v2.0 (za dokument)

>[!NOTE]
>Upute za export grafa u sliku
>
>1. Kopirati source kod grafa (sve unutar "mermaid" bloka)
>2. https://www.mermaidchart.com/play?utm_source=mermaid_live_editor
>3. `theme: neutral`
>4. Export

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

---

### WBS Dijagram

![wbs](wbs.png)

---

