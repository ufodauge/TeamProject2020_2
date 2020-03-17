-- class
-- background
Const.define('BACKGROUND_X', 0)
Const.define('BACKGROUND_Y', 0)

-- countdowntimer
Const.define('COUNTDOWN_X', 40)
Const.define('COUNTDOWN_Y', 510)
Const.define('COUNTDOWN_MAX_TIME', 60)
Const.define('COUNTDOWN_PENALTY_TIME_BY_MISSING_STAMP', 3.0)

-- score
Const.define('SCORE_X', 40)
Const.define('SCORE_Y', 530)
Const.define('SCORE_STAMPED_SCORE', 200)

-- paper
Const.define('PAPER_X', 32) -- 左上に配置する紙を前提とする
Const.define('PAPER_Y', 32) -- 同上
Const.define('PAPER_WIDTH', 76)
Const.define('PAPER_HEIGHT', 76)
Const.define('PAPER_TOTAL', 36)
Const.define('PAPER_COLUMN', 6)
Const.define('PAPER_IMPRINTED_RATE', 0.25)

-- player
Const.define('PLAYER_COLLISION_DATA', {600, 300, 16})
Const.define('PLAYER_FORCE', 6000)

-- enemy
Const.define('ENEMY_COLLISION_DATA', {900, 300, 16})
Const.define('ENEMY_VELOCITY', 160)

-- food
Const.define('FOOD_COLLISION_DATA', {512, 0, 16})
Const.define('FOOD_APPEARANCE_RATE', 0.005)

-- obstacle
Const.define('OBSTACLE_COLLISION_DATA', {512, 0, 16})
Const.define('OBSTACLE_MAX', 7)
Const.define('OBSTACLE_STUB_RATE', 0.5)
Const.define('OBSTACLE_AREA', {LEFT = 552, RIGHT = 984, TOP = 40, BOTTOM = 472})

-- bean
Const.define('BEAN_COLLISION_DATA', {512, 0, 4})
Const.define('BEAN_MAX', 5)
Const.define('BEAN_VELOCITY', 200)

-- wall
Const.define('WALL_OBJECTS_NUMBER', 4)
Const.define('WALL_COLLISION_DATA_1', {512, 0, 10, 512})
Const.define('WALL_COLLISION_DATA_2', {512, 502, 512, 10})
Const.define('WALL_COLLISION_DATA_3', {1014, 0, 10, 512})
Const.define('WALL_COLLISION_DATA_4', {512, 0, 512, 10})
