-- Copyright (c) 2012 by Christian Wiese <chris@opensde.org>
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-- THE SOFTWARE.

basetype "socklen_t"		"integer" "0"
basetype "socklen_t *"		"lightuserdata" "NULL"
basetype "pid_t"		"integer" "0"

--
-- mnl_socket
--
object "mnl_socket" {
	c_source [[
typedef struct mnl_socket mnl_socket;
]],
	-- The first constructor can be called as: mnl.mnl_socket(bus) or
	-- mnl.mnl_socket.new(bus) The default name for a constructor is 'new'
	constructor {
		c_call "mnl_socket *" "mnl_socket_open" { "int", "bus" }
	},
	-- alternatively mnl.mnl_socket.open(bus)
	constructor "open" {
		c_call "mnl_socket *" "mnl_socket_open" { "int", "bus" }
	},
	-- "close" destructor allows freeing of the object before it gets GC'ed
	destructor "close" {
		c_method_call "int" "mnl_socket_close" {}
	},
	-- bind netlink socket
	method "bind" {
		c_method_call "int" "mnl_socket_bind" { "unsigned int", "groups", "pid_t", "pid" }
	},
	-- obtain file descriptor from netlink socket
	method "get_fd" {
		c_method_call "int" "mnl_socket_get_fd" {}
	},
	-- obtain Netlink PortID from netlink socket
	method "get_portid" {
		c_method_call "unsigned int" "mnl_socket_get_portid" {}
	},
	-- send a netlink message of a certain size
	method "sendto" {
		c_method_call "ssize_t" "mnl_socket_sendto" { "const void *", "req", "size_t", "siz" }
	},
	-- receive a netlink message
	method "recvfrom" {
		c_method_call "ssize_t" "mnl_socket_recvfrom" { "void *", "req", "size_t", "siz" }
	},
	-- set Netlink socket option
	method "setsockopt" {
		c_method_call "int" "mnl_socket_setsockopt" { "int", "type", "void *", "buf", "socklen_t", "len" }
	},
	-- get Netlink socket option
	method "getsockopt" {
		c_method_call "int" "mnl_socket_getsockopt" { "int", "type", "void *", "buf", "socklen_t *", "len" }
	},
}

