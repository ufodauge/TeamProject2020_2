local Player = Instance:extend('Player')

function Player:init()
    Player.super:init(self)

    self.keys = KeyManager()

    self.image = nil
    self.collider = nil

    self.isFired = false
end

function Player:update(dt)
    self.keys:update(dt)

    local vx, vy = self.collider:getLinearVelocity()
    self.collider:setAngle(lume.angle(0, 0, vx, vy))
end

function Player:draw()
    love.graphics.setColor(1, 1, 1, 1)
    self.x, self.y = self.collider:getPosition()
    self.x = self.x - self.collision_data[3]
    self.y = self.y - self.collision_data[3]
    love.graphics.draw(self.image, self.x, self.y)
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
end

function Player:setImage(imageData)
    self.image = imageData
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
