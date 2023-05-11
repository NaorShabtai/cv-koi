
local QBCore = exports["qb-core"]:GetCoreObject()



---- locals ----



---- functions ----


---- Events ----
RegisterNetEvent("cv-koi:server:pay")
AddEventHandler("cv-koi:server:pay", function(payment)
    PlayerId = tonumber(payment.citizenid)
    Player = QBCore.Functions.GetPlayer(PlayerId)
    if Player then
    if Player.PlayerData.money.cash >= tonumber(payment.billprice) then
    Player.Functions.RemoveMoney(payment.billtype, payment.billprice, "KOI")
    exports['qb-management']:AddMoney("koi", payment.billprice)
    elseif Player.PlayerData.money.bank >= tonumber(payment.billprice) then
    Player.Functions.RemoveMoney(payment.billtype, payment.billprice, "KOI")
    exports['qb-management']:AddMoney("koi", payment.billprice)
    else
    TriggerClientEvent('QBCore:Notify', source, ("Player don't have money"), "error")
    end
    else
    TriggerClientEvent('QBCore:Notify', source, ('Player not online'), "error")
    end
end)

QBCore.Functions.CreateUseableItem(Config.paymenttabletitem, function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName(Config.paymenttabletitem) then
    TriggerClientEvent("cv-koi:client:payment", src)
    end
end)