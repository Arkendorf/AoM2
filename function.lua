function distance(a, b)
  return math.sqrt((a.x - b.x) * (a.x - b.x) + (a.y - b.y) * (a.y - b.y))
end

function removeNil(t)
  local ans = {}
  for _,v in pairs(t) do
    ans[ #ans+1 ] = v
  end
  return ans
end

function drawObject(object, img)
  local scale = {y = 1}
  if object.dir == 1 then
    scale.x = 1
  else
    scale.x = -1
  end
  if object.swordtime > 0 and object.dead == false then
    local hitbox = getWeaponHitbox(object)
    love.graphics.draw(weaponImgs[weapons[object.weapon].img], math.floor(object.x)+object.w*(scale.x+1)/2-hiltSize*scale.x, math.floor(hitbox.y), 0, scale.x, scale.y)
  end
  love.graphics.draw(charImgs[img].img, charImgs[img].anim[object.anim][math.floor(object.frame)], math.floor(object.x)-object.w*(scale.x-1)/2, math.floor(object.y), 0, scale.x, scale.y)
end

function animate(object, dt)
  if object.swordtime > 0 then
    if object.anim ~= 5 then
      object.frame = 1
    end
    object.anim = 5
  elseif object.shield == true and math.abs(object.xV) > 0.1 then
    if object.anim ~= 4 then
      object.frame = 1
    end
    object.anim = 4
  elseif object.shield == true then
    if object.anim ~= 3 then
      object.frame = 1
    end
    object.anim = 3
  elseif math.abs(object.xV) > 0.1 then
    if object.anim ~= 2 then
      object.frame = 1
    end
    object.anim = 2
  else
    if object.anim ~= 1 then
      object.frame = 1
    end
    object.anim = 1
  end
  if object.anim == 2 then
    object.frame = object.frame + dt * 6 * math.abs(object.xV) * charImgs[object.img].speed[object.anim]
  elseif object.anim == 4 then
    object.frame = object.frame + dt * 12 * object.xV * charImgs[object.img].speed[object.anim]
  else
    object.frame = object.frame + dt * charImgs[object.img].speed[object.anim]
  end
  if object.frame >= charImgs[object.img].length[object.anim]+1 then
    object.frame = 1
  elseif object.frame < 1 then
    object.frame = charImgs[object.img].length[object.anim]+1-dt
  end
end
