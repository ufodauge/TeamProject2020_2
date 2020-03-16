local sandbox = {}

sandbox.name = 'sandbox'

function sandbox:init()
end

function sandbox:enter()
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

function sandbox:update(dt)
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
end

function sandbox:draw()
    -- for debugging
    world:draw(0.3)
end

function sandbox:leave()
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

return sandbox
