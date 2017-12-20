function char_load()
  char = {x = 0, y = 32, w = 24, h = 32, xV = 0, yV = 0, dir = 1, jump = false, shield = false, swordtime = 0, weapon = 1, hp = 10, invtime = 0, dead = false}
end

function char_update(dt)
  local speed = 40
  if char.swordtime > 0 then
    speed = 0
  elseif char.shield == true then
    speed = speed / 4
  end
  if love.keyboard.isDown("right") then
    char.xV = char.xV + dt * speed
    if char.swordtime <= 0 and char.shield == false then
      char.dir = 1
    end
  end
  if love.keyboard.isDown("left") then
    char.xV = char.xV - dt * speed
    if char.swordtime <= 0 and char.shield == false then
      char.dir = -1
    end
  end
  if love.keyboard.isDown("x") and char.swordtime <= -attackDelay and char.jump == true then
    char.shield = true
  elseif char.shield == true then
    char.shield = false
  end
  if love.keyboard.isDown("z") and char.swordtime <= -attackDelay then
    char.swordtime = weapons[char.weapon].spd
    char.shield = false
    if weapons[char.weapon].type == 2 then
      newProjectile(char.x+char.w*(char.dir+1)/2, char.y+char.h/2, weapons[char.weapon].dmg*char.dir, 0, 1, 1)
    end
  elseif char.swordtime > -attackDelay then
    char.swordtime = char.swordtime - dt
  end
  physics(char, dt)
  borders(char)
end

function char_draw()
  drawObject(char, matthew)
end

function char_keypressed(key)
  if love.keyboard.isDown("up") and char.jump == true and char.swordtime <= 0 then
    char.yV = - globalDt * 600
  end
end
