-- -- Point  -------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Wait(0)
        if (IsControlJustPressed(0,0xF3830D8E))  then --J
            local ped = PlayerPedId()
            if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then

                RequestAnimDict( "ai_react@point@base" )

                while ( not HasAnimDictLoaded( "ai_react@point@base" ) ) do
                    Wait( 100 )
                end

                if IsEntityPlayingAnim(ped, "ai_react@point@base", "point_fwd", 3) then
                    ClearPedSecondaryTask(ped)
                else
                    TaskPlayAnim(ped, "ai_react@point@base", "point_fwd", 8.0, -8.0, 120000, 31, 0, true, 0, false, 0, false)
                end
            end
        end
    end
end)
