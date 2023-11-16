# p - Unified package manager script

## Overview

The `p` script is a convenient tool that abstracts away the complexity of using different JavaScript package managers. It automatically detects and uses the correct package manager based on the presence of specific lock files in your project directory or its parent directories. Supports npm, Yarn, pnpm and Bun.

## Features

- Automatically detects the package manager (npm, Yarn, pnpm, Bun) based on lock files.
- Supports common package manager commands and translates them according to the detected manager.
- Handles `--dev` flag appropriately for each package manager.
- Runs scripts defined in `package.json` by adding `run` when necessary.
- Echoes the executed command for clarity.

## Installation

1. Clone this repository or download the `p` script.
2. Place the script in a directory included in your system's PATH, e.g., `/usr/local/bin`.
3. Make the script executable: `chmod +x /path/to/p`.

## Usage

Run the script with any package manager command, like so:

```bash
p install
p add <package-name>
p add --dev <package-name>
p remove <package-name>
```

## License

This project is open-sourced under the MIT License. See the LICENSE file for more details.
