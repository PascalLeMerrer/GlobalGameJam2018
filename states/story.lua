Story = {}

function Story:init()
    self.text = texts[level]
    self.image = love.graphics.newImage(illustrations[level]) 
end

function Story:enter(previous) -- runs every time the state is entered
end

function Story:update(dt) -- runs every frame
end

function Story:draw()
  love.graphics.print(self.text, 10, 10)
  love.graphics.draw(self.image, 200, 200)
end


function Story:keypressed(key)
  if key == "return" then
    Signal.emit(NEXT_GAME_SIGNAL, gameState) 
  end
end