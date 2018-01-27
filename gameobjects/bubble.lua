Class = require 'hump.class'

Bubble = Class{}

function Bubble:init(x, y, radius, label)
  self.label = label
  self.radius = radius
  self.x = x
  self.y = y
  self.image = love.graphics.newImage("resources/images/bubbles/bubble50x50.png") 
  self.rotation = 0
  self.scale = 1
end

function Bubble:__tostring()
  return "bubble [ radius = " .. self.radius .. ", label = \"" .. self.label .. "\" ]"
end

function Bubble:draw()
  love.graphics.draw(self.image, self.x, self.y, self.rotation, self.scale, self.scale)
end
