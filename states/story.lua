Story = {}

HORIZONTAL_MARGIN = 10

function Story:init()
  self.font = love.graphics.newFont(20)
  self.lineHeight = self.font:getHeight()
end

function Story:enter(previous) -- runs every time the state is entered

  self.currentPartIndex = 1
  self.partCount = #levels[level]["chapters"]

  self:load()
end

function Story:load()
  local level = levels[level]
  local chapter = level["chapters"][self.currentPartIndex]
  local text = chapter["story"]

  local wrapLimit = WIN_WIDTH - 2 * HORIZONTAL_MARGIN
  local width, wrappedtext = self.font:getWrap( text, wrapLimit )
  self.lines = wrappedtext 

  self.image = love.graphics.newImage(chapter["illustration"]) 
  self.imageX = (WIN_WIDTH - HORIZONTAL_MARGIN - self.image:getWidth()) / 2
  self.imageY = WIN_HEIGHT - self.image:getHeight() - 100
end

function Story:update(dt) -- runs every frame
end

function Story:draw()
  love.graphics.setColor(255, 255, 255)    
  love.graphics.setFont(self.font)
  for i, line in ipairs(self.lines) do
    love.graphics.print(line, HORIZONTAL_MARGIN, i * self.lineHeight)
  end
  love.graphics.draw(self.image, self.imageX, self.imageY)
end

function Story:mousereleased()
  self.currentPartIndex = self.currentPartIndex + 1
  if self.currentPartIndex > self.partCount then
    if level == LAST_LEVEL then
      Signal.emit(GAME_END_SIGNAL) 
    else
      Signal.emit(NEXT_GAME_SIGNAL) 
    end
  else
    self:load()
  end
end