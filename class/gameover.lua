local Gameover = Instance:extend('Gameover')

Gameover.isSwitching = false

local blackout = nil

local continueYes = nil
local continueNo = nil

function Gameover:init()
    Gameover.super:init(self)

    Gameover.isSwitching = false

    continueYes =
        lume.once(
        function()
            if Gameover.isSwitching then
                return
            end
            Gameover.isSwitching = true
            blackout = Blackout(1)
            blackout:setImage(Data.Image.blackout)
            Timer.after(
                1,
                function()
                    blackout:delete()
                    State.pop()
                    State.switch(States.Maingame)
                end
            )
        end
    )

    continueNo =
        lume.once(
        function()
            if Gameover.isSwitching then
                return
            end
            Gameover.isSwitching = true
            blackout = Blackout(1)
            blackout:setImage(Data.Image.blackout)
            Timer.after(
                1,
                function()
                    blackout:delete()
                    -- State.switch(maingame)
                    love.event.quit(0)
                end
            )
        end
    )

    self.animationManager = AnimationManager()
    self.animationManager:setTilesets(Data.Animation.gameover)
    self.animationManager:setPermanence(false)

    Timer.after(
        2,
        function()
            self.keyManager = KeyManager()
            self.keyManager:register(
                {
                    {
                        key = 'z',
                        func = continueYes,
                        rep = false,
                        act = 'pressed'
                    },
                    {
                        key = 'x',
                        func = continueNo,
                        rep = false,
                        act = 'pressed'
                    }
                }
            )

            self.joystickManager = JoystickManager()
            self.joystickManager:register(
                {
                    {
                        key = 'a',
                        func = continueYes,
                        rep = false,
                        act = 'pressed'
                    },
                    {
                        key = 'b',
                        func = continueNo,
                        rep = false,
                        act = 'pressed'
                    }
                }
            )
        end
    )

    self.time = 0
end

function Gameover:update(dt)
    self.animationManager:update(dt)
    if self.keyManager then
        self.keyManager:update(dt)
        self.joystickManager:update(dt)
    end

    self.time = self.time + dt

    if self.time >= 1 and self.time < 2 then
        self.time = 2
        self.animationManager:play()
    end
end

function Gameover:draw()
    love.graphics.setColor(1, 1, 1, 1)

    self.animationManager:draw(self.x, self.y, 0, 3, 3)
end

function Gameover:delete()
    self.super:delete(self) -- selfを明示的に書いてあげる必要あり
end

return Gameover
