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
    self.status = "plain"
    self.grHandle = Data.Image.emptyDocument
end

function Paper:update(dt)
end

function Paper:draw()
    love.graphics.setColor(1, 1, 1, 1)
    --love.graphics.rectangle("line", self.x, self.y, PAPER_WIDTH, PAPER_HEIGHT)
    --love.graphics.draw( Data.Image.emptyDocument, x, y, r, sx, sy, ox, oy, kx, ky )
    love.graphics.draw(self.grHandle, self.x, self.y,0,2,2)
end

function Paper:delete()
    self.super:delete(self) -- selfを明示的に書いてあげる必要あり
end

function Paper:setStatus(status)
    self.status = status
    if self.status == "plain" then
        self.grHandle = Data.Image.emptyDocument
    end
    if self.status == "imprinted" then
        self.grHandle = Data.Image.approvedDocument
    end


end

--スコアが入ったフレームだけスコアを返す
function Paper:getStatus()

end

function Paper:setImprintStatus(index)
    self.index.status = "inprinted"
end

--捺印する
function Paper:stamp()
    if(self.status == "imprinted")then
        love.graphics.setColor(1, 0, 0, 1)
        love.graphics.rectangle("fill", 0, 0, 1024, 512)
        self:setStatus("plain")
    else
        self:setStatus("imprinted")
    end
end

return Paper
