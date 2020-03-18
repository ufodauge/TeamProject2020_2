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

function Text:setText(text)
end

function Text:setAlign(option)
end

function Text:setFont(font)
end

function Text:setPosition(x, y)
end

function Text:setDelay(ms)
end

return Text
