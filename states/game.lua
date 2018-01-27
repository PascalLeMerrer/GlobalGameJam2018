Game = {}

require "gameobjects.bubble"



function Game:init()
  self.sentence = sentences[level]
  self.bubbles = {}
end

function Game:enter(previous) -- runs every time the state is entered
  self:createBubble()
end

function Game:update(dt) -- runs every frame
end

function Game:draw()
  -- love.graphics.print(self.sentence, 10, 10)
  for index, bubble in ipairs(self.bubbles) do
    bubble:draw()
  end
end

