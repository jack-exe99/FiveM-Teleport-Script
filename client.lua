local function ShowHelpText(text)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayHelp(0, 0, 1, -1)
end

CreateThread(function()
    while true do
        local waitTime = 1000
        for title, location in pairs(Config.Locations) do
            local entrance = location.Coords.Entrance
            local exit = location.Coords.Exit

            local myPed = PlayerPedId()
            local myCoords = GetEntityCoords(myPed)

            local entranceDist = #(myCoords - entrance.Point)
            local exitDist = #(myCoords - exit.Point)

            if entranceDist < 15.0 then
                waitTime = 0
                DrawMarker(2, entrance.Point.x, entrance.Point.y, entrance.Point.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.5, 1.5, 1.5, 171, 30, 30, 50, true, true, 2, nil, nil, nil, false)
                
                if entranceDist < 1.5 then
                    ShowHelpText("Press ~INPUT_PICKUP~ to Enter " .. title)
                    if IsControlJustPressed(0, 38) then
                        SetEntityCoords(myPed, entrance.Landing.x, entrance.Landing.y, entrance.Landing.z)
                        SetEntityHeading(myPed, entrance.Landing.w)
                    end
                end
            end

            if exitDist < 15.0 then
                waitTime = 0
                DrawMarker(2, exit.Point.x, exit.Point.y, exit.Point.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.5, 1.5, 1.5, 171, 30, 30, 50, true, true, 2, nil, nil, nil, false)
            
            if exitDist < 1.5 then
                    ShowHelpText("Press ~INPUT_PICKUP~ to Exit " .. title)
                    if IsControlJustPressed(0, 38) then
                        SetEntityCoords(myPed, exit.Landing.x, exit.Landing.y, exit.Landing.z)
                        SetEntityHeading(myPed, exit.Landing.w)
                    end
                end
            end
        end
        Wait(waitTime)
    end
end)