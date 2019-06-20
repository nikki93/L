-- Main `L` table behavior -- look through Love modules, cache results

local L = setmetatable({}, {
    __index = function(t, k)
        local r
        if love.audio and love.audio[k]then
            r = love.audio[k]
        elseif love.data and love.data[k]then
            r = love.data[k]
        elseif love.event and love.event[k]then
            r = love.event[k]
        elseif love.filesystem and love.filesystem[k]then
            r = love.filesystem[k]
        elseif love.font and love.font[k]then
            r = love.font[k]
        elseif love.graphics and love.graphics[k]then
            r = love.graphics[k]
        elseif love.image and love.image[k]then
            r = love.image[k]
        elseif love.joystick and love.joystick[k]then
            r = love.joystick[k]
        elseif love.keyboard and love.keyboard[k]then
            r = love.keyboard[k]
        elseif love.math and love.math[k]then
            r = love.math[k]
        elseif love.mouse and love.mouse[k]then
            r = love.mouse[k]
        elseif love.physics and love.physics[k]then
            r = love.physics[k]
        elseif love.sound and love.sound[k]then
            r = love.sound[k]
        elseif love.system and love.system[k]then
            r = love.system[k]
        elseif love.thread and love.thread[k]then
            r = love.thread[k]
        elseif love.timer and love.timer[k]then
            r = love.timer[k]
        elseif love.touch and love.touch[k]then
            r = love.touch[k]
        elseif love.video and love.video[k]then
            r = love.video[k]
        elseif love.window and love.window[k]then
            r = love.window[k]
        end
        if r == nil then
            error("`L." .. k .. "` isn't defined")
        end
        t[k] = r
        return r
    end
})


-- Disambiguate clashes

L.compress = love.data and love.data.compress

L.decompress = love.data and love.data.decompress

L.getDPIScale = love.graphics and love.graphics.getDPIScale

L.push = love.graphics and love.graphics.push
L.eventPush = love.event and love.event.push

L.clear = love.graphics and love.graphics.clear
love.eventClear = love.event and love.event.clear

L.setPosition = function()
    error('Please use `L.audioSetPosition`, `L.mouseSetPosition` or `L.windowSetPosition`')
end
L.audioSetPosition = love.audio and love.audio.setPosition
L.mouseSetPosition = love.mouse and love.mouse.setPosition
L.windowSetPosition = love.window and love.window.setPosition

L.isDown = function()
    error('Please use `L.keyboardIsDown` or `L.mouseIsDown`')
end
L.keyboardIsDown = love.keyboard and love.keyboard.isDown
L.mouseIsDown = love.mouse and love.mouse.isDown

L.isVisible = function()
    error('Please use `L.mouseIsVisible` or `L.windowIsVisible`')
end
L.windowIsVisible = love.window and love.window.isVisible
L.mouseIsVisible = love.mouse and love.mouse.isVisible

L.getPosition = function()
    error('Please use `L.audioGetPosition`, `L.mouseGetPosition`, `L.touchGetPosition` or `L.windowGetPosition`')
end
L.audioGetPosition = love.audio and love.audio.getPosition
L.mouseGetPosition = love.mouse and love.mouse.getPosition
L.touchGetPosition = love.touch and love.touch.getPosition
L.windowGetPosition = love.window and love.window.getPosition


-- Additional functions

if love.graphics then
    -- `L.stacked([arg], func)` calls `func` between `L.push([arg])` and `L.pop()`, always calling `L.pop()` even
    -- if an error occurs in `func`
    function L.pushed(argOrFunc, funcOrNil)
        L.push(funcOrNil and argOrFunc)
        local succeeded, err = pcall(funcOrNil or argOrFunc)
        L.pop()
        if not succeeded then
            error(err, 0)
        end
    end
end


return L
