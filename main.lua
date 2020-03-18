-- debug
lovebird = require 'lovebird'
lume = require 'lume'
-- lurker = require 'lurker'

-- data
Data = {}
Data.Font = require 'data.font'
Data.Image = require 'data.image'
Data.Audio = require 'data.audio'

Data.Animation = {}
Data.Animation.animationStamp = require 'data.animation.animationStamp'
Data.Animation.gameover = require 'data.animation.gameover'
Data.Animation.player = require 'data.animation.player'
Data.Animation.ogre = require 'data.animation.ogre'

-- library
Class = require '30log.30log'
Camera = require 'hump.camera'
State = require 'hump.gamestate'
Timer = require 'hump.timer'
Windfield = require 'windfield'
Const = require 'const.const'
flux = require 'flux'

-- defines
require 'data.defines'

-- state
States = {}
States.Dummy = require 'state.dummy'
States.Sandbox = require 'state.sandbox'
States.Maingame = require 'state.maingame'
States.Gameover = require 'state.gameover'

-- Debug
Debug = require 'class.debug.debug'

-- class
Instance = require 'class.Instance.instance'
KeyManager = require 'class.keyManager'
JoystickManager = require 'class.joystickManager'
AnimationManager = require 'class.animationManager'

SampleTimer = require 'class.sampletimer'
AnimationTest = require 'class.animationTest'

CountdownTimer = require 'class.countdowntimer'
Background = require 'class.Background'
Blackout = require 'class.Blackout'
Gameover = require 'class.Gameover'
Text = require 'class.Text'

Score = require 'class.score'
Paper = require 'class.paper'
StampCursor = require 'class.stampcursor'

Player = require 'class.player'
Enemy = require 'class.enemy'
Obstacle = require 'class.obstacle'
Food = require 'class.food'
Bean = require 'class.bean'
Wall = require 'class.wall'

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
    Timer.update(dt)
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
