GameOver = {}

HORIZONTAL_MARGIN = 10

function GameOver:init()

  self.image = love.graphics.newImage(levels[level]["endIllustration"]) 
  self.imageX = (WIN_WIDTH - HORIZONTAL_MARGIN - self.image:getWidth()) / 2
  
  self.font = love.graphics.newFont(22)
  self.lineHeight = self.font:getHeight()
end

function GameOver:enter(previous) -- runs every time the state is entered
  local endText = levels[level]["endText"]
  local wrapLimit = WIN_WIDTH - 2 * HORIZONTAL_MARGIN
  local width, wrappedtext = self.font:getWrap( endText, wrapLimit )
  self.lines = wrappedtext 
end

function GameOver:update(dt) -- runs every frame
end

function GameOver:draw()
  love.graphics.setColor(255, 255, 255)    
  love.graphics.setFont(self.font)
  local textHeight = 0
  for i, line in ipairs(self.lines) do
    love.graphics.print(line, HORIZONTAL_MARGIN, i * self.lineHeight)
    textHeight = textHeight + self.lineHeight
  end
  
    local imageY = WIN_HEIGHT - self.image:getHeight() - (WIN_HEIGHT - textHeight - self.image:getHeight()) / 2
  love.graphics.draw(self.image, self.imageX, self.imageY)
end