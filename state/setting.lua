local setting = {}

setting.name = 'setting'

function setting:init()

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

function setting:enter()
    --read
    --love.filesystem.write(love.filesystem.getIdentity(),"999999,088888,007777,000666,000055")
    str = love.filesystem.read(love.filesystem.getIdentity())
    scoreValues = lume.split(str,",")
    
    ranking ={
        x = 512,
        y = 386,
        sx = 1,
        sy = 1
    }

    scores = {
        x1 = -200,
        x2 = 1024+200
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
        y = 386 + 70,
        label = ">     <"
    }

    start = {
        x = 512,
        y = 316
    }

    setting = {
        x = 512,
        y = 386+70,
        scale = 1
    }

    hanko = {
        x = 512,
        y = 132
    }
    onigo = {
        x = 512,
        y = 132
    }

    contents = {
        x=512,
        y=300,
        label = " Comming soon...",
        scale = 0,
        r = 0,
        cnt = 0
    }
    
    back.cnt = 0
    flux.to(setting,EASE_TIME,{y=30+64}):ease("expoinout")
    flux.to(setting,EASE_TIME*0.8,{scale=2}):ease("elasticout")
    --flux.to(scores,EASE_TIME,{x1 = 512, x2 = 512}):ease("expoinout")
    flux.to(back,EASE_TIME,{y = 460+32}):ease("expoinout")
    flux.to(start,EASE_TIME,{x = -150}):ease("expoinout")
    flux.to(ranking,EASE_TIME,{x = 1024+150}):ease("expoinout")
    flux.to(hanko,EASE_TIME,{x = -150}):ease("expoinout")
    flux.to(onigo,EASE_TIME,{x = 1024+150}):ease("expoinout")
    flux.to(cursor,EASE_TIME,{x=750+16*7, y = 460+32}):ease("expoinout")
    flux.to(contents,EASE_TIME*0.5,{scale=1}):ease("backout"):delay(EASE_TIME*0.5)
 
end

function setting:update(dt)
    flux.update(dt)
    self.keyManager:update(dt)

    contents.cnt = contents.cnt + 1

--    contents.y = contents.y + math.sin(contents.cnt/5)

    if back.cnt > 1 then
        back.cnt = back.cnt + 1
        if back.cnt > EASE_TIME*60 then
            State.switch(States.Title)
        end
    end
end

function setting:draw()
    love.graphics.setColor(1, 1, 1, 1)
    --love.graphics.setFont(Data.Font.title)
    --love.graphics.print("HANKO ONIGO", 512-5.5*32, 150)
    self:printCenter(Data.Font.veryBig,Data.Font.size.veryBig,"HANKO      ", hanko.x, hanko.y,1,0)
    self:printCenter(Data.Font.veryBig,Data.Font.size.veryBig,"      ONIGO", onigo.x, onigo.y,1,0)
    
    self:printCenter(Data.Font.title,Data.Font.size.title,"RANKING", ranking.x, ranking.y,ranking.sy,0)
    

    for i=1, string.len(contents.label) do
        self:printCenter(Data.Font.title,Data.Font.size.title, string.sub(contents.label,i,i), contents.x+(i-string.len(contents.label)/2)*32, contents.y + 3*math.floor(1.5*math.sin(contents.cnt/10+0.5*i)),contents.scale,contents.r)
    end

    self:printCenter(Data.Font.title,Data.Font.size.title,cursor.label, cursor.x, cursor.y,1,0)
    self:printCenter(Data.Font.title,Data.Font.size.title,back.moji, back.x, back.y,back.scale,0)

    self:printCenter(Data.Font.title,Data.Font.size.title,"START", start.x, start.y,1,0)
    self:printCenter(Data.Font.title,Data.Font.size.title,"SETTING", setting.x, setting.y,setting.scale,0)

end

function setting:leave()
end

function setting:pressZ()
    back.cnt = back.cnt + 1
    if back.cnt == 2 then
        flux.to(ranking,EASE_TIME,{x=512}):ease("expoinout")
        flux.to(back,EASE_TIME*0.4,{scale = 1.3}):ease("elasticout")
        flux.to(back,EASE_TIME*0.3,{scale = 0}):ease("circin"):delay(EASE_TIME*0.4)
        flux.to(cursor,EASE_TIME,{x=512,y=386+70}):ease("expoinout")
        cursor.label=">         <"
        flux.to(start,EASE_TIME,{x = 512}):ease("expoinout")
        flux.to(setting,EASE_TIME,{y=386+70,scale = 1}):ease("expoinout")
        flux.to(hanko,EASE_TIME,{x = 512}):ease("expoinout")
        flux.to(onigo,EASE_TIME,{x = 512}):ease("expoinout")
        flux.to(contents,EASE_TIME*0.5,{scale=0}):ease("backin")

    end
end


function setting:printCenter(fontType,fontSize,char,x,y,scale,r)
    love.graphics.setFont(fontType)
    love.graphics.print(char, x-(#char/2)*fontSize/2*scale, y-fontSize/2*scale,r,scale)
    --love.graphics.print(char, -(#char/2)*fontSize/2*scale, -fontSize/2*scale,0.08,scale,scale,-x, -y)
end
return setting
