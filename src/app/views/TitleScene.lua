require "app.Common"
local Scene = require "app.Scene"
local Block = require "app.Block"

local Next = require "app.Next"

--- @class TitleScene
local TitleScene = class("TitleScene",cc.load("mvc").ViewBase)

---onCreate
function TitleScene:onCreate()

    ---- 初始化背景
    --display.newSprite("back.png")
    --    :move(display.center)
    --    :addTo(self)

    self:ProcessInput()
    self.scene = Scene.new(self)
    self.next = Next.new(self)

    --self.b = Block.new(self.scene, 1)
    --self.b:Place()
    ----- attempt to index local 'self' (a nil value) . == :
    ----- attempt to call method 'schedulerScriptFunc' (a nil value)
    ----- attempt to call global 'getScheduler' (a nil value)
    ----- syntax error during pre-compilation
    ----- attempt to perform arithmetic on local 'x' (a nil value)

    self:Gen()
    local tick = function()
        if self.pauseGame then
            return
        end
        if not self.b:Move(0, -1) then
            self:Gen()
        else
            self.b:Clear()
            while self.scene:CheckAndSweep() > 0 do
                self.scene:Shift()
            end
            self.b:Place()
        end
    end

    cc.Director:getInstance():getScheduler():scheduleScriptFunc(tick, 0.3, false)
end

function TitleScene:Gen()
    local stype = self.next:Next()
    self.b = Block.new(self.scene, stype)
    if not self.b:Place() then
        --- Game Over
        self.scene:Clear()
    end
end

function TitleScene:ProcessInput()

    -- 键盘监听器
    local listener = cc.EventListenerKeyboard:create()
    local keyState = {}

    --- EVENT_KEYBOARD_PRESSED
    listener:registerScriptHandler(function(keyCode, event)
        keyState[keyCode] = true
    end, cc.Handler.EVENT_KEYBOARD_PRESSED)

    --- EVENT_KEYBOARD_RELEASED
    listener:registerScriptHandler(function(keyCode, event)
        keyState[keyCode] = nil
        -- w
        if keyCode == 146 then
            self.b:Rotation()
        -- p
        elseif keyCode == 139 then
            self.pauseGame = not self.pauseGame
        end
    end, cc.Handler.EVENT_KEYBOARD_RELEASED)

    --- 分发器
    local eventDiapatcher = self:getEventDispatcher()
    eventDiapatcher:addEventListenerWithSceneGraphPriority(listener, self)

    local inputTick = function()
        for keyCode, v in pairs(keyState) do
            -- s
            if keyCode == 142 then
                self.b:Move(0, -1)
            -- a
            elseif keyCode == 124 then
                self.b:Move(-1, 0)
            -- d
            elseif keyCode == 127 then
                self.b:Move(1, 0)
            end
        end
    end

    cc.Director:getInstance():getScheduler():scheduleScriptFunc(inputTick, 0.1, false)
end

return TitleScene