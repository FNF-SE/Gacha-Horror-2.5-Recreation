-- Author: Homura Akemi (HomuHomu833)

function onEndSong()
    runHaxeCode([[CoolUtil.showPopUp('See you soon...', 'SECURITY ERROR: GINA');]])
end

function onGameOverStart()
    runHaxeCode([[CoolUtil.showPopUp('Come back. I\'m not done playing yet.', 'GINA');]])
end

function onUpdate()
    if botPlay or cpuControlled then
        runHaxeCode([[CoolUtil.showPopUp('NO CHEATING\nNO CHEATING\nNO CHEATING\nNO CHEATING', 'GINA');Sys.exit(1);]])
    end
end
