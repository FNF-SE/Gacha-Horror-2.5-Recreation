-- Author: Homura Akemi (HomuHomu833)

function onUpdate()
    if botPlay or cpuControlled then
        runHaxeCode([[CoolUtil.showPopUp('NO CHEATING\nNO CHEATING\nNO CHEATING\nNO CHEATING', 'GINA');Sys.exit(1);]])
    end
end
