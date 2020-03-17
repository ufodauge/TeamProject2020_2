local Text = Instance:extend('Text')

function Text:init()
    Text.super:init(self)
end

function Text:update(dt)
end

function Text:draw()
    love.graphics.setColor(1, 1, 1, 1)
end

function Text:delete()
    self.super:delete(self) -- selfを明示的に書いてあげる必要あり
end

return Text
