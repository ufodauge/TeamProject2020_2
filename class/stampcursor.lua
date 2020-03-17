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

    self.positionOnPaperX = math.floor((self.paperColumn - 1) / 2)
    self.positionOnPaperY = math.floor((self.paperRow - 1) / 2)
    self.onPaperIndex = 0

    self.isJoystickReleased = {x = true, y = true}

    self.keyManager = KeyManager()
    self.keyManager:register(
        {
            {
                key = 'z',
                func = function()
                    self.onPaperIndex = self:getIndex(self.positionOnPaperX, self.positionOnPaperY)
                    self.animationManager:play()
                end,
                rep = false,
                act = 'pressed'
            },
            {
                key = 'up',
                func = function()
                    self:move(0, -1)
                end,
                rep = false,
                act = 'pressed'
            },
            {
                key = 'down',
                func = function()
                    self:move(0, 1)
                end,
                rep = false,
                act = 'pressed'
            },
            {
                key = 'right',
                func = function()
                    self:move(1, 0)
                end,
                rep = false,
                act = 'pressed'
            },
            {
                key = 'left',
                func = function()
                    self:move(-1, 0)
                end,
                rep = false,
                act = 'pressed'
            }
        }
    )

    self.joystickManager = JoystickManager()
    self.joystickManager:register(
        {
            {
                key = 'a',
                func = function()
                    self.onPaperIndex = self:getIndex(self.positionOnPaperX, self.positionOnPaperY)
                    self.animationManager:play()
                end,
                rep = false,
                act = 'pressed'
            },
            {
                key = 'b',
                func = function()
                    self.onPaperIndex = self:getIndex(self.positionOnPaperX, self.positionOnPaperY)
                    self.animationManager:play()
                end,
                rep = false,
                act = 'pressed'
            },
            {
                key = 'lefty',
                func = function(axisValue)
                    if not self.isJoystickReleased.x or not self.isJoystickReleased.y then
                        return
                    end
                    if axisValue > 0 then
                        self:move(0, 1)
                    else
                        self:move(0, -1)
                    end
                end,
                rep = false,
                act = 'pressed'
            },
            {
                key = 'leftx',
                func = function(axisValue)
                    if not self.isJoystickReleased.x or not self.isJoystickReleased.y then
                        return
                    end
                    if axisValue > 0 then
                        self:move(1, 0)
                    else
                        self:move(-1, 0)
                    end
                end,
                rep = false,
                act = 'pressed'
            },
            {
                key = 'leftx',
                func = function(axisValue)
                    self.isJoystickReleased.x = false
                end,
                rep = true,
                act = 'pressed'
            },
            {
                key = 'lefty',
                func = function(axisValue)
                    self.isJoystickReleased.y = false
                end,
                rep = true,
                act = 'pressed'
            },
            {
                key = 'leftx',
                func = function(axisValue)
                    self.isJoystickReleased.x = true
                end,
                rep = true,
                act = 'released'
            },
            {
                key = 'lefty',
                func = function(axisValue)
                    self.isJoystickReleased.y = true
                end,
                rep = true,
                act = 'released'
            }
        }
    )

    self.image = Data.Image.highlight
    self.image:setFilter('nearest')
    self.animationManager = AnimationManager()
    self.animationManager:setTilesets(Data.Animation.animationStamp)
    self.animationManager:setPermanence(false)
end

function StampCursor:update(dt)
    self.keyManager:update(dt)
    self.joystickManager:update(dt)
    self.animationManager:update(dt)
end

function StampCursor:draw()
    love.graphics.setColor(1, 1, 1, 1)

    love.graphics.draw(self.image, self.x, self.y, 0, 2, 2)
    self.animationManager:draw(self.x, self.y, 0, 2, 2)

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

function StampCursor:move(dx, dy)
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
