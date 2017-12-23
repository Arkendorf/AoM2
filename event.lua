function event_load()
  events = {
    -- {x = 96, y = 32, enemies = {createEnemy(200, 0, 24, 32, 3, 2, tile.size, 2, true)}, done = false},
    -- {x = 32, y = 32, textboxes = {{"test of a textbox event", 1}}, done = false},
  }
  vips = 0
  currentEvent = nil
end

function event_update(dt)
  for i, v in ipairs(events) do
    if v.done == false and char.x+char.w/2 >= v.x then
      v.done = true
      currentEvent = v
      if v.enemies then
        lockScreen(v.x, v.y)
        for j, w in ipairs(v.enemies) do
          enemies[#enemies+1] = w
        end
        vips = #v.enemies
      end
      if v.textboxes then
        setTextboxes(v.textboxes)
      end
    end
  end
  if currentEvent and vips <= 0 then
    currentEvent = nil
    unlockScreen()
  end
end
