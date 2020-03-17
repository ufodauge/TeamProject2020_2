local maingame = {}

maingame.name = 'maingame'

function maingame:init()
    -- 乱数シードの設定
    love.math.setRandomSeed(love.timer.getTime())
end

function maingame:enter()
    --[[
    background = {}
    background = Background()
    background:setPosition(COUNTDOWN_X, COUNTDOWN_Y)
    background:setImage(Data.Background.image)
    ]]
    
    countdownTimer = CountdownTimer()
    countdownTimer:setPosition(COUNTDOWN_X, COUNTDOWN_Y)
    countdownTimer:setTime(COUNTDOWN_MAX_TIME)
    countdownTimer:toggle()

    score = Score()
    score:setPosition(SCORE_X, SCORE_Y)
    score:setScore(0)

   -- stampgame
   papers = {}
   for i = 1, PAPER_TOTAL do
       papers[i] = Paper()
       papers[i].index = i

       local x = PAPER_X + PAPER_WIDTH * ((i-1) % PAPER_COLUMN)
       local y = PAPER_Y + PAPER_HEIGHT * math.floor((i - 1) / (PAPER_TOTAL / PAPER_COLUMN))
       papers[i]:setPosition(x, y)

       -- 捺印済み(imorinted)か否か(plain)の設定
       local state = "plain"
       if love.math.random(1,100) <= PAPER_IMPRINTED_RATE*100 then 
           state = "imprinted"
       end
       papers[i]:setStatus(state)
   end

   stampCursor = StampCursor()
   -- 台紙群の中央に配置
   local x = PAPER_X + PAPER_WIDTH * ((PAPER_TOTAL) / 2 / PAPER_COLUMN -1)
   local y = PAPER_Y + PAPER_HEIGHT * math.floor(((PAPER_TOTAL + 1) / 2 - 1) / (PAPER_TOTAL / PAPER_COLUMN))
   stampCursor:setPosition(x, y)
   -- 台紙の配置を設定する
   stampCursor:setPapersSize(PAPER_COLUMN, PAPER_TOTAL / PAPER_COLUMN)

    -- taggame
    -- ︙
end

function maingame:update(dt)

    -- stampgame

    for i = 1, PAPER_TOTAL do
        -- ペナルティの状況を監視
        countdownTimer:setPenalty(papers[i]:getPenalty())
        -- スコアの状況を監視
        score:setStatus(papers[i]:getStatus())
    end

    -- 捺印の状況を監視
    stampedIndex = stampCursor:getStatus()
    if(stampedIndex ~= 0)then
        papers[stampedIndex]:stamp()
    end

    -- カウント終了時の処理
    if countdownTimer:isOver() then
    -- State.push(Pause)
    end
end

function maingame:draw()
end

function maingame:leave()
    countdownTimer:delete()
    score:delete()
    background:delete()
    for i, paper in ipairs(papers) do
        paper:delete()
    end
    stampCursor:delete()
end

return maingame
