-- debug
lovebird = require 'lovebird'

-- data
Data = {}
Data.Font = require 'data.font'

-- state
States = {}
States.Dummy = require 'state.dummy'

-- library
Class = require '30log.30log'
Camera = require 'hump.camera'
State = require 'hump.gamestate'

-- Debug
Debug = require 'class.debug.debug'

-- class
Instance = require 'class.Instance.instance'
KeyManager = require 'class.keyManager'
JoystickManager = require 'class.joystickManager'
AnimationManager = require 'class.animationManager'

function love.load()
    -- デバッグモードの有効化の際は true を渡すこと
    debug = Debug(true)

    State.registerEvents()
    State.switch(States.Dummy)
end

function love.update(dt)
    -- debug
    lovebird.update()
    debug:update(dt)
    --debug

    Instance:update(dt)
end

function love.draw()
    --debug
    debug.free_camera:attach()
    Instance:draw()
    debug.free_camera:detach()

    --debug
    debug:draw()
    --debug
end
