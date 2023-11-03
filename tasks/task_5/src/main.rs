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
    let image = create_image(20, 10);
    let positions = get_red_positions(&image);
    println!("Positions: {:?}", positions);
}

#[test]
fn test_average_position_of_red_pixels_in_20x10_image() {
    let image = create_image(20, 10);
    let positions = get_red_positions(&image);

    let sum_of_positions = positions.iter().fold(
        (0, 0),
        |(accumulated_x, accumulated_y), (current_x, current_y)| {
            (accumulated_x + current_x, accumulated_y + current_y)
        },
    );
    let average_positions = (
        (sum_of_positions.0 as f32) / (positions.len() as f32),
        (sum_of_positions.1 as f32) / (positions.len() as f32),
    );

    assert_eq!(average_positions, (4.5, 4.5));
}

#[test]
fn test_average_position_of_red_pixels_in_30x15_image() {
    let image = create_image(30, 15);
    let positions = get_red_positions(&image);

    let sum_of_positions = positions.iter().fold(
        (0, 0),
        |(accumulated_x, accumulated_y), (current_x, current_y)| {
            (accumulated_x + current_x, accumulated_y + current_y)
        },
    );
    let average_positions = (
        (sum_of_positions.0 as f32) / (positions.len() as f32),
        (sum_of_positions.1 as f32) / (positions.len() as f32),
    );

    assert_eq!(average_positions, (7.0, 7.0));
}
