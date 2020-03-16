local maingame = {}

maingame.name = 'maingame'

function maingame:init()
    -- 乱数シードの設定
    love.math.setRandomSeed(love.timer.getTime())
end

function maingame:enter()
    background = {}
    background = Background()
    background:setPosition(COUNTDOWN_X, COUNTDOWN_Y)
    background:setImage(Data.Image.background)

    countdownTimer = CountdownTimer()
    countdownTimer:setPosition(COUNTDOWN_X, COUNTDOWN_Y)
    countdownTimer:setTime(COUNTDOWN_MAX_TIME)

    score = Score()
    score:setPosition(SCORE_X, SCORE_Y)
    score:setScore(0)

    -- stampgame
    papers = {}
    for i = 1, PAPER_TOTAL do
        papers[i] = Paper()
        papers[i].index = i

        local x = PAPER_X + PAPER_WIDTH * (i % PAPER_COLUMN)
        local y = PAPER_Y + PAPER_HEIGHT * math.floor((i - 1) / (PAPER_TOTAL / PAPER_COLUMN))
        papers[i]:setPosition(x, y)

        -- 捺印済み(imorinted)か否か(plain)の設定
        local state = love.math.random() <= PAPER_IMPRINTED_RATE and 'plain' or 'imprinted'
        papers[i]:setStatus(state)
    end

    stampCursor = StampCursor()
    -- 台紙群の中央に配置
    local x = PAPER_X + PAPER_WIDTH * ((PAPER_TOTAL + 1) / 2 % PAPER_COLUMN)
    local y = PAPER_Y + PAPER_HEIGHT * math.floor(((PAPER_TOTAL + 1) / 2 - 1) / (PAPER_TOTAL / PAPER_COLUMN))
    stampCursor:setPosition(x, y)
    -- 台紙の配置を設定する
    stampCursor:setPapersSize(PAPER_COLUMN, PAPER_TOTAL / PAPER_COLUMN)

    -- taggame
    -- world
    world = Windfield.newWorld()
    world:addCollisionClass('Player')
    world:addCollisionClass('Enemy')
    world:addCollisionClass('Food', {ignores = {'Enemy'}})
    world:addCollisionClass('Obstacle')
    world:addCollisionClass('Bean', {ignores = {'Player', 'Food'}})
    world:addCollisionClass('Wall')

    -- taggame
    -- player
    player = Player()
    player:setPhysicsStatus('Player', PLAYER_COLLISION_DATA, world)
    player:setImage(Data.Image.player)

    -- obstacles
    obstacles = {}
    for i = 1, OBSTACLE_MAX do
        obstacles[i] = Obstacle()
        obstacles[i]:setPhysicsStatus('Obstacle', OBSTACLE_COLLISION_DATA, world)
        if love.math.random() >= OBSTACLE_STUB_RATE then
            obstacles[i]:setImage(Data.Image.stub)
        else
            obstacles[i]:setImage(Data.Image.rock)
        end
    end

    -- enemy
    enemy = Enemy()
    enemy:setPhysicsStatus('Enemy', ENEMY_COLLISION_DATA, world)
    enemy:setImage(Data.Image.ogre)
    enemy:setPlayerPosition(player:getPosition())

    -- food
    foods = {}

    -- beans
    beans = nil

    -- walls
    walls = {}
    for i = 1, WALL_OBJECTS_NUMBER do
        walls[i] = Wall()
        walls[i]:setPhysicsStatus('Wall', _G['WALL_COLLISION_DATA_' .. i], world)
    end
end

function maingame:update(dt)
    -- ペナルティの状況を監視
    countdownTimer:setPenalty(Paper:getPenalty())

    -- スコアの状況を監視
    score:setStatus(Paper:getStatus())

    -- 捺印の状況を監視
    Paper:setImprintStatus(stampCursor:getStatus())

    -- 物理空間の更新処理
    world:update(dt)

    -- 鬼の追っかける方向を取得
    enemy:setPlayerPosition(player:getPosition())

    -- 食べ物
    if Food.RNG:random() <= FOOD_APPEARANCE_RATE then
        foods[#foods + 1] = Food()
        foods[#foods]:setPhysicsStatus('Food', FOOD_COLLISION_DATA, world)
        foods[#foods]:setImage(Data.Image.food)
    end

    if player:isLiterallyFired() then
        beans = Bean()
        beans:setPosition(player:getPosition())
        beans:setAngle(player:getAngle())
        beans:setPhysicsStatus('Bean', BEAN_COLLISION_DATA, world)
    end

    -- カウント終了時の処理
    if countdownTimer:isOver() then
    -- State.push(Pause)
    end
end

function maingame:draw()
    -- for debugging
    world:draw(0.3)
end

function maingame:leave()
    countdownTimer:delete()
    score:delete()
    background:delete()
    for i, paper in ipairs(papers) do
        paper:delete()
    end
    stampCursor:delete()

    player:delete()
    enemy:delete()
    for i = 1, WALL_OBJECTS_NUMBER do
        walls[i]:delete()
    end
    for i = 1, OBSTACLE_MAX do
        obstacles[i]:delete()
    end
    for i, food in ipairs(foods) do
        if food.delete then
            food:delete()
        end
    end
    if bean then
        bean:delete()
    end
    world:destroy()
end

return maingame
