
--- @class MainScene
local MainScene = class("MainScene",cc.load("mvc").ViewBase)
--local MainScene = class("MainScene", function() return display.newScene("MainScene") end)

---onEnter
function MainScene:onEnter()
    print("onEnter")
end

---createStaticButton 通用创建按钮方法
---@param node table
---@param imageName table
---@param x table
---@param y table
---@param callBack table
local function createStaticButton(node, imageName, x, y, callBack)

    local btn = ccui.Button:create(imageName, imageName)
    btn:move(x, y)
    btn:addClickEventListener(callBack)
    btn:addTo(node)

end

---onCreate
function MainScene:onCreate()

    -- 初始化背景
    display.newSprite("back.png")
           :move(display.center)
           :addTo(self)

    -- 初始化按钮
    createStaticButton(self, "start.png", display.cx - 150, display.cy - 150, function ()
        self:getApp():enterScene("TitleScene")
    end)
    createStaticButton(self, "leave.png", display.cx + 150, display.cy - 150, function ()
        self:getApp():enterScene("TitleScene")
    end)

end

return MainScene