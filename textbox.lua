function textbox_load()
  textboxes = {}
  textSpeed = 10
end

function textbox_update(dt)
  if #textboxes > 0 then
    if love.keyboard.isDown("z") then
      textboxes[1].t = textboxes[1].t + dt * textSpeed * 4
    else
      textboxes[1].t = textboxes[1].t + dt * textSpeed
    end
  end
end

function textbox_draw()
  if #textboxes > 0 then
    if textboxes[1].img then
      love.graphics.draw(profileImgs[textboxes[1].img], screen.w/2-64, screen.h-96)
    end
    love.graphics.draw(textboxImg, screen.w/2-64, screen.h-64)
    love.graphics.printf(string.sub(textboxes[1].str, 1, textboxes[1].t), screen.w/2-62, screen.h-62, 124)
  end
end

function textbox_keypressed(key)
  if key == "z" and textboxes[1].t >= string.len(textboxes[1].str) then
    table.remove(textboxes, 1)
    if #textboxes < 1 then
      pause = false
    end
  end
end

function setTextboxes(table)
  textboxes = {}
  for i, v in ipairs(table) do
    textboxes[#textboxes + 1] = {str = v[1], img = v[2], t = 0}
  end
  pause = true
end
