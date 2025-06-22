squishDuration = 0.036 -- 0.048 is default
defy = 0.7
note0 = true
note1 = true
note2 = true
note3 = true
note4 = true
note5 = true
note6 = true
note7 = true
function goodNoteHit(id, direction, noteType, isSustainNote)
    cancelTimer('resetNoteP1' .. direction+4)
    cancelTimer('resetNoteP2' .. direction+4)
    cancelTimer('resetNoteP3' .. direction+4)
    cancelTimer('resetNoteP4' .. direction+4)
    cancelTimer('resetNoteP5' .. direction+4)
    setPropertyFromGroup('strumLineNotes', direction+4, 'scale.x', defy*1.1)
    setPropertyFromGroup('strumLineNotes', direction+4, 'scale.y', defy*0.9)
    runTimer('resetNoteP1' .. direction+4, squishDuration)
end
function opponentNoteHit(id, direction, noteType, isSustainNote)
    cancelTimer('resetNoteP1' .. direction)
    cancelTimer('resetNoteP2' .. direction)
    cancelTimer('resetNoteP3' .. direction)
    cancelTimer('resetNoteP4' .. direction)
    cancelTimer('resetNoteP5' .. direction)
    setPropertyFromGroup('strumLineNotes', direction, 'scale.x', defy*1.1)
    setPropertyFromGroup('strumLineNotes', direction, 'scale.y', defy*0.9)
    runTimer('resetNoteP1' .. direction, squishDuration)
end

function onTimerCompleted(tag)
    if note4 then
        if tag == 'resetNoteP14' then
            setPropertyFromGroup('strumLineNotes', 4, 'scale.x', defy*1.2)
            setPropertyFromGroup('strumLineNotes', 4, 'scale.y', defy*0.8)
            runTimer('resetNoteP24', squishDuration)
        end
        if tag == 'resetNoteP24' then
            setPropertyFromGroup('strumLineNotes', 4, 'scale.x', defy*1.05)
            setPropertyFromGroup('strumLineNotes', 4, 'scale.y', defy*0.95)
            runTimer('resetNoteP34', squishDuration)
        end
        if tag == 'resetNoteP34' then
            setPropertyFromGroup('strumLineNotes', 4, 'scale.x', defy)
            setPropertyFromGroup('strumLineNotes', 4, 'scale.y', defy)
            runTimer('resetNoteP44', squishDuration)
        end
        if tag == 'resetNoteP44' then
            setPropertyFromGroup('strumLineNotes', 4, 'scale.x', defy*0.95)
            setPropertyFromGroup('strumLineNotes', 4, 'scale.y', defy*1.05)
            runTimer('resetNoteP54', squishDuration)
        end
        if tag == 'resetNoteP54' then
            setPropertyFromGroup('strumLineNotes', 4, 'scale.x', defy)
            setPropertyFromGroup('strumLineNotes', 4, 'scale.y', defy)
        end
    end
    if note5 then
        if tag == 'resetNoteP15' then
            setPropertyFromGroup('strumLineNotes', 5, 'scale.x', defy*1.2)
            setPropertyFromGroup('strumLineNotes', 5, 'scale.y', defy*0.8)
            runTimer('resetNoteP25', squishDuration)
        end
        if tag == 'resetNoteP25' then
            setPropertyFromGroup('strumLineNotes', 5, 'scale.x', defy*1.05)
            setPropertyFromGroup('strumLineNotes', 5, 'scale.y', defy*0.95)
            runTimer('resetNoteP35', squishDuration)
        end
        if tag == 'resetNoteP35' then
            setPropertyFromGroup('strumLineNotes', 5, 'scale.x', defy)
            setPropertyFromGroup('strumLineNotes', 5, 'scale.y', defy)
            runTimer('resetNoteP45', squishDuration)
        end
        if tag == 'resetNoteP45' then
            setPropertyFromGroup('strumLineNotes', 5, 'scale.x', defy*0.95)
            setPropertyFromGroup('strumLineNotes', 5, 'scale.y', defy*1.05)
            runTimer('resetNoteP55', squishDuration)
        end
        if tag == 'resetNoteP55' then
            setPropertyFromGroup('strumLineNotes', 5, 'scale.x', defy)
            setPropertyFromGroup('strumLineNotes', 5, 'scale.y', defy)
        end
    end
    if note6 then
        if tag == 'resetNoteP16' then
            setPropertyFromGroup('strumLineNotes', 6, 'scale.x', defy*1.2)
            setPropertyFromGroup('strumLineNotes', 6, 'scale.y', defy*0.8)
            runTimer('resetNoteP26', squishDuration)
        end
        if tag == 'resetNoteP26' then
            setPropertyFromGroup('strumLineNotes', 6, 'scale.x', defy*1.05)
            setPropertyFromGroup('strumLineNotes', 6, 'scale.y', defy*0.95)
            runTimer('resetNoteP36', squishDuration)
        end
        if tag == 'resetNoteP36' then
            setPropertyFromGroup('strumLineNotes', 6, 'scale.x', defy)
            setPropertyFromGroup('strumLineNotes', 6, 'scale.y', defy)
            runTimer('resetNoteP46', squishDuration)
        end
        if tag == 'resetNoteP46' then
            setPropertyFromGroup('strumLineNotes', 6, 'scale.x', defy*0.95)
            setPropertyFromGroup('strumLineNotes', 6, 'scale.y', defy*1.05)
            runTimer('resetNoteP56', squishDuration)
        end
        if tag == 'resetNoteP56' then
            setPropertyFromGroup('strumLineNotes', 6, 'scale.x', defy)
            setPropertyFromGroup('strumLineNotes', 6, 'scale.y', defy)
        end
    end
    if note7 then
        if tag == 'resetNoteP17' then
            setPropertyFromGroup('strumLineNotes', 7, 'scale.x', defy*1.2)
            setPropertyFromGroup('strumLineNotes', 7, 'scale.y', defy*0.8)
            runTimer('resetNoteP27', squishDuration)
        end
        if tag == 'resetNoteP27' then
            setPropertyFromGroup('strumLineNotes', 7, 'scale.x', defy*1.05)
            setPropertyFromGroup('strumLineNotes', 7, 'scale.y', defy*0.95)
            runTimer('resetNoteP37', squishDuration)
        end
        if tag == 'resetNoteP37' then
            setPropertyFromGroup('strumLineNotes', 7, 'scale.x', defy)
            setPropertyFromGroup('strumLineNotes', 7, 'scale.y', defy)
            runTimer('resetNoteP47', squishDuration)
        end
        if tag == 'resetNoteP47' then
            setPropertyFromGroup('strumLineNotes', 7, 'scale.x', defy*0.95)
            setPropertyFromGroup('strumLineNotes', 7, 'scale.y', defy*1.05)
            runTimer('resetNoteP57', squishDuration)
        end
        if tag == 'resetNoteP57' then
            setPropertyFromGroup('strumLineNotes', 7, 'scale.x', defy)
            setPropertyFromGroup('strumLineNotes', 7, 'scale.y', defy)
        end
    end

    if note0 then
        if tag == 'resetNoteP10' then
            setPropertyFromGroup('strumLineNotes', 0, 'scale.x', defy*1.2)
            setPropertyFromGroup('strumLineNotes', 0, 'scale.y', defy*0.8)
            runTimer('resetNoteP20', squishDuration)
        end
        if tag == 'resetNoteP20' then
            setPropertyFromGroup('strumLineNotes', 0, 'scale.x', defy*1.05)
            setPropertyFromGroup('strumLineNotes', 0, 'scale.y', defy*0.95)
            runTimer('resetNoteP30', squishDuration)
        end
        if tag == 'resetNoteP30' then
            setPropertyFromGroup('strumLineNotes', 0, 'scale.x', defy)
            setPropertyFromGroup('strumLineNotes', 0, 'scale.y', defy)
            runTimer('resetNoteP40', squishDuration)
        end
        if tag == 'resetNoteP40' then
            setPropertyFromGroup('strumLineNotes', 0, 'scale.x', defy*0.95)
            setPropertyFromGroup('strumLineNotes', 0, 'scale.y', defy*1.05)
            runTimer('resetNoteP50', squishDuration)
        end
        if tag == 'resetNoteP50' then
            setPropertyFromGroup('strumLineNotes', 0, 'scale.x', defy)
            setPropertyFromGroup('strumLineNotes', 0, 'scale.y', defy)
        end
    end
    if note1 then
        if tag == 'resetNoteP11' then
            setPropertyFromGroup('strumLineNotes', 1, 'scale.x', defy*1.2)
            setPropertyFromGroup('strumLineNotes', 1, 'scale.y', defy*0.8)
            runTimer('resetNoteP21', squishDuration)
        end
        if tag == 'resetNoteP21' then
            setPropertyFromGroup('strumLineNotes', 1, 'scale.x', defy*1.05)
            setPropertyFromGroup('strumLineNotes', 1, 'scale.y', defy*0.95)
            runTimer('resetNoteP31', squishDuration)
        end
        if tag == 'resetNoteP31' then
            setPropertyFromGroup('strumLineNotes', 1, 'scale.x', defy)
            setPropertyFromGroup('strumLineNotes', 1, 'scale.y', defy)
            runTimer('resetNoteP41', squishDuration)
        end
        if tag == 'resetNoteP41' then
            setPropertyFromGroup('strumLineNotes', 1, 'scale.x', defy*0.95)
            setPropertyFromGroup('strumLineNotes', 1, 'scale.y', defy*1.05)
            runTimer('resetNoteP51', squishDuration)
        end
        if tag == 'resetNoteP51' then
            setPropertyFromGroup('strumLineNotes', 1, 'scale.x', defy)
            setPropertyFromGroup('strumLineNotes', 1, 'scale.y', defy)
        end
    end
    if note2 then
        if tag == 'resetNoteP12' then
            setPropertyFromGroup('strumLineNotes', 2, 'scale.x', defy*1.2)
            setPropertyFromGroup('strumLineNotes', 2, 'scale.y', defy*0.8)
            runTimer('resetNoteP22', squishDuration)
        end
        if tag == 'resetNoteP22' then
            setPropertyFromGroup('strumLineNotes', 2, 'scale.x', defy*1.05)
            setPropertyFromGroup('strumLineNotes', 2, 'scale.y', defy*0.95)
            runTimer('resetNoteP32', squishDuration)
        end
        if tag == 'resetNoteP32' then
            setPropertyFromGroup('strumLineNotes', 2, 'scale.x', defy)
            setPropertyFromGroup('strumLineNotes', 2, 'scale.y', defy)
            runTimer('resetNoteP42', squishDuration)
        end
        if tag == 'resetNoteP42' then
            setPropertyFromGroup('strumLineNotes', 2, 'scale.x', defy*0.95)
            setPropertyFromGroup('strumLineNotes', 2, 'scale.y', defy*1.05)
            runTimer('resetNoteP52', squishDuration)
        end
        if tag == 'resetNoteP52' then
            setPropertyFromGroup('strumLineNotes', 2, 'scale.x', defy)
            setPropertyFromGroup('strumLineNotes', 2, 'scale.y', defy)
        end
    end
    if note3 then
        if tag == 'resetNoteP13' then
            setPropertyFromGroup('strumLineNotes', 3, 'scale.x', defy*1.2)
            setPropertyFromGroup('strumLineNotes', 3, 'scale.y', defy*0.8)
            runTimer('resetNoteP23', squishDuration)
        end
        if tag == 'resetNoteP23' then
            setPropertyFromGroup('strumLineNotes', 3, 'scale.x', defy*1.05)
            setPropertyFromGroup('strumLineNotes', 3, 'scale.y', defy*0.95)
            runTimer('resetNoteP33', squishDuration)
        end
        if tag == 'resetNoteP33' then
            setPropertyFromGroup('strumLineNotes', 3, 'scale.x', defy)
            setPropertyFromGroup('strumLineNotes', 3, 'scale.y', defy)
            runTimer('resetNoteP43', squishDuration)
        end
        if tag == 'resetNoteP43' then
            setPropertyFromGroup('strumLineNotes', 3, 'scale.x', defy*0.95)
            setPropertyFromGroup('strumLineNotes', 3, 'scale.y', defy*1.05)
            runTimer('resetNoteP53', squishDuration)
        end
        if tag == 'resetNoteP53' then
            setPropertyFromGroup('strumLineNotes', 3, 'scale.x', defy)
            setPropertyFromGroup('strumLineNotes', 3, 'scale.y', defy)
        end
    end
end