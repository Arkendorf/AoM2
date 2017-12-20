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
  matthew = loadObjImg("matthew.png")
  guk = loadObjImg("guk.png")
  tile.img = love.graphics.newImage("tiles.png")
  tile.quad = createSpriteSheet(tile.img, 2, 2, 32, 32)

  textboxImg = love.graphics.newImage("textbox.png")

  projectileImgs = loadFolder("projectileImgs")
end

function drawObject(object, img)
  local scale = {y = 1}
  local quad = nil
  if object.dir == 1 then
    scale.x = 1
  else
    scale.x = -1
  end
  if object.swordtime > 0 then
    quad = img.sword
  elseif object.shield == true then
    quad = img.shield
  else
    quad = img.idle
  end
  if object.swordtime > 0 and object.dead == false then
    local hitbox = getWeaponHitbox(object)
    love.graphics.draw(weaponImgs[weapons[object.weapon].img], math.floor(object.x)+object.w*(scale.x+1)/2-hiltSize*scale.x, math.floor(hitbox.y), 0, scale.x, scale.y)
  end
  love.graphics.draw(img.img, quad, math.floor(object.x)-object.w*(scale.x-1)/2, math.floor(object.y), 0, scale.x, scale.y)
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

function loadObjImg(img)
  local object = {}
  object.img = love.graphics.newImage(img)
  local w = object.img:getWidth() / 3
  local h = object.img:getHeight()
  object.idle = love.graphics.newQuad(0, 0, w, h, object.img:getDimensions())
  object.shield = love.graphics.newQuad(w, 0, w, h, object.img:getDimensions())
  object.sword = love.graphics.newQuad(w*2, 0, w, h, object.img:getDimensions())
  return object
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
