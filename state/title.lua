local title = {}

title.name = 'title'

function title:init()
    self.cursorY = 0
    self.cursorYMax = 3
    self.cursorDY = 70
    self.cursorNormY = 316


end

function title:enter()
    --self.fontTitle = love.graphics.newFont(64)
    self.cursorChar = ">         <"
    self.pressZWaiting = 0

    hanko = {
        x = 512,
        y = 132,
        label = "HANKO      "
    }
    onigo = {
        x = 512,
        y = 132,
        label = "      ONIGO"
    }

    start = {
        x = 512,
        y = self.cursorNormY,
        scale = 1
    }

    ranking = {
        x = 512,
        y = self.cursorNormY+self.cursorDY*1,
    }

    setting = {
        x = 512,
        y = self.cursorNormY+self.cursorDY*2,
    }
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
    flux.update(dt)

    -- Zが押されてから次のシーンに遷移するまでちょっと待つ
    if self.pressZWaiting >= 1 then
        self.pressZWaiting = self.pressZWaiting + 1
        if self.pressZWaiting % 30 > 15 then
            self.cursorChar = ">         <"
        else
            self.cursorChar = ">        <"
        end

        if self.pressZWaiting >= 90 then
            if self.cursorY == 0 then
                State.switch(States.Maingame)
            end
        end
    end
end

function title:draw()
    love.graphics.setColor(1, 1, 1, 1)
    --love.graphics.setFont(Data.Font.title)
    --love.graphics.print("HANKO ONIGO", 512-5.5*32, 150)
    self:printCenter(Data.Font.veryBig,Data.Font.size.veryBig,hanko.label, hanko.x, hanko.y,1)
    self:printCenter(Data.Font.veryBig,Data.Font.size.veryBig,onigo.label, onigo.x, onigo.y,1)
    self:printCenter(Data.Font.title,Data.Font.size.title,"START", start.x, start.y,start.scale)
    self:printCenter(Data.Font.title,Data.Font.size.title,"RANKING", ranking.x, ranking.y,1)
    self:printCenter(Data.Font.title,Data.Font.size.title,"SETTING", setting.x, setting.y,1)
    --self:printCenter(Data.Font.title,Data.Font.size.title,""..self.cursorY, 512, self.cursorNormY+self.cursorDY*3)
    self:printCenter(Data.Font.title,Data.Font.size.title,self.cursorChar, 512, self.cursorNormY+self.cursorY*self.cursorDY,1)
end

function title:leave()
end

function title:pressZ()
    if self.cursorY == 0 then
        self.pressZWaiting = 1
        flux.to(start,0.5,{scale = 1.5}):ease("elasticout")
        flux.to(hanko,0.5,{x=-200}):ease("expoin")
        flux.to(onigo,0.5,{x=1024+200}):ease("expoin")
        flux.to(ranking,0.5,{x=-200}):ease("expoin")
        flux.to(setting,0.5,{x=1024+200}):ease("expoin")
        
        --State.switch(States.Maingame)
    end
    if self.cursorY == 1 then
        State.switch(States.Ranking)
    end
    if self.cursorY == 2 then
        State.switch(States.Setting)
    end
end

function title:moveCursor(dy)
    if self.pressZWaiting == 0 then
        --self.cursorY = math.max(math.min(self.cursorY+dy,2),0)
        flux.to(self,0.15,{cursorY = math.max(math.min(self.cursorY+dy,2),0)}):ease("expoout")
    end
end

function title:printCenter(fontType,fontSize,char,x,y,scale)
    love.graphics.setFont(fontType)
    love.graphics.print(char, x-(#char/2)*fontSize/2*scale, y-fontSize/2*scale,0,scale)
end

return title
