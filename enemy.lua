require("ai")

function enemy_load()
  enemies = {
    createEnemy(200, 0, 24, 32, 3, 2, tile.size)
  }
end

function enemy_update(dt)
  for i, v in ipairs(enemies) do
    if v.dead == false then
      ai[1](v, dt)
    end

    physics(v, dt)
  end
end

function enemy_draw()
  for i, v in ipairs(enemies) do
    drawObject(v, guk)
  end
end

function createEnemy(x, y, w, h, hp, weapon, range, vip)
  return {x = x, y= y, w = w, h = h, hp = hp, weapon = weapon, range = range, xV = 0, yV = 0, dir = 1, swordtime = 0, shield = false, invtime = 0, dead = false, vip = vip}
end
