Class = require 'hump.class'

Syllable = Class{}

function Syllable:init(x, y, label)
  self.label = label
  self.font = love.graphics.newFont(20)
  self.width = self.font:getWidth(self.label)
  self.height = self.font:getHeight()
  self.x = x
  self.y = y
  self.scale = 1
  self.body = HC.rectangle(x, y, self.width * self.scale, self.height * self.scale)
  self.highlight = false
end

function Syllable:getMaxX()
  return self.x + self.width
end

function Syllable:draw()
  if self.highlight then
    love.graphics.setColor(255, 0, 0)
  else
    love.graphics.setColor(255, 255, 255)    
  end

  love.graphics.print(self.label, self.x, self.y, 0, self.scale, self.scale)
end

function Syllable:isOver(x, y)
  return self.x <= x 
  and self.x + self.width >= x 
  and self.y <= y
  and self.y + self.height >= y
end

function Syllable:destroy()
  HC.remove(self.body)
end
