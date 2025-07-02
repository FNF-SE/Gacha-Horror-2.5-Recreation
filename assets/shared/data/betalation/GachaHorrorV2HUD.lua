-- MODIFICATION FOR BETALATION

local moepart = false

function onCreate()
    setProperty('iconP1.flipX', true)
end

function onUpdatePost()
    setProperty('iconP1.x', 15)
    setProperty('iconP2.x', 1100)
end

function onBeatHit()
    if (curBeat % 2 == 0) then
        if getProperty('health') >= 0.375 then
            setProperty('iconP1.angle', 20)
            doTweenAngle('bop', 'iconP1', 0, 0.2, 'cubicOut')
        end
    end
    if (curBeat % 2 == 0) and moepart then
        if getProperty('health') <= 1.625 then
            if moepart then
                setProperty('iconP2.angle', -20)
            else
                setProperty('iconP2.angle', 20)
            end
            doTweenAngle('bip', 'iconP2', 0, 0.2, 'cubicOut')
        end
    end
end

function onStepHit() -- oh my fucking god I hate betalation - Homura Akemi (HomuHomu833)
    if curStep == 256 or curStep == 276 or curStep == 328 or curStep == 552 or curStep == 720 or curStep == 736 or
        curStep == 742 or curStep == 748 or curStep == 758 or curStep == 762 or curStep == 766 or curStep == 800 or
        curStep == 802 or curStep == 803 or curStep == 805 or curStep == 807 or curStep == 809 or curStep == 811 or
        curStep == 813 or curStep == 815 then
        runHaxeCode([[PlayState.instance.changeNoteSkin(false, "noteSkins/MoeArrows");]])
        moepart = true
        setProperty('iconP2.flipX', true)
    end
    if curStep == 272 or curStep == 308 or curStep == 472 or curStep == 656 or curStep == 728 or curStep == 740 or
        curStep == 744 or curStep == 756 or curStep == 760 or curStep == 764 or curStep == 772 or curStep == 801 or
        curStep == 803 or curStep == 804 or curStep == 806 or curStep == 808 or curStep == 810 or curStep == 812 or
        curStep == 814 then
        runHaxeCode([[PlayState.instance.changeNoteSkin(false, "noteSkins/M-O-Arrows");]])
        moepart = false
        setProperty('iconP2.flipX', false)
    end
end
