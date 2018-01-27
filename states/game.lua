Game = {}

function Game:init()
    self.sentence = sentences[level]
end

function Game:enter(previous) -- runs every time the state is entered
end

function Game:update(dt) -- runs every frame
end

function Game:draw()
  love.graphics.print(self.sentence, 10, 10)
end