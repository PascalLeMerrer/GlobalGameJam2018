require "gameobjects.bubble"

require "resources.texts.sentences"



BubbleFactory = Class{}

function BubbleFactory:reset(index)
  self.nextSolutionPartIndex = index
end

function BubbleFactory:createBubblesAround(bubble)
  -- creates 4 bubbles around the given bubble position
  -- one with the next label to be identified, 3 with random text if the given bubble is a good one
  -- 4 with random texts otherwise
  local bubbles = {}

  if bubble:isRight() then
    local x, y = self:getRandomCoordinatesAround(bubble.x, bubble.y, bubble.radius)
    local label = self:getNextPartOfSolution()
    local newBubble = self:createBubble(x, y, label, IS_RIGHT)
    table.insert(bubbles, newBubble)
    random_bubble_count = 3
  else
    random_bubble_count = 4
  end

  for i = 1, random_bubble_count do
    local x, y = self:getRandomCoordinatesAround(bubble.x, bubble.y, bubble.radius)
    local randomLabel = self:getRandomString() 
    local newBubble = self:createBubble(x, y, randomLabel, IS_WRONG)
    table.insert(bubbles, newBubble)
  end

  return bubbles
end

function BubbleFactory:getRandomCoordinatesAround(x_pos, y_pos, radius)
  local angle = math.random(0, 2 * math.pi)
  local dx = math.cos(angle) * radius
  local dy = math.sin(angle) * radius
  return x_pos + dx, y_pos + dy
end

function BubbleFactory:createBubble(x, y, label, type)
  return Bubble(x, y, label, type)
end

function BubbleFactory:getNextPartOfSolution()
  -- return the next label for a right bubble
  -- when the solution was found, returns an empty string
  local startIndex = self.nextSolutionPartIndex
  local endIndex = startIndex + LABEL_LENGTH
  local sentence = sentences[level]
  if startIndex > #sentence then
    return ""
  end
  if endIndex > #sentence then
    endIndex = #sentence
  end
  self.nextSolutionPartIndex = endIndex + 1
  return string.sub(sentence, startIndex, endIndex)
end

function BubbleFactory:getRandomString()
  local fake_text = fake_texts[level]
  local start_index = math.random(0, string.utf8len(fake_text) - LABEL_LENGTH)
  local end_index = start_index + LABEL_LENGTH
  return string.utf8sub(fake_text, start_index, end_index)
end