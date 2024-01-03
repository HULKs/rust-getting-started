use rand::random;

enum PixelColor {
    Black,
    Custom { red: f32, green: f32, blue: f32 },
}

impl PixelColor {
    fn black() -> Self {
        Self::Black
    }

    fn new(red: f32, green: f32, blue: f32) -> Result<Self, &'static str> {
        if red < 0.0 || red > 1.0 || green < 0.0 || green > 1.0 || blue < 0.0 || blue > 1.0 {
            return Err("Some color is out of range");
        }
        Ok(Self::Custom { red, green, blue })
    }

    fn is_red(&self) -> bool {
        match self {
            PixelColor::Black => false,
            PixelColor::Custom { red, green, blue } => *red > 0.5 && *green < 0.5 && *blue < 0.5,
        }
    }
}

#[allow(dead_code)]
fn create_image(width: usize, height: usize) -> Vec<Vec<PixelColor>> {
    let mut image = vec![];
    for y in 0..height {
        let mut row = vec![];
        for x in 0..width {
            row.push(if x == y {
                PixelColor::new(1.0, 0.0, 0.0).unwrap()
            } else {
                PixelColor::black()
            });
        }
        image.push(row);
    }
    image
}

fn create_random_image(width: usize, height: usize) -> Vec<Vec<PixelColor>> {
    let mut image = vec![];
    for _ in 0..height {
        let mut row = vec![];
        for _ in 0..width {
            row.push(if random() {
                PixelColor::new(1.0, 0.0, 0.0).unwrap()
            } else {
                PixelColor::black()
            });
        }
        image.push(row);
    }
    image
}

fn get_red_positions(image: &Vec<Vec<PixelColor>>) -> Vec<(usize, usize)> {
    let mut positions = vec![];
    for y in 0..image.len() {
        let row = &image[y];
        for x in 0..row.len() {
            let pixel = &row[x];
            if pixel.is_red() {
                positions.push((x, y));
            }
        }
    }
    positions
}

fn main() {
    let image = create_random_image(20, 10);
    let positions = get_red_positions(&image);
    println!("Positions: {:?}", positions);
}

#[test]
fn create_image_of_2x3_image_has_3_rows() {
    let image = create_image(2, 3);

    assert_eq!(image.len(), 3);
}

#[test]
fn get_red_positions_of_4x4_finds_diagonal_positions() {
    let image = create_image(4, 4);
    let positions = get_red_positions(&image);

    let expected_positions = vec![(0, 0), (1, 1), (2, 2), (3, 3)];
    assert_eq!(positions, expected_positions);
}
