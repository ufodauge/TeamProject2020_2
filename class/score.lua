--[[
    Score
    スコアを管理・表示する
    
    func:
        setStatus(score(number))
        スコアを計上する
            score(number)
            計上するスコア
]]
local Score = Instance:extend('Score')

function Score:init()
    Score.super:init(self)

    self.score = 0
end

function Score:update(dt)
end

function Score:draw()
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.setFont(Data.Font.middle)
    love.graphics.print('SCORE: ' .. self.score, self.x, self.y)
end

function Score:delete()
    self.super:delete(self) -- selfを明示的に書いてあげる必要あり
end

function Score:setScore(score)
    self.score = score
end

function Score:getScore()
    return self.score
end

function Score:setStatus(dScore)
    self.score = self.score + dScore
end

return Score
