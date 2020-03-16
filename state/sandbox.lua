local sandbox = {}

sandbox.name = 'sandbox'

function sandbox:init()
    love.keyboard.setKeyRepeat(true)
end

function sandbox:enter()
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
end

function sandbox:update(dt)
    -- ペナルティの状況を監視
    --countdownTimer:setPenalty(Paper:getPenalty())

    -- スコアの状況を監視
    --score:setStatus(Paper:getStatus())

    -- 捺印の状況を監視
    stampedIndex = stampCursor:getStatus()
    if(stampedIndex ~= 0)then
        papers[stampedIndex]:stamp()
    end
end

function sandbox:draw()
    love.graphics.setDefaultFilter("nearest", "nearest",100)

    love.graphics.setColor(1, 1, 1, 1)
    --love.graphics.rectangle("fill", 0, 0, 512, 512)

    love.graphics.print(love.math.random(0,100),512,500)
end

function sandbox:leave()
end

return sandbox
