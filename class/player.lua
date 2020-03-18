local Player = Instance:extend('Player')

function Player:init()
    Player.super:init(self)

    self.keys = KeyManager()
    self.joysticks = JoystickManager()

    self.animationManager = AnimationManager()
    self.animationManager:setTilesets(Data.Animation.player)
    self.animationManager:setPermanence(true)

    self.image = nil
    self.collider = nil

    self.isFired = false
    self.penalty = 0
    self.satiety = 0
end

function Player:update(dt)
    self.keys:update(dt)
    self.joysticks:update(dt)
    self.animationManager:update(dt)

    local vx, vy = self.collider:getLinearVelocity()
    self.collider:setAngle(lume.angle(0, 0, vx, vy))

    if self.collider:enter('Enemy') then
        self.penalty = 1
    end

    if self.collider:enter('Food') then
        self.satiety = self.satiety + 1
    end
end

function Player:draw()
    love.graphics.setColor(1, 1, 1, 1)
    self.x, self.y = self.collider:getPosition()
    self.x = self.x - PLAYER_SIZE[1]
    self.y = self.y - PLAYER_SIZE[2]
    -- love.graphics.draw(self.image, self.x, self.y)
    self.animationManager:draw(self.x, self.y)
end

function Player:setPhysicsStatus(collision_class, collision_data, world)
    self.collision_data = collision_data

    self.collider = world:newCircleCollider(unpack(collision_data))
    self.collider:setRestitution(0.3)
    self.collider:setCollisionClass(collision_class)
    self.collider:setLinearDamping(20)

    self.keys:register(
        {
            {
                key = 'right',
                func = function()
                    self.collider:applyForce(4000, 0)
                end,
                rep = true,
                act = 'pressed'
            },
            {
                key = 'right',
                func = function()
                    local vx, vy = self.collider:getLinearVelocity()
                    self.collider:setLinearVelocity(0, vy)
                    self.animationManager:setTile(PLAYER_ANIMATION_RIGHT)
                end,
                rep = false,
                act = 'pressed'
            },
            {
                key = 'left',
                func = function()
                    self.collider:applyForce(-4000, 0)
                end,
                rep = true,
                act = 'pressed'
            },
            {
                key = 'left',
                func = function()
                    local vx, vy = self.collider:getLinearVelocity()
                    self.collider:setLinearVelocity(0, vy)
                    self.animationManager:setTile(PLAYER_ANIMATION_LEFT)
                end,
                rep = false,
                act = 'pressed'
            },
            {
                key = 'up',
                func = function()
                    self.collider:applyForce(0, -4000)
                end,
                rep = true,
                act = 'pressed'
            },
            {
                key = 'up',
                func = function()
                    local vx, vy = self.collider:getLinearVelocity()
                    self.collider:setLinearVelocity(vx, 0)
                    self.animationManager:setTile(PLAYER_ANIMATION_BACK)
                end,
                rep = false,
                act = 'pressed'
            },
            {
                key = 'down',
                func = function()
                    self.collider:applyForce(0, 4000)
                end,
                rep = true,
                act = 'pressed'
            },
            {
                key = 'down',
                func = function()
                    local vx, vy = self.collider:getLinearVelocity()
                    self.collider:setLinearVelocity(vx, 0)
                    self.animationManager:setTile(PLAYER_ANIMATION_FRONT)
                end,
                rep = false,
                act = 'pressed'
            },
            {
                key = 'z',
                func = function()
                    self.isFired = true
                end,
                rep = false,
                act = 'pressed'
            }
        }
    )
    self.joysticks:register(
        {
            {
                key = 'a',
                func = function()
                    self.isFired = true
                end,
                rep = false,
                act = 'pressed'
            },
            {
                key = 'b',
                func = function()
                    self.isFired = true
                end,
                rep = false,
                act = 'pressed'
            },
            {
                key = 'lefty',
                func = function(axisValue)
                    self.collider:applyForce(0, 4000 * axisValue)
                end,
                rep = true,
                act = 'pressed'
            },
            {
                key = 'lefty',
                func = function(axisValue)
                    local vx, vy = self.collider:getLinearVelocity()
                    self.collider:setLinearVelocity(vx, 0)
                    if axisValue > 0 then
                        self.animationManager:setTile(PLAYER_ANIMATION_FRONT)
                    else
                        self.animationManager:setTile(PLAYER_ANIMATION_BACK)
                    end
                end,
                rep = false,
                act = 'pressed'
            },
            {
                key = 'leftx',
                func = function(axisValue)
                    self.collider:applyForce(4000 * axisValue, 0)
                end,
                rep = true,
                act = 'pressed'
            },
            {
                key = 'leftx',
                func = function(axisValue)
                    local vx, vy = self.collider:getLinearVelocity()
                    self.collider:setLinearVelocity(0, vy)
                    if axisValue > 0 then
                        self.animationManager:setTile(PLAYER_ANIMATION_RIGHT)
                    else
                        self.animationManager:setTile(PLAYER_ANIMATION_LEFT)
                    end
                end,
                rep = false,
                act = 'pressed'
            }
        }
    )
end

function Player:setImage(imageData)
    self.image = imageData
    self.image:setFilter('nearest')
end

function Player:isSatiety()
    if self.satiety >= PLAYER_SATIETY_VALUE then
        self.satiety = 0
        return true
    end
    return false
end

function Player:getPenalty()
    if self.penalty == 1 then
        self.penalty = 0
        return 1
    end
    return 0
end

function Player:getPosition()
    return self.collider:getPosition()
end

function Player:getAngle()
    return self.collider:getAngle()
end

function Player:isLiterallyFired()
    if self.isFired then
        self.isFired = false
        return true
    end
    return false
end

function Player:delete()
    self.collider:destroy()
    self.collider = nil
    self.super:delete(self) -- selfを明示的に書いてあげる必要あり
end

return Player
