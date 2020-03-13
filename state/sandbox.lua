local sandbox = {}

sandbox.name = 'sandbox'

function sandbox:init()
end

function sandbox:enter()
    sampleTimer = SampleTimer()
    sampleTimer:toggle()
end

function sandbox:update(dt)
end

function sandbox:draw()
end

function sandbox:leave()
    sampleTimer:delete()
end

return sandbox
