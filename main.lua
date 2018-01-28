-- pour écrire dans la console au fur et à mesure, facilitant ainsi le débogage
io.stdout:setvbuf('no') 

if arg[#arg] == "-debug" then require("mobdebug").start() end

Gamestate = require "hump.gamestate"
Signal = require 'hump.signal'
require "UTF8.utf8"
require "debugTable"
require "constants"

levels = {}
require "levels.level1"
require "levels.level2"
require "levels.level3"
require "levels.level4"
require "levels.level5"

require "states.story"
require "states.game"
require "states.gameover"
require "states.gameend"

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
  Signal.register(GAME_OVER_SIGNAL, function()
      Gamestate.switch(GameOver)
    end
  )
  Signal.register(GAME_END_SIGNAL, function()
      Gamestate.switch(GameEnd)
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

  if key == "space" and Gamestate.current() == Game then
    level = level + 1
    Signal.emit(NEXT_STORY_SIGNAL)
  end
  if key == "escape" then
    love.event.quit()
  end
end