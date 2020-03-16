local sandbox = {}

sandbox.name = 'sandbox'

function sandbox:init()
end

function sandbox:enter()
    ct = CountdownTimer()
    ct:setTime(5)
    ct:toggle()
end

function sandbox:update(dt)
end

function sandbox:draw()
end

function sandbox:leave()
end

return sandbox
