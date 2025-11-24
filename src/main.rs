use std::fs;
use std::path::Path;

fn walk_dir(path: &Path) -> std::io::Result<()> {
    let mut stack = vec![path.to_path_buf()];
    
    while let Some(current_path) = stack.pop() {
        if current_path.is_dir() {
            for entry in fs::read_dir(&current_path)? {
                let entry = entry?;
                let entry_path = entry.path();
                
                println!("{}", entry_path.display());
                
                if entry_path.is_dir() {
                    stack.push(entry_path);
                }
            }
        }
    }
    Ok(())
}

fn main() {
    let current_dir = Path::new(".");
    
    if let Err(e) = walk_dir(current_dir) {
        eprintln!("Error: {}", e);
        std::process::exit(1);
    }
}
