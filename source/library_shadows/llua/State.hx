package llua;

#if !cpp
#error 'LuaJIT supports only C++ target platforms.'
#end
import hxlua.Types;

typedef State = cpp.RawPointer<hxlua.Lua_State>;
typedef StatePointer = cpp.RawPointer<hxlua.Lua_State>;
