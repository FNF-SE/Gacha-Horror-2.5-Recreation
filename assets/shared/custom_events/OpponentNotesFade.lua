function onEvent(name, value1, value2)
    time = tonumber(value1)
    alpha = tonumber(value2)
    if name == 'OpponentNotesFade' then
        if not middlescroll then
            if getProperty('characterPlayingAsDad') == false then
                for i = 0, 3 do
                    noteTweenAlpha(i + 16, i, alpha, time, 'QuadOut')
                end
            else
                for i = 4, 7 do
                    noteTweenAlpha(i + 16, i, alpha, time, 'QuadOut')
                end
            end
        end
    end
end
