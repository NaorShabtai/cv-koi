local QBCore = exports["qb-core"]:GetCoreObject()

---- locals ----

---- functions ----

---- Events ----

RegisterNetEvent("cv-koi:server:getitem")
AddEventHandler("cv-koi:server:getitem", function(item, amount)
	Player = QBCore.Functions.GetPlayer(source)
	Player.Functions.AddItem(item, amount)
end)

RegisterNetEvent("cv-koi:server:removeitem")
AddEventHandler("cv-koi:server:removeitem", function(item, amount)
	Player = QBCore.Functions.GetPlayer(source)
	Player.Functions.RemoveItem(item, amount)
end)

RegisterNetEvent("cv-koi:server:removesushiwithavocadoitems")
AddEventHandler("cv-koi:server:removesushiwithavocadoitems", function()
	Player = QBCore.Functions.GetPlayer(source)
	Player.Functions.RemoveItem("rice", 1)
	Player.Functions.RemoveItem("avocado", 1)
	Player.Functions.RemoveItem("seaweed", 1)
end)


RegisterNetEvent("cv-koi:server:removesushiitems")
AddEventHandler("cv-koi:server:removesushiitems", function()
	Player = QBCore.Functions.GetPlayer(source)
	Player.Functions.RemoveItem("rice", 1)
	Player.Functions.RemoveItem("avocado", 1)
	Player.Functions.RemoveItem("seaweed", 1)
	Player.Functions.RemoveItem("cuttedfish", 1)
end)

RegisterNetEvent("cv-koi:server:takejobmoney", function()
	local business =  exports['qb-management']:GetAccount("koi", amount)
	if business > 0 then
	Player = QBCore.Functions.GetPlayer(source)
	exports['qb-management']:RemoveMoney("koi", business)
	Player.Functions.AddMoney("cash", business)
	TriggerClientEvent('QBCore:Notify', source, "You collected " ..business.. " $", "error")
	else
	TriggerClientEvent('QBCore:Notify', source, "KOI Brokies", "error")
	end
end)

RegisterNetEvent("colldown:server", function()
    TriggerClientEvent("colldown", -1)
end)

---- commands ----


---- other stuff ----


AddEventHandler('onResourceStart', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
	  return
	end
	print(resourceName.. ' loading 100% ')
  end)

  AddEventHandler('onResourceStop', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
	  return
	end
	print(resourceName..  ' loading 100% ')
  end)

