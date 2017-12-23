






function background_draw()
  for i = 0, math.ceil(screen.w/256) do
    love.graphics.draw(background.img, background.layers[3], math.floor(i*256-((camera.x * 0.4) % 256)),  math.floor(#map*tile.size-256-camera.y+screen.h/2))
  end
  for i = 0, math.ceil(screen.w/256) do
    love.graphics.draw(background.img, background.layers[2], math.floor(i*256-((camera.x * 0.6) % 256)),  math.floor(#map*tile.size-256-camera.y+screen.h/2))
  end
  for i = 0, math.ceil(screen.w/256) do
    love.graphics.draw(background.img, background.layers[1], math.floor(i*256-((camera.x * 0.8) % 256)),  math.floor(#map*tile.size-256-camera.y+screen.h/2))
  end
end
