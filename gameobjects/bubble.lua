Class = require 'hump.class'

Bubble = Class{}

local anim8 = require 'anim8.anim8'
local image, animation

IS_RIGHT = 1
IS_WRONG = 0

LABEL_LENGTH = 4

DEFAULT_SPEED = 50
MIN_SPEED = 5

RADIUS = 50

FRAMES_FOR_DESTRUCTION_ANIMATION = '1-4'
ANIMATION_STEP_DURATION = 0.1 -- in seconds
FRAME_ROW = 1 -- all images are on one row

local bubbleFont = love.graphics.newFont(24)

function Bubble:init(x, y, label, type, world)
  self.type = type
  self.label = label
  self.radius = RADIUS
  self.scale = 1
  self.body = HC.circle(x, y, self.radius * self.scale)
  self.x, self.y = self.body:center()
  self.body.velocity = {}
  self.body.velocity.x = math.random(-DEFAULT_SPEED, DEFAULT_SPEED)
  self.body.velocity.y = math.random(-DEFAULT_SPEED, DEFAULT_SPEED)

  self.image = love.graphics.newImage("resources/images/bubbles/bubble100x100.png") 
  self.rotation = 0

  local textWidth = bubbleFont:getWidth(self.label)
  self.textOffset = textWidth / 2

  image = love.graphics.newImage("resources/images/bubbles/bubbleBurst100x100.png")
  local grid = anim8.newGrid(100, 100, image:getWidth(), image:getHeight())
  self.destructionAnimation = anim8.newAnimation(grid(FRAMES_FOR_DESTRUCTION_ANIMATION, FRAME_ROW), ANIMATION_STEP_DURATION, 'pauseAtEnd')
  self.destructionAnimation:pause()

  self.isDestroyed = false
  self.isBeingDestroyed = false
end

function Bubble:__tostring()
  return "bubble [ x = " .. self.body.x .. ", y = " .. self.body.y .. ", label = \"" .. self.label .. "\" ]"
end

function Bubble:isRight()
  return self.type == IS_RIGHT
end

function Bubble:update(dt)
  local collisions = HC.collisions(self.body)
  local x, y = self.body:center()
  for otherBody, separatingVector in pairs(collisions) do   
    self:repulse(otherBody, separatingVector)
  end

  if not self.isBeingDestroyed and not self.isDestroyed then
    self.body:move(self.body.velocity.x * dt, self.body.velocity.y * dt)
    self.x, self.y = self.body:center()
  end
  self.destructionAnimation:update(dt)

  if self.destructionAnimation.status == 'paused' and self.isBeingDestroyed then
    self.isBeingDestroyed = false
    self.isDestroyed = true
  end

end

function Bubble:draw()

  local x, y = self.body:center()
  self.destructionAnimation:draw(image, x - self.radius, y - self.radius)

  love.graphics.setFont(bubbleFont)
  if not self.isBeingDestroyed then
    love.graphics.print(self.label, x - self.textOffset, y, self.rotation, self.scale, self.scale)
  end
end

function Bubble:repulse(otherBody, separatingVector)
  local len = math.sqrt(separatingVector.x^2 + separatingVector.y^2)
  self.body.velocity.x = separatingVector.x / len * DEFAULT_SPEED * math.random(0.8, 1.2)
  self.body.velocity.y = separatingVector.y / len * DEFAULT_SPEED * math.random(0.8, 1.2)
end

function Bubble:isOver(x, y)
  local _x, _y = self.body:center()
  local dx = _x - x
  local dy = _y - y
  local distance = math.sqrt(dx^2 + dy^2)
  return distance <= self.radius
end

function Bubble:destroy()
  HC.remove(self.body)
  self.destructionAnimation:resume()
  self.isBeingDestroyed = true
end
