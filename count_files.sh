#!/bin/bash

if [ "$1" = "-h" ]; then
echo "Usage: ./count_files.sh [directory] [extension]"
exit 0
fi

TARGET_DIR=$1
if [ -z "$TARGET_DIR" ]; then
  TARGET_DIR="/etc"
fi

EXTENSION=$2
if [ -z "$EXTENSION" ]; then
  EXTENSION="conf"
fi

if [ ! -d "$TARGET_DIR" ]; then
  echo "Error: directory $TARGET_DIR does not exist"
  exit 1
fi

count_items() {
  local dir=$1
  local ftype=$2
  find "$dir" -maxdepth 1 -type "$ftype" 2>/dev/null | wc -l
}

files=$(count_items "$TARGET_DIR" "f")
dirs=$(count_items "$TARGET_DIR" "d")
links=$(count_items "$TARGET_DIR" "l")

by_ext=$(find "$TARGET_DIR" -maxdepth 1 -type f -name "*.$EXTENSION" 2>/dev/null | wc -l)

files_all=$(find "$TARGET_DIR" -type f 2>/dev/null | wc -l)

total_size=$(find "$TARGET_DIR" -type f -printf '%s\n' 2>/dev/null | awk '{sum += $1 / 1024} END {printf "%.2f", sum}')

echo "Statistics for directory $TARGET_DIR:"
echo "Generated: $(date '+%d-%m-%Y %H:%M:%S')"
echo "  Regular files: $files"
echo "  Directories: $((dirs - 1))"
echo "  Symbolic links: $links"
echo "  -------------------------"
echo "  Files with extension .$EXTENSION: $by_ext"
echo "  Files in all subdirectories: $files_all"
echo "  Total size: $total_size KB"
echo "  -------------------------"
echo "COMPLETED"
exit 0
