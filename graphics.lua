function graphics_load()
  love.graphics.setDefaultFilter("nearest", "nearest")

  font = love.graphics.newImageFont("font.png",
  " abcdefghijklmnopqrstuvwxyz" ..
  "ABCDEFGHIJKLMNOPQRSTUVWXYZ0" ..
  "123456789.,!?-+/():;%&`'*#=[]\"", 1)
  love.graphics.setFont(font)

  canvas = love.graphics.newCanvas(screen.w, screen.h)
  weaponIcons = loadFolder("weaponIcons")
  weaponImgs = loadFolder("weaponImgs")
  hiltSize = 6
  profileImgs = loadFolder("profileImgs")
  tileImgs = loadFolder("tiles")
  bitmaskQuads = {}
  for i = 0, 3 do
    for j = 0, 3 do
      bitmaskQuads[j*4+i] = love.graphics.newQuad(i*tile.size, j*tile.size, tile.size, tile.size, tile.size*4, tile.size*4)
    end
  end

  charImgs = loadAnimFolder("chars")

  textboxImg = love.graphics.newImage("textbox.png")

  projectileImgs = loadFolder("projectileImgs")
end

function bitmask(tX, tY)
  local value = 0
  if tX > 1 and tile.type[map[tY][tX-1]] == 1 then
    value = value + 2
  end
  if tY > 1 and tile.type[map[tY-1][tX]] == 1 then
    value = value + 1
  end
  if tX < #map[1] and tile.type[map[tY][tX+1]] == 1 then
    value = value + 4
  end
  if tY < #map and tile.type[map[tY+1][tX]] == 1 then
    value = value + 8
  end
  return bitmaskQuads[value]
end

function loadAnimFolder(folder)
  imageList = {}
  i = 1
  while true do
    if love.filesystem.isFile(folder.."/"..tostring(i)..".png") == true then
      imageList[i] = {anim = {}}
      imageList[i].img = love.graphics.newImage(folder.."/"..tostring(i)..".png")
      local animInfo = love.filesystem.load(folder.."/"..tostring(i)..".txt")()    
      for j = 1, #animInfo.length do
        imageList[i].anim[j] = createSpriteSheet(imageList[i].img, 1, animInfo.length[j], animInfo.frame.x, animInfo.frame.y, (j-1)*animInfo.frame.x)
      end
      imageList[i].length = animInfo.length
      imageList[i].speed = animInfo.speed
      i = i + 1
    else
      break
    end
  end
  return imageList
end

function loadFolder(folder)
  imageList = {}
  i = 1
  while true do
    if love.filesystem.isFile(folder.."/"..tostring(i)..".png") == true then
      imageList[i] = love.graphics.newImage(folder.."/"..tostring(i)..".png")
      i = i + 1
    else
      break
    end
  end
  return imageList
end

function createSpriteSheet(a, b, c, d, e, f, g) -- image, tiles across, tiles down, tile width, tile height, x offset, y offset
if not f then
  f = 0
end
if not g then
  g = 0
end
local spriteSheet = {}
for i = 1, c do
  for k = 1, b do
    spriteSheet[#spriteSheet + 1] = love.graphics.newQuad(f + (k - 1) * d, g + (i - 1) * e, d, e, a:getDimensions())
  end
end
return spriteSheet
end
