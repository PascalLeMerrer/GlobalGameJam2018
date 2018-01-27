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
  self.isHovered = false
end

function Syllable:getMaxX()
    return self.x + self.width
end

function Syllable:update(dt)

end

function Syllable:draw()
    love.graphics.print(self.label, self.x, self.y, 0, self.scale, self.scale)
end

function Syllable:isOver(x, y)
  local _x, _y = self.body:center()
  local dx = _x - x
  local dy = _y - y
  local distance = math.sqrt(dx^2 + dy^2)
  return distance <= self.radius
end

function Syllable:destroy()
  HC.remove(self.body)
end
