function projectile_load()
  projectiles = {}
  projectileTypes = {
    {w = 4, h = 4, dmg = 3, img = 1}
  }
end

function projectile_update(dt)
  for i, v in ipairs(projectiles) do
    if collide(v) then
      projectiles[i] = nil
    elseif v.side == 1 then
      for j, w in ipairs(enemies) do
        if w.dead == false and aabb(v, w) then
          w.hp = w.hp - v.dmg
          projectiles[i] = nil
          break
        end
      end
    elseif v.side == 2 and aabb(v, char) then
      char.hp = char.hp - v.dmg
      projectiles[i] = nil
    end
    v.x = v.x + v.xV
    v.y = v.y + v.yV
  end
  projectiles = removeNil(projectiles)
end

function projectile_draw()
  for i, v in ipairs(projectiles) do
    love.graphics.draw(projectileImgs[v.img], math.floor(v.x), math.floor(v.y), v.angle, 1, 1, math.floor(v.w/2), math.floor(v.h/2))
  end
end

function newProjectile(x, y, xV, yV, side, a)
  local type = projectileTypes[a]
  projectiles[#projectiles+1] = {x = x, y = y, xV = xV, yV = yV, w = type.w, h = type.h, dmg = type.dmg, img = type.img, side = side, angle = math.atan2(yV, xV)}
end
