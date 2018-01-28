GameEnd = {}

HORIZONTAL_MARGIN = 10

function GameEnd:init()
  self.font = love.graphics.newFont(20)
  self.lineHeight = self.font:getHeight()

  text = "FIN"
  local wrapLimit = WIN_WIDTH - 2 * HORIZONTAL_MARGIN
  local width, wrappedtext = self.font:getWrap( text, wrapLimit )
  self.lines = wrappedtext 

--  self.image = love.graphics.newImage(chapter["illustration"]) 
--  self.imageX = WIN_WIDTH - HORIZONTAL_MARGIN - self.image:getWidth()
--  self.imageY = WIN_HEIGHT - self.image:getHeight()
end

function GameOver:update(dt) -- runs every frame
end

function GameEnd:draw()
  love.graphics.setColor(255, 255, 255)    
  love.graphics.setFont(self.font)
  for i, line in ipairs(self.lines) do
    love.graphics.print(line, HORIZONTAL_MARGIN, i * self.lineHeight)
  end
--  love.graphics.draw(self.image, self.imageX, self.imageY)
end