#!/bin/bash
# Test script for rust-fd pattern matching functionality

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BINARY="$SCRIPT_DIR/target/debug/rust-fd"
TEST_DIR="$SCRIPT_DIR/test_cases"

echo "Running rust-fd pattern matching tests..."
echo "=========================================="
echo ""

# Build first
cargo build 2>&1 | grep -E "(Compiling|Finished)" || true
echo ""

# Run tests from test_cases directory
cd "$TEST_DIR"

# Test 1: Pattern *.rs
echo "Test 1: Pattern *.rs"
RESULT=$($BINARY "*.rs" 2>/dev/null | wc -l | tr -d ' ')
[ "$RESULT" -eq 1 ] && echo "✓ PASS: Found 1 .rs file" || echo "✗ FAIL: Expected 1, got $RESULT"
echo ""

# Test 2: Pattern *.txt
echo "Test 2: Pattern *.txt"
RESULT=$($BINARY "*.txt" 2>/dev/null | wc -l | tr -d ' ')
[ "$RESULT" -eq 3 ] && echo "✓ PASS: Found 3 .txt files" || echo "✗ FAIL: Expected 3, got $RESULT"
echo ""

# Test 3: Pattern file*
echo "Test 3: Pattern file*"
RESULT=$($BINARY "file*" 2>/dev/null | wc -l | tr -d ' ')
[ "$RESULT" -eq 5 ] && echo "✓ PASS: Found 5 files starting with 'file'" || echo "✗ FAIL: Expected 5, got $RESULT"
echo ""

# Test 4: No pattern (all files)
echo "Test 4: No pattern (all files)"
RESULT=$($BINARY 2>/dev/null | wc -l | tr -d ' ')
[ "$RESULT" -eq 118 ] && echo "✓ PASS: Found 118 items" || echo "✗ FAIL: Expected 118, got $RESULT"
echo ""

# Test 5: Case sensitivity
echo "Test 5: Case sensitivity (*.MD vs *.md)"
RESULT=$($BINARY "*.MD" 2>/dev/null | wc -l | tr -d ' ')
[ "$RESULT" -eq 0 ] && echo "✓ PASS: Case sensitive - no match for *.MD" || echo "✗ FAIL: Expected 0, got $RESULT"
echo ""

# Test 6: Complex pattern *file*
echo "Test 6: Complex pattern *file*"
RESULT=$($BINARY "*file*" 2>/dev/null | wc -l | tr -d ' ')
[ "$RESULT" -eq 7 ] && echo "✓ PASS: Found 7 files containing 'file'" || echo "✗ FAIL: Expected 7, got $RESULT"
echo ""

# Test 7: Pattern with spaces
echo "Test 7: Files with spaces in names"
RESULT=$($BINARY "*spaces*" 2>/dev/null | wc -l | tr -d ' ')
[ "$RESULT" -eq 2 ] && echo "✓ PASS: Found 2 items with 'spaces'" || echo "✗ FAIL: Expected 2, got $RESULT"
echo ""

# Test 8: Deep file
echo "Test 8: Deep file (100 levels)"
RESULT=$($BINARY "deep_file.txt" 2>/dev/null | wc -l | tr -d ' ')
[ "$RESULT" -eq 1 ] && echo "✓ PASS: Found deep_file.txt at 100 levels" || echo "✗ FAIL: Expected 1, got $RESULT"
echo ""

echo "=========================================="
echo "All pattern matching tests completed!"
