funny = -135
angle = 360

function onSongStart()
    if not middlescroll then
        noteTweenX("Move0", 0, 98, 1, 'cubeOut')
        noteTweenAngle("Angle0", 0, angle, 1, 'cubeOut')
        noteTweenX("Move1", 1, 210, 1, 'cubeOut')
        noteTweenAngle("Angle1", 1, angle, 1, 'cubeOut')
        noteTweenX("Move2", 2, 322, 1, 'cubeOut')
        noteTweenAngle("Angle2", 2, angle, 1, 'cubeOut')
        noteTweenX("Move3", 3, 434, 1, 'cubeOut')
        noteTweenAngle("Angle3", 3, angle, 1, 'cubeOut')
        noteTweenX("Move4", 4, 739, 1, 'cubeOut')
        noteTweenAngle("Angle4", 4, angle, 1, 'cubeOut')
        noteTweenX("Move5", 5, 851, 1, 'cubeOut')
        noteTweenAngle("Angle5", 5, angle, 1, 'cubeOut')
        noteTweenX("Move6", 6, 963, 1, 'cubeOut')
        noteTweenAngle("Angle6", 6, angle, 1, 'cubeOut')
        noteTweenX("Move7", 7, 1075, 1, 'cubeOut')
        noteTweenAngle("Angle7", 7, angle, 1, 'cubeOut')
    end
end
