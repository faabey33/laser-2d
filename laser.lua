laser = {}

--laser.clevel.gridSize = 60
laser.gridColor = {255,255,255,70}
laser.snapX = {}
laser.snapY = {}

source = love.graphics.newImage("resc/source.png")
mirror = love.graphics.newImage("resc/mirror.png")
splitter = love.graphics.newImage("resc/split.png")
target = love.graphics.newImage("resc/target.png")
wall = love.graphics.newImage("resc/wall.png")
check = love.graphics.newImage("resc/check.png")

laser.level = {}
laser.level[2] = {{grid,50,0,0},{wall,3,2,0},{wall,3,3,0},{wall,3,4,0},{wall,3,5,0},{source,12,8,3},{target,19,1,3},{check,4,4,0},{check,2,3,0},{check,12,2,0},{check,11,5,0},{mirror,10,7,0},{mirror,11,7,0},{mirror,12,7,0},{mirror,13,7,0},{mirror,14,7,0},{mirror,15,7,0},{mirror,800,7,0}}
laser.level[1] = {{grid,80,0,0},{wall,4,5,0},{wall,4,5,0},{wall,4,5,0},{mirror,4,5,0},{mirror,5,5,0},{mirror,1,3,1},{mirror,1,2,2},{mirror,6,2,3},{source,6,6,0},{target,9,4,0},{check,10,4,0}}
--laser.level[2] = {{grid,40,0,0},{wall,4,6,0},{wall,4,5,0},{wall,4,7,0},{mirror,4,5,0},{mirror,5,5,0},{mirror,1,3,1},{mirror,1,2,2},{mirror,6,2,3},{source,6,6,0},{target,9,4,0},{check,10,4,0},{check,10,7,0}}
laser.level[3] = {{grid,40,0,0},{wall,4,6,0},{wall,4,5,0},{wall,4,7,0},{mirror,4,5,0},{mirror,5,5,0},{mirror,1,3,1},{mirror,1,2,2},{mirror,6,2,3},{source,6,6,0},{target,9,4,0},{check,10,4,0}}
laser.level[4] = {{grid,40,0,0},{wall,4,6,0},{wall,4,5,0},{wall,4,7,0},{mirror,4,5,0},{mirror,5,5,0},{mirror,1,3,1},{mirror,1,2,2},{mirror,6,2,3},{source,6,6,0},{target,9,4,0},{check,10,4,0}}
laser.level[5] = {{grid,40,0,0},{wall,4,6,0},{wall,4,5,0},{wall,4,7,0},{mirror,4,5,0},{mirror,5,5,0},{mirror,1,3,1},{mirror,1,2,2},{mirror,6,2,3},{source,6,6,0},{target,9,4,0},{check,10,4,0}}
laser.level[6] = {{grid,40,0,0},{wall,4,6,0},{wall,4,5,0},{wall,4,7,0},{mirror,4,5,0},{mirror,5,5,0},{mirror,1,3,1},{mirror,1,2,2},{mirror,6,2,3},{source,6,6,0},{target,9,4,0},{check,10,4,0}}
laser.level[7] = {{grid,40,0,0},{wall,4,6,0},{wall,4,5,0},{wall,4,7,0},{mirror,4,5,0},{mirror,5,5,0},{mirror,1,3,1},{mirror,1,2,2},{mirror,6,2,3},{source,6,6,0},{target,9,4,0},{check,10,4,0}}
laser.level[8] = {{grid,40,0,0},{wall,4,6,0},{wall,4,5,0},{wall,4,7,0},{mirror,4,5,0},{mirror,5,5,0},{mirror,1,3,1},{mirror,1,2,2},{mirror,6,2,3},{source,6,6,0},{target,9,4,0},{check,10,4,0}}
laser.level[9] = {{grid,40,0,0},{wall,4,6,0},{wall,4,5,0},{wall,4,7,0},{mirror,4,5,0},{mirror,5,5,0},{mirror,1,3,1},{mirror,1,2,2},{mirror,6,2,3},{source,6,6,0},{target,9,4,0},{check,10,4,0}}
laser.level[10] = {{grid,40,0,0},{wall,4,6,0},{wall,4,5,0},{wall,4,7,0},{mirror,4,5,0},{mirror,5,5,0},{mirror,1,3,1},{mirror,1,2,2},{mirror,6,2,3},{source,6,6,0},{target,9,4,0},{check,10,4,0}}

laser.cl = 1   --current level

--test = love.filesystem.read('lvl/01.txt')

laser.beam = {}
laser.beam.color = {255,0,0,255}
laser.beam.x = {}
laser.beam.y = {}
laser.beam.length = 100

laser.clevel = {}
laser.clevel.x = {}
laser.clevel.y = {}
laser.clevel.o = {}
laser.clevel.r = {}
laser.clevel.targets = 0
laser.clevel.sourceIndex = 0
laser.clevel.checks = {}
laser.clevel.c = {}
laser.clevel.gridSize = 0



mactive = false
totalchecks = 0

function laser_init()
    level_parse()
end

function laser_update()
    laser_mouse()
     
end

function love.keypressed(key)
    if key == "r" and selectedObject ~= nil then
       if laser.clevel.r[selectedObject] == 3 then
           laser.clevel.r[selectedObject] = 0
       else 
           laser.clevel.r[selectedObject] = laser.clevel.r[selectedObject] + 1
       end

    elseif key == "escape" then
        love.graphics.setColor(255,255,255,255)
        game_set_state("menu")
    end
end

function laser_draw()
    grid_draw()
    objects_draw()
    beam_draw()
    
    --love.graphics.print(laser.clevel.x[1].."  "..laser.clevel.x[1], 0,0)
    
    love.graphics.print("Level: "..laser.cl, 10,10)
    
    --love.graphics.print(x.."  "..y, 0,10)
    
    --love.graphics.print(usedCP.."  von "..get_total_checks(), 100,10)
    

end




function laser_mouse()
    x, y = xy_snap()
    for i = 1, #laser.level[laser.cl]-1 do
        if x/laser.clevel.gridSize == laser.clevel.x[i] and y/laser.clevel.gridSize == laser.clevel.y[i] and love.mouse.isDown("l") and mactive == false and laser.clevel.o[i] ~= source and laser.clevel.o[i] ~= check and laser.clevel.o[i] ~= target and laser.clevel.o[i] ~= wall then
            selectedObject = i
            mactive = true
        end
    end
    
    if mactive == true then
        laser.clevel.x[selectedObject] = x/laser.clevel.gridSize
        laser.clevel.y[selectedObject] = y/laser.clevel.gridSize
        if love.mouse.isDown("r") then
            mactive = false
        end
    end
    
end




function level_parse()
    local length = #laser.level[laser.cl]
    
    for i = 1, length do
        laser.clevel.x[i] = laser.level[laser.cl][i][2]
        laser.clevel.y[i] = laser.level[laser.cl][i][3]
        laser.clevel.o[i] = laser.level[laser.cl][i][1]
        laser.clevel.r[i] = laser.level[laser.cl][i][4]
        
        if (laser.clevel.o[i] == source) then
            laser.clevel.sourceIndex = i
        end
        
        if laser.clevel.o[i] == grid then
            laser.clevel.gridSize = laser.clevel.x[i]
        end
    end
    
end


function objects_draw()
    
    local length = #laser.clevel.o
    
    
    
    for i = 1, length do
            
           love.graphics.setColor(255,255,255,255)
        
           local object = laser.clevel.o[i]
          
           if object ~= grid then
                
           
           
           local x = laser.clevel.x[i]
           local y = laser.clevel.y[i]
           local r = laser.clevel.r[i]*(math.pi/2)
    
           local scale = laser.clevel.gridSize/(object):getWidth()
           local offsetX, offsetY = 0, 0
           
              if laser.clevel.r[i] == 1 then
                   offsetX = 1
              elseif laser.clevel.r[i] == 2 then
                    offsetX = 1
                   offsetY = 1
               elseif laser.clevel.r[i] == 3 then
                   offsetY = 1
              elseif laser.clevel.r[i] == 0 then

              end
                                 
               if laser.clevel.c[i] == "green" then
                 love.graphics.setColor(100,255,100,255)
             end
           
            laser.clevel.c[i] = "none"
           
            love.graphics.draw(object, x_grid(x+offsetX), y_grid(y+offsetY), r, scale, scale)
            
           end
    end
    
end


function beam_draw()

    love.graphics.setColor(laser.beam.color)

    currentX, currentY, dir = beam_source_dir()
    local index = 1
    local done = false
    
    laser.beam.x[index] = currentX
    laser.beam.y[index] = currentY
    
    while done == false do
    
        index = index + 1
        
        beam_offset()
        
        beam_check()
        
        laser.beam.x[index] = currentX
        laser.beam.y[index] = currentY
       
        if index == laser.beam.length then
            done = true
        end
        
    end
    
    for i = 1, #laser.beam.x-1 do
        love.graphics.line(laser.beam.x[i]+laser.clevel.gridSize/2, laser.beam.y[i]+laser.clevel.gridSize/2, laser.beam.x[i+1]+laser.clevel.gridSize/2, laser.beam.y[i+1]+laser.clevel.gridSize/2)
    end
    
end

function beam_check()
    
    local length = #laser.clevel.o
    
   
    
    usedchecks = 0
    
    for i = 1, length do
       if x_grid(laser.clevel.x[i]) == currentX and y_grid(laser.clevel.y[i]) == currentY then
            --beam_offset()
            
             
             
            if laser.clevel.o[i] == mirror then
                if dir == "up" then
                    if laser.clevel.r[i] == 3 then
                        dir = "left"
                    elseif laser.clevel.r[i] == 2 then
                        dir = "right"
                    else
                        dir = "none"
                    end
                elseif dir == "down" then
                    if laser.clevel.r[i] == 0 then
                        dir = "left"
                    elseif laser.clevel.r[i] == 1 then
                        dir = "right"
                    else
                        dir = "none"
                    end
                 
                elseif dir == "left" then
                    if laser.clevel.r[i] == 1 then
                        dir = "up"
                    elseif laser.clevel.r[i] == 2 then
                        dir = "down"
                    else
                        dir = "none"
                    end
                elseif dir == "right" then
                    if laser.clevel.r[i] == 3 then
                        dir = "down"
                    elseif laser.clevel.r[i] == 0 then
                        dir = "up"
                    else
                        dir = "none"
                    end
                end
            
            
            elseif laser.clevel.o[i] == target then
                if dir == "down" and laser.clevel.r[i] == 0 and allChecks == true then
                    laser_level_win()
                elseif dir == "up" and laser.clevel.r[i] == 2 and allChecks == true then
                    laser_level_win()
                elseif dir == "left" and laser.clevel.r[i] == 1 and allChecks == true then
                    laser_level_win()
                elseif dir == "right" and laser.clevel.r[i] == 3 and allChecks == true then
                   laser_level_win()
                end
                dir = "none"
                
            elseif laser.clevel.o[i] == wall then
                dir = "none"
            elseif laser.clevel.o[i] == check then
                usedchecks = usedchecks + 1
                laser.clevel.c[i] = "green"
                
               
               
                --laser.clevel.checked = laser.clevel.checked + 1                     
            end
       end
    end
    
    usedCP = usedchecks
    
    if get_total_checks() == usedchecks then
        allChecks = true
        set = false
    end     
end

function get_total_checks()
    local totalchecks = 0
    for i = 1, #laser.clevel.o do
        if laser.clevel.o[i] == check then
            totalchecks = totalchecks + 1
        end
    end
    return totalchecks
end

   


function beam_offset()
     if dir == "up" then currentY = currentY - 1 * laser.clevel.gridSize end
     if dir == "down" then currentY = currentY + 1 * laser.clevel.gridSize end
     if dir == "left" then currentX = currentX - 1 * laser.clevel.gridSize end
     if dir == "right" then currentX = currentX + 1 * laser.clevel.gridSize end
     if dir == "none" then end
end

function beam_source_dir()

    local dir = ""
    if laser.clevel.r[laser.clevel.sourceIndex] == 0 then
            dir = "up"
        elseif laser.clevel.r[laser.clevel.sourceIndex] == 1 then
            dir = "right"
        elseif laser.clevel.r[laser.clevel.sourceIndex] == 2 then
            dir = "down"
        elseif laser.clevel.r[laser.clevel.sourceIndex] == 3 then
            dir = "left"
        end
        
    return x_grid(laser.clevel.x[laser.clevel.sourceIndex]), y_grid(laser.clevel.y[laser.clevel.sourceIndex]), dir
end

function x_grid(x)
    return x*laser.clevel.gridSize
end

function y_grid(y)
    return y*laser.clevel.gridSize
end


function grid_draw()
    love.graphics.setColor(laser.gridColor)
    local index = 0
    for i = 0, window.width, laser.clevel.gridSize do
        laser.snapY[index] = i
        love.graphics.line(i, 0, i, window.height)
        index = index + 1
    end
    local index = 0
    for a = 0, window.height, laser.clevel.gridSize do
        laser.snapX[index] = a
        love.graphics.line(0, a, window.width, a)
        index = index + 1
    end
    love.graphics.setColor(255,255,255,255)
end


function xy_snap()
    local mousex, mousey = love.mouse.getPosition()
    
    local x = math.floor(mousex/laser.clevel.gridSize)*laser.clevel.gridSize
    local y = math.floor(mousey/laser.clevel.gridSize)*laser.clevel.gridSize

    return x, y
end

function laser_level_win()
    love.graphics.print("Level Completed!", 1280-190,720-100)
    love.graphics.rectangle("line",1280-190,720-50,100,32)
    love.graphics.print("Next Level",1280-170,720-40)
    
    local mousex, mousey = love.mouse.getPosition()
    
    if checkcollision(mousex, mousey,1,1, 1280-190,720-50,100,32) == true and love.mouse.isDown("l") then
        nextLevel()
    end
end

function nextLevel()
    if set == false then
        laser.cl = laser.cl + 1
    end
    set = true
    level_parse()
end