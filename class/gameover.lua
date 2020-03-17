local Gameover = Instance:extend('Gameover')

function Gameover:init()
    Gameover.super:init(self)

    self.animationManager = AnimationManager()
    self.animationManager:setTilesets(Data.Animation.gameover)
    self.animationManager:setPermanence(false)

    self.time = 0
end

function Gameover:update(dt)
    self.animationManager:update(dt)

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
