require 'slam.slam'

SoundManager = Class{}

function SoundManager:init()
  self.bubblePopSound = love.audio.newSource({'resources/sounds/bubblePopping.wav'}, 'static')
  self.allbubbleBurstSound = love.audio.newSource({'resources/sounds/allBubbleBurst.wav'}, 'static')
  self.bubbleSpawnSound = love.audio.newSource({'resources/sounds/bubbleSpawn.wav'}, 'static')
  self.bubbleGameMusic = love.audio.newSource({'resources/sounds/GameplayMusic.wav'}, 'static')
  self.endMusic = love.audio.newSource({'resources/sounds/EndMusic.mp3'}, 'static')
  self.bubbleGameOverSound = love.audio.newSource({'resources/sounds/shellDestroyed.wav'}, 'static')
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

function SoundManager:playGameOverSound()
  love.audio.play(self.bubbleGameOverSound)
end

function SoundManager:playGameMusic()
  self.bubbleGameMusic:setLooping(true) 
  love.audio.play(self.bubbleGameMusic)
end

function SoundManager:playEndMusic()
  self.endMusic:setLooping(true) 
  love.audio.play(self.endMusic)
end