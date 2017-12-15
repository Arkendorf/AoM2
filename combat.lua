function combat_load()
  weapons = {
    {w = 16, h = 4, dmg = 1, spd = .3, drop = true, icon = 1, img = 1},
    {w = 12, h = 4, dmg = 1, spd = 1, drop = true, icon = 2, img = 2}
  }
  weaponDrops = {}
  attackDelay = 0.1
end

function combat_update(dt)
  if char.invtime > 0 then
    char.invtime = char.invtime - dt
  end
  for i, v in ipairs(enemies) do
    if v.dead == false then
      if v.invtime > 0 then
        v.invtime = v.invtime - dt
      end

      if v.swordtime > 0 and aabb(char, getWeaponHitbox(v)) and char.invtime <= 0 then
        if char.shield == false or char.dir == v.dir then
          char.hp = char.hp - weapons[v.weapon].dmg
          char.xV =  200 * dt * v.dir
          char.yV = 0
          char.invtime = 1
        else
          char.invtime = 1
        end
      end

      if char.swordtime > 0 and aabb(v, getWeaponHitbox(char)) and v.invtime <= 0 then
        if v.shield == false or v.dir == char.dir then
          v.hp = v.hp - weapons[char.weapon].dmg
          v.xV =  200 * dt * char.dir
          v.yV = 0
          v.invtime = 1
        else
          v.invtime = 1
        end
      end

      if v.hp <= 0 and v.dead == false then
        v.dead = true
        if v.vip then
          vips = vips - 1
        end
        if weapons[v.weapon].drop == true then
          newWeaponDrop(v)
        end
      end
    end
  end

  for i, v in ipairs(weaponDrops) do
    physics(v, dt)

    if aabb(char, v) == true and not inventory[v.weapon] then
      inventory[v.weapon] = true
      weaponDrops[i] = nil
    end
  end
end

function getWeaponHitbox(v)
  local weapon = weapons[v.weapon]
  local w = weapon.w
  local h = weapon.h
  local x = v.x+(v.w+w)*(v.dir+1)/2-w
  local y = v.y+v.h/2-weapon.h/2
  return {x = x, y = y, w = w, h = h}
end

function newWeaponDrop(object)
  local weapon = weapons[object.weapon]
  weaponDrops[#weaponDrops + 1] = {x = object.x+(object.w-weapon.w)/2, y = object.y+(object.h-weapon.h)/2, w = weapon.w, h = weapon.h, xV = object.xV*0.5, yV = object.yV*0.5, dir = object.dir, weapon = object.weapon}
end

function combat_draw()
  for i, v in ipairs(weaponDrops) do
    love.graphics.draw(weaponImgs[weapons[v.weapon].img], v.x, v.y)
  end
end
