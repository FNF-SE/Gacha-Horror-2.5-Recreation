local icos = {'', '', ''}
local testr = {'boyfriend', 'dad', 'gf'}
local vOffset = 0
local regHpBar = true -- reg hp bar

function onCreatePost()
    icos[1] = getProperty('boyfriend.healthIcon')
    icos[2] = getProperty('dad.healthIcon')
    icos[3] = getProperty('gf.healthIcon')

    for i = 1, #icos do -- null icon check (only really for the gf icon, god help you if there's others)
        if icos[i] == testr[i] .. '.healthIcon' then
            table.remove(icos, i)
        end
    end

    setProperty('iconP1.visible', false)
    setProperty('iconP2.visible', false)

    for i = 1, #icos do
        if i == 3 and icos[3] == icos[2] then
        else
            makeLuaSprite('iconP' .. i .. 'F', 'icons/icon-' .. icos[i], 0, 100)
        end

        setObjectCamera('iconP' .. i .. 'F', 'hud')
        if stringEndsWith(icos[i], '-pixel') then
            setProperty('iconP' .. i .. 'F.antialiasing', false)
        end
        if i ~= 3 then
            setObjectOrder('iconP' .. i .. 'F', getObjectOrder('healthBar') + i)
        else
            setObjectOrder('iconP' .. i .. 'F', getObjectOrder('iconP' .. (i - 1) .. 'F') - 1)
        end
        if i == 1 or i == 3 then
            setProperty('iconP' .. i .. 'F.flipX', true)
        end

        -- stole this from ralt
        setProperty("iconP" .. i .. "F._frame.frame.x", 0)
        setProperty("iconP" .. i .. "F._frame.frame.y", 0)
        setProperty("iconP" .. i .. "F._frame.frame.width", 150)
        setProperty("iconP" .. i .. "F._frame.frame.height", 150)

        addLuaSprite('iconP' .. i .. 'F')

    end

    setProperty('iconP3F.visible', false)
    setProperty("iconP1F.flipX", false)
    setProperty("iconP2F.flipX", true)
end

local rayman = { -- bf and gf
{
    x = 150,
    y = 150
},
{
    x = 75,
    y = 150
},
{
    x = 75,
    y = 150
},
{
    x = 0,
    y = 150
}
}

local origins = { -- dad
{
    x = 320,
    y = 150
}, -- left
{
    x = 215,
    y = 150
}, -- down
{
    x = 215,
    y = 150
}, -- up
{
    x = 120,
    y = 150
} -- right
}

local directionScales = {
{
    x = 1.4,
    y = 1
},
{
    x = 1.4,
    y = 0.5
},
{
    x = 0.8,
    y = 1.4
},
{
    x = 1.4,
    y = 1
}
}

function onCountdownTick(c)
    if c % 2 == 0 then
        for i = 1, #icos do
            if i ~= 2 then
                setProperty('iconP' .. i .. 'F.origin.x', rayman[2].x)
                setProperty('iconP' .. i .. 'F.origin.y', rayman[2].y)
            else
                setProperty('iconP' .. i .. 'F.origin.x', origins[2].x)
                setProperty('iconP' .. i .. 'F.origin.y', origins[2].y)
            end
            setProperty('iconP' .. i .. 'F.scale.x', 1.2)
            setProperty('iconP' .. i .. 'F.scale.y', 0.7)
        end
    end
end

function onUpdate(elapsed)
    for i = 1, #icos do
        setProperty('iconP' .. i .. 'F.scale.x',
            math.lerp(1, getProperty('iconP' .. i .. 'F.scale.x'), fakeBoundTo(1 - (elapsed * 9), 0, 1)))
        setProperty('iconP' .. i .. 'F.scale.y',
            math.lerp(1, getProperty('iconP' .. i .. 'F.scale.y'), fakeBoundTo(1 - (elapsed * 9), 0, 1)))
    end

    if getProperty('healthBar.percent') > 80 then
        adjustIcon('iconP2F', false)
    else
        adjustIcon('iconP2F', true)
    end

    if getProperty('healthBar.percent') < 20 then
        adjustIcon('iconP1F', false)
        adjustIcon('iconP3F', false)
    else
        adjustIcon('iconP1F', true)
        adjustIcon('iconP3F', true)
    end
end

function onUpdatePost(elapsed)
    setProperty('iconP2F.x', 940)
    setProperty('iconP1F.x', 40)
    if not downscroll then
        setProperty('iconP2F.y', 470)
        setProperty('iconP1F.y', 470)
    else
        setProperty('iconP2F.y', 80)
        setProperty('iconP1F.y', 80)
    end

    if icos[3] ~= nil then
        setProperty('iconP3F.x', (screenWidth / 2.281) - getProperty('iconP3F.width') / 2)
        setProperty('iconP3F.y', (getProperty('healthBar.y') - (not regHpBar and -250 or 140)) - vOffset)
    end

end

function onBeatHit()
    if not singn and getProperty('dad.holdTimer') <= 0 then
        setProperty('iconP1F.origin.x', rayman[2].x)
        setProperty('iconP1F.origin.y', rayman[2].y)
        setProperty('iconP1F.scale.x', 1.2)
        setProperty('iconP1F.scale.y', 0.7)
    end

    if not singnOp and getProperty('boyfriend.holdTimer') <= 0 then
        setProperty('iconP2F.origin.x', origins[2].x)
        setProperty('iconP2F.origin.y', origins[2].y)
        setProperty('iconP2F.scale.x', 1.2)
        setProperty('iconP2F.scale.y', 0.7)
    end

    if icos[3] ~= nil then
        if not singnG and getProperty('gf.holdTimer') <= 0 then
            if curBeat % 2 == 0 then
                setProperty('iconP3F.origin.x', rayman[2].x + 150)
                setProperty('iconP3F.origin.y', rayman[2].y)
                setProperty('iconP3F.scale.x', 1.2)
                setProperty('iconP3F.scale.y', 0.7)
            else
                setProperty('iconP3F.origin.x', rayman[2].x - 150)
                setProperty('iconP3F.origin.y', rayman[2].y)
                setProperty('iconP3F.scale.x', 1.2)
                setProperty('iconP3F.scale.y', 0.7)
            end
        end
    end
end

function onStepHit() -- only checks every step if there is a new character icon
    check = {getProperty('boyfriend.healthIcon'), getProperty('dad.healthIcon'), getProperty('gf.healthIcon')}
    for i = 1, #icos do
        if check[i] ~= icos[i] then
            if check[i] == testr[i] .. '.healthIcon' then
                table.remove(icos, i)
                return
            else
                icos[i] = check[i]
            end

            makeLuaSprite('iconP' .. i .. 'F', 'icons/icon-' .. icos[i], 100, 100)
            setObjectCamera('iconP' .. i .. 'F', 'hud')

            setObjectOrder('iconP' .. i .. 'F', getObjectOrder('healthBar') + i)
            if i == 1 or i == 3 then
                setProperty('iconP' .. i .. 'F.flipX', true)
            end

            if stringEndsWith(icos[i], '-pixel') then
                setProperty('iconP' .. i .. 'F.antialiasing', false)
            end

            if i ~= 3 then
                setObjectOrder('iconP' .. i .. 'F', getObjectOrder('healthBar') + i)
            else
                setObjectOrder('iconP' .. i .. 'F', getObjectOrder('iconP' .. (i - 1) .. 'F') - 1)
            end

            setProperty("iconP" .. i .. "F._frame.frame.x", 0)
            setProperty("iconP" .. i .. "F._frame.frame.y", 0)
            setProperty("iconP" .. i .. "F._frame.frame.width", 150)
            setProperty("iconP" .. i .. "F._frame.frame.height", 150)

            addLuaSprite('iconP' .. i .. 'F')
        end
    end
end

function goodNoteHit(i, d, ntype, sus)
    if ntype ~= 'GF Sing' or not gfSection then -- guh
        -- if  then
        singn = true

        setProperty('iconP1F.origin.x', rayman[d + 1].x)
        setProperty('iconP1F.origin.y', rayman[d + 1].y)

        setProperty('iconP1F.scale.x', directionScales[d + 1].x)
        setProperty('iconP1F.scale.y', directionScales[d + 1].y)

        runTimer('a', crochet / 2500)
        -- else gfSec(d) end
    else
        gfSec(d)
    end
end

function opponentNoteHit(i, d, ntype, sus)
    if ntype ~= 'GF Sing' then -- idk man
        if not gfSection then
            singnOp = true

            setProperty('iconP2F.origin.x', origins[d + 1].x)
            setProperty('iconP2F.origin.y', origins[d + 1].y)

            setProperty('iconP2F.scale.x', directionScales[d + 1].x)
            setProperty('iconP2F.scale.y', directionScales[d + 1].y)

            runTimer('aO', crochet / 2500)
        else
            gfSec(d)
        end
    else
        gfSec(d)
    end
end

function gfSec(ay)
    singnG = true

    setProperty('iconP3F.origin.x', rayman[ay + 1].x)
    setProperty('iconP3F.origin.y', rayman[ay + 1].y)

    setProperty('iconP3F.scale.x', directionScales[ay + 1].x)
    setProperty('iconP3F.scale.y', directionScales[ay + 1].y)

    runTimer('aG', crochet / 2500)
end

function adjustIcon(icon, based)
    if not based then
        setProperty(icon .. "._frame.frame.x", 150)
        setProperty(icon .. "._frame.frame.y", 0)
        setProperty(icon .. "._frame.frame.width", 150)
        setProperty(icon .. "._frame.frame.height", 150)
    elseif based then
        setProperty(icon .. "._frame.frame.x", 0)
        setProperty(icon .. "._frame.frame.y", 0)
        setProperty(icon .. "._frame.frame.width", 150)
        setProperty(icon .. "._frame.frame.height", 150)
    end
end

function onTimerCompleted(t, l, ll)
    if t == 'a' then
        singn = false
    end
    if t == 'aO' then
        singnOp = false
    end
    if t == 'aG' then
        singnG = false
    end
end

function resetIcons()
    plea = {getProperty('boyfriend.healthIcon'), getProperty('dad.healthIcon'), getProperty('gf.healthIcon')}
    for i = 1, 3 do
        table.remove(icos, i)
        if plea[i] ~= testr[i] .. '.healthIcon' then
            new = table.insert(icos, plea[i])
        end
    end
end

function math.lerp(a, b, t)
    return (b - a) * t + a;
end

function fakeBoundTo(v, min, max)
    return math.max(min, math.min(max, v))
end
