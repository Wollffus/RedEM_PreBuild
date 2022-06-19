Dialogs = {}

AddEventHandler("redemrp_dialog:createDialog", function(id, title, subtitle, options)
    local cDialog = CreateDialog(tonumber(id),title,subtitle,options)
    Dialogs[id] = cDialog
end)

RegisterNetEvent("redemrp_dialog:listDialog")
AddEventHandler("redemrp_dialog:listDialog", function(id)
    TriggerEvent("redemrp_dialog:getDialogFromId", id, function(dialog)
        if dialog then
            local options = dialog.getOptions()
            
            print("^2[RedEM:RP Dialog]^0")
            print("ID: " .. dialog.getId() .. " | Title: " .. dialog.getTitle() .. " | Subtitle: " .. dialog.getSubtitle() .. " | Options: ")

                for k,v in pairs(options) do 
                    print(" - " .. options[k].name)
                end

        else
            print("^8[RedEM:RP Dialog]^0 Dialog with ID: " .. id .. " doesn't exist.")
        end
    end)
end)

RegisterNetEvent("redemrp_dialog:listDialogs")
AddEventHandler("redemrp_dialog:listDialogs", function()
    TriggerEvent("redemrp_dialog:getAllDialogs", function(dialog)
        print("^2[RedEM:RP Dialog]^0")
        for k, v in pairs(dialog) do
            if k then
                print("ID: " .. v.getId() .. " | Title: " .. v.getTitle())
            end
        end
    end)
end)
RegisterNetEvent("redemrp_dialog:UseOption")
AddEventHandler("redemrp_dialog:UseOption", function(id, option)
local _source = source
    TriggerEvent("redemrp_dialog:getDialogFromId", id, function(dialog)
        if dialog then
			local _optionid = option + 1
            local options = dialog.getOptions()
			if options[_optionid].focusOFF then
				TriggerClientEvent("redemrp_dialog:SetNuiFocus", _source)					
			end
			options[_optionid].func(_source)
        else
            print("^8[RedEM:RP Dialog]^0 Dialog with ID: " .. id .. " doesn't exist.")
        end
    end)
end)

RegisterNetEvent("redemrp_dialog:openDialog")
AddEventHandler("redemrp_dialog:openDialog", function(id , src)
	 local _source 
	 if src ~= nil then
	  _source = src
	 else
	     _source = source
	 end
    TriggerEvent("redemrp_dialog:getDialogFromId", id, function(dialog)
        if dialog then
            TriggerClientEvent("redemrp_dialog:openDialogClient", _source, dialog.getId(), dialog.getTitle(), dialog.getSubtitle(), dialog.getOptions())
        else
            print("^8[RedEM:RP Dialog]^0 Error! Incorrect dialog ID!")
        end
    end)
end)

function getDialogFromId(id)
	return Dialogs[id]
end

AddEventHandler("redemrp_dialog:getDialogFromId", function(id, cb)
    if(Dialogs)then
        if(Dialogs[id])then
			cb(Dialogs[id])
        else
			cb(nil)
		end
	else
		cb(nil)
	end
end)

AddEventHandler("redemrp_dialog:getAllDialogs", function(cb)
    if(Dialogs)then
			cb(Dialogs)
	else
		cb(nil)
	end
end)

TriggerEvent("redemrp_dialog:createDialog", 1, "EXAMPLE TITLE", "EXAMPLE SUBTITLE",
    {
        {name = "Option1", func = function(source) TriggerEvent('redemrp_dialog:openDialog', 1 , source) end},
        {name = "Option2",  func = function() print("SELECTED OPTION 2") end},
        {name = "Option3",func =  function() print("SELECTED OPTION 3") end},
        {name = "Option4",func = function() print("SELECTED OPTION 4") end},
        {name = "Option5", func = function() print("SELECTED OPTION 5")end},
        {name = "Option6",  func = function() print("SELECTED OPTION 6") end},
        {name = "Option7",func =  function() print("SELECTED OPTION 7") end},
        {name = "Option8",func = function() print("SELECTED OPTION 8") end}
    }
)

