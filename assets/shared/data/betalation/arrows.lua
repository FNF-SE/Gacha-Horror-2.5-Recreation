function onSongStart()
    if not middlescroll then
        noteTweenX(defaultOpponentStrumX0, 4, defaultPlayerStrumX0, 0.5, "cubeOut")
        noteTweenX(defaultOpponentStrumX1, 5, defaultPlayerStrumX1, 0.5, "cubeOut")
        noteTweenX(defaultOpponentStrumX2, 6, defaultPlayerStrumX2, 0.5, "cubeOut")
        noteTweenX(defaultOpponentStrumX3, 7, defaultPlayerStrumX3, 0.5, "cubeOut")

        noteTweenAngle("NoteAngle1", 4, -360, 0.25, cubeOut)
        noteTweenAngle("NoteAngle2", 5, -360, 0.25, cubeOut)
        noteTweenAngle("NoteAngle3", 6, -360, 0.25, cubeOut)
        noteTweenAngle("NoteAngle4", 7, -360, 0.25, cubeOut)

        noteTweenX(defaultPlayerStrumX0, 0, defaultOpponentStrumX0, 0.5, "cubeOut")
        noteTweenX(defaultPlayerStrumX1, 1, defaultOpponentStrumX1, 0.5, "cubeOut")
        noteTweenX(defaultPlayerStrumX2, 2, defaultOpponentStrumX2, 0.5, "cubeOut")
        noteTweenX(defaultPlayerStrumX3, 3, defaultOpponentStrumX3, 0.5, "cubeOut")

        noteTweenAngle("NoteAngle5", 0, 360, 0.25, cubeOut)
        noteTweenAngle("NoteAngle6", 1, 360, 0.25, cubeOut)
        noteTweenAngle("NoteAngle7", 2, 360, 0.25, cubeOut)
        noteTweenAngle("NoteAngle8", 3, 360, 0.25, cubeOut)
    end
end