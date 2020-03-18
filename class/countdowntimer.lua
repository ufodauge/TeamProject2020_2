--[[
    CountdownTimer
    ゲーム開始時からのカウントダウンを実行・表示する
    
    func:
        setTime(time(number))
        計測する時間を設定する

        setPenalty(penalty(number))
        ペナルティの状況を監視する
            penalty(number)
            1 の時にペナルティありと判定

        isOver()
        カウント終了時に true を返す
]]
local CountdownTimer = Instance:extend('CountdownTimer')

function CountdownTimer:init()
    CountdownTimer.super:init(self)

    self.time = 0
    self.started = false
    self.finished = false
    self.text = {
        mm = ('%02d'):format(math.floor(self.time / 60)),
        ss = ('%02d'):format(math.floor(self.time)),
        ml = ('%02d'):format(math.floor(self.time - math.floor(self.time)) * 100)
    }
end

function CountdownTimer:update(dt)
    if self.started == true and self.finished == false then
        self.time = self.time - dt
        if self.time <= 0 and self.finished == false then
            self.time = 0
            self.finished = true
            self:toggle()
        end
    end

    self.text = {
        mm = ('%02d'):format(math.floor(self.time / 60)),
        ss = ('%02d'):format(math.floor(self.time) % 60),
        ml = ('%02d'):format(math.floor((self.time - math.floor(self.time)) * 100))
    }
end

function CountdownTimer:draw()
    love.graphics.setColor(0, 0, 0, 1)

    love.graphics.print('TIME: ' .. self:getText(), self.x, self.y)

    --[[
    love.graphics.print(self.time,20,80)
    if self:isOver() == true then
        love.graphics.print("finish",20,100)
    end
    ]]
end

function CountdownTimer:delete()
    self.super:delete(self) -- selfを明示的に書いてあげる必要あり
end

function CountdownTimer:setTime(time)
    self.time = time
end

function CountdownTimer:setPenalty(penalty)
    if penalty == 1 and self.time ~= 0 then
        self.time = self.time - COUNTDOWN_PENALTY_TIME_BY_MISSING_STAMP
    end
end

function CountdownTimer:isOver()
    return self.finished
end

function CountdownTimer:getText()
    return self.text.mm .. ':' .. self.text.ss .. '.' .. self.text.ml
end

function CountdownTimer:toggle()
    self.started = not self.started

    if self.started == true then
        self.finished = false
    end
end

return CountdownTimer
