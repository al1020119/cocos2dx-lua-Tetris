
cc.FileUtils:getInstance():setPopupNotify(false)

require "config"
require "cocos.init"

local function main()
    require("app.MyApp"):create():run()
end

---- 针对于lua的错误，一般分为编译时错误和运行时错误；
---
---
--- 针对于运行错误，一般情况下，你可以参考如下代码：

-- lua提供，调用其他函数，可以捕捉到错误，第一个参数为要调用的函数， 第二个参数为捕捉到错误时所调用的函数
-- 返回的参数status为错误状态， msg为错误信息
local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end

---
---
--- 针对于编译错误，可以通过如下的代码来打印错误信息：

--const char* error = lua_tostring(L, -1);
--CCLOG("[LUA ERROR] error result: %s",error);
--lua_pop(L, 1);

--在LuaStack::luaLoadBuffer(...)中
--
--
--switch (r)
--{
--    case LUA_ERRSYNTAX:     // 编译出错
--    CCLOG("[LUA ERROR] load \"%s\", error: syntax error during pre-compilation.", chunkName);
--break;
--case LUA_ERRMEM:        // 内存分配错误
--CCLOG("[LUA ERROR] load \"%s\", error: memory allocation error.", chunkName);
--break;
--case LUA_ERRRUN:        // 运行错误
--CCLOG("[LUA ERROR] load \"%s\", error: run error.", chunkName);
--break;
--case LUA_YIELD:         // 线程被挂起
--CCLOG("[LUA ERROR] load \"%s\", error: thread has suspended.", chunkName);
--break;
--case LUA_ERRFILE:
--CCLOG("[LUA ERROR] load \"%s\", error: cannot open/read file.", chunkName);
--break;
--case LUA_ERRERR:        // 运行错误处理函数时发生错误
--CCLOG("[LUA ERROR] load \"%s\", while running the error handler function.", chunkName);
--break;
--default:
--CCLOG("[LUA ERROR] load \"%s\", error: unknown.", chunkName);
--}
--// (2)处添加部分代码
--const char* error = lua_tostring(L, -1);
--CCLOG("[LUA ERROR] error result: %s",error);
--lua_pop(L, 1);