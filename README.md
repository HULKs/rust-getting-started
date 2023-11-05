# Rust Introduction

Lessons learned:

- It will take long (last event was 7 hours long)
- This introduction has a focus on syntax and new simple concepts and not "medium"/"advanced" features (traits, generics, ...)
- The idea is to extend one file further and further with the tasks
- Tutors should only explain things that we covered in the slides before
- Tutors will wonder around, answer questions, and guide participants

TODO:

- Control Flow in Variable (man kann auch `if`/`match`/`loop` in variablen speichern)
- Enum ist ein Beispiel was nicht kompiliert (andere Fälle auskommentieren, anstatt löschen)
- Wir machen `println!("something else")` aber es gibt einen Typen SomethingElse
- floats matchen vielleicht nicht (nicht kompilierbar)
- Task 2a früher hinter den Tuples/Structs
- Matching: boolean zuerst?
- Erstmal nur C++-style enums, dann Typen hinzufügen
- Please don't abbreviate: Option, Result `<T>` -> `<Value>` und `<E>` -> `<Error>`
- move of borrowed value fehlt
- Bild für `Vec<Vec<PixelColor>>`
- `#[derive(Debug)]`
- Man braucht im Task mit `get_red_positions()` eine `&self` reference in `is_red()`
- Additional material: rustlinks, libs.rs

Feedback:

- Start:
    - wo findet man Doku zu den Dingen auf den Folien, weitere Links hinzufügen
    - Zusatzaufgaben für Schnelle
    - wie printed man Dinge (dbg, format String)
- Stop:
    - Beispiele sollten kompilieren
    - Pattern Matching einfaches boolean Beispiel nach oben
    - wo soll bei dem is_red geprinted werden (in main oder in der Funktion) (Task 1 Aufgabenbeschreibung genauer machen)
    - Block mit Structs und Enums zu lang
- Continue:
    - gleiche Datei immer ausgebaut
    - Folien, Vorbereitung
    - mit Beispielen direkt coden
    - rumgegangen
