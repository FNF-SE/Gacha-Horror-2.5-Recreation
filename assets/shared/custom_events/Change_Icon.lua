function split(s, delimiter)
  local result = {}
  for match in (s..delimiter):gmatch('(.-)'..delimiter) do
    table.insert(result, stringTrim(tostring(match)))
  end
  return result
end

function onEvent(n, v1, v2)
  if n == 'Change Icon' or n == 'Change_Icon' then --discord shit :skull:
    local tableee = split(v1, ', ')
    local tableee = split(v1, ',')
    icon = tableee[1]
    name = tableee[2]
    tableee[1] = tonumber(tableee[1])
    tableee[2] = tonumber(tableee[2])
    runHaxeCode([[game.icon]] .. icon .. [[.changeIcon(']] .. name .. [[')]])
  end
end
