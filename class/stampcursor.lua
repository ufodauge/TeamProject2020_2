--[[
    StampCursor
    ハンコのカーソル
    
    func:
        setPapersSize(column(number), row(number))
        台紙の縦横の配置を設定する
            column(number)
            列数
            row(number)
            行数

        getStatus()
        捺印した場所のインデックスを返す
]]
local StampCursor = Instance:extend('StampCursor')

function StampCursor:init()
    StampCursor.super:init(self)
    self.paperColumn = PAPER_COLUMN
    self.paperRow = PAPER_TOTAL / PAPER_COLUMN

    self.positionOnPaperX = math.floor((self.paperColumn-1)/2)
    self.positionOnPaperY = math.floor((self.paperRow-1)/2)
    self.onPaperIndex = 0

    self.keyManager = KeyManager()
    self.keyManager:register(
        {
            {
                key = 'z',
                func = function()
                    self.onPaperIndex = self:getIndex(self.positionOnPaperX,self.positionOnPaperY)
                end,
                rep = false,
                act = 'pressed'
            },
            {
                key = 'up',
                func = function()
                    self:move(0,-1)
                end,
                rep = false,
                act = 'pressed'
            },
            {
                key = 'down',
                func = function()
                    self:move(0,1)
                end,
                rep = false,
                act = 'pressed'
            },
            {
                key = 'right',
                func = function()
                    self:move(1,0)
                end,
                rep = false,
                act = 'pressed'
            },
            {
                key = 'left',
                func = function()
                    self:move(-1,0)
                end,
                rep = false,
                act = 'pressed'
            }
        }
    )
end

function StampCursor:update(dt)
    self.keyManager:update(dt)
end

function StampCursor:draw()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(Data.Image.stamp, self.x, self.y,0,2,2)
    -- love.graphics.print("StampPosOnPaper(" .. self.positionOnPaperX .. ", " .. self.positionOnPaperY .. ")"..self:getIndex(self.positionOnPaperX,self.positionOnPaperY),20,520)
end

function StampCursor:delete()
    self.super:delete(self) -- selfを明示的に書いてあげる必要あり
end

function StampCursor:setPapersSize(column, row)
    self.paperColumn = column
    self.paperRow = row
end

function StampCursor:getStatus()
    returnValue = self.onPaperIndex
    self.onPaperIndex = 0
    return returnValue
end

function StampCursor:move(dx,dy)
    if self.positionOnPaperX + dx >= 0 and self.positionOnPaperX + dx < self.paperColumn then
        if self.positionOnPaperY + dy >= 0 and self.positionOnPaperY + dy < self.paperRow then

            self.positionOnPaperX = self.positionOnPaperX + dx
            self.positionOnPaperY = self.positionOnPaperY + dy

            self.x = PAPER_X + PAPER_WIDTH * self.positionOnPaperX
            self.y = PAPER_Y + PAPER_HEIGHT * self.positionOnPaperY
        end
    end
end

function StampCursor:getIndex(x, y)
    return y * self.paperRow + x + 1
end

return StampCursor
