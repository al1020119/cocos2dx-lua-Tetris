
--- @class MyApp
local MyApp = class("MyApp", cc.load("mvc").AppBase)

-- 构造方法
function MyApp:onCreate()
    math.randomseed(os.time())
end

return MyApp
