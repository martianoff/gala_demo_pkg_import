# GALA Demo Package Import (Standalone)

This example demonstrates how to use GALA without Bazel, using `gala build` to compile your project.

## Prerequisites

- Go 1.21+
- GALA CLI (`gala` binary)

## Quick Start

```bash
# 1. Add GALA dependencies
gala mod add github.com/martianoff/gala_demo_pkg@v0.2.3

# 2. Add Go dependencies (transitive from GALA package)
gala mod add github.com/google/uuid@v1.6.0 --go

# 3. Build
gala build

# 4. Run
./gala_demo_pkg_import
```

## Project Structure

Your project only needs these files:

```
gala_demo_pkg_import/
├── main.gala              # GALA source code
├── gala.mod               # GALA dependencies (source of truth)
├── gala.sum               # Dependency checksums
└── gala_demo_pkg_import   # Built binary (after gala build)
```

**No go.mod, no _gala folder, no .gen.go files in your project!**

## Setup

### 1. Initialize GALA module

```bash
gala mod init github.com/your/project
```

### 2. Add dependencies

```bash
# Add a GALA package
gala mod add github.com/martianoff/gala_demo_pkg@v0.2.3

# Add a Go package (transitive dep from GALA package)
gala mod add github.com/google/uuid@v1.6.0 --go
```

Or edit `gala.mod` directly:

```
module github.com/your/project

gala 1.0

require (
    github.com/martianoff/gala_demo_pkg v0.2.3
    github.com/google/uuid v1.6.0 // go
)
```

### 3. Write GALA code

```gala
package main

import "fmt"
import "github.com/martianoff/gala_demo_pkg"
import "github.com/google/uuid"

func main() {
    val sum = demomath.Add(10, 20)
    fmt.Printf("10 + 20 = %d\n", sum)
    fmt.Println("UUID:", uuid.New().String())
}
```

### 4. Build

```bash
# Build with default output name
gala build

# Build with verbose output
gala build -v

# Build with custom output name
gala build -o myapp
```

### 5. Run

```bash
./gala_demo_pkg_import
# or
gala run
```

## How It Works

1. **gala.mod** - Single source of truth for all dependencies
2. **gala build** - Transpiles GALA to Go, downloads dependencies, produces binary
3. **Clean project** - No generated files in your project folder

Behind the scenes:
- Build workspace at `~/.gala/build/<hash>/` (per-project)
- Stdlib cached at `~/.gala/stdlib/v<version>/`
- GALA packages cached at `~/.gala/pkg/mod/`
- Go packages cached at `~/.gala/go/pkg/mod/`

## Commands

| Command | Description |
|---------|-------------|
| `gala build` | Build project to binary |
| `gala build -v` | Build with verbose output |
| `gala build -o name` | Build with custom output name |
| `gala run` | Build and run |
| `gala run -- args` | Build and run with arguments |
| `gala clean` | Clean build workspace for this project |
| `gala clean --all` | Clean all GALA caches |

## Notes

- Mark Go dependencies with `// go` comment in gala.mod
- GALA packages are cached in `~/.gala/pkg/mod/`
- Go packages are cached in `~/.gala/go/pkg/mod/`
- Run `gala mod tidy` after changing imports
