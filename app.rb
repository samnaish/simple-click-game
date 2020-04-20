require 'ruby2d'

set background: 'green'
set title: 'Reaction Click Game'

greeting_string = 'click to begin!'
message = Text.new(greeting_string, x: 20, y:20)
game_started = false
start_time = nil
square = nil
duration = nil

on :mouse_down do |event|
    
    if game_started
        if square.contains?(event.x,event.y)
            duration = ((Time.now - start_time) * 1000).round
            message = Text.new("You took: #{duration}. click to begin!",  x: 20, y:20)
            square.remove
            game_started = false
        end
    else
        message.remove

        square = Square.new(
            x: rand(get(:width) - 25), y: rand(get(:height) - 25),
            size: 25,
            color: 'blue'
        )
        game_started = true
        start_time = Time.now
    end
end 

show