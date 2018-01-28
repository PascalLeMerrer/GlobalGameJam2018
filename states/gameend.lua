GameEnd = {}

require "levels.credits"

HORIZONTAL_MARGIN = 10
SCROLLING_SPEED = 1


function GameEnd:init()
  self.titleFont = love.graphics.newFont(32)
  self.lineHeight = self.titleFont:getHeight()

  self.text = "FIN"
  local textWidth = self.titleFont:getWidth(self.text)
  self.textX = (WIN_WIDTH - textWidth) / 2
  self.textY = WIN_HEIGHT * 0.25

  self.image = love.graphics.newImage('resources/images/shell.png') 
  local imageHeight = self.image:getHeight()
  self.imageX = (WIN_WIDTH - HORIZONTAL_MARGIN - self.image:getWidth()) / 2
  self.imageY = WIN_HEIGHT - self.image:getHeight() - 50 - (WIN_HEIGHT - self.textY - imageHeight) / 2

  self.credits = self:formatCredits()
  self.creditsY = self.imageY + imageHeight + 50
      
  self.isScrolling = false
      
  self.endTimer = Timer.new()
  self.endTimer:after(2.5, function() 
      self.isScrolling = true
    end)
  
end

function GameEnd:formatCredits()
  self.creditFont = love.graphics.newFont(20)
  self.creditLineHeight = self.creditFont:getHeight()
  local wrapLimit = WIN_WIDTH - 2 * HORIZONTAL_MARGIN
  local width, wrappedtext = self.creditFont:getWrap( credits, wrapLimit )
  return wrappedtext 
end

function GameEnd:enter()
  soundManager:playEndMusic()
end

function GameEnd:update(dt)
  self.endTimer:update(dt)
  
  if self.isScrolling then
    self.textY = self.textY - SCROLLING_SPEED
    self.imageY = self.imageY - SCROLLING_SPEED
    self.creditsY = self.creditsY - SCROLLING_SPEED
  end
end

function GameEnd:draw()
  love.graphics.setColor(255, 255, 255)    
  love.graphics.setFont(self.titleFont)
  love.graphics.print(self.text, self.textX, self.textY)

  love.graphics.draw(self.image, self.imageX, self.imageY)

  love.graphics.setFont(self.creditFont)
  for i, line in ipairs(self.credits) do
    love.graphics.print(line, HORIZONTAL_MARGIN, self.creditsY + i * self.creditLineHeight)
  end

end