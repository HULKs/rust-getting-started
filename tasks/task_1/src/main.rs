fn is_red(red_intensity: f32) -> bool {
    red_intensity > 0.5
}

fn main() {
    println!("Hello, world!");
    let red_intensity = 0.75;
    if is_red(red_intensity) {
        println!("is red");
    } else {
        println!("not red");
    }
}
