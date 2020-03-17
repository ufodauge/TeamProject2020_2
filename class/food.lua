local Food = Instance:extend('Food')

Food.RNG = love.math.newRandomGenerator()
Food.RNG:setSeed(love.timer.getTime())

function Food:init()
    self.super:init(self)

    self.collider = nil
end

function Food:update(dt)
    if self.collider:enter('Player') then
        self:delete()
    end
end

function Food:draw()
    love.graphics.setColor(1, 1, 1, 1)
    self.x, self.y = self.collider:getPosition()
    self.x = self.x - self.collision_data[3]
    self.y = self.y - self.collision_data[3]
    love.graphics.draw(self.image, self.x, self.y)
end

function Food:setPhysicsStatus(collision_class, collision_data, world)
    self.collision_data = collision_data

    self.collision_data[1] = Food.RNG:random(OBSTACLE_AREA.LEFT, OBSTACLE_AREA.RIGHT)
    self.collision_data[2] = Food.RNG:random(OBSTACLE_AREA.TOP, OBSTACLE_AREA.BOTTOM)

    self.collider = world:newCircleCollider(unpack(collision_data))
    self.collider:setType('kinemathic')
    self.collider:setMass(0)
    self.collider:setRestitution(0)
    self.collider:setCollisionClass(collision_class)
end

function Food:setImage(imageData)
    self.image = imageData
end

function Food:delete()
    self.collider:destroy()
    self.super:delete(self) -- selfを明示的に書いてあげる必要あり
end

return Food