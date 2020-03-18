local gameover = {}

gameover.name = 'gameover'

local Tween = Timer.tween

local blackout = nil
local gameover = nil
local text = nil

function gameover:init()
end

function gameover:enter(from, score)
    self.from = from

    blackout = Blackout()
    blackout:setImage(Data.Image.blackout)

    gameover = Gameover()
    gameover:setPosition(120, 90)

    text = {}
    text.score = Text()
    text.score:setText('Score:\t' .. score)
    text.score:setAlign('middle')
    text.score:setFont(Data.Font.middle)
    text.score:setPosition(512, 400)
    text.score:setDelay(2000)

    text.AorB = Text()
    text.score:setText('Continue?\t\nA: Yes\t/\tB: No')
    text.AorB:setAlign('middle')
    text.AorB:setFont(Data.Font.middle)
    text.AorB:setPosition(512, 440)
    text.AorB:setDelay(2000)
end

function gameover:update(dt)
end

function gameover:draw()
    self.from:draw()
end

function gameover:leave()
end

return gameover
