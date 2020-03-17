local AnimationTest = Instance:extend('AnimationTest')

function AnimationTest:init()
    AnimationTest.super:init(self)

    self.x, self.y = 0, 0

    self.width = 32
    self.height = 32
end

function AnimationTest:update(dt)
    self.tilesets:update(dt)
end

function AnimationTest:draw()
    love.graphics.setColor(1, 1, 1, 1)
    self.tilesets:draw(self.x, self.y)
end

function AnimationTest:setTiles(tilesets)
    self.tilesets = AnimationManager()
    self.tilesets:setTilesets(tilesets)
end

function AnimationTest:delete()
    self.super:delete(self) -- selfを明示的に書いてあげる必要あり
end

return AnimationTest
