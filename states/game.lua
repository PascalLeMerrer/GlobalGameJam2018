Game = {}

HC = require 'HardonCollider'

require "gameobjects.bubble"
require "gameobjects.bubblefactory"
require "gameobjects.syllable"

BORDER_WIDTH = 200
SPACE_BETWEEN_CHARS = 5
SELECTED_TEXT_HEIGHT = 50

MAX_BUBBLES = 31

function Game:init()
  Collider = HC.new(100)
  self.topBorder = HC.rectangle(0, -BORDER_WIDTH, WIN_WIDTH, BORDER_WIDTH) -- x, y, width, height
  self.bottomBorder = HC.rectangle(0, WIN_HEIGHT - SELECTED_TEXT_HEIGHT, WIN_WIDTH, BORDER_WIDTH)
  self.leftBorder = HC.rectangle(-BORDER_WIDTH, 0, BORDER_WIDTH, WIN_HEIGHT)
  self.rightBorder = HC.rectangle(WIN_WIDTH, 0, BORDER_WIDTH, WIN_HEIGHT)

  self.bubbleFactory = BubbleFactory()

  self.font = love.graphics.newFont(22)

end

function Game:getFirstWord()
  local endIndex = self.sentence:find(' ')
  return self.sentence:sub(0, endIndex - 1)
end

function Game:enter(previous) -- runs every time the state is entered
  self.sentence = levels[level]["sentence"]

  math.randomseed( os.time() )
  local firstWord = self:getFirstWord()

  self.bubbles = {}
  self.selectedSyllables = {}

  self.bubbleFactory:reset(string.utf8len(firstWord) + 1)
  local initialBubble = self.bubbleFactory:createBubble(WIN_WIDTH / 2, WIN_HEIGHT / 2, firstWord, IS_RIGHT)
  table.insert(self.bubbles, initialBubble)
end

function Game:setMouseClicked(x, y)
--  self.isClicked = true
  self.mouseX = x
  self.mouseY = y
end

function Game:update(dt) -- runs every frame
--  local isClicked = love.mouse.isDown(1)
  local mouseX, mouseY = love.mouse.getPosition()
  local bubbleToRemove = nil
  for index, bubble in ipairs(self.bubbles) do
    if self:isClicked(bubble) then
      bubble:destroy()
    else
      bubble:update(dt)
      if bubble.isDestroyed then
        bubbleToRemove = bubble
      end
    end
  end

  local gameNotFinished = not self:isFinished()
  if bubbleToRemove ~= nil then
    self:removeBubble(bubbleToRemove, gameNotFinished)
    if gameNotFinished then
      self:createNewBubblesAround(bubbleToRemove)
      if #self.bubbles > MAX_BUBBLES then
        Signal.emit(GAME_OVER_SIGNAL)
      end
    else
      if #self.bubbles == 0 then
        level = level + 1
        Signal.emit(NEXT_STORY_SIGNAL) 
      end
    end
  end

  self:updateSyllables()

  if not love.mouse.isDown(1) then
    self.mouseClickProcessed = false
  end

end

function Game:updateSyllables()
  local mouseX = love.mouse.getX()
  local mouseY = love.mouse.getY()
  local previousSyllableX = 0

  for i, syllable in ipairs(self.selectedSyllables) do
    syllable.highlight = syllable:isOver(mouseX, mouseY)

    if syllable.highlight and love.mouse.isDown(1) and not self.mouseClickProcessed  then
      self:removeSyllable(syllable)
      self.mouseClickProcessed = true
    end
  end
end

function Game:removeSyllable(syllable)
  local index = -1
  local shiftLeft = false
  local previousSyllableX = 0
  for i, selectedSyllable in ipairs(self.selectedSyllables) do
    if shiftLeft then
      local tempX = selectedSyllable.x
      selectedSyllable.x = previousSyllableX
      previousSyllableX = tempX
    end
    if syllable == selectedSyllable then
      index = i
      previousSyllableX = syllable.x
      shiftLeft = true
    end
  end
  if index > 0 then
    table.remove(self.selectedSyllables, index)
  end
end

function Game:isClicked(bubble)
  if love.mouse.isDown(1) and not self.mouseClickProcessed then
    local mouseIsOverBubble = bubble:isOver(love.mouse.getX(), love.mouse.getY()) 
    self.mouseClickProcessed = mouseIsOverBubble
    return mouseIsOverBubble
  end
end

function Game:removeBubble(bubble, addWordToSelection)
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

  if addWordToSelection then
    self:createSyllable(bubble.label)
  end

  if self:isFinished() then
    self:destroyAllBubbles()
  end
end

function Game:createSyllable(label)
  local x = 10
  if #self.selectedSyllables > 0 then
    local lastSyllable = self.selectedSyllables[#self.selectedSyllables]
    x = lastSyllable:getMaxX() + SPACE_BETWEEN_CHARS
  end
  local y = WIN_HEIGHT - SELECTED_TEXT_HEIGHT
  local syllable = Syllable(x, y, label)
  table.insert(self.selectedSyllables, syllable)
end

function Game:isFinished()
  local selectedSyllables = ""
  for i, syllable in ipairs(self.selectedSyllables) do
    selectedSyllables = selectedSyllables .. syllable.label
  end
  return selectedSyllables == self.sentence
end

function Game:destroyAllBubbles()
  for _, bubble in ipairs(self.bubbles) do
    bubble:destroy()
  end
end

function Game:createNewBubblesAround(bubble)
  local newBubbles = self.bubbleFactory:createBubblesAround(bubble)
  for i, newBubble in ipairs(newBubbles) do
    table.insert(self.bubbles, newBubble)
  end
end

function Game:draw()
  love.graphics.setColor(255, 255, 255)    
  love.graphics.setFont(self.font)
  for i, syllable in ipairs(self.selectedSyllables) do
    syllable:draw()
  end

  for index, bubble in ipairs(self.bubbles) do
    bubble:draw()
  end
end