GameEnd = {}

Timer = require "hump.timer"

HORIZONTAL_MARGIN = 10

function GameEnd:init()
  self.font = love.graphics.newFont(32)
  self.lineHeight = self.font:getHeight()

  self.text = "FIN"
  local textWidth = self.font:getWidth(self.text)
  self.textX = (WIN_WIDTH - textWidth) / 2
  self.textY = WIN_HEIGHT * 0.25

  self.image = love.graphics.newImage('resources/images/shell.png') 
  self.imageX = (WIN_WIDTH - HORIZONTAL_MARGIN - self.image:getWidth()) / 2
  self.imageY = WIN_HEIGHT - self.image:getHeight() - (WIN_HEIGHT - self.textY - self.image:getHeight()) / 2
  
end

function GameEnd:update(dt)

end

function GameEnd:draw()
  love.graphics.setColor(255, 255, 255)    
  love.graphics.setFont(self.font)

  love.graphics.print(self.text, self.textX, self.textY)

  love.graphics.draw(self.image, self.imageX, self.imageY)

end