function goodNoteHit(id, direction, noteType, isSustainNote)
  if _G['boyfriendGhostData.strumTime'] == getPropertyFromGroup('notes', id, 'strumTime') and not isSustainNote and not getPropertyFromGroup('notes',id,'gfNote') then
    if getProperty('characterPlayingAsDad') == false then createGhost('boyfriend') else createGhost('dad') end
  end

  if not isSustainNote and not getPropertyFromGroup('notes',id,'gfNote') then
    _G['boyfriendGhostData.strumTime'] = getPropertyFromGroup('notes', id, 'strumTime')
    if getProperty('characterPlayingAsDad') == false then updateGData('boyfriend') else updateGData('dad') end
  end

  if _G['gfGhostData.strumTime'] == getPropertyFromGroup('notes',id,'strumTime') and not isSustainNote and getPropertyFromGroup('notes',id,'gfNote') then
    createGhost('gf')
  end

  if not isSustainNote and getPropertyFromGroup('notes',id,'gfNote') then
    _G['gfGhostData.strumTime'] = getPropertyFromGroup('notes',i,'strumTime')
    updateGData('gf')
  end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
  if _G['dadGhostData.strumTime'] == getPropertyFromGroup('notes', id, 'strumTime') and not isSustainNote and not getPropertyFromGroup('notes',i,'gfNote') then
    if getProperty('characterPlayingAsDad') == false then createGhost('dad') else createGhost('boyfriend') end
  end

  if not isSustainNote and not getPropertyFromGroup('notes',i,'gfNote') then
    _G['dadGhostData.strumTime'] = getPropertyFromGroup('notes', id, 'strumTime')
    if getProperty('characterPlayingAsDad') == false then updateGData('dad') else updateGData('boyfriend') end
  end

  if _G['gfGhostData.strumTime'] == getPropertyFromGroup('notes',id,'strumTime') and not isSustainNote and getPropertyFromGroup('notes',id,'gfNote') then
    createGhost('gf')
  end

  if not isSustainNote and getPropertyFromGroup('notes',id,'gfNote') then
    _G['gfGhostData.strumTime'] = getPropertyFromGroup('notes',i,'strumTime')
    updateGData('gf')
  end
end

function createGhost(char)
  songPos = math.floor(math.abs(getSongPosition()))
  local imageFile = getProperty(char..'.imageFile')
  local animName = getProperty(char..'.animation.curAnim.name')
  local isMultiAtlas = getProperty(char..'.isMultiAtlas')
  local newPath = isMultiAtlas and (imageFile:match("(.+)/[^/]+$") or imageFile)..'/'..animName or imageFile
  makeAnimatedLuaSprite(char..'Ghost'..songPos, newPath, getProperty(char..'.x'), getProperty(char..'.y'))
  addLuaSprite(char..'Ghost'..songPos, false)
  setProperty(char..'Ghost'..songPos..'.scale.x',getProperty(char..'.scale.x'))
  setProperty(char..'Ghost'..songPos..'.scale.y',getProperty(char..'.scale.y'))
  setProperty(char..'Ghost'..songPos..'.flipX', getProperty(char..'.flipX'))
  if getProperty('inSilhouette') == true then
    setProperty(char..'Ghost'..songPos..'.color',000000)
  else end
  setProperty(char..'Ghost'..songPos..'.alpha', 1)
  doTweenAlpha(char..'Ghost'..songPos..'delete', char..'Ghost'..songPos, 0, 0.4)
  setProperty(char..'Ghost'..songPos..'.animation.frameName', _G[char..'GhostData.frameName'])
  setProperty(char..'Ghost'..songPos..'.offset.x', _G[char..'GhostData.offsetX'])
  setProperty(char..'Ghost'..songPos..'.offset.y', _G[char..'GhostData.offsetY'])
  setObjectOrder(char..'Ghost'..songPos, getObjectOrder(char..'Group')-1)
end

function onTweenCompleted(tag)
  if (tag:sub(#tag- 5, #tag)) == 'delete' then
    removeLuaSprite(tag:sub(1, #tag - 6), true)
  end
end

function updateGData(char)
  _G[char..'GhostData.frameName'] = getProperty(char..'.animation.frameName')
  _G[char..'GhostData.offsetX'] = getProperty(char..'.offset.x')
  _G[char..'GhostData.offsetY'] = getProperty(char..'.offset.y')
end
