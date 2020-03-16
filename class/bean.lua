local Bean = Instance:extend('Bean')

Bean.RNG = love.math.newRandomGenerator()
Bean.RNG:setSeed(love.timer.getTime())

function Bean:init()
    self.super:init(self)

    self.colliders = {}

    self.lifespan = 60
end

function Bean:update(dt)
    self.lifespan = self.lifespan - 1
    if self.lifespan <= 0 then
        self:delete()
    end
end

function Bean:draw()
    love.graphics.setColor(1, 1, 1, 1)
    -- self.x, self.y = self.colliders:getPosition()
    -- self.x = self.x - self.collision_data[3]
    -- self.y = self.y - self.collision_data[3]
    -- love.graphics.draw(self.image, self.x, self.y)
end

function Bean:setPhysicsStatus(collision_class, collision_data, world)
    self.collision_data = collision_data

    self.collision_data[1] = self.x
    self.collision_data[2] = self.y

    for i = 1, BEAN_MAX do
        self.colliders[i] = world:newCircleCollider(unpack(collision_data))
        self.colliders[i]:setType('dynamic')
        self.colliders[i]:setRestitution(0.3)
        self.colliders[i]:setCollisionClass(collision_class)
        self.colliders[i]:setLinearDamping(20)
        self.colliders[i]:applyLinearImpulse(lume.vector(self.angle + (math.pi / 20) * (i - (BEAN_MAX + 1) / 2), BEAN_VELOCITY * math.abs(Bean.RNG:randomNormal())))
    end
end

function Bean:setImage(imageData)
    self.image = imageData
end

function Bean:setAngle(angle)
    self.angle = angle
end

function Bean:delete()
    for i = 1, #self.colliders do
        self.colliders[i]:destroy()
    end
    self.super:delete(self) -- selfを明示的に書いてあげる必要あり
end

return Bean
