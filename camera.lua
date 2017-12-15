function camera_load()
  camera = {x = 0, y = 0, newX = 0, newY = 0, lock = false, speed = 10}
  screen = {scale = 2}
  screen.w = love.graphics.getWidth() / screen.scale
  screen.h = love.graphics.getHeight() / screen.scale
end
function camera_update(dt)
  if camera.lock == false then
    camera.newX = char.x+char.w/2
    camera.newY = char.y+char.h/2

  end
  if camera.x ~= camera.newX then
    local difX = camera.speed * math.cos(math.atan2(camera.newY-camera.y, camera.newX-camera.x)) * 60 * dt
    if (camera.x > camera.newX and camera.x+difX < camera.newX) or (camera.x < camera.newX and camera.x+difX > camera.newX) then
      camera.x = camera.newX
    else
      camera.x = camera.x + difX
    end
  end
  if camera.y ~= camera.newY then
    local difY =  camera.speed  * math.sin(math.atan2(camera.newY-camera.y, camera.newX-camera.x)) * 60 * dt
    if (camera.y > camera.newY and camera.y+difY < camera.newY) or (camera.y < camera.newY and camera.y+difY > camera.newY) then
      camera.y = camera.newY
    else
      camera.y = camera.y + difY
    end
  end

end

function lockScreen(x, y)
  camera.lock = true
  camera.newX = x
  camera.newY = y
end

function unlockScreen()
  camera.lock = false
end
