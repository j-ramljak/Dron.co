
### **Dron.co**

---

- Simulacija
	- [x] kontrole
	    - [x] kontroler
	    - [ ] tipkovnica
	- [x] letjenje
    - [ ] detekcija kolizije
	- [ ] animacija
	    - [ ] rotiranje propelera
	    - [ ] glatke kontrole
	        - [x] kamera
	        - [ ] translacija
	        - [ ] rotacija
	    - [ ] naginjanje pri kretanju/skretanju
- Modeliranje
    - [ ] za grad
        - [x] podloge grada
        - [x] građevine
        - [ ] okolina grada (brda)?
        - [ ] drveća
        - [ ] detalji
        - [ ] raspored grada
	- [ ] za igranje
        - [ ] model drona
        - [ ] prepreke za dron
        - [ ] postaja za dron
- Igra
	- [ ] dostavljanje paketa
	- [ ] tajmer
	- [ ] granice mape
	- [ ] death mechanic
	- [ ] scoreboard?
	- [ ] punjenje baterije?
- Dokumentacija
	- [ ] Plan projekta
	- [ ] Tehnička dokumentacija

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

    section Kontrolne točke
        Određena tema projekta                          : milestone, 14-10-2025, 0d
        Kraj planiranja projekta                        : milestone, 20-10-2025, 0d

	section Dokumentacija
		Osmišljavanje teme                              : 07-10-2025, 7d
        Plan projekta                                   : 27-10-2025, until rok1
        Tehnička dokumentacija                          : 10-01-2026, until rok2
        Razrada plana projekta                          : 10-01-2026, until rok2

    section Simulacija
        Kontrole i letjenje                             : 27-10-2025, 14d
        Detekcija kolizije                              : 7d
        Animacije                                       : 30d
        ...                                             : 7d

    section Modeliranje
        Građevine                                       : 20-10-2025, 29-10-2025
        Drveća                                          : 7d
        Model drona                                     : 7d
        Detalji grada                                   : 03-11-2025, 21d
        Raspored grada                                  : 7d
        ...                                             : 7d

    section Igra
        Funkcionalnost dostave paketa                   : 10-11-2025, 14d
        Tajmer                                          : 7d
        ...                                             : 7d
		
```

>[!NOTE]
>https://mermaid.js.org/syntax/gantt.html

---

