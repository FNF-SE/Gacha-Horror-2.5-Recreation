function onCreatePost()
    makeLuaSprite('BlackScreenHUD', 'empty', -550, -150)
    makeGraphic('BlackScreenHUD', 2500, 1920, '000000')
    setObjectCamera('BlackScreenHUD', 'hud')
    addLuaSprite('BlackScreenHUD', false)
    setProperty("BlackScreenHUD.visible", false)

    makeLuaText("Captions", " ", 1200, 55, 515)
    addLuaText("Captions", true)
    setTextSize("Captions", 30)
    setTextBorder("Captions", 2, "564793")
    setTextColor("Captions", "CDC5EE")
    setTextFont("Captions", "Comfortaa-Bold.ttf")
    setTextAlignment("Captions", "center")
end

function onBeatHit()
    if curBeat == 64 then
        if flashingLights then
            cameraFlash('hud', 'FFFFFF', 0.75, true)
        end
        setProperty("BlackScreenHUD.visible", true)
    end

    if curBeat == 80 then
        if flashingLights then
            cameraFlash('hud', 'FFFFFF', 0.75, true)
        end
        setProperty("BlackScreenHUD.visible", false)
    end

    if curBeat == 368 then
        setTextString("Captions", "Take the Syringe")
    end
    if curBeat == 370 then
        setTextString("Captions", "It won't hurt.")
    end
    if curBeat == 372 then
        setTextString("Captions", "Your answers")
    end
    if curBeat == 374 then
        setTextString("Captions", "Shall be heard.")
    end
    if curBeat == 376 then
        setTextString("Captions", "In my hand is the key to life,")
    end
    if curBeat == 380 then
        setTextString("Captions", "Keeping you from PAIN AND STRIFE.")
    end
    if curBeat == 384 then
        setTextString("Captions", " ")
    end
    if curBeat == 400 then
        setTextString("Captions", "No chance of you ever being free")
    end
    if curBeat == 404 then
        setTextString("Captions", "Without my knife THROUGH YOUR BODY.")
    end
    if curBeat == 408 then
        setTextString("Captions", "Nobody else will hear your screams")
    end
    if curBeat == 412 then
        setTextString("Captions", "Take it from me im not just a")
    end
    if curBeat == 416 then
        setTextString("Captions", "DREAM")
    end
    if curBeat == 420 then
        setTextString("Captions", "DREAM, WAKE")
    end
    if curBeat == 424 then
        setTextString("Captions", "DREAM, WAKE UP")
    end
    if curBeat == 428 then
        setTextString("Captions", "FROM YOUR NIGHTMARE OR DIE")
    end

    if curBeat == 432 then
        setTextString("Captions", " ")
        setProperty("BlackScreenHUD.visible", true)
    end

    if curBeat == 436 then
        if flashingLights then
            cameraFlash('hud', 'FFFFFF', 0.75, true)
        end

        if not middlescroll then
            noteTweenX("NoteMove1", 0, 420, 1, 'cubeOut')
            noteTweenX("NoteMove2", 1, 530, 1, 'cubeOut')
            noteTweenX("NoteMove3", 2, 640, 1, 'cubeOut')
            noteTweenX("NoteMove4", 3, 750, 1, 'cubeOut')

            noteTweenX("NoteMove5", 4, 420, 1, 'cubeOut')
            noteTweenX("NoteMove6", 5, 530, 1, 'cubeOut')
            noteTweenX("NoteMove7", 6, 640, 1, 'cubeOut')
            noteTweenX("NoteMove8", 7, 750, 1, 'cubeOut')

            noteTweenAngle("MNoteAngle1", 0, 360, 1, 'cubeOut')
            noteTweenAngle("MNoteAngle2", 1, 360, 1, 'cubeOut')
            noteTweenAngle("MNoteAngle3", 2, 360, 1, 'cubeOut')
            noteTweenAngle("MNoteAngle4", 3, 360, 1, 'cubeOut')

            noteTweenAngle("MNoteAngle5", 4, 360, 1, 'cubeOut')
            noteTweenAngle("MNoteAngle6", 5, 360, 1, 'cubeOut')
            noteTweenAngle("MNoteAngle7", 6, 360, 1, 'cubeOut')
            noteTweenAngle("MNoteAngle8", 7, 360, 1, 'cubeOut')
        end
        setProperty("BlackScreenHUD.visible", false)
    end

    if curBeat == 468 then
        if not middlescroll then
            noteTweenX(defaultPlayerStrumX0 .. "2", 4, defaultPlayerStrumX0, 0.5, "cubeOut")
            noteTweenX(defaultPlayerStrumX1 .. "2", 5, defaultPlayerStrumX1, 0.5, "cubeOut")
            noteTweenX(defaultPlayerStrumX2 .. "2", 6, defaultPlayerStrumX2, 0.5, "cubeOut")
            noteTweenX(defaultPlayerStrumX3 .. "2", 7, defaultPlayerStrumX3, 0.5, "cubeOut")

            noteTweenAngle("NoteAngle1" .. "2", 4, 360, 0.25, cubeOut)
            noteTweenAngle("NoteAngle2" .. "2", 5, 360, 0.25, cubeOut)
            noteTweenAngle("NoteAngle3" .. "2", 6, 360, 0.25, cubeOut)
            noteTweenAngle("NoteAngle4" .. "2", 7, 360, 0.25, cubeOut)

            noteTweenX(defaultOpponentStrumX0 .. "2", 0, defaultOpponentStrumX0, 0.5, "cubeOut")
            noteTweenX(defaultOpponentStrumX1 .. "2", 1, defaultOpponentStrumX1, 0.5, "cubeOut")
            noteTweenX(defaultOpponentStrumX2 .. "2", 2, defaultOpponentStrumX2, 0.5, "cubeOut")
            noteTweenX(defaultOpponentStrumX3 .. "2", 3, defaultOpponentStrumX3, 0.5, "cubeOut")

            noteTweenAngle("NoteAngle5" .. "2", 0, -360, 0.25, cubeOut)
            noteTweenAngle("NoteAngle6" .. "2", 1, -360, 0.25, cubeOut)
            noteTweenAngle("NoteAngle7" .. "2", 2, -360, 0.25, cubeOut)
            noteTweenAngle("NoteAngle8" .. "2", 3, -360, 0.25, cubeOut)
        end
    end
end
