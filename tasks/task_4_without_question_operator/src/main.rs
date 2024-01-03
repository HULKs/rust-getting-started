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

    fn is_red(self) -> bool {
        match self {
            PixelColor::Black => false,
            PixelColor::Custom { red, green, blue } => red > 0.5 && green < 0.5 && blue < 0.5,
        }
    }
}

fn main() -> Result<(), &'static str> {
    let red_pixel = match PixelColor::new(0.75, 0.0, 0.0) {
        Ok(red_pixel) => red_pixel,
        Err(message) => {
            println!("Failed to create pixel: {}", message);
            return Err(message);
        }
    };
    if red_pixel.is_red() {
        println!("Red is red");
    } else {
        println!("Red is not red");
    }
    let black_pixel = PixelColor::black();
    if black_pixel.is_red() {
        println!("Black is red");
    } else {
        println!("Black is not red");
    }
    Ok(())
}
