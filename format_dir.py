#!/usr/bin/env python3
import os
import argparse

def format_directory_structure(root_dir, include_git=False, indent=0):
    result = ""
    for item in sorted(os.listdir(root_dir)):
        item_path = os.path.join(root_dir, item)
        if not include_git and item == ".git":
            continue
        result += " " * indent + f"{item}/\n" if os.path.isdir(item_path) else " " * indent + f"{item}\n"
        if os.path.isdir(item_path):
            result += format_directory_structure(item_path, include_git, indent + 4)
    return result

def main():
    parser = argparse.ArgumentParser(description="Format a directory structure with indentation.")
    parser.add_argument("directory", type=str, nargs="?", default=".", help="The root directory to format (default: current directory).")
    parser.add_argument("--include-git", action="store_true", help="Include the .git/ folder in the output.")
    args = parser.parse_args()

    if not os.path.isdir(args.directory):
        print(f"Error: {args.directory} is not a valid directory.")
        exit(1)

    print(format_directory_structure(args.directory, args.include_git))

if __name__ == "__main__":
    main()

