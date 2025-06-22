function onEvent(name, value1, value2)
    if name == 'RunLua' then
        if value1 ~= '' then loadstring(value1)() end
    end
end