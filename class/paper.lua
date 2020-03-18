--[[
    Paper
    捺印される台紙
    
    func:
        setStatus(status(string))
        捺印済み(imorinted)か否か(plain)を設定する
            status(string)
            変更するステータス

        getPenalty()
        ペナルティがあったフレームのみ 1 と返す

        getStatus()
        ハンコが正常に押されたフレームのみスコアを返す
        ❌ペナルティがあったフレームのみスコアを返す

        setImprintStatus(index(number))
        捺印があった台紙を監視する
            index(number)
            捺印されたフレームにカーソルが合っていた台紙のインデックス
            （通常は 0 ）
]]
local Paper = Instance:extend('Paper')

Paper.score = 0

function Paper:init()
    Paper.super:init(self)
    self.status = 'plain'
    self.grHandle = Data.Image.emptyDocument
    self.missFlag = 0 -- ミスしたら１
    self.correctFlag = 0 -- 正しくハンコを押したら１

    self.changed = false
end

function Paper:update(dt)
end

function Paper:draw()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(self.grHandle, self.x, self.y, 0, 2, 2)
end

function Paper:delete()
    self.super:delete(self) -- selfを明示的に書いてあげる必要あり
end

function Paper:setStatus(status)
    self.status = status

    if self.status == 'plain' then
        self.grHandle = Data.Image.emptyDocument
    end
    if self.status == 'imprinted' then
        self.grHandle = Data.Image.approvedDocument
    end

    self.grHandle:setFilter('nearest')
end

function Paper:isImprinted()
    return self.status == 'imprinted'
end

-- ペナルティがあったフレームのみ 1 と返す
function Paper:getPenalty()
    self.returnValue = self.missFlag
    self.missFlag = 0
    return self.returnValue
end

-- スコアが入ったフレームだけスコアを返す
function Paper:getStatus()
    self.returnValue = 0
    if self.correctFlag == 1 then
        self.returnValue = SCORE_STAMPED_SCORE
        self.correctFlag = 0
    end

    return self.returnValue
end

function Paper:setImprintStatus(index)
    self.index.status = 'inprinted'
end

function Paper:isImprinted()
    return not self.changed
end

-- 捺印する
function Paper:stamp()
    self.changed = false
    if (self.status == 'imprinted') then
        -- self:setStatus("plain")
        -- ミス
        self.changed = false
        self.missFlag = 1
    else
        -- 正しくハンコ押した
        self.changed = true
        self.correctFlag = 1
        self:setStatus('imprinted')
    end
end

return Paper
