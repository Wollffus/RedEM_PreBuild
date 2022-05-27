if Config.ExampleQuest then
function modelrequest( model )
    Citizen.CreateThread(function()
        RequestModel( model )
    end)
end

local Bobbygroup = GetRandomIntInRange(0, 0xffffff)

local active = false
local Bobbyprompt
function BobbyPrompt()
    Citizen.CreateThread(function()
        local str = 'Talk with Bobby Train'
        local wait = 0
        Bobbyprompt = Citizen.InvokeNative(0x04F97DE45A519419)
        PromptSetControlAction(Bobbyprompt, 0xC7B5340A)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(Bobbyprompt, str)
        PromptSetEnabled(Bobbyprompt, true)
        PromptSetVisible(Bobbyprompt, true)
        PromptSetHoldMode(Bobbyprompt, true)
        PromptSetGroup(Bobbyprompt, Bobbygroup)
        PromptRegisterEnd(Bobbyprompt)
    end)
end

Citizen.CreateThread(function()
    BobbyPrompt()
    while true do
        Wait(0)
        local pedCoords = GetEntityCoords(PlayerPedId())
        local dist = Vdist(pedCoords.x, pedCoords.y, pedCoords.z, 483.9141, 665.3777, 116.5, 108.49)
        if dist < 3.0 and not active then
			local BobbyGroupName  = CreateVarString(10, 'LITERAL_STRING', "Bobby Train")
               PromptSetActiveGroupThisFrame(Bobbygroup, BobbyGroupName) 
            if PromptHasHoldModeCompleted(Bobbyprompt) then
                active = true
                TriggerServerEvent("redemrp_dialog:openDialog", 2)
            end
        else
            active = false
        end
    end
end)

function SET_PED_RELATIONSHIP_GROUP_HASH ( iVar0, iParam0 )
    return Citizen.InvokeNative( 0xC80A74AC829DDD92, iVar0, _GET_DEFAULT_RELATIONSHIP_GROUP_HASH( iParam0 ) )
end

function _GET_DEFAULT_RELATIONSHIP_GROUP_HASH ( iParam0 )
    return Citizen.InvokeNative( 0xC80A74AC829DDD92, iParam0 );
end

Citizen.CreateThread(function()
    while not HasModelLoaded( GetHashKey("A_M_M_ValFarmer_01") ) do
        Wait(500)
        modelrequest( GetHashKey("A_M_M_ValFarmer_01") )
    end
    local npc = CreatePed(GetHashKey("A_M_M_ValFarmer_01"), 483.9141, 665.3777, 116.5, 180.0, false, false, 0, 0)
    while not DoesEntityExist(npc) do
        Wait(300)
    end
    Citizen.InvokeNative(0x283978A15512B2FE, npc, true)
    FreezeEntityPosition(npc, true)
    SetEntityInvincible(npc, true)
    TaskStandStill(npc, -1)
    SET_PED_RELATIONSHIP_GROUP_HASH(npc, GetHashKey("A_M_M_ValFarmer_01"))
    SetEntityCanBeDamagedByRelationshipGroup(npc, false, `PLAYER`)
    SetEntityAsMissionEntity(npc, true, true)
    SetModelAsNoLongerNeeded(GetHashKey("A_M_M_ValFarmer_01"))
end)

Citizen.CreateThread(function()
    Wait(100)
        local blip = Citizen.InvokeNative(0x554d9d53f696d002, 1664425300, 483.9141, 665.3777, 116.5)
        SetBlipSprite(blip, 133359852)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, "Bobby Train")
end)

end