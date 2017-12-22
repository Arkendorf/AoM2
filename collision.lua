function collide(object)
  local collision = false
  for i = 0, 1 do
    for j = 0, 1 do
      corner = pointToTile(object.x+object.w*j+object.xV, object.y+object.h*i+object.yV)
      if map[corner.y] and map[corner.y][corner.x] and tile.type[map[corner.y][corner.x]] == 1 then
        collision = true
        local dif = {math.abs(object.x + object.w - (corner.x-1)*tile.size),
                     math.abs(object.x - corner.x*tile.size),
                     math.abs(object.y + object.h - (corner.y-1)*tile.size),
                     math.abs(object.y - corner.y*tile.size)}
        if dif[1] < dif[2] and dif[1] < dif[3] and dif[1] < dif[4] then
          object.x = (corner.x-1)*tile.size - object.w
          object.xV = 0
        elseif dif[2] < dif[1] and dif[2] < dif[3] and dif[2] < dif[4] then
          object.x = corner.x*tile.size
          object.xV = 0
        elseif dif[3] < dif[2] and dif[3] < dif[1] and dif[3] < dif[4] then
          object.y = (corner.y-1)*tile.size - object.h
          object.yV = 0
        elseif dif[4] < dif[2] and dif[4] < dif[3] and dif[4] < dif[1] then
          object.y = corner.y*tile.size
          object.yV = 0
        end
      end
    end
  end
  return collision
end

function borders(object)
  if currentEvent then -- collide with border of screen if locked
    if object.x+object.w+object.xV > currentEvent.x+screen.w/2 then
      object.xV = 0
      object.x = currentEvent.x+screen.w/2-object.w
    elseif object.x+object.xV < currentEvent.x-screen.w/2 then
      object.xV = 0
      object.x = currentEvent.x-screen.w/2
    end
  end
end

function pointToTile(x, y)
  return {x = math.ceil(x / tile.size), y = math.ceil(y / tile.size)}
end

function aabb(a, b)
  return (a.x < b.x + b.w and a.x + a.w > b.x and a.y < b.y + b.h and a.y + a.h > b.y)
end

function physics(object, dt)
  object.yV = object.yV + dt * gravity * 4 -- gravity

  collide(object)
  if isTile(object.x+1, object.y+object.h+1) or isTile(object.x+object.w-1, object.y+object.h+1) then -- if tile beneath object, it can jump
    object.jump = true
  else
    object.jump = false
  end

  object.x = object.x + object.xV
  object.xV = object.xV * 0.9

  object.y = object.y + object.yV
  object.yV = object.yV * 0.9
end

function isTile(x, y)
  local p = pointToTile(x, y)
  if map[p.y] and map[p.y][p.x] and tile.type[map[p.y][p.x]] == 1 then
    return true
  else
    return false
  end
end
