Home = {}

Timer = require "hump.timer"

HORIZONTAL_MARGIN = 10

function Home:init()
  self.font = love.graphics.newFont(32)
  self.lineHeight = self.font:getHeight()

  self.text = TITLE
  local textWidth = self.font:getWidth(self.text)
  self.textX = (WIN_WIDTH - textWidth) / 2
  self.textY = WIN_HEIGHT * 0.25

  self.image = love.graphics.newImage('resources/images/shell.png') 
  self.imageX = (WIN_WIDTH - HORIZONTAL_MARGIN - self.image:getWidth()) / 2
  self.imageY = WIN_HEIGHT - self.image:getHeight() - (WIN_HEIGHT - self.textY - self.image:getHeight()) / 2
  
  Timer.after(2.5, function() 
      Signal.emit(NEXT_STORY_SIGNAL)
    end)

end

function Home:update(dt)
  Timer.update(dt)
end

function Home:draw()
  love.graphics.setColor(255, 255, 255)    
  love.graphics.setFont(self.font)

  love.graphics.print(self.text, self.textX, self.textY)

  love.graphics.draw(self.image, self.imageX, self.imageY)

end