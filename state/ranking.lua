local ranking = {}

ranking.name = 'ranking'

function ranking:init()

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
        }
    )

end

function ranking:enter()
    --read
    --love.filesystem.write(love.filesystem.getIdentity(),"999999,088888,007777,000666,000055")
    str = love.filesystem.read(love.filesystem.getIdentity())
    scoreValues = lume.split(str,",")
    
    bigLabel ={
        x = 512,
        y = 386,
        sx = 1,
        sy = 1
    }

    scores = {
        x1 = -200,
        x2 = 1024+200,
        x = {-200,1024+200,-200,1024+200,-200}
    }

    back = {
        x = 750+16*7,
        y = 600,
        cnt = 0,
        waku = ">     <",
        moji = " back ",
        scale = 1
    }

    cursor = {
        x = 512,
        y = 386,
        label = ">     <"
    }

    start = {
        x = 512,
        y = 316
    }

    setting = {
        x = 512,
        y = 386+70
    }

    hanko = {
        x = 512,
        y = 132
    }
    onigo = {
        x = 512,
        y = 132
    }
    
    back.cnt = 0
    flux.to(bigLabel,EASE_TIME,{y=30+64,sx = 20}):ease("expoinout")
    flux.to(bigLabel,EASE_TIME*0.8,{sy=2}):ease("elasticout")
    flux.to(scores,EASE_TIME,{x1 = 512, x2 = 512}):ease("expoinout")

    for i=1, #scores.x do
        if i ~= 5 then
            flux.to(scores.x,EASE_TIME,{[6-i]=512}):ease("expoinout"):delay((i)*0.15)
        else
            flux.to(scores.x,EASE_TIME*1.5,{[6-i]=512}):ease("expoinout"):delay((i)*0.15)
        end
    end

    flux.to(back,EASE_TIME,{y = 460+32}):ease("expoinout")
    flux.to(start,EASE_TIME,{x = -150}):ease("expoinout")
    flux.to(setting,EASE_TIME,{x = 1024+150}):ease("expoinout")
    flux.to(hanko,EASE_TIME,{x = -150}):ease("expoinout")
    flux.to(onigo,EASE_TIME,{x = 1024+150}):ease("expoinout")
    flux.to(cursor,EASE_TIME,{x=750+16*7, y = 460+32}):ease("expoinout")

end

function ranking:update(dt)
    flux.update(dt)
    self.keyManager:update(dt)

    if back.cnt > 1 then
        back.cnt = back.cnt + 1
        if back.cnt > EASE_TIME*60 then
            State.switch(States.Title)
        end
    end
end

function ranking:draw()
    love.graphics.setColor(1, 1, 1, 1)
    --love.graphics.setFont(Data.Font.title)
    --love.graphics.print("HANKO ONIGO", 512-5.5*32, 150)
    self:printCenter(Data.Font.veryBig,Data.Font.size.veryBig,"HANKO      ", hanko.x, hanko.y,1)
    self:printCenter(Data.Font.veryBig,Data.Font.size.veryBig,"      ONIGO", onigo.x, onigo.y,1)
    
    self:printCenter(Data.Font.title,Data.Font.size.title,"RANKING", bigLabel.x, bigLabel.y,bigLabel.sy)
    self:printCenter(Data.Font.title,Data.Font.size.title,"1st "..scoreValues[1].."pt", scores.x[1], 180+32,1)
    self:printCenter(Data.Font.title,Data.Font.size.title,"2nd "..scoreValues[2].."pt", scores.x[2], 250+32,1)
    self:printCenter(Data.Font.title,Data.Font.size.title,"3rt "..scoreValues[3].."pt", scores.x[3], 320+32,1)
    self:printCenter(Data.Font.title,Data.Font.size.title,"4th "..scoreValues[4].."pt", scores.x[4], 390+32,1)
    self:printCenter(Data.Font.title,Data.Font.size.title,"5th "..scoreValues[5].."pt", scores.x[5], 460+32,1)

    self:printCenter(Data.Font.title,Data.Font.size.title,cursor.label, cursor.x, cursor.y,1)
    self:printCenter(Data.Font.title,Data.Font.size.title,back.moji, back.x, back.y,back.scale)

    self:printCenter(Data.Font.title,Data.Font.size.title,"START", start.x, start.y,1)
    self:printCenter(Data.Font.title,Data.Font.size.title,"SETTING", setting.x, setting.y,1)

end

function ranking:leave()
end

function ranking:pressZ()
    back.cnt = back.cnt + 1
    if back.cnt == 2 then
        flux.to(bigLabel,EASE_TIME,{y=386,sx = 20,sy=1}):ease("expoinout")
        flux.to(back,EASE_TIME*0.4,{scale = 1.3}):ease("elasticout")
        flux.to(back,EASE_TIME*0.3,{scale = 0}):ease("circin"):delay(EASE_TIME*0.4)
        flux.to(cursor,EASE_TIME,{x=512,y=386}):ease("expoinout")
        cursor.label=">         <"
        flux.to(start,EASE_TIME,{x = 512}):ease("expoinout")
        flux.to(setting,EASE_TIME,{x = 512}):ease("expoinout")
        flux.to(hanko,EASE_TIME,{x = 512}):ease("expoinout")
        flux.to(onigo,EASE_TIME,{x = 512}):ease("expoinout")
    
        for i=1, #scores.x do
            flux.to(scores.x,EASE_TIME*0.8,{[i]=1024+200-(1024+400)*(i % 2)}):ease("expoinout"):delay((i)*0.03)
        end
        end
end


function ranking:printCenter(fontType,fontSize,char,x,y,scale)
    love.graphics.setFont(fontType)
    love.graphics.print(char, x-(#char/2)*fontSize/2*scale, y-fontSize/2*scale,0,scale)
    --love.graphics.print(char, -(#char/2)*fontSize/2*scale, -fontSize/2*scale,0.08,scale,scale,-x, -y)
end
return ranking
