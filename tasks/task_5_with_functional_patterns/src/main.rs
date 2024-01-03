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
    (0..height)
        .map(|y| {
            (0..width)
                .map(|x| {
                    if x == y {
                        PixelColor::new(1.0, 0.0, 0.0).unwrap()
                    } else {
                        PixelColor::black()
                    }
                })
                .collect()
        })
        .collect()
}

fn get_red_positions(image: &Vec<Vec<PixelColor>>) -> Vec<(usize, usize)> {
    image
        .iter()
        .enumerate()
        .map(|(y, row)| {
            row.iter()
                .enumerate()
                .filter(|(_x, pixel)| pixel.is_red())
                .map(move |(x, _pixel)| (x, y))
        })
        .flatten()
        .collect()
}

fn main() {
    let image = create_image(20, 10);
    let positions = get_red_positions(&image);
    println!("Positions: {:?}", positions);
}
