module github.com/martianoff/gala_demo_pkg_import

go 1.21

require github.com/martianoff/gala_demo_pkg v0.2.3

require github.com/google/uuid v1.6.0 // indirect

replace github.com/martianoff/gala_demo_pkg => C:/Users/maxmr/.gala/pkg/mod/github.com/martianoff/gala_demo_pkg@v0.2.3

require martianoff/gala/std v0.0.0

replace martianoff/gala/collection_mutable => ./_gala/collection_mutable

replace martianoff/gala/concurrent => ./_gala/concurrent

replace martianoff/gala/std => ./_gala/std

replace martianoff/gala/go_interop => ./_gala/go_interop

replace martianoff/gala/collection_immutable => ./_gala/collection_immutable
