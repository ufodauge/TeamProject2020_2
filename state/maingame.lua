local maingame = {}

Const.define('COUNTDOWN_X', 0)
Const.define('COUNTDOWN_Y', 0)

Const.define('COUNTDOWN_TIME', 0)

-- ステートの同時起動が出来ないのでごり押し　しゃーなし
local stampgame = States.Stampgame
local taggame = States.Taggame

maingame.name = 'maingame'

function maingame:init()
    stampgame:init()
    taggame:init()

    -- 乱数シードの設定
    love.math.setRandomSeed(love.timer.getTime())
end

function maingame:enter()
    stampgame:enter()
    taggame:enter()

    countdownTimer = CountdownTimer()
    countdownTimer:setPosition(COUNTDOWN_X, COUNTDOWN_Y)
    countdownTimer:setTime(COUNTDOWN_TIME)
end

function maingame:update(dt)
    stampgame:update(dt)
    taggame:update(dt)
end

function maingame:draw()
    stampgame:draw()
    taggame:draw()
end

function maingame:leave()
    stampgame:leave()
    taggame:leave()
end

return maingame
