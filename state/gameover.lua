local gameover = {}
gameover.name = 'gameover'

local Tween = Timer.tween

function gameover:init()
end

function gameover:enter(from)
    self.from = from

    blackout = Blackout()
    blackout:setImage(Data.Image.blackout)

    self.gameover = Gameover()
    self.gameover:setPosition(120, 90)
end

function gameover:update(dt)
end

function gameover:draw()
    self.from:draw()
end

function gameover:leave()
end

return gameover
