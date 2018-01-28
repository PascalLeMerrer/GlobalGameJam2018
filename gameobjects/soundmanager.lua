require 'slam.slam'

SoundManager = Class{}

function SoundManager:init()
  self.bubblePopSound = love.audio.newSource({'resources/sounds/bubblePopping.wav'}, 'static')
  self.allbubbleBurstSound = love.audio.newSource({'resources/sounds/allBubbleBurst.wav'}, 'static')
  self.bubbleSpawnSound = love.audio.newSource({'resources/sounds/bubbleSpawn.wav'}, 'static')
end

function SoundManager:playBubblePopSound()
  love.audio.play(self.bubblePopSound)
end
function SoundManager:playAllBubbleBurstSound()
  love.audio.play(self.allbubbleBurstSound)
end
function SoundManager:playBubbleSpawnSound()
  love.audio.play(self.bubbleSpawnSound)
end

function SoundManager:playMusic()
  music = love.audio.newSource('music.ogg', 'stream') -- creates a new SLAM source
  music:setLooping(true)                              -- all instances will be looping
  music:setVolume(.3)                                 -- set volume for all instances
  love.audio.play(music)                              -- play music

end