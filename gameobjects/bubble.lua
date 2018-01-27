Class = require 'hump.class'

Bubble = Class{}

IS_RIGHT = 1
IS_WRONG = 0

LABEL_LENGTH = 4

local bubbleFont = love.graphics.newFont(12)

function Bubble:init(x, y, label, type)
  self.type = type
  self.label = label
  self.radius = 25
  self.x = x
  self.y = y
  self.image = love.graphics.newImage("resources/images/bubbles/bubble50x50.png") 
  self.rotation = 0
  self.scale = 1
end

function Bubble:__tostring()
  return "bubble [ x = " .. self.x .. ", y = " .. self.y .. ", label = \"" .. self.label .. "\" ]"
end

function Bubble:isRight()
  return self.type == IS_RIGHT
end

function Bubble:draw()
  love.graphics.setFont(bubbleFont)
  love.graphics.draw(self.image, self.x, self.y, self.rotation, self.scale, self.scale)
  love.graphics.print(self.label, self.x + self.radius / 2, self.y + self.radius, self.rotation, self.scale, self.scale)
end
end
