use std::fs;

struct Box {
    l: i32,
    w: i32,
    h: i32
}

impl Box {
    fn new(dim_str: &str) -> Self {
        let dim: Vec<i32> = dim_str
            .trim()
            .split("x")
            .map(|s| s.parse().unwrap())
            .collect();
        Box {
            l: dim[0],
            w: dim[1],
            h: dim[2]
        }
    }

    fn volume(&self) -> i32{
        self.l*self.w*self.h
    }

    fn wrapping_paper(&self) -> i32{
        2*self.l*self.w + 2*self.w*self.h + 2*self.h*self.l
        + vec![self.l*self.h, self.h*self.w, self.w*self.l].iter().min().unwrap()
    }

    fn ribbon(&self) -> i32 {
        *vec![2*(self.l+self.h), 2*(self.h+self.w), 2*(self.w+self.l)].iter().min().unwrap() + self.volume()
    }
}
fn get_input() -> Vec<String> {
    fs::read_to_string("src/input.txt").unwrap()
    .split("\n")
    .map(|l| l.to_string())
    .collect()
}

fn part1() -> i32 {
    let input = get_input();
    input.iter()
    .map(|d| Box::new(d).wrapping_paper())
    .sum()
}

fn part2() -> i32 {
    let input = get_input();
    input.iter()
    .map(|x| Box::new(x).ribbon())
    .sum()
}

fn main() {
    // println!("{}", part1());
    println!("{}", part2());
    // println!("{}", Box::new("2x3x4").wrapping_paper());
    // println!("{}", "123".parse().unwrap());
}
