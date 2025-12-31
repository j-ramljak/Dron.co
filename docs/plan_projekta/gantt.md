
---

> Upute za export grafa u sliku
> 1. Kopirati source kod grafa (sve unutar "mermaid" bloka)
> 2. https://www.mermaidchart.com/play?utm_source=mermaid_live_editor
> 3. `theme: neutral`
> 4. Export

---

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