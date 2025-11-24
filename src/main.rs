use glob::Pattern;
use std::env;
use std::fs;
use std::path::Path;

fn walk_dir(path: &Path, pattern: Option<&Pattern>) -> std::io::Result<()> {
    let mut stack = vec![path.to_path_buf()];
    
    while let Some(current_path) = stack.pop() {
        if current_path.is_dir() {
            for entry in fs::read_dir(&current_path)? {
                let entry = entry?;
                let entry_path = entry.path();
                
                // Check if the entry matches the pattern (if provided)
                let matches = if let Some(pat) = pattern {
                    entry_path
                        .file_name()
                        .and_then(|name| name.to_str())
                        .map(|name| pat.matches(name))
                        .unwrap_or(false)
                } else {
                    true // No pattern means match everything
                };
                
                if matches {
                    println!("{}", entry_path.display());
                }
                
                // Always traverse into directories
                if entry_path.is_dir() {
                    stack.push(entry_path);
                }
            }
        }
    }
    Ok(())
}

fn main() {
    let args: Vec<String> = env::args().collect();
    
    // Parse command line arguments
    let pattern = if args.len() > 1 {
        match Pattern::new(&args[1]) {
            Ok(pat) => Some(pat),
            Err(e) => {
                eprintln!("Invalid pattern: {}", e);
                std::process::exit(1);
            }
        }
    } else {
        None
    };
    
    let current_dir = Path::new(".");
    
    if let Err(e) = walk_dir(current_dir, pattern.as_ref()) {
        eprintln!("Error: {}", e);
        std::process::exit(1);
    }
}
