#
# Lua bindings for libmnl
#
cmake_minimum_required(VERSION 2.8)

project(lua-mnl C)

set(BUILD_SHARED_LIBS TRUE)

set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)

set(INSTALL_CMOD share/lua/cmod CACHE PATH "Directory to install Lua binary modules (configure lua via LUA_CPATH)")

set(COMMON_CFLAGS "${CFLAGS}")
set(COMMON_LDFLAGS)
set(COMMON_LIBS)

## Lua 5.1.x
include(FindLua51)
if(NOT ${LUA51_FOUND})
    message(FATAL_ERROR "The FindLua51 module could not find lua :-(")
endif()
set(COMMON_LIBS "${COMMON_LIBS};${LUA_LIBRARIES}")

## LibMnl
include(FindPkgConfig)
pkg_search_module(MNL REQUIRED libmnl)
set(COMMON_CFLAGS "${COMMON_CFLAGS} ${MNL_CFLAGS}")
set(COMMON_LDFLAGS "${COMMON_LDFLAGS} ${MNL_LDFLAGS}")
set(COMMON_LIBS "${COMMON_LIBS};${MNL_LIBRARIES}")

## LuaNativeObjects
include(LuaNativeObjects)

include_directories(${CMAKE_CURRENT_SOURCE_DIR}
                    ${CMAKE_CURRENT_BINARY_DIR}
                    ${LUA_INCLUDE_DIR})

## LuaMnl
set(LUA_MNL_SRC
	mnl.nobj.lua
)

if(${USE_PRE_GENERATED_BINDINGS})
	set(LUA_MNL_SRC src/pre_generated-mnl.nobj.c)
else()
	# Generate Lua bindings.
	GenLuaNativeObjects(LUA_MNL_SRC)
endif()

add_library(lua-mnl MODULE ${LUA_MNL_SRC})
target_link_libraries(lua-mnl ${COMMON_LIBS})
set_target_properties(lua-mnl PROPERTIES PREFIX "")
set_target_properties(lua-mnl PROPERTIES COMPILE_FLAGS "${COMMON_CFLAGS}")
set_target_properties(lua-mnl PROPERTIES OUTPUT_NAME mnl)

install(TARGETS lua-mnl
        DESTINATION "${INSTALL_CMOD}")

