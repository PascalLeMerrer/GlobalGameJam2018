Game = {}


require "gameobjects.bubble"
require "gameobjects.bubblefactory"
require "resources.texts.sentences"

function Game:init()
  self.sentence = sentences[level]
  self.bubbles = {}
  self.bubbleFactory = BubbleFactory()
end

function Game:enter(previous) -- runs every time the state is entered
  math.randomseed( os.time() )
  self.intialBubble = self.bubbleFactory:createBubble(WIN_WIDTH / 2, WIN_HEIGHT / 2, "OK", IS_RIGHT)
  self.bubbles = self.bubbleFactory:createBubblesAround(self.intialBubble)
end

function Game:update(dt) -- runs every frame
end

function Game:draw()
  -- love.graphics.print(self.sentence, 10, 10)
  for index, bubble in ipairs(self.bubbles) do
    bubble:draw()
  end
end
  
