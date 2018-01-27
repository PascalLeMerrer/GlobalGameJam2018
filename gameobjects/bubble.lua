Class = require 'hump.class'

Bubble = Class{}

IS_RIGHT = 1
IS_WRONG = 0

LABEL_LENGTH = 4

DEFAULT_SPEED = 30

local bubbleFont = love.graphics.newFont(12)

function Bubble:init(x, y, label, type, world)
  self.type = type
  self.label = label
  self.radius = 25
  self.scale = 1
  self.world = world
  self.body = HC.circle(x, y, self.radius * self.scale)
  self.x, self.y = self.body:center()
  self.body.velocity = {}
  self.body.velocity.x = math.random(-DEFAULT_SPEED, DEFAULT_SPEED)
  self.body.velocity.y = math.random(-DEFAULT_SPEED, DEFAULT_SPEED)

  self.image = love.graphics.newImage("resources/images/bubbles/bubble50x50.png") 
  self.rotation = 0

  local textWidth = bubbleFont:getWidth(self.label)
  self.textOffset = textWidth / 2
end

function Bubble:__tostring()
  return "bubble [ x = " .. self.body.x .. ", y = " .. self.body.y .. ", label = \"" .. self.label .. "\" ]"
end

function Bubble:isRight()
  return self.type == IS_RIGHT
end

function Bubble:update(dt)
  local collisions = HC.collisions(self.body)
  for otherBody, separatingVector in pairs(collisions) do   
    if otherBody == self.world.bottomBorder or otherBody == self.world.topBorder then
      self.body.velocity.y = -self.body.velocity.y
    elseif otherBody == self.world.leftBorder or otherBody == self.world.rightBorder then
      self.body.velocity.x = -self.body.velocity.x
    else
      -- colliding with another bubble
      self:repulse(otherBody, separatingVector)
    end
  end

  self.body:move(self.body.velocity.x * dt, self.body.velocity.y * dt)
  self.x, self.y = self.body:center()
end

function Bubble:draw()

  love.graphics.setFont(bubbleFont)
  local x, y = self.body:center()

  love.graphics.draw(self.image, x - self.radius, y - self.radius, self.rotation, self.scale, self.scale)

  love.graphics.print(self.label, x - self.textOffset, y, self.rotation, self.scale, self.scale)
  --self.body:draw('fill')
end

function Bubble:repulse(otherBody, separatingVector)
  x1, y1 = self.body:center()

  x2, y2 = otherBody:center()

  local len = math.sqrt(separatingVector.x^2 + separatingVector.y^2)
  self.body.velocity.x = separatingVector.x / len * DEFAULT_SPEED
  self.body.velocity.y = separatingVector.y / len * DEFAULT_SPEED
end
