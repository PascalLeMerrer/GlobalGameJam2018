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

  local sound = chapter["sound"]
  if sound ~= nil then
    self.sound = love.audio.newSource({sound}, 'static')
    love.audio.play(self.sound)
  end

end

function Story:update(dt) -- runs every frame
end

function Story:draw()
  love.graphics.setColor(255, 255, 255)    
  love.graphics.setFont(self.font)
  local textHeight = 0
  for i, line in ipairs(self.lines) do
    love.graphics.print(line, HORIZONTAL_MARGIN, i * self.lineHeight)
    textHeight = textHeight + self.lineHeight
  end
  local imageY = WIN_HEIGHT - self.image:getHeight() - (WIN_HEIGHT - textHeight - self.image:getHeight()) / 2
  love.graphics.draw(self.image, self.imageX, imageY)
end

function Story:mousereleased()
  love.audio.stop()
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