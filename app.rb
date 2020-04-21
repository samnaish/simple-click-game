require 'ruby2d'

set title: 'Reaction Click Game'
set width: 920
set height: 720

def update_background_color
    seconds = 0
    update do
        if seconds % 60 == 0
            set background: 'random'
        end
        seconds += 0.4
    end
end

update_background_color()

greeting_string = 'click to begin the game!'
message = Text.new(greeting_string, x: 330, y:320, color: 'black')
game_started = false
start_time = nil
circle = nil
duration = nil
boom = nil
boom_sound = nil

def boom_sound
    boom_sound = Sound.new('boom-sound.wav')
    boom_sound.play
end


music = Sound.new('arcade-game.wav')
music.play

on :mouse_down do |event|
    if game_started
        if circle.contains?(event.x,event.y)
            duration = ((Time.now - start_time) * 1000).round
            message = Text.new("You took: #{duration}. click to begin!",  x: 330, y:320, color: 'black')
            circle.remove
            boom_sound()
            boom = Sprite.new(
                'boom.png',
                x: circle.x - 30 , y: circle.y - 30,
                clip_width: 127,
                time: 60,
                z: 5
            )  
            boom.play
            game_started = false
        end
    else
        message.remove
        circle = Circle.new(
            x: rand(get(:width) - 30), y: rand(get(:height) - 30),
            size: 25,
            radius: 20,
            color: 'random',
            sectors: 32,
            z: 5
        )
        game_started = true
        start_time = Time.now
    end
end 

show