--[[
    Background
    背景を表示する
    
    func:
        setImage(image(Drawable))
        表示する画像を設定する
            image(Drawable)
            イメージデータ
]]
local Background = Instance:extend('Background')

function Background:init()
    Background.super:init(self)
end

function Background:update(dt)
end

function Background:draw()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(self.image, self.x, self.y)
end

function Background:setImage(imageData)
    self.image = imageData
end

function Background:delete()
    self.super:delete(self) -- selfを明示的に書いてあげる必要あり
end

return Background
