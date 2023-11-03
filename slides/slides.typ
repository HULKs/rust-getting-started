#import "theme.typ": *

#show: workshop-theme.with(
  footer: [Rust --- Getting Started],
)

#title-slide(
  title: [Rust],
  subtitle: [Getting Started],
  author: [Team HULKs],
)

#slide(title: "Content")[
  Learning Rust in sessions implementing a simple ball detection.

  #grid(
    columns: (1fr, 1fr),
    [  
      - Basics
      - Structs
      - Enums
      - Pattern Matching
      - Error Handling
    ],
    [
      - Collections
      - Ownership
      - Testing
      - Crates
    ],
  )
]

#slide(title: "What is Rust?")[
  - _Statically typed:_ All types are known at compile time.
  - _Strongly typed:_ Compiler checks for type safety.
  - _Memory safe:_ No dangling pointers, no buffer overflows.

  ```rust
  fn main() {
      println!("Hello, world!");
  }
  ```
]

#slide(title: "Variables")[
  ```rust
  let value = 42;
  ```

  #list(
    [
      Integral:
      ```rust i8```,
      ```rust u8```,
      ```rust i16```,
      ```rust u16```,
      ```rust i32```,
      ```rust u32```,
      ```rust i64```,
      ```rust u64```,
      ```rust isize```,
      ```rust usize```
    ],
    [
      Floating point:
      ```rust f32```,
      ```rust f64```
    ],
    [
      Boolean:
      ```rust bool```
    ],
    [
      Strings:
      ```rust &str```,
      ```rust String```
    ],
    [
      Arrays: 
      ```rust [u32; 42]```
    ],
    [
      ...
    ],
  )
]

#slide(title: "Control Flow")[
  #list(
    [
      Conditional:
      ```rust if```,
      ```rust else```,
      ```rust match```,
    ],
    [
      Loops:
      ```rust while```,
      ```rust for```
      ```rust loop```
    ],
  )

  No parantheses around predicates: ```rust if x == 42 { ... }```

  Logic operators: ```rust &&```, ```rust ||```, ```rust !```
]

#slide(title: "Functions")[
  ```rust
  fn add(x: u32, y: u32) -> u32 {
      x + y
  }
  ```
  #pause
  ```rust
  fn absolute_value(x: f32) -> f32 {
    if x < 0.0 {
      return -x;
    }
    x
  }
  ```
]

#slide(title: "Task 1: Hello World and Functions")[
  + Create a new project with ``` cargo new hello_world```
  + Inspect the directory structure (e.g. ``` src/main.rs```)
  + Run the project with ``` cargo run```
  + Add a function ```rust fn is_red(red_intensity: f32) -> bool```
  + Create a variable ```rust red_intensity``` $in [0, 1]$
  + Add an ```rust if``` statement to print whether the color is red or not
]

#new-section-slide([Mutability])

#slide(title: "Immutable Variables")[
  #set text(size: 20pt)
  ```rust
  let immutable_value = 42;
  //  ---------------
  //  |
  //  first assignment to `immutable_value`
  //  help: consider making this binding mutable: `mut immutable_value`
  immutable_value = 1337;
  //              ^^^^^^ error: cannot assign twice to immutable variable
  ```
]

#slide(title: "Mutable Variables")[
  ```rust
  let mut mutable_value = 42;
  mutable_value = 1337;
  ```
]

#slide(title: "Tuples")[
  ```rust (f32, bool, &str)``` is a 3-tuple

  ```rust let tuple = (1.0, true, "HULKs");```
]

#slide(title: "Structs")[
  ```rust
  struct ComplexNumber {
      real: f32,
      imaginary: f32,
  }
  ```

  No inheritance, use composition instead.

  Instantiate structs with:

  ```rust
  let complex_number = ComplexNumber {
    real: 1.0,
    imaginary: 2.0
  };
  ```
]
