#import "theme.typ": *

#show: workshop-theme.with(
  footer: [Rust Introduction],
)

#title-slide(
  title: [Rust Introduction],
  author: [Team HULKs],
)

#slide(title: "Rust Introduction")[
  Learning Rust in sessions implementing a simple ball detection.

  #grid(
    columns: (25%, 1fr),
    column-gutter: 10pt,
    [
      #set align(top)
      #set text(size: 18pt)
      = Agenda
      - Basics
      - Structs
      - Enums
      - Pattern Matching
      - Error Handling
      - Collections
      - Ownership
      - Testing
      - Crates
    ],
    [
      #set align(top)
      #set text(size: 18pt)
      = Setup Steps
      This guide is for Arch Linux / Manjaro. If you are using another distribution, ask us or try to adapt yourself.

      - Install rustup: `yay -S rustup`
      - Download Rust stable toolchain: `rustup install stable`
      - You should be able to execute `cargo --version` which should not result in an error

      If you are using Visual Studio Code (we recommend that for Newbies), please follow these steps:

      - In the left pane, select "Extensions"
      - Search for `rust-analyzer` and install that extension
    ],
  )
]

#slide(title: "What is Rust?")[
  #grid(
    columns: (79%, 25%),
    [ // TODO: keep strong font for emphasizing some things and make the slides more interesting?
      - *Statically typed:* All types are known at compile time.
      - *Strongly typed:* Compiler checks for type safety.
      - *Memory safe:* No dangling pointers, no buffer overflows.

      *Hello World Example:*

      ```rust
      fn main() {
          println!("Hello, world!");
      }
      ```
    ],
    [
      #figure(image("Rust_programming_language_black_logo.svg")) // https://upload.wikimedia.org/wikipedia/commons/d/d5/Rust_programming_language_black_logo.svg
    ],
  )
]

#slide(title: "Variables")[
  ```rust
  let value = 42;
  ```

  #list(
    [
      *Integral:*
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
      *Floating point:*
      ```rust f32```,
      ```rust f64```
    ],
    [
      *Boolean:*
      ```rust bool```
    ],
    [
      *Strings:*
      ```rust &str```,
      ```rust String```
    ],
    [
      *Arrays:*
      ```rust [u32; 42]``` represents 42x ```rust u32``` items, zero indexed
    ],
    // TODO: you removed more advanced types?
    [
      ...
    ],
  )
]

#slide(title: "Control Flow")[
  #list(
    [
      *Conditionals:*
      ```rust if```,
      ```rust else```,
      ```rust match```
    ],
    [
      *Loops:*
      ```rust while```,
      ```rust for```,
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
  #v(30pt)

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
  + Create a new project with `cargo new hello_world`
  + Inspect the directory structure (e.g. `src/main.rs`)
  + Run the project with `cargo run`
  + Add a function ```rust fn is_red(red_intensity: f32) -> bool```
  + Create a variable ```rust red_intensity``` $in [0, 1]$
  + Add an ```rust if``` statement to print whether the color is red or not
]

// TODO: I think it is better to have more things on the slides in less slides to have more context
#slide(title: "Mutability")[
  #set text(size: 21pt)
  ```rust
  let immutable_value = 42;
  //  ---------------
  //  |
  //  first assignment to `immutable_value`
  //  help: consider making this binding mutable: `mut immutable_value`
  immutable_value = 1337;
  //              ^^^^^^ error: cannot assign twice to immutable variable
  ```

  #pause
  #v(30pt)

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
    imaginary: 2.0,
  };
  ```
]

#slide(title: "Struct Implementations")[
  #[
    #set text(size: 21pt)
    ```rust
    impl ComplexNumber {
        fn zero() -> Self {
            Self { real: 0.0, imaginary: 0.0 }
        }

        fn norm(self) -> f32 {
            let squared_norm = self.real.powi(2) + self.imaginary.powi(2);
            squared_norm.sqrt()
        }
    }
    ```
  ]

  Call a method with:

  #[
    #set text(size: 21pt)
    ```rust
    let complex_number = ComplexNumber::zero();
    let norm = complex_number.norm();
    ```
  ]
]

#slide(title: "Traits")[
  Traits define shared behavior. Other languages call them interfaces.

  #[
    #set text(size: 21pt)
    ```rust
    trait Add {
      fn add(self, other: Self) -> Self;
    }
    ```
  ]

  Traits can be implemented by other types:

  #[
    #set text(size: 21pt)
    ```rust
    impl Add for ComplexNumber {
      fn add(self, other: Self) -> Self {
        Self {
          real: self.real + other.real,
          imaginary: self.imaginary + other.imaginary,
        }
      }
    }
    ```
  ]
]

#slide(title: "Enums")[
  Enums are variants, more powerful than C++ enums.

  #[
    #set text(size: 21pt)
    ```rust
    enum Number {
        OnlyReal(f32),

        Complex(ComplexNumber), // or
        Complex(f32, f32), // or
        Complex{real: f32, imaginary: f32},

        SomethingElse,
    }
    ```
  ]

  Instantiate enums with:

  #[
    #set text(size: 21pt)
    ```rust
    let number = Number::Complex { real: 42.0, imaginary: 1337.0 };
    ```
  ]
]

#slide(title: "Pattern Matching")[
  // https://www.sheshbabu.com/images/2020-rust-for-javascript-developers-4/pattern-matching-rust-1.png
  // https://www.sheshbabu.com/images/2020-rust-for-javascript-developers-4/pattern-matching-rust-2.png
  #figure(image("pattern-matching.png"))
]

#slide(title: "Pattern Matching")[
  #set text(size: 16pt)
  ```rust
  let number = Number::OnlyReal(42.0);
  match number {
      OnlyReal(real: 0.0) => println!("Zero real"),
      OnlyReal(real)      => println!("Real part: {}", real),  // Matches & Binds `real`
      _                   => println!("Something else"),
  }
  ```
  #pause
  ```rust
  let norm = match number {
      OnlyReal(real)          => real,                         // Matches & Binds `real`
      Complex(complex_number) => complex_number.norm(),
      SomethingElse           => 0.0,
  };
  ```
  #pause
  ```rust
  if let OnlyReal(real) = number {                             // Matches & Binds `real`
      println!("Real part: {}", real);
  }
  ```
  #pause
  ```rust
  let is_complex = true;
  match is_complex {
      true  => println!("We got a complex number"),            // Matches
      false => println!("Normal real number"),
  }
  ```
]

#slide(title: "Task 2a: Structs")[
  + Add ```rust struct PixelColor``` which holds three ```rust f32``` RGB color fields
  + Add two constructors in ```rust impl PixelColor```:
    - ```rust fn black() -> Self```
    - ```rust fn new(red: f32, green: f32, blue: f32) -> Self```
  + Add ```rust fn is_red(self) -> bool``` to ```rust impl PixelColor```
  + Create two variables ```rust red_pixel``` and ```rust black_pixel```
  + Use ```rust pixel.is_red()``` instead of ```rust is_red()```
  + Fix all warnings by cleaning up your code
]

#slide(title: "Task 2b: Enums and Pattern Matching")[
  + Convert ```rust struct PixelColor``` into ```rust enum PixelColor``` with two variants:
    - ```rust Black```
    - ```rust Custom { red: f32, green: f32, blue: f32 }```
  + Refactor constructors to generate enum variants
  + Use pattern matching inside ```rust is_red()```
]

#slide(title: "Option")[
  ```rust
  // part of std library
  enum Option<T> {
      Some(T),
      None,
  }

  let something = Some(42);
  let nothing = None;
  ```

  No ```rust Option::``` prefix needed
]

#slide(title: "Result")[
  ```rust
  // part of std library
  enum Result<T, E> {
      Ok(T),
      Err(E),
  }

  let success = Ok(42);
  let failure = Err("no such file or directory");
  ```

  No ```rust Result::``` prefix needed
]

#slide(title: "Error Handling")[
  #[
    #set text(size: 18pt)
    ```rust
    match File::open("file.txt") {
        Ok(opened_file) => { read_from(opened_file)                 },
        Err(error)      => { eprintln!("Failed to open: {}", error) },
    };
    ```
  ]

  #pause

  #[
    #set text(size: 18pt)
    ```rust
    fn read_from(file: File) -> Result<String, std::io::Error> {
        let data = match file.read() {
            Ok(data)   => data,
            Err(error) => return Err(error),
        };
        dbg!(data);
        Ok(data)
    }
    ```
  ]

  #pause

  #[
    #set text(size: 18pt)
    ```rust
    fn read_from(file: File) -> Result<String, std::io::Error> {
        let data = file.read()?;
        dbg!(data);
        Ok(data)
    }
    ```
  ]
]

#slide(title: "Task 3: Result and Error Handling")[
  + Refactor ```rust PixelColor::new()``` to return ```rust Result<Self, String>```
    - ```rust new()``` should return ```rust Err``` if a color channel is ```rust < 0``` or ```rust > 1```
    - ```rust String``` represents an error message that you can define yourself, e.g, ```rust String::from("foo")```
  + Change return type of ```rust main()``` to ```rust Result<(), String>```, return ```rust Ok(())``` in the end
  + Handle the result of ```rust PixelColor::new()``` with pattern matching
    - Save ```rust Ok``` in the variable
    - Print ```rust Err``` message and return error from ```rust main()```
  + Test your code
  + Now, replace the pattern matching with a ```rust ?``` operator
]

#slide(title: "Collections")[
  - *Sequences:* ```rust Vec```, ```rust VecDeque``` (ring buffer), ```rust LinkedList```
  - *Maps:* ```rust HashMap```, ```rust BTreeMap```
  - *Sets:* ```rust HashSet```, ```rust BTreeSet```
  - *Misc:* ```rust BinaryHeap``` (priority queue)
  - ... from external crates

  ```rust Vec``` example:

  ```rust
  let mut vector = Vec::new();
  vector.push(1);
  vector.push(2);
  ```
]

#slide(title: "Ownership")[
  Memory is always owned by a single entity.

  It can either be *moved* or *borrowed*.

  ```rust
  let complex_number = ComplexNumber::zero();
  let mut vector = Vec::new();
  vector.push(complex_number);
  //          -------------- value moved here
  vector.push(complex_number);
  //          ^^^^^^^^^^^^^^ error: value used here after move
  ```
]

#slide(title: "Ownership: Borrowing")[
  ```rust
  let complex_number = ComplexNumber::zero();
  let mut vector = Vec::new();
  vector.push(&complex_number); // value immutably borrowed here
  vector.push(&complex_number); // value immutably borrowed here
  ```

  #pause

  ```rust
  let complex_number = ComplexNumber::zero();
  let mut vector = Vec::new();
  vector.push(&mut complex_number);
  //          ------------------- first mutable borrow occurs here
  vector.push(&mut complex_number);
  //     ---- ^^^^^^^^^^^^^^^^^^^ second mutable borrow occurs here
  //     |
  //     first borrow later used by call
  ```

  Borrowed references (sometimes) need to be dereferenced with ```rust *```
]

#slide(title: "Task 4: Collections and Ownership")[
  #set text(size: 20pt)
  #show link: underline
  + For this task, you will need index iteration: ```rust for index in 0..some_length {}```
  + Documentation for ```rust Vec```: https://doc.rust-lang.org/std/vec/struct.Vec.html
  + ```rust fn create_image(width: usize, height: usize) -> Vec<Vec<PixelColor>>```
    - Store red pixel if ```rust x == y```, else black
    - Create an image of size 20x10 in ```rust main()``` using this function
  + Iterate over pixels by index, find red pixels, store them in a collection
    - ```rust fn get_red_positions(image: &Vec<Vec<PixelColor>>) -> Vec<(usize, usize)>```
  + Use ```rust dbg!(positions);``` to print the resulting collection
]

#slide(title: "Functional Patterns")[
  - Iterators from ranges, collections, ...
  - Transformations on iterators: ```rust map()```, ```rust filter()```, ```rust reduce()```, ```rust enumerate()```, ...
  - Collect iterators into collections

  #[
    #set text(size: 20pt)
    ```rust
    fn get_red_positions(image: &Vec<Vec<PixelColor>>) -> Vec<(usize, usize)> {
        image.iter()
            .enumerate()
            .flat_map(|(y, row)| {
                row.iter()
                    .enumerate()
                    .filter(|(_x, pixel)| pixel.is_red())
                    .map(move |(x, _pixel)| (x, y))
            })
            .collect()
    }
    ```
  ]
]

#slide(title: "Testing")[
  #set text(size: 20pt)
  ```rust
  #[test]
  fn test_complex_number_norm_is_zero() {
      let zero_complex_number = ComplexNumber::zero();

      assert!(zero_complex_number.norm() == 0.0); // or
      assert_eq!(zero_complex_number.norm(), 0.0);
  }
  #[test]
  fn test_complex_number_norm_is_non_zero() {
      let mut zero_complex_number = ComplexNumber::zero();
      zero_complex_number.real = 3.0;
      zero_complex_number.imaginary = 4.0;

      assert!(zero_complex_number.norm() == 5.0); // or
      assert_eq!(zero_complex_number.norm(), 5.0);
  }
  ```
]

#slide(title: "Task 5: Testing")[
  + Implement two test cases with different image sizes
    - `create_image_of_2x3_image_has_3_rows`
    - `get_red_positions_of_4x4_finds_diagonal_positions`
  + Run your tests with `cargo test`
]

#slide(title: "Test-Driven Development (TDD)")[
  #grid(
    columns: (70%, 35%),
    [
      - Software requirements are converted to test cases before implementation
      - Test-driven development cycle:
        + Add a test (must fail)
        + Write the simplest code that passes the test
        + Refactor as needed (functionality must be preserved, tests must still pass)
        + Go to 1.
    ],
    [
      #figure(image("test-driven-development-TDD.png")) // https://marsner.com/wp-content/uploads/test-driven-development-TDD.png
    ],
  )
]

#slide(title: "Crates")[
  External libraries are called crates. You can install them from crates.io using `cargo add`.

  Normal workflow:

  - Search for crates online
  - Find a fitting one
  - Copy dependency string, e.g. from docs.rs or crates.io
  - Paste it into your `Cargo.toml`
  - Start using the crate in your project

  ... or use `cargo add`
]

#slide(title: "Task 6: Crates")[
  #set text(size: 21pt)
  + Add `rand` to your `Cargo.toml`, make yourself familiar with the crate via docs.rs
  + Generate a random image
    - Create new function \
      ```rust fn create_random_image(width: usize, height: usize) -> Vec<Vec<PixelColor>>```
    - Store red pixel if e.g. random number is above some threshold, else black
  + Adjust ```rust main()``` to use ```rust create_random_image()```
]

#slide(title: "Outlook")[
  #show link: underline
  - There is more to discover: Modules, Generics, Traits, Lifetimes, Concurrency, I/O
  - Additional material
    - https://doc.rust-lang.org/book/
    - https://doc.rust-lang.org/rust-by-example/
    - https://crates.io
    - https://docs.rs
]

#slide(title: "Feedback")[
  - Start: ...
  - Stop: ...
  - Continue: ...
]
