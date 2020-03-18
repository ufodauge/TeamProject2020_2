local gameoverState = {}

gameoverState.name = 'gameoverState'

local Tween = Timer.tween

local blackout = nil
local gameover = nil
local text = nil

function gameoverState:init()
end

function gameoverState:enter(from, score)
    self.from = from

    blackout = Blackout()
    blackout:setImage(Data.Image.blackout)

    gameover = Gameover()
    gameover:setPosition(120, 90)

    texts = {}
    texts.score = Text()
    texts.score:setText(('Score: %d'):format(score))
    texts.score:setAlign('center')
    texts.score:setFont(Data.Font.middle)
    texts.score:setPosition(312, 400)
    texts.score:setLimit(400)
    texts.score:setTween(2, 1000, {0, 0, 0, 0}, {1, 1, 1, 1}, 'in-out-quad')

    texts.AorB = Text()
    texts.AorB:setText(('Continue?\nA/Z: Yes   B/X: No'):format())
    texts.AorB:setAlign('center')
    texts.AorB:setFont(Data.Font.middle)
    texts.AorB:setPosition(312, 440)
    texts.AorB:setLimit(400)
    texts.AorB:setTween(2, 1000, {0, 0, 0, 0}, {1, 1, 1, 1}, 'in-out-quad')
end

function gameoverState:update(dt)
end

function gameoverState:draw()
    self.from:draw()
end

function gameoverState:leave()
    blackout:delete()
    gameover:delete()
    for i, text in ipairs(texts) do
        text:delete()
    end
end

return gameoverState
