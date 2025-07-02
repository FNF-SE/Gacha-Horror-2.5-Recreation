function onCreatePost()
    if not middlescroll then
        noteTweenX("NoteMove1", 4, 435, 1, 'cubeOut')
        noteTweenX("NoteMove2", 5, 545, 1, 'cubeOut')
        noteTweenX("NoteMove3", 6, 655, 1, 'cubeOut')
        noteTweenX("NoteMove4", 7, 765, 1, 'cubeOut')

        noteTweenAngle("MNoteAngle1", 4, -360, 1, 'cubeOut')
        noteTweenAngle("MNoteAngle2", 5, -360, 1, 'cubeOut')
        noteTweenAngle("MNoteAngle3", 6, -360, 1, 'cubeOut')
        noteTweenAngle("MNoteAngle4", 7, -360, 1, 'cubeOut')

        noteTweenX("ONoteMove1", 0, 43335, 0.1, 'cubeOut')
        noteTweenX("ONoteMove2", 1, 54335, 0.1, 'cubeOut')
        noteTweenX("ONoteMove3", 2, 65335, 0.1, 'cubeOut')
        noteTweenX("ONoteMove4", 3, 76335, 0.1, 'cubeOut')
    end
end
