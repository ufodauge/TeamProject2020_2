local Enemy = Instance:extend('Enemy')

function Enemy:init()
    Enemy.super:init(self)

    self.collider = nil
    self.playerPosition = {}
    self.playerPosition.x = 0
    self.playerPosition.y = 0

    self.stayInterval = 0
end

function Enemy:update(dt)
    if self.collider:enter('Player') then
        self.stayInterval = 3
    end
    if self.collider:enter('Bean') then
        self.stayInterval = 2
    end

    if self.stayInterval > 0 then
        self.collider:setCollisionClass('EnemyStucked')
    else
        self.collider:setCollisionClass('Enemy')
    end

    local vx, vy = self.collider:getLinearVelocity()
    vx, vy = lume.vector(lume.angle(self.collider:getX(), self.collider:getY(), self.playerPosition.x, self.playerPosition.y), ENEMY_VELOCITY)

    if self.stayInterval > 0 then
        self.stayInterval = self.stayInterval - dt
        vx, vy = 0, 0
    end

    self.collider:setLinearVelocity(vx, vy)
end

function Enemy:draw()
    love.graphics.setColor(1, 1, 1, 1)
    self.x, self.y = self.collider:getPosition()
    self.x = self.x - ENEMY_SIZE[1]
    self.y = self.y - ENEMY_SIZE[2]
    love.graphics.draw(self.image, self.x, self.y)
end

function Enemy:setPhysicsStatus(collision_class, collision_data, world)
    self.collision_data = collision_data

    self.collider = world:newCircleCollider(unpack(collision_data))
    self.collider:setRestitution(0.3)
    self.collider:setCollisionClass(collision_class)
    self.collider:setLinearDamping(20)
end

function Enemy:setPlayerPosition(x, y)
    self.playerPosition.x = x
    self.playerPosition.y = y
end

function Enemy:setImage(imageData)
    self.image = imageData
    self.image:setFilter('nearest')
end

function Enemy:delete()
    self.collider:destroy()
    self.super:delete(self) -- selfを明示的に書いてあげる必要あり
end

return Enemy
