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
