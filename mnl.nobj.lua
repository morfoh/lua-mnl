
c_module "mnl" {

-- enable FFI bindings support.
luajit_ffi = false,

-- load MNL shared library.
ffi_load"mnl",

sys_include "libmnl/libmnl.h",

subfiles {
"src/socket.nobj.lua",
},
}

