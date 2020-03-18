--[[
    Blackout
    背景を表示する
    
    func:
        setImage(image(Drawable))
        表示する画像を設定する
            image(Drawable)
            イメージデータ
]]
local Blackout = Instance:extend('Blackout')

function Blackout:init()
    Blackout.super:init(self)

    self.color = {1, 1, 1, 0}
    Timer.tween(1, self.color, {1, 1, 1, 0.5}, 'in-out-quad')
end

function Blackout:update(dt)
end

function Blackout:draw()
    love.graphics.setColor(unpack(self.color))
    love.graphics.draw(self.image, self.x, self.y)
end

function Blackout:setImage(imageData)
    self.image = imageData
end

function Blackout:delete()
    self.super:delete(self) -- selfを明示的に書いてあげる必要あり
end

return Blackout
