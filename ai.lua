ai = {}

ai[1] = function(v, dt)
  if v.swordtime <= 0 and distance(v, char) > v.range then
    local current = pointToTile(v.x+v.w/2, v.y + v.h + 1)
    local below = pointToTile(v.x + v.w/2 + v.xV + v.w * v.dir, v.y + v.h + 1)
    local side = pointToTile(v.x + v.w/2 + v.xV + v.w * v.dir, v.y + v.h)
    if isTile(v.x + v.w/2 + v.xV + v.w * v.dir, v.y + v.h + 1) == true and isTile(v.x + v.w/2 + v.xV + v.w * v.dir, v.y + v.h) == false then
      v.xV = v.xV + dt * 4 * v.dir
    elseif isTile(v.x+v.w/2, v.y + v.h + 1) == true then
      v.dir = v.dir * -1
    end
  else
    if v.swordtime <= -attackDelay then
      v.swordtime = weapons[char.weapon].spd
      if char.x-v.x > 0 then
        v.dir = 1
      else
        v.dir = -1
      end
    else
      v.swordtime = v.swordtime - dt
    end
  end
end
