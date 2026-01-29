# GALA Demo Package Import (Go Modules)

This example demonstrates how to use GALA with Go modules to import external GALA packages.

## Prerequisites

- Go 1.21+
- GALA CLI (`gala` binary)

## Quick Start

```bash
# 1. Add GALA dependencies
gala mod add github.com/martianoff/gala_demo_pkg@v0.2.3

# 2. Transpile
gala transpile -i main.gala -o main_gen.go

# 3. Run
go run main_gen.go
```

## Project Structure

```
gala_demo_pkg_import/
├── main.gala          # GALA source code
├── gala.mod           # GALA dependencies (source of truth)
├── go.mod             # Auto-managed by transpiler
├── main_gen.go        # Generated Go code
└── _gala/             # Embedded GALA stdlib (auto-generated)
    ├── std/
    ├── go_interop/
    ├── collection_immutable/
    ├── collection_mutable/
    └── concurrent/
```

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

func main() {
    val sum = demomath.Add(10, 20)
    fmt.Printf("10 + 20 = %d\n", sum)
}
```

### 4. Transpile

```bash
gala transpile -i main.gala -o main_gen.go
```

This automatically:
- Generates `main_gen.go` from your GALA code
- Extracts the GALA stdlib to `_gala/`
- Updates `go.mod` with necessary dependencies

### 5. Build and Run

```bash
go run main_gen.go
```

Or build a binary:

```bash
go build -o demo main_gen.go
./demo
```

## How It Works

1. **gala.mod** - Single source of truth for all dependencies
2. **gala transpile** - Transpiles GALA to Go, manages go.mod automatically
3. **go build** - Standard Go build process

## Notes

- The `_gala/` directory contains the embedded stdlib - commit to version control
- The transpiler auto-manages `go.mod` - no manual editing needed
- GALA packages are cached in `~/.gala/pkg/mod/`
- Mark Go dependencies with `// go` comment in gala.mod
