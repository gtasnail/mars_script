

local gotoSpace = vector3(-1045.18, -2750.3, 21.36-0.99)
local msec2 = 1000
local spaceCoords = vector3(4432.86, 7374.21, 604.04-0.99)

local zone = vector3(4143.37, 7461.09, 686.64+-100.0)
local radius = 1090.0
local msec = 1000
local inzone = false
Citizen.CreateThread(function()
    while true do
        Wait(msec)
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        local dist = #(coords - zone)
        if dist < 700.0 then
            msec = 0
            print(1)
            DrawSphere2(zone, radius, 255,100,0,255)
            SetTimecycleModifier('prologue_ending_fog')
            SetTimecycleModifierStrength(1.0)
            inzone = true
        else
            if inzone then
                DoScreenFadeOut(1000)
                Wait(1000)
                SetEntityCoords(playerPed, gotoSpace)
                Wait(5000)
                DoScreenFadeIn(1000)
                inzone = false
                Wait(1000)
                if IsPedRagdoll(playerPed) then
                    SetEntityCoords(playerPed, spaceCoords)
                end
                Wait(2000)
                if IsPedRagdoll(playerPed) then
                    SetEntityCoords(playerPed, spaceCoords)
                end
            end
            ClearTimecycleModifier()
            msec = 1000
        end

    end

end)


Citizen.CreateThread(function()
    while true do
        Wait(msec2)
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        local dist = #(coords - gotoSpace)
        if dist < 10.0 then
            msec2 = 0
            DrawSphere3(gotoSpace, 1.0, 255,100,0,255)
            Draw3DText(gotoSpace.x, gotoSpace.y, gotoSpace.z+0.99, '[E] Take the next spaceship to mars!')
            if IsControlJustPressed(0, 38) then
                DoScreenFadeOut(1000)
                Wait(1000)
                
                SetEntityCoords(playerPed, spaceCoords)
                
                FreezeEntityPosition(playerPed, true)
                SetEntityCoords(playerPed, spaceCoords)
                Wait(5000)
                SetEntityCoords(playerPed, spaceCoords)
                FreezeEntityPosition(playerPed, false)
                DoScreenFadeIn(1000)
                Wait(2000)
                if IsPedRagdoll(playerPed) then
                    SetEntityCoords(playerPed, spaceCoords)
                end
            end
        else
            msec2 = 1000
        end

    end

end)


function Draw3DText(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

--epic useless functions 
function DrawSphere2(pos, radius, r, g, b, a)
	DrawMarker(1, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, radius, radius, 500.0, r, g, b, a, false, false, 2, nil, nil, false)
end

function DrawSphere3(pos, radius, r, g, b, a)
	DrawMarker(1, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, radius, radius, 1.0, r, g, b, a, false, false, 2, nil, nil, false)
end
