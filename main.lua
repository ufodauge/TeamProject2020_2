-- debug
lovebird = require 'lovebird'
lume = require 'lume'
lurker = require 'lurker'

-- data
Data = {}
Data.Font = require 'data.font'

-- library
Class = require '30log.30log'
Camera = require 'hump.camera'
State = require 'hump.gamestate'
Const = require 'const.const'

-- state
States = {}
States.Dummy = require 'state.dummy'
States.Sandbox = require 'state.sandbox'
States.Stampgame = require 'state.stampgame'
States.Taggame = require 'state.taggame'
States.Maingame = require 'state.maingame'

-- Debug
Debug = require 'class.debug.debug'

-- class
Instance = require 'class.Instance.instance'
KeyManager = require 'class.keyManager'
JoystickManager = require 'class.joystickManager'
AnimationManager = require 'class.animationManager'

SampleTimer = require 'class.sampletimer'

function love.load()
    -- デバッグモードの有効化の際は true を渡すこと
    debug = Debug(true)

    State.registerEvents()
    State.switch(States.Dummy)
end

function love.update(dt)
    -- debug
    -- lurker.update()
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
