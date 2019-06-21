-- Main lookup behavior

local L = setmetatable({}, {
    __index = function(t, k)
        local r
        if love.graphics and love.graphics[k] then
            r = love.graphics[k]
        elseif love[k] then
            r = love[k]
        elseif castle and castle[k] then
            r = castle[k]
        end
        if r == nil then
            error("`L." .. k .. "` isn't defined")
        end
        t[k] = r
        return r
    end
})


-- Extras

if love.graphics then
    -- `L.stacked([arg], func)` calls `func` between `love.graphics.push([arg])` and `love.graphics.pop()`,
    -- always calling `love.graphics.pop()` even if an error occurs in `func`
    function L.stacked(argOrFunc, funcOrNil)
        love.graphics.push(funcOrNil and argOrFunc)
        local succeeded, err = pcall(funcOrNil or argOrFunc)
        love.graphics.pop()
        if not succeeded then
            error(err, 0)
        end
    end
end


return L
