function inventory_load()
  pause = false
  inventory = {true}
  inv_menu = {current = 1, pos = 1, tileSize = 64, spacing = 80, active = false}
end
function inventory_update(dt)
  if love.keyboard.isDown("lshift") and char.swordtime <= 0 and inv_menu.active == false then
    pause = true
    inv_menu.active = true
    inv_menu.items = {}
    for i, v in ipairs(inventory) do
      if v == true then
        inv_menu.items[#inv_menu.items + 1] = i
      end
    end
  end
  inv_menu.pos = inv_menu.pos + ((inv_menu.current-1)*inv_menu.spacing - inv_menu.pos) * 30 * dt
end

function inventory_draw()
  if inv_menu.active == true then
    local items = 0
    for i, v in ipairs(inv_menu.items) do
      love.graphics.draw(weaponIcons[weapons[v].icon], items*inv_menu.spacing-inv_menu.pos-inv_menu.tileSize/2+screen.w/2, (screen.h-char.h)/2-inv_menu.spacing)
      items = items + 1
    end
  end
end

function inventory_keypressed(key)
  if key == "right" then
    inv_menu.current = inv_menu.current+1
    if inv_menu.current > #inv_menu.items then
      inv_menu.current = 1
    end
  elseif key == "left" then
    inv_menu.current = inv_menu.current-1
    if inv_menu.current < 1 then
      inv_menu.current = #inv_menu.items
    end
  end
end

function inventory_keyreleased(key)
  if key == "lshift" then
    char.weapon = inv_menu.items[inv_menu.current]
    pause = false
    inv_menu.active = false
  end
end
