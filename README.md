# rust-fd

A fast file finder written in Rust, inspired by [fd](https://github.com/sharkdp/fd).

## Features

- 🚀 **Fast**: Iterative directory traversal with no stack overflow on deep directories
- 🔍 **Pattern Matching**: Glob pattern support (`*.rs`, `file*`, etc.)
- 📁 **Comprehensive**: Finds files, directories, and symlinks
- 🎯 **Simple**: Easy-to-use command-line interface
- ✅ **Tested**: Handles edge cases (spaces in names, deep nesting, symlinks)

## Installation

### From Source

```bash
git clone https://github.com/atiyil/rust-fd.git
cd rust-fd
cargo build --release
```

The binary will be at `target/release/rust-fd`.

### From Crates.io (Coming Soon)

```bash
cargo install rust-fd
```

## Usage

### Basic Examples

```bash
# Find all files and directories
rust-fd

# Find all Rust files
rust-fd "*.rs"

# Find all files starting with "test"
rust-fd "test*"

# Find files containing "config"
rust-fd "*config*"
```

### Pattern Syntax

rust-fd uses glob patterns for matching:

- `*` - Matches any sequence of characters
- `?` - Matches any single character
- `[abc]` - Matches any character in the set
- `[!abc]` - Matches any character not in the set

**Note**: Patterns are case-sensitive.

## Examples

```bash
# Find all JavaScript and TypeScript files
rust-fd "*.js"
rust-fd "*.ts"

# Find all test files
rust-fd "*test*"

# Find README files
rust-fd "README*"

# Find all files (no pattern)
rust-fd
```

## Performance

rust-fd uses an iterative approach with an explicit stack for directory traversal, which:
- ✅ Prevents stack overflow on deeply nested directories
- ✅ Handles hundreds of thousands of files efficiently
- ✅ Uses constant call stack space

Tested on:
- ✅ 100-level deep directory nesting
- ✅ 500,000+ files without issues

## Development

### Running Tests

```bash
# Run the automated test suite
./test_pattern_matching.sh

# Or run with cargo
cargo test
```

### Project Structure

```
rust-fd/
├── src/
│   └── main.rs           # Main implementation
├── test_cases/           # Test files and directories
├── test_pattern_matching.sh  # Test script
├── Cargo.toml
└── README.md
```

## Roadmap

- [x] Iterative directory traversal
- [x] Glob pattern matching
- [ ] Filter by file type (file/dir/symlink)
- [ ] CLI argument parsing with clap
- [ ] Ignore .gitignore patterns
- [ ] Parallel directory traversal

## Contributing

Contributions are welcome! Feel free to open issues or submit pull requests.

## License

MIT License - see [LICENSE](LICENSE) for details.

## Acknowledgments

Inspired by [fd](https://github.com/sharkdp/fd) - a fast alternative to `find`.
