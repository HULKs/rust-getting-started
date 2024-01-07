#import "theme.typ": *

#show: workshop-theme.with(
  footer: [Rust Introduction],
)

#title-slide(
  title: [Rust Introduction],
  author: [Team HULKs],
)

#slide(title: "Rust Introduction")[
  Learning Rust in sessions implementing a simple red ball detection.

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

      - Install rustup: https://rustup.rs or `yay -S rustup`
      - Download stable toolchain: `rustup install stable`
      - Ensure `cargo --version` is successful

      If you are using Visual Studio Code, follow these steps:

      - In the left pane, select _Extensions_
      - Search and install the `rust-analyzer` extension
    ],
  )
]

#slide(title: "What is Rust?")[
  #grid(
    columns: (80%, 25%),
    [
      - *Statically typed:* All types are known at compile time.
      - *Strongly typed:* Compiler checks for type safety.
      - *Memory safe:* No dangling pointers, no buffer overflows.

      #v(1em)

      *Hello World Example:*

      ```rust
        fn main() {
            println!("Hello, world!");
        }
      ```
    ],
    [
      #figure(
        image(
          width: 90%,
          "Rust_programming_language_black_logo.svg"
        )
      ) // https://upload.wikimedia.org/wikipedia/commons/d/d5/Rust_programming_language_black_logo.svg
    ],
  )
]

#slide(title: "Variables")[
  ```rust
  let value = 42;
  ```

  - *Integral:* ```rust i8```, ```rust u8```, ```rust i16```, ```rust u16```, ```rust i32```, ```rust u32```, ```rust i64```, ```rust u64```, ```rust isize```, ```rust usize```
  - *Floating point:* ```rust f32```, ```rust f64```
  - *Boolean:* ```rust bool```
  - *Strings:* ```rust &str```, ```rust String```
  - *Arrays:* ```rust [u32; 42]``` represents 42x ```rust u32``` items, zero indexed
  - *Empty Type:* ```rust ()```
  - Slices, `HashMap`, `Vec`, ...
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

  Expressions evaluate to a value and can therefore be assigned to a variable: ```rust let x = if condition { 42 } else { 1337 };```
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
  fn absolute_value(x: f64) -> f64 {
    if x < 0.0 {
      return -x;
    }
    x
  }
  ```
]

#slide(title: "Printing")[
  ```rust
  println!("Hello, world!");
  // Hello, world!

  let x = 42;
  println!("The answer is {x}");
  // The answer is 42

  let y = 1337;
  dbg!(y);
  // [src/main.rs:5] y = 1337
  ```
]

#slide(title: "Task 1: Hello World and Functions")[
  + Create a new project with `cargo new hello_world`
  + Inspect the directory structure (e.g. `src/main.rs`)
  + Run the project with `cargo run`
  + Add a function ```rust fn is_red(red_intensity: f64) -> bool```
  + In the ```rust main()``` function:
    - Create a variable ```rust red_intensity``` containing a literal value $in [0, 1]$
    - Determine whether the color is red using ```rust is_red()```
    - Add an ```rust if``` statement to print whether the color is red or not
]

#slide(title: "Mutability")[
  #set text(size: 21pt)
  ```rust
  let immutable_value = 42;
  ```
  #uncover("2-")[
    ```rust
    //  ---------------
    //  |
    //  first assignment to `immutable_value`
    //  help: consider making this binding mutable: `mut immutable_value`
    ```
  ]
  ```rust
  immutable_value = 1337;
  ```
  #uncover("2-")[
    ```rust
    //              ^^^^^^ error: cannot assign twice to immutable variable
    ```
  ]

  #v(30pt)

  #uncover("3-")[
    ```rust
    let mut mutable_value = 42;
    mutable_value = 1337;
    ```
  ]
]

#slide(title: "Tuples")[
  Tuple is a fixed size collection of values.

  ```rust (f64, bool, &str)``` is a 3-tuple

  ```rust let tuple = (1.0, true, "HULKs");```

  Access fields with ```rust tuple.0```, ```rust tuple.1```, ```rust tuple.2```
]

#slide(title: "Structs")[
  ```rust
  struct ComplexNumber {
      real: f64,
      imaginary: f64,
  }
  ```

  #pause

  No inheritance, use composition instead.

  #pause

  Instantiate structs with:

  ```rust
  let complex_number = ComplexNumber {
    real: 1.0,
    imaginary: 2.0,
  };
  ```
]

#slide(title: "Struct Implementations")[
  #set text(size: 21pt)
  ```rust
  impl ComplexNumber {
  ```
  #uncover("2-")[
    ```rust
        fn zero() -> Self {
            Self { real: 0.0, imaginary: 0.0 }
        }

        fn norm(self) -> f64 {
            self.real.abs() + self.imaginary.abs()
        }
    ```
  ]
  ```rust
  }
  ```
  

  #uncover("3-")[
    Call a method with:

    ```rust
    let complex_number = ComplexNumber::zero();
    let norm = complex_number.norm();
    ```
  ]
]

#slide(title: "Traits")[
  Traits define shared behavior, like interfaces in other languages.

  #text(size: 21pt)[
    ```rust
    trait MyAdd {
        fn my_add(self, other: Self) -> Self;
    }
    ```
  ]

  #pause

  Traits can be implemented by other types:

  #text(size: 21pt)[
    ```rust
    impl MyAdd for ComplexNumber {
        fn my_add(self, other: Self) -> Self {
            Self {
                real: self.real + other.real,
                imaginary: self.imaginary + other.imaginary,
            }
        }
    }
    ```
  ]
]

#slide(title: "Task 2: Structs")[
  + Add ```rust struct PixelColor``` which holds three ```rust f64``` RGB color fields
  + Add two constructors in ```rust impl PixelColor```:
    - ```rust fn black() -> Self```
    - ```rust fn new(red: f64, green: f64, blue: f64) -> Self```
  + Add ```rust fn is_red(self) -> bool``` to ```rust impl PixelColor```
  + Create two variables ```rust red_pixel``` and ```rust black_pixel```
  + Use ```rust pixel.is_red()``` instead of ```rust is_red()```
  + Fix all warnings by cleaning up your code
]

#slide(title: "Enums")[
  Enums are variants, more powerful than C++ enums.

  #only("1")[
    #text(size: 21pt)[
      ```rust
      enum Number {
          Real,

          Complex,

          NotANumber,
      }
      ```
    ]
  ]
  #only("2-")[
    #text(size: 21pt)[
      ```rust
      enum Number {
          Real(f64),

          Complex{real: f64, imaginary: f64},

          NotANumber,
      }
      ```
    ]
  ]

  #uncover("3-")[
    Instantiate enums with:

    #text(size: 21pt)[
      ```rust
      let real_number = Number::Real(42.0);
      let complex_number = Number::Complex { real: 42.0, imaginary: 1337.0 };
      let not_a_number = Number::NotANumber;
      ```
    ]
  ]
]

#slide(title: "Pattern Matching")[
  // https://www.sheshbabu.com/images/2020-rust-for-javascript-developers-4/pattern-matching-rust-1.png
  // https://www.sheshbabu.com/images/2020-rust-for-javascript-developers-4/pattern-matching-rust-2.png
  #set text(size: 15pt)
  #show figure.caption: body => text(fill: gray, body)
  #figure(
    image("pattern-matching.png"),
    gap: 1em,
    caption: [https://www.sheshbabu.com/posts/rust-for-javascript-developers-pattern-matching/],
  )
]

#slide(title: "Pattern Matching")[
  #set text(size: 16pt)
  ```rust
  let number = Number::Real(42.0);
  match number {
      Number::Real(real) => println!("Real part: {real}"),   // Binds `real`
      _                  => println!("Something else"),
  }
  ```
  #pause
  ```rust
  let norm = match number {
      Number::Real(real)                     => real.abs(),        // Binds `real`
      Number::Complex{real: r, imaginary: i} => r.abs() + i.abs(), // Binds `real` to `r` and
                                                                   //       `imaginary` to `i`
      Number::NotANumber                     => f64::NAN,
  };
  ```
  #pause
  ```rust
  if let Number::Real(real) = number {                       // Binds `real`
      println!("Real part: {real}");
  }
  ```
  #pause
  ```rust
  let my_value = true;
  match my_value {
      true  => println!("Boolean value is true"),
      false => println!("Boolean value is false"),
  }
  ```
]

#slide(title: "Task 3: Enums and Pattern Matching")[
  + Convert ```rust struct PixelColor``` into ```rust enum PixelColor``` with two variants:
    - ```rust Black```
    - ```rust Custom { red: f64, green: f64, blue: f64 }```
  + Refactor constructors to generate enum variants
  + Use pattern matching inside ```rust is_red()```
]

#slide(title: "Option")[
  ```rust
  // part of std library
  enum Option<Value> {
      Some(Value),
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
  enum Result<Value, Error> {
      Ok(Value),
      Err(Error),
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
        Ok(file)   => { read_from(file)                      },
        Err(error) => { eprintln!("Failed to open: {error}") },
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
        Ok(data)
    }
    ```
  ]
]

#slide(title: "Task 4: Result and Error Handling")[
  #set text(size: 22pt)
  + Refactor ```rust PixelColor::new()``` to return ```rust Result<Self, String>```
    - ```rust new()``` should return ```rust Err``` if a color channel is ```rust < 0``` or ```rust > 1```
    - ```rust String``` represents an error message e.g., ```rust String::from("foo")```
  + Change return type of ```rust main()``` to ```rust Result<(), String>``` and return ```rust Ok(())```
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

  #uncover("2-")[
    ```rust
    let complex_number = ComplexNumber::zero();
    let mut vector = Vec::new();
    ```
  ]
  #uncover("3-")[
    ```rust
    vector.push(complex_number);
    ```
  ]
  #uncover("5-")[
    ```rust
    //          -------------- value moved here
    ```
  ]
  #uncover("4-")[
    ```rust
    vector.push(complex_number);
    ```
  ]
  #uncover("5-")[
    ```rust
    //          ^^^^^^^^^^^^^^ error: value used here after move
    ```
  ]
]

#slide(title: "Ownership: Borrowing")[
  #[
    #set text(size: 18pt)
    ```rust
    let complex_number = ComplexNumber::zero();
    let mut vector = Vec::new();
    vector.push(&complex_number); // value immutably borrowed here
    vector.push(&complex_number); // value immutably borrowed here
    ```
  ]

  #uncover("2-")[
    #set text(size: 18pt)
    ```rust
    let mut complex_number = ComplexNumber::zero();
    let mut vector = Vec::new();
    vector.push(&mut complex_number);
    ```
  ]
  #uncover("3-")[
    #set text(size: 18pt)
    ```rust
    //          ------------------- first mutable borrow occurs here
    ```
  ]
  #uncover("2-")[
    #set text(size: 18pt)
    ```rust
    vector.push(&mut complex_number);
    ```
  ]
  #uncover("3-")[
    #set text(size: 18pt)
    ```rust
    //     ---- ^^^^^^^^^^^^^^^^^^^ second mutable borrow occurs here
    //     |
    //     first borrow later used by call
    ```
  ]
  #uncover("4-")[
    Borrowed references (sometimes) need to be dereferenced with ```rust *```
  ]
]

#slide(title: "Ownership: Moving Borrowed Values")[
  #set text(size: 20pt)
  ```rust
  let complex_number = ComplexNumber::zero();
  ```
  #uncover("2-")[
    ```rust
    //  -------------- binding `complex_number` declared here
    ```
  ]
  ```rust
  let mut borrowing_vector = Vec::new();
  borrowing_vector.push(&complex_number);
  ```
  #uncover("2-")[
    ```rust
    //                    --------------- borrow of `complex_number` occurs here
    ```
  ]
  ```rust
  let mut owning_vector = Vec::new();
  owning_vector.push(complex_number);
  ```
  #uncover("2-")[
    ```rust
    //                 ^^^^^^^^^^^^^^ move out of `complex_number` occurs here
    ```
  ]
  ```rust
  dbg!(borrowing_vector);
  ```
  #uncover("2-")[
    ```rust
    //   ---------------- borrow later used here
    ```
  ]
]

#slide(title: "Task 5: Collections and Ownership")[
  #set text(size: 18pt)
  Tips:

  - For this task, you will need index iteration: ```rust for index in 0..some_length {}```
  - Documentation for ```rust Vec```: https://doc.rust-lang.org/std/vec/struct.Vec.html
  - See the visualization for the image type ```rust Vec<Vec<PixelColor>>``` on the next slide

  Steps:

  + ```rust fn create_image(width: usize, height: usize) -> Vec<Vec<PixelColor>>```
    - Store red pixel if ```rust x == y```, else black
    - Create an image of size 20x10 in ```rust main()``` using this function
  + ```rust fn is_red(self) -> bool``` should now take ```rust self``` by reference (```rust &self```)
  + Create new function, iterate over pixels by index, find red pixels, store them in a collection
    - ```rust fn get_red_positions(image: &Vec<Vec<PixelColor>>) -> Vec<(usize, usize)>```
  + Add ```rust #[derive(Debug)]``` to ```rust PixelColor```
  + Use ```rust dbg!(positions);``` to print the resulting collection
]

#slide(title: "Image Type for Task 5: Collections and Ownership")[
  #figure(
    image("vec_vec_pixel_color.drawio.svg", height: 100% - 2em),
    gap: 1em,
    caption: [Row Major ```rust Vec<Vec<PixelColor>>```],
  )
]

#slide(title: "Functional Patterns")[
  - Iterators from ranges, collections, ...
  - Transformations on iterators: ```rust map()```, ```rust filter()```, ```rust reduce()```, ```rust enumerate()```, ...
  - Collect iterators into collections

  #text(size: 20pt)[
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

#slide(title: "Task 6: Testing")[
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
  External libraries are called crates.\
  You can install them from crates.io using `cargo add`.

  Normal workflow:

  - Search for crates online
  - Find a fitting one
  - Copy dependency string, e.g. from docs.rs or crates.io
  - Paste it into your `Cargo.toml`
  - Start using the crate in your project

  ... or use `cargo add`
]

#slide(title: "Task 7: Crates")[
  #set text(size: 21pt)
  + Add `rand` to your `Cargo.toml`, make yourself familiar with the crate via docs.rs
  + Generate a random image
    - Create new function \
      ```rust fn create_random_image(width: usize, height: usize) -> Vec<Vec<PixelColor>>```
    - Store red pixel if e.g. random number is above some threshold, else black
  + Adjust ```rust main()``` to use ```rust create_random_image()```
]

#slide(title: "Outlook")[
  - There is more to discover: Modules, Generics, Traits, Lifetimes, Concurrency, I/O
  - Additional material
    - https://doc.rust-lang.org/book/
    - https://doc.rust-lang.org/rust-by-example/
    - https://crates.io
    - https://docs.rs
    - https://lib.rs
    - https://rustlings.cool/
]

#slide(title: "Feedback")[
  #set text(size: 40pt)
  #grid(
    columns: (48%, 27%, 35%),
    [
      #align(end, [What should we#h(30pt)])
    ],
    [
      *Start* \
      *Stop* \
      *Continue*
    ],
    [
      doing?
    ],
  )
]
