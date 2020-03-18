local Text = Instance:extend('Text')

local Tween = Timer.tween

function Text:init()
    Text.super:init(self)

    self.text = ''
    self.alignment = 'left'
    self.font = nil
    self.delay = 0

    self.ms = 0

    self.color = {1, 1, 1, 0}
end

function Text:update(dt)
    self.ms = self.ms + dt * 1000
end

function Text:draw()
    love.graphics.setColor(1, 1, 1, 1)
    if self.ms >= self.delay then
    end
end

function Text:delete()
    self.super:delete(self) -- selfを明示的に書いてあげる必要あり
end

function Text:setText(text)
    self.text = text
end

function Text:setAlign(option)
    self.alignment = option
end

function Text:setFont(font)
    self.font = font
    self.font:setFilter('nearest', 'nearest')
end

function Text:setDelay(ms)
    self.delay = ms
end

function Text:setTween(ms, colorTableTo, method)
    self.colorTable = {0, 0, 0, 0}
    Timer.tween(ms / 1000, self.colorTable, colorTableTo, method)
end

return Text
