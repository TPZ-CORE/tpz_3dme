-----------------------------------------------------------
--[[ Functions  ]]--
-----------------------------------------------------------

-- DRAW FUNCTION
function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = GetScreenCoordFromWorldCoord(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoord())
    local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, true)

    if not onScreen then return end

    local scale = 160 / (GetGameplayCamFov() * dist)
    local str = CreateVarString(10, "LITERAL_STRING", text)

    SetTextScale(0.30, 0.30)
    SetTextFontForCurrentCommand(11)
    SetTextColor(Config.Color.r, Config.Color.g, Config.Color.b, Config.Color.a)
    SetTextCentre(true)
    DisplayText(str, _x, _y)

    local factor = string.len(text) / 225
    DrawSprite(
        "feeds",
        "toast_bg",
        _x,
        _y + 0.0125,
        0.015 + factor,
        0.03,
        0.0,
        0,
        0,
        0,
        150,
        0
    )
end
