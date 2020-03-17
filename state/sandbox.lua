local sandbox = {}

sandbox.name = 'sandbox'

function sandbox:init()
end

function sandbox:enter()
    animationTest = AnimationTest()
    animationTest:setPosition(200, 200)
    animationTest:setTiles(Data.Animation.animationStamp)
end

function sandbox:update(dt)
end

function sandbox:draw()
    love.graphics.setColor(1, 1, 1, 1)
end

function sandbox:leave()
end

return sandbox
