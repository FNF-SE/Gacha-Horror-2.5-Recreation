-- Author: Homura Akemi (HomuHomu833) - fixed a bit by mr_chaoss
local width = 0
local height = 0
local minSize = 100

function onCreate()
    if buildTarget == 'android' or buildTarget == 'ios' then
        width = math.floor(math.abs(getPropertyFromClass('flixel.FlxG', 'stage.stageWidth')))
        height = math.floor(math.abs(getPropertyFromClass('flixel.FlxG', 'stage.stageHeight')))
    else
        width = math.floor(math.abs(getPropertyFromClass('openfl.system.Capabilities', 'screenResolutionX')))
        height = math.floor(math.abs(getPropertyFromClass('openfl.system.Capabilities', 'screenResolutionY')))
    end
end

function onEvent(name, value1, value2)
    if name == "WindowMove" then
        setPropertyFromClass('openfl.Lib', 'application.window.fullscreen', false)

        if buildTarget == 'android' or buildTarget == 'ios' then
            newWidth = math.max(minSize, math.floor(width / math.max(1, getRandomInt(1, 3))))
            newHeight = math.max(minSize, math.floor(height / math.max(1, getRandomInt(1, 3))))

            setPropertyFromClass('openfl.Lib', 'application.window.width', newWidth)
            setPropertyFromClass('openfl.Lib', 'application.window.height', newHeight)
        else
            newX = getRandomInt(0, math.max(1, math.max(0, width - math.floor(width / 2.25))))
            newY = getRandomInt(0, math.max(1, math.max(0, height - math.floor(height / 2.25))))

            setPropertyFromClass('openfl.Lib', 'application.window.x', newX)
            setPropertyFromClass('openfl.Lib', 'application.window.y', newY)
            setPropertyFromClass('openfl.Lib', 'application.window.width', math.floor(width / 2.25))
            setPropertyFromClass('openfl.Lib', 'application.window.height', math.floor(height / 2.25))
        end
    end
end
