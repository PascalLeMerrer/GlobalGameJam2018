Game = {}

HC = require 'HardonCollider'

require "gameobjects.bubble"
require "gameobjects.bubblefactory"
require "resources.texts.sentences"

BORDER_WIDTH = 100

SELECTED_TEXT_HEIGHT = 50

function Game:init()
  Collider = HC.new(100)
  self.topBorder = HC.rectangle(0, -BORDER_WIDTH, WIN_WIDTH, BORDER_WIDTH) -- x, y, width, height
  self.bottomBorder = HC.rectangle(0, WIN_HEIGHT - SELECTED_TEXT_HEIGHT, WIN_WIDTH, BORDER_WIDTH)
  self.leftBorder = HC.rectangle(-BORDER_WIDTH, 0, BORDER_WIDTH, WIN_HEIGHT)
  self.rightBorder = HC.rectangle(WIN_WIDTH, 0, BORDER_WIDTH, WIN_HEIGHT)

  self.sentence = sentences[level]
  self.bubbles = {}
  self.bubbleFactory = BubbleFactory()
  
  
  self.selectedSyllables = {}
  self.font = love.graphics.newFont(22)
  
end

function Game:enter(previous) -- runs every time the state is entered
  math.randomseed( os.time() )
  initialBubble = self.bubbleFactory:createBubble(WIN_WIDTH / 2, WIN_HEIGHT / 2, "Morgan ", IS_RIGHT)
  table.insert(self.bubbles, initialBubble)
end

function Game:setMouseClicked(x, y)
  self.isClicked = true
  self.mouseX = x
  self.mouseY = y
end

function Game:update(dt) -- runs every frame
  local isClicked = love.mouse.isDown(1)
  local mouseX, mouseY = love.mouse.getPosition()
  local bubbleToRemove = nil
  for index, bubble in ipairs(self.bubbles) do
    if self:isClicked(bubble) then
      bubbleToRemove = bubble
    else
      bubble:update(dt)
    end
  end

  if bubbleToRemove ~= nil then
    self:removeBubble(bubbleToRemove)
    self:createNewBubbleAround(bubbleToRemove)
  end

end

function Game:isClicked(bubble)
  if love.mouse.isDown(1) and not self.mouseClickProcessed then
    local mouseIsOverBubble = bubble:isOver(love.mouse.getX(), love.mouse.getY()) 
    self.mouseClickProcessed = mouseIsOverBubble
    return mouseIsOverBubble
  end

  if not love.mouse.isDown(1) then
    self.mouseClickProcessed = false
  end

end

function Game:removeBubble(bubble)
  local index = -1
  for i, registeredBubble in ipairs(self.bubbles) do
    if bubble == registeredBubble then
      index = i
      break
    end
  end
  if index > 0 then
    table.remove(self.bubbles, index)
  end
  table.insert(self.selectedSyllables, bubble.label)
  bubble:destroy()
end

function Game:createNewBubbleAround(bubble)
  local newBubbles = self.bubbleFactory:createBubblesAround(bubble)
  for i, newBubble in ipairs(newBubbles) do
    table.insert(self.bubbles, newBubble)
  end
end

function Game:draw()
  love.graphics.setFont(self.font)
  love.graphics.print(self.selectedSyllables, 10, WIN_HEIGHT - SELECTED_TEXT_HEIGHT)
  for index, bubble in ipairs(self.bubbles) do
    bubble:draw()
  end
end