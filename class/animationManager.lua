local AnimationManager = Class('AnimationManager')

function AnimationManager:init()
end

function AnimationManager:setTilesets(tilesets)
    self.width = tilesets.tilewidth
    self.height = tilesets.tileheight
    self.imagewidth = tilesets.imagewidth
    self.imageheight = tilesets.imageheight
    self.columns = tilesets.columns
    self.tilecount = tilesets.tilecount
    self.image = love.graphics.newImage(tilesets.image)
    self.image:setFilter('nearest')

    self.quads = {}

    for y, tiles in ipairs(tilesets.tiles) do
        self.quads[y] = {}
        self.quads[y].animationmax = 0
        self.quads.id = tiles.id
        for x, tile in ipairs(tiles.animation) do
            self.quads[y][x] = {}
            self.quads[y][x].quad = love.graphics.newQuad((x - 1) * tilesets.tilewidth, (y - 1) * tilesets.tilewidth, tilesets.tilewidth, tilesets.tileheight, self.image:getDimensions())
            self.quads[y][x].duration = tile.duration
            self.quads[y].animationmax = self.quads[y].animationmax + 1
        end
    end

    self.ms = 0
    self.type = 1
    self.animationid = 1

    self.permanence = true
    self.isPlaying = false
end

function AnimationManager:draw(x, y, r, sx, sy)
    sx = sx or 1
    sy = sy or sx

    love.graphics.draw(self.image, self.quads[self.type][self.animationid].quad, x, y, r, sx, sy)
end

function AnimationManager:setTile(id)
    self.type = id
end

function AnimationManager:setPermanence(permanence)
    self.permanence = permanence
end

function AnimationManager:play()
    self.isPlaying = true
    self.animationid = 1
end

function AnimationManager:update(dt)
    if self.permanence or self.isPlaying then
        self.ms = self.ms + dt * 1000
        if self.ms >= self.quads[self.type][self.animationid].duration then
            self.ms = self.ms - self.quads[self.type][self.animationid].duration
            if self.animationid < self.quads[self.type].animationmax then
                self.animationid = self.animationid + 1
            else
                if self.permanence then
                    self.animationid = 1
                end
                self.isPlaying = false
            end
        end
    end
end

return AnimationManager
