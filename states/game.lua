Game = {}

HC = require 'HardonCollider'

require "gameobjects.bubble"
require "gameobjects.bubblefactory"
require "resources.texts.sentences"

BORDER_WIDTH = 100

function Game:init()
  Collider = HC.new(100)
  self.topBorder = HC.rectangle(0, -BORDER_WIDTH, WIN_WIDTH, BORDER_WIDTH) -- x, y, width, height
  self.bottomBorder = HC.rectangle(0, WIN_HEIGHT, WIN_WIDTH, BORDER_WIDTH)
  self.leftBorder = HC.rectangle(-BORDER_WIDTH, 0, BORDER_WIDTH, WIN_HEIGHT)
  self.rightBorder = HC.rectangle(WIN_WIDTH, 0, BORDER_WIDTH, WIN_HEIGHT)

  self.sentence = sentences[level]
  self.bubbles = {}
  self.bubbleFactory = BubbleFactory()

end

function Game:enter(previous) -- runs every time the state is entered
  math.randomseed( os.time() )
  self.intialBubble = self.bubbleFactory:createBubble(WIN_WIDTH / 2, WIN_HEIGHT / 2, "OK", IS_RIGHT)
  self.bubbles = self.bubbleFactory:createBubblesAround(self.intialBubble)
  self:removeBubble(self.intialBubble)
end

function Game:update(dt) -- runs every frame
  local isClicked = love.mouse.isDown(1)
  local mouseX, mouseY = love.mouse.getPosition()
  for index, bubble in ipairs(self.bubbles) do
    if isClicked then
      if bubble:isOver(mouseX, mouseY) then
        self:removeBubble(bubble)
      else
        bubble:update(dt)
      end
    else
      bubble:update(dt)
    end
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
  bubble:destroy()
end

function Game:draw()
  -- love.graphics.print(self.sentence, 10, 10)
  for index, bubble in ipairs(self.bubbles) do
    bubble:draw()
  end
end