local title = {}

title.name = 'title'

function title:init()
end

function title:enter()
    --self.fontTitle = love.graphics.newFont(64)
    self.cursorY = 0
    self.cursorYMax = 3
    self.cursorDY = 70
    self.cursorNormY = 300
    self.cursorChar = ">         <"
    self.pressZWaiting = 0
    self.keyManager = KeyManager()
    self.keyManager:register(
        {
            {
                key = 'z',
                func = function()
                    self:pressZ()
                end,
                rep = false,
                act = 'pressed'
            },
            {
                key = 'up',
                func = function()
                    self:moveCursor(-1)
                end,
                rep = false,
                act = 'pressed'
            },
            {
                key = 'down',
                func = function()
                    self:moveCursor(1)
                end,
                rep = false,
                act = 'pressed'
            },
        }
    )

end

function title:update(dt)
    self.keyManager:update(dt)

    -- Zが押されてから次のシーンに遷移するまでちょっと待つ
    if self.pressZWaiting >= 1 then
        self.pressZWaiting = self.pressZWaiting + 1
        if self.pressZWaiting % 30 > 15 then
            self.cursorChar = ">         <"
        else
            self.cursorChar = ">        <"
        end

        if self.pressZWaiting >= 90 then
            State.switch(States.Maingame)
        end
    end
end

function title:draw()
    love.graphics.setColor(1, 1, 1, 1)
    --love.graphics.setFont(Data.Font.title)
    --love.graphics.print("HANKO ONIGO", 512-5.5*32, 150)
    self:printCenter(Data.Font.veryBig,Data.Font.size.veryBig,"HANKO ONIGO", 512, 100)
    self:printCenter(Data.Font.title,Data.Font.size.title,"START", 512, self.cursorNormY)
    self:printCenter(Data.Font.title,Data.Font.size.title,"RANKING", 512, self.cursorNormY+self.cursorDY*1)
    self:printCenter(Data.Font.title,Data.Font.size.title,"SETTING", 512, self.cursorNormY+self.cursorDY*2)
    --self:printCenter(Data.Font.title,Data.Font.size.title,""..self.cursorY, 512, self.cursorNormY+self.cursorDY*3)
    self:printCenter(Data.Font.title,Data.Font.size.title,self.cursorChar, 512, self.cursorNormY+self.cursorY*self.cursorDY)
end

function title:leave()
end

function title:pressZ()
    if self.cursorY == 0 then
        self.pressZWaiting = 1
        --State.switch(States.Maingame)
    end
end

function title:moveCursor(dy)
    if self.pressZWaiting == 0 then
        self.cursorY = math.max(math.min(self.cursorY+dy,2),0)
    end
end

function title:printCenter(fontType,fontSize,char,x,y)
    love.graphics.setFont(fontType)
    love.graphics.print(char, x-(#char/2)*fontSize/2, y)
end

return title
