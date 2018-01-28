-- pour écrire dans la console au fur et à mesure, facilitant ainsi le débogage
io.stdout:setvbuf('no') 

if arg[#arg] == "-debug" then require("mobdebug").start() end

Gamestate = require "hump.gamestate"
Signal = require 'hump.signal'
require "UTF8.utf8"
require "debugTable"
require "constants"
require "resources.texts.sentences"
require "resources.illustrations"
require "states.story"
require "states.game"
require "states.gameover"

level = 1


function love.load()
  initializeWindow()
  Gamestate.registerEvents()
  Gamestate.switch(Story)
--  Gamestate.switch(Game) -- to delete

  Signal.register(NEXT_GAME_SIGNAL, function()
      Gamestate.switch(Game)
    end
  )
  Signal.register(NEXT_STORY_SIGNAL, function()
      Gamestate.switch(Story)
    end
  )
  Signal.register(END_GAME_SIGNAL, function()
      Gamestate.switch(GameOver)
    end
  )

end

function initializeWindow()
  love.window.setTitle(TITLE) 
  local imgIcon = love.graphics.newImage("resources/images/shell.png") 
  love.window.setIcon(imgIcon:getData())
  love.window.setMode(WIN_WIDTH, WIN_HEIGHT)
end

function love.keypressed(key)
  if key == "escape" then
    love.event.quit()
  end
end