
### **Dron.co**

---

### Lista funkcionalnosti

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

> Alat za Gantt: https://mermaid.js.org/syntax/gantt.html

> Alat za WBS: https://online.visual-paradigm.com/diagrams/features/work-breakdown-structure-software/

---


```mermaid
gantt
    title Gantogram
    dateFormat DD-MM-YYYY

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

    section Kontrolne točke
        Određena tema projekta : milestone, 14-10-2025, 0d
        Implementirana kontrola drona : milestone, after s1, 0d
        Završeno modeliranje drona i grada : milestone, after m1, 0d
        Dizajniran tlocrt grada : milestone, after m2, 0d
        Implementirana funkcionalnost igre : milestone, after i3, 0d
        Završetak praktične implementacije projekta : milestone, after s3 m3 i3, 0d
        Završetak dokumentacije projekta : milestone, after d3 d4, 0d

	section Dokumentacija
		Osmišljavanje teme : d1, 07-10-2025, 7d
        Plan projekta : d2, 14-10-2025, until rok1
        Tehnička dokumentacija : d3, after rok1, 23-01-2026
        Razrada plana projekta : d4, 10-01-2026, 23-01-2026

    section Simulacija i efekti
        Kontrole i letjenje : s1, 27-10-2025, 21d
        Simulacija nošenja pakete : s2, after s1, 21d
        Audio i vizualni efekti : s3, after s2, 21d

    section Modeliranje
        Izgradnja 3D modela : m1, 20-10-2025, 21-12-2025
        Raspored grada : m2, after m1, 7d
        Integracija sa funkcionalnosti igre: m3, after m2, 7d

    section Igra
        Funkcionalnost dostave paketa : i1, 10-11-2025, 21d
        Funkcionalnost baterije i punjenja : i2, after i1, 14d
        Početak, završetak, resetiranje igre : i3, after i2, 14d
```

---

