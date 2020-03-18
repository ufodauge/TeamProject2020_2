local Text = Instance:extend('Text')

local DEFAULT_LIMIT = 400

local Tween = Timer.tween

function Text:init()
    Text.super:init(self)

    self.text = ''
    self.alignment = 'left'
    self.font = nil
    self.limit = DEFAULT_LIMIT
    self.delay = 0
    self.tweens = {}

    self.ms = 0

    self.colorTable = {0, 0, 0, 0}
end

function Text:update(dt)
    self.ms = self.ms + dt
    for i, tween in ipairs(self.tweens) do
        if not tween.played and tween.delay >= self.ms then
            self.colorTable = tween.colorTableFrom
            tween.played = true

            Tween(tween.ms / 1000, self.colorTable, tween.colorTableTo, tween.method)
        end
    end
end

function Text:draw()
    love.graphics.setColor(unpack(self.colorTable))
    if self.font then
        love.graphics.setFont(self.font)
    end

    love.graphics.printf(self.text, self.x, self.y, self.limit, self.alignment)
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

function Text:setLimit(limit)
    self.limit = limit
end

function Text:setTween(delay, ms, colorTableFrom, colorTableTo, method)
    table.insert(
        self.tweens,
        {
            delay = delay,
            played = false,
            ms = ms,
            colorTableFrom = colorTableFrom,
            colorTableTo = colorTableTo,
            method = method
        }
    )
end

return Text
