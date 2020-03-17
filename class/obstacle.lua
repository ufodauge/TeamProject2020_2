local Obstacle = Instance:extend('Obstacle')

Obstacle.RNG = love.math.newRandomGenerator()
Obstacle.RNG:setSeed(love.timer.getTime())

function Obstacle:init()
    self.super:init(self)

    self.collider = nil
end

function Obstacle:update(dt)
end

function Obstacle:draw()
    love.graphics.setColor(1, 1, 1, 1)
    self.x, self.y = self.collider:getPosition()
    self.x = self.x - self.collision_data[3]
    self.y = self.y - self.collision_data[3]
    love.graphics.draw(self.image, self.x, self.y)
end

function Obstacle:setPhysicsStatus(collision_class, collision_data, world)
    self.collision_data = collision_data

    self.collision_data[1] = Obstacle.RNG:random(OBSTACLE_AREA.LEFT, OBSTACLE_AREA.RIGHT)
    self.collision_data[2] = Obstacle.RNG:random(OBSTACLE_AREA.TOP, OBSTACLE_AREA.BOTTOM)

    self.collider = world:newCircleCollider(unpack(collision_data))
    self.collider:setType('static')
    self.collider:setRestitution(0.3)
    self.collider:setCollisionClass(collision_class)
end

function Obstacle:setImage(imageData)
    self.image = imageData
end

function Obstacle:delete()
    self.collider:destroy()
    self.collider = nil
    self.super:delete(self) -- selfを明示的に書いてあげる必要あり
end

return Obstacle
