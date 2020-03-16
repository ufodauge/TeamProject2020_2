local Wall = Instance:extend('Wall')

function Wall:init()
    Wall.super:init(self)

    self.collider = nil
end

function Wall:update(dt)
end

function Wall:draw()
    love.graphics.setColor(1, 1, 1, 1)
end

function Wall:setPhysicsStatus(collision_class, collision_data, world)
    self.collision_data = collision_data

    self.collider = world:newRectangleCollider(unpack(collision_data))
    self.collider:setType('static')
    self.collider:setRestitution(0.3)
    self.collider:setCollisionClass(collision_class)
end

function Wall:delete()
    self.collider:destroy()
    self.collider = nil
    self.super:delete(self) -- selfを明示的に書いてあげる必要あり
end

return Wall
