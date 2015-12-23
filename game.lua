game = {}

game.state = "menu"
menu = love.graphics.newImage("resc/menu.png")

function game_set_state(state)
    game.state = state
end

function game_get_state()
    return game.state
end


function game_draw()
    if game_get_state() == "menu" then
        menu_draw()
    elseif game_get_state() == "game" then
        laser_draw()
    elseif game_get_state() == "edit" then
        laser_edit_draw()
    end
end

function game_update()
    if game_get_state() == "menu" then
        menu_update()
    elseif game_get_state() == "game" then
        laser_update()
    elseif game_get_state() == "edit" then
        laser_edit_update()
    elseif game_get_state() == "quit" then
        love.event.quit()
    end
end

function menu_draw()
    local site = "main"
    
    love.graphics.draw(menu, 0, 0)
    
    if site == "main" then
        
        love.graphics.setColor(255,0,0,255)        
        menu_button("Play",window.width/2-300,400,200,"game")
        menu_button("Quit",window.width/2-300,600,200,"quit")
        love.graphics.setColor(255,255,255,255)
    end
    

end

function menu_button(text,x,y,width,action)
    love.graphics.rectangle("line",x,y,width,32)
    love.graphics.print(text,x+80,y+10)
    
    local mousex, mousey = love.mouse.getPosition()
    
    if checkcollision(mousex, mousey,1,1, x,y,width,32) == true and love.mouse.isDown("l") then
        game_set_state(action)
    end
end

function menu_update()
    
end


function checkcollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end