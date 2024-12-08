# Dependency Checker Tool

## Description

The Dependency Checker Tool is a simple shell script designed to validate the dependencies listed in a `package.json` file. It verifies if each dependency exists on the npm registry and warns about potential security risks, such as dependency confusion attacks, for packages not found on the registry.

## Features

- Validates each dependency and development dependency in a `package.json` file.
- Flags dependencies that do not exist on the npm registry as potentially vulnerable to dependency confusion.
- Easy to use: pass the `package.json` file as an argument to the script.

## Requirements

- Bash shell (available by default on most Unix-based systems)
- Internet connectivity to query the npm registry
- A valid `package.json` file

## Installation

1. Clone the repository or download the script.
2. Ensure the script has executable permissions:
   ```bash
   chmod +x check_dependencies.sh
   ```

## Usage

Run the script by passing the path to the `package.json` file as an argument:
```bash
./check_dependencies.sh path/to/package.json
```

### Example

Given the following `package.json` file:

```json
{
  "dependencies": {
    "express": "^4.17.1",
    "nonexistent-package": "^1.0.0"
  },
  "devDependencies": {
    "jest": "^29.0.0"
  }
}
```

Running the script:
```bash
./check_dependencies.sh package.json
```

Output:
```
Checking dependencies in package.json...

Checking express... ✅ Exists on npm registry
Checking nonexistent-package... ❌ May be vulnerable to dependency confusion
Checking jest... ✅ Exists on npm registry
```

## Notes

- The tool assumes the `package.json` file is in a valid JSON format. If the file is invalid, the script will terminate with an error.
- Any dependency flagged as missing from the npm registry should be thoroughly investigated to confirm its legitimacy.
