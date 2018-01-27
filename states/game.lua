Game = {}

require "gameobjects.bubble"

function Game:init()
    self.sentence = sentences[level]
end

function Game:enter(previous) -- runs every time the state is entered
  self.bubble = Bubble(WIN_WIDTH/2, WIN_HEIGHT/2, 20, "La p")
end

function Game:update(dt) -- runs every frame
end

function Game:draw()
  love.graphics.print(self.sentence, 10, 10)
  self.bubble:draw()
end