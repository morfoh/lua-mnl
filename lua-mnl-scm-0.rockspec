#!/usr/bin/env lua

package	= 'lua-mnl'
version	= 'scm-0'
source	= {
	url	= 'https://github.com/morfoh/lua-mnl'
}
description	= {
	summary	= "Lua bindings for libmnl.",
	detailed	= '',
	homepage	= 'https://github.com/morfoh/lua-mnl',
	license	= 'MIT',
	maintainer = "Christian Wiese",
}
dependencies = {
	'lua >= 5.1',
}
external_dependencies = {
	MNL = {
		header = "libmnl/libmnl.h",
		library = "mnl",
	}
}
build	= {
	type = "builtin",
	modules = {
		mnl = {
			sources = { "src/pre_generated-mnl.nobj.c" },
			libraries = { "mnl" },
		}
	}
}
