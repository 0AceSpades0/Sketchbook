function onEvent(name, value1, value2)
    if name == 'RunHscript' then
        if value1 ~= '' then runHaxeCode(value1) end
    end
end