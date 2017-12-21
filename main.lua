require("function")
require("collision")
require("enemy")
require("combat")
require("camera")
require("event")
require("inventory")
require("graphics")
require("char")
require("textbox")
require("projectile")

function love.load()
  char_load()

  map = {{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
         {0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0},
         {0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0},
         {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
         {1, 0, 0, 1, 1, 2, 2, 1, 1, 1, 1, 1},
         {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}}
  tile = {type = {[0] = 0, 1, 1, 0, 1, 1, 1, 1}, size = 32}

  gravity = 10

  inventory_load()
  enemy_load()
  combat_load()
  camera_load()
  event_load()
  graphics_load()
  textbox_load()
  projectile_load()

  globalDt = 0
end

function love.update(dt)
  globalDt = dt
  if pause == false then
    char_update(dt)
    enemy_update(dt)
    combat_update(dt)
    camera_update(dt)
    event_update(dt)
    projectile_update(dt)
  end
  inventory_update(dt)
  textbox_update(dt)
end


function love.draw()
  love.graphics.setCanvas(canvas)
  love.graphics.clear()
  love.graphics.push()
  love.graphics.translate(math.floor(-camera.x)+screen.w/2, math.floor(-camera.y)+screen.h/2)

  enemy_draw()
  combat_draw()
  char_draw()
  projectile_draw()

  for i, v in ipairs(map) do
    for j, w in ipairs(v) do
      if w > 0 then
        love.graphics.draw(tileImgs[w], bitmask(j, i), (j-1)*tile.size, (i-1)*tile.size)
      end
    end
  end
  love.graphics.pop()

  inventory_draw()
  textbox_draw()

  love.graphics.setCanvas()
  love.graphics.draw(canvas, 0, 0, 0, screen.scale, screen.scale)
end

function love.keypressed(key)
  if inv_menu.active == true then
    inventory_keypressed(key)
  elseif pause == true then
    textbox_keypressed(key)
  else
    char_keypressed(key)
  end
end

function love.keyreleased(key)
  if inv_menu.active == true then
    inventory_keyreleased(key)
  end
end
