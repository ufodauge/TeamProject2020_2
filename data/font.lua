local font = {}

font.size = {
    debug = 16,
    title = 64,
    middle = 32
}

font.debug = love.graphics.newFont('resource/fixedsys-ligatures.ttf', font.size.debug)
font.debug:setFilter('nearest', 'nearest')

font.title = love.graphics.newFont('resource/fixedsys-ligatures.ttf', font.size.title)
font.title:setFilter('nearest', 'nearest')

font.middle = love.graphics.newFont('resource/fixedsys-ligatures.ttf', font.size.middle)
font.middle:setFilter('nearest', 'nearest')

return font
