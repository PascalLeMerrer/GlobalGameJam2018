-- pour écrire dans la console au fur et à mesure, facilitant ainsi le débogage
io.stdout:setvbuf('no') 

if arg[#arg] == "-debug" then require("mobdebug").start() end

Gamestate = require "hump.gamestate"
Signal = require 'hump.signal'

require "constants"
require "resources.sentences"
require "resources.texts"
require "states.story"
require "states.game"

level = 1


function love.load()
    initializeWindow()
    Gamestate.registerEvents()
    Gamestate.switch(Story)
    
    Signal.register(NEXT_GAME_SIGNAL, function(state)
      Gamestate.switch(Game)
    end
  )
    
    
end

function initializeWindow()
  love.window.setTitle(TITLE) 
  -- local imgIcon = love.graphics.newImage(ICON_PATH) 
  -- love.window.setIcon(imgIcon:getData())
  love.window.setMode(WIN_WIDTH, WIN_HEIGHT)
  
  font = love.graphics.newFont(32)
  love.graphics.setFont(font)
end


function love.keypressed(key)
  if key == "escape" then
    love.event.quit()
  end
end