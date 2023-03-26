local ShopItems = {}

data = {}
TriggerEvent("redemrp_inventory:getData",function(call)
    data = call
end)

Citizen.CreateThread(function()
    LoadShop()
end)

function LoadShop()
    ShopItems = {}
   for k,v in pairs(ShopItemsData) do
        if ShopItems[v.store] == nil then
            ShopItems[v.store] = {}
        end
        local name = v.item
        if data.getItemData(name) ~= nil and data.getItemData(name).label ~= nil then
            name = data.getItemData(name).label
        end
        table.insert(ShopItems[v.store], {
            label = name,
            item  = v.item,
            price = v.price,
            object = v.object,
            limit = 32,
        })
    end
end

function GetPrice(ItemName , Zone)
	for k,v in pairs(ShopItems[Zone]) do
        if v.item == ItemName then
           return v.price
        end
   end
   return 0
end
RegisterServerEvent('redemrp_shops:RequestItems')
AddEventHandler('redemrp_shops:RequestItems', function()
    local _source = source
    TriggerClientEvent('redemrp_shops:GetItems', _source, ShopItems)
end)

RegisterServerEvent('redemrp_shops:BuyItem')
AddEventHandler('redemrp_shops:BuyItem', function(itemName, amount , zone)
    local _source = source
    local amount_ = math.floor(amount)
	if amount_ < 0 then return end
	local ItemPrice = GetPrice(itemName , zone)
	local TotalPrice = ItemPrice * amount_
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user)

            if user.getMoney() >= TotalPrice then

                local ItemData = data.getItem(_source, itemName)
                if not ItemData.AddItem(amount_) then
                    TriggerClientEvent("redemrp_notification:start", _source, "You don't have enough space!", 3, "error")
                else
                    user.removeMoney(TotalPrice)

                    local name = itemName
                    if ItemData.ItemInfo.label ~= nil then
                        name = ItemData.ItemInfo.label
                    end
                    TriggerClientEvent("pNotify:SendNotification", _source , {
                        text = "<img src='nui://redemrp_inventory/html/items/"..itemName..".png' height='40' width='40' style='float:left; margin-bottom:10px; margin-left:20px;' />You Bought: ".. name.."<br>+"..tonumber(amount_),
                        type = "success",
                        timeout = math.random(2000, 3000),
                        layout = "centerLeft",
                        queue = "right"
                    })
                end
            else
                local missingMoney = TotalPrice - user.getMoney()
                TriggerClientEvent("redemrp_notification:start", _source, "You don't have enough money: "..missingMoney, 3, "error")
            end
    end)
end)
