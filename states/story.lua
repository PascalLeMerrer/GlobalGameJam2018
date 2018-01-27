Story = {}

require "resources.texts.chapters"

HORIZONTAL_MARGIN = 10

function Story:init()

  self.image = love.graphics.newImage(illustrations[level]) 
  self.imageX = WIN_WIDTH - HORIZONTAL_MARGIN - self.image:getWidth()
  self.imageY = WIN_HEIGHT - self.image:getHeight()
  self.font = love.graphics.newFont(22)
  local chapter = chapters[level]
  local wrapLimit = WIN_WIDTH - 2 * HORIZONTAL_MARGIN
  local width, wrappedtext = self.font:getWrap( chapter, wrapLimit )
  self.lines = wrappedtext 
  
  self.lineHeight = self.font:getHeight()
end

function Story:enter(previous) -- runs every time the state is entered
end

function Story:update(dt) -- runs every frame
end

function Story:draw()
  love.graphics.setFont(self.font)
  for i, line in ipairs(self.lines) do
    love.graphics.print(line, HORIZONTAL_MARGIN, i * self.lineHeight)
  end
  love.graphics.draw(self.image, self.imageX, self.imageY)
end


function Story:keypressed(key)
  if key == "return" then
    Signal.emit(NEXT_GAME_SIGNAL, gameState) 
  end
end