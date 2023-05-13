
local QBCore = exports["qb-core"]:GetCoreObject()



---- locals ----

PlayerJob = {}

local knfie = false

local uses = Config.uses

local StartCoolDownSeconds = 3600

local StartCoolDownRemaining = 0

local SafeSpawn = false


---- functions ----

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
	if not SafeSpawn then
		SpawnSafe()
	end
end)

local function CheckOnDuty()
	if Config.OnDutyOnly then
	return QBCore.Functions.GetPlayerData().job.onduty
	end
	return true
end

CreateThread(function()
	for _, restaurants in pairs(Config.Locations["restaurants"]) do
		local blip = AddBlipForCoord(restaurants.coords.x, restaurants.coords.y, restaurants.coords.z)
		SetBlipSprite(blip, restaurants.blip)
		SetBlipAsShortRange(blip, true)
		SetBlipScale(blip, restaurants.scale)
		SetBlipColour(blip, restaurants.color)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(restaurants.label)
		EndTextCommandSetBlipName(blip)
	end
end)

function StartCoolDown()
    StartCoolDownRemaining = StartCoolDownSeconds
    Citizen.CreateThread(function()
        while StartCoolDownRemaining > 0 do
            Citizen.Wait(1000)
            StartCoolDownRemaining = StartCoolDownRemaining - 1
        end
    end)
end

function LoadModel(model)
	while not HasModelLoaded(model) do
		RequestModel(model)
		Wait(10)
	end
end

function SpawnSafe()
	for k, v in pairs(Config.Safeobject) do
		LoadModel(v.model)
		local Model = CreateObject(GetHashKey(v.model), v.coords.x, v.coords.y, v.coords.z, true)
		SetEntityHeading(Model, v.heading)
		FreezeEntityPosition(Model, true)
		SafeSpawn = true
	end
end


---- Events ----



RegisterNetEvent("colldown", function()
	StartCoolDown()
end)

RegisterNetEvent("cv-koi:client:opensushimenu", function()
    exports["qb-menu"]:openMenu({
        {
            header = "Make sushi",
            isMenuHeader = true, -- Set to true to make a nonclickable title
        },
        {
            header = "Sushi with avocado",
            txt = "Make Sushi with avocado",
            params = {
            event = "cv-koi:client:makesushiavocado",
		}
	},
        {
            header = "Sushi with fish and avocado",
            txt = "Make Sushi with fish and avocado",
            params = {
            event = "cv-koi:client:makesushi",
		}
	},
})
end)

RegisterNetEvent("cv-koi:client:opendrinkmenu", function()
	if CheckOnDuty() then
    exports["qb-menu"]:openMenu({
        {
            header = "Grab drinks",
            isMenuHeader = true, -- Set to true to make a nonclickable title
        },
        {
            header = "Grab Cola",
            txt = "Cola",
            params = {
            event = "cv-koi:client:grabcola",
		}
	},
        {
            header = "Grab Water",
            txt = "Water",
            params = {
            event = "cv-koi:client:grabwater",
		},
	},
		{
            header = "Grab Coffee",
            txt = "Coffee",
            params = {
            event = "cv-koi:client:grabcoffee",
	},
	},
})
else
	QBCore.Functions.Notify("You are not on duty", "error")
   end
end)

RegisterNetEvent("cv-koi:client:toiletpee", function()
   QBCore.Functions.Progressbar("pee", "Pee...", 5000, false, true, {
   disableMovement = true,
   disableCarMovement = false,
   disableMouse = false,
   disableCombat = true,
}, {
   animDict = "misscarsteal2peeing",
   anim = "peeing_loop",
   flags = 49,
}, {}, {}, function() -- Done
   StopAnimTask(PlayerPedId(), animDict, anim, 1.0)
   TriggerServerEvent('hud:server:RelieveStress', math.random(5, 10))
end, function() -- Cancel
    StopAnimTask(PlayerPedId(), animDict, anim, 1.0)
    QBCore.Functions.Notify("Cancel", "error")
   end)
end)

RegisterNetEvent("cv-koi:client:toiletwashhands", function()
    QBCore.Functions.Progressbar("washhands", "Washing hands...", 5000, false, true, {
   disableMovement = true,
   disableCarMovement = false,
   disableMouse = false,
   disableCombat = true,
}, {
   animDict = "anim@mp_snowball",
   anim = "pickup_snowball",
   flags = 49,
}, {}, {}, function() -- Done
   StopAnimTask(PlayerPedId(), animDict, anim, 1.0)
   TriggerServerEvent('hud:server:RelieveStress', math.random(4, 9))
end, function() -- Cancel
    StopAnimTask(PlayerPedId(), animDict, anim, 1.0)
    QBCore.Functions.Notify("Cancel", "error")
   end)
end)


RegisterNetEvent("cv-koi:client:storage", function()
	if CheckOnDuty() then
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "koi", Config.Items)
else
    QBCore.Functions.Notify("You are not on duty", "error")
   end
end)

RegisterNetEvent("cv-koi:client:stash", function()
    if CheckOnDuty() then
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "koi")
    TriggerEvent("inventory:client:SetCurrentStash", "koi")
else
    QBCore.Functions.Notify("You are not on duty", "error")
   end
end)

RegisterNetEvent("cv-koi:client:takeknife", function()
    if CheckOnDuty() then
	if not exports['qb-inventory']:HasItem("chefknife", 1) then
    if knfie == true then
    QBCore.Functions.Notify("You already take a knife", "error")
    else
	TriggerServerEvent("cv-koi:server:getitem", "chefknife", 1)
	TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["chefknife"], "add")
	knfie = true
    end
else
	QBCore.Functions.Notify("You already have a knife", "error")
   end
else
    QBCore.Functions.Notify("You are not on duty", "error")
   end
end)


RegisterNetEvent("cv-koi:client:washknife", function()
    if CheckOnDuty() then
    if exports['qb-inventory']:HasItem("dirtyknife", 1) then
    QBCore.Functions.Progressbar("washknife", "Washing knife...", 5000, false, true, {
   disableMovement = true,
   disableCarMovement = false,
   disableMouse = false,
   disableCombat = true,
}, {
   animDict = "anim@mp_snowball",
   anim = "pickup_snowball",
   flags = 49,
}, {}, {}, function() -- Done
   StopAnimTask(PlayerPedId(), animDict, anim, 1.0)
   TriggerServerEvent("cv-koi:server:getitem", "chefknife", 1)
   TriggerServerEvent("cv-koi:server:removeitem", "dirtyknife", 1)
   TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["chefknife"], "add")
   TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["dirtyknife"], "remove")
end, function() -- Cancel
    StopAnimTask(PlayerPedId(), animDict, anim, 1.0)
    QBCore.Functions.Notify("Cancel", "error")
   end)
else
	QBCore.Functions.Notify("You don't have a dirty knife", "error")
   end
else
    QBCore.Functions.Notify("You are not on duty", "error")
   end
end)

RegisterNetEvent("cv-koi:client:cookstake", function()
	if CheckOnDuty() then
	if exports['qb-inventory']:HasItem("wagyuburger", 1) then
	TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BBQ", 0, false)
    QBCore.Functions.Progressbar("cookw", "Cooking wagyu ...", 5000, false, true, {
   disableMovement = true,
   disableCarMovement = false,
   disableMouse = false,
   disableCombat = true,
}, {
   animDict = "",
   anim = "",
   flags = 49,
}, {}, {}, function() -- Done
   ClearPedTasks(PlayerPedId())
   TriggerServerEvent("cv-koi:server:getitem", "cookedwagyu", 1)
   TriggerServerEvent("cv-koi:server:removeitem", "wagyuburger", 1)
   TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["cookedwagyu"], "add")
   TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["wagyuburger"], "remove")
end, function() -- Cancel
    ClearPedTasks(PlayerPedId())
    QBCore.Functions.Notify("Cancel", "error")
end)
else
    QBCore.Functions.Notify("You don't have a wagyu", "error")
   end
else
    QBCore.Functions.Notify("You are not on duty", "error")
   end
end)

RegisterNetEvent("cv-koi:client:cookeggs", function()
	if CheckOnDuty() then
	if exports['qb-inventory']:HasItem("eggs", 1) then
	TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BBQ", 0, false)
    QBCore.Functions.Progressbar("cookegg", "Cooking eggs ...", 5000, false, true, {
   disableMovement = true,
   disableCarMovement = false,
   disableMouse = false,
   disableCombat = true,
}, {
   animDict = "",
   anim = "",
   flags = 49,
}, {}, {}, function() -- Done
   ClearPedTasks(PlayerPedId())
   TriggerServerEvent("cv-koi:server:getitem", "cookedeggs", 1)
   TriggerServerEvent("cv-koi:server:removeitem", "eggs", 1)
   TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["cookedeggs"], "add")
   TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["eggs"], "remove")
end, function() -- Cancel
    ClearPedTasks(PlayerPedId())
    QBCore.Functions.Notify("Cancel", "error")
end)
else
    QBCore.Functions.Notify("You don't have eggs", "error")
   end
else
    QBCore.Functions.Notify("You are not on duty", "error")
   end
end)

RegisterNetEvent("cv-koi:client:filletfish", function()
	if uses > 0 then 
	if CheckOnDuty() then
	if exports['qb-inventory']:HasItem("chefknife", 1)  then
	if exports['qb-inventory']:HasItem("fish", 1) or exports['qb-inventory']:HasItem("salmon", 1) then
    QBCore.Functions.Progressbar("filletfish", "Filleting fish ...", 5000, false, true, {
   disableMovement = true,
   disableCarMovement = false,
   disableMouse = false,
   disableCombat = true,
}, {
   animDict = "anim@heists@prison_heiststation@cop_reactions",
   anim = "cop_b_idle",
   flags = 49,
}, {}, {}, function() -- Done
   uses = uses -1
   ClearPedTasks(PlayerPedId())
   if exports['qb-inventory']:HasItem("fish", 1)  then
   TriggerServerEvent("cv-koi:server:getitem", "cuttedfish", 1)
   TriggerServerEvent("cv-koi:server:removeitem", "fish", 1)
   TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["cuttedfish"], "add")
   TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["fish"], "remove")
   elseif exports['qb-inventory']:HasItem("salmon", 1) then
   TriggerServerEvent("cv-koi:server:getitem", "cuttedfish", 1)
   TriggerServerEvent("cv-koi:server:removeitem", "salmon", 1)
   TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["cuttedfish"], "add")
   TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["salmon"], "remove")
   end
end, function() -- Cancel
    ClearPedTasks(PlayerPedId())
    QBCore.Functions.Notify("Cancel", "error")
end)
else
	QBCore.Functions.Notify("You don't have a fish or salmon", "error")
end
else
	QBCore.Functions.Notify("You don't have a knife", "error")
end
else
    QBCore.Functions.Notify("You are not on duty", "error")
   end
else 
	TriggerServerEvent("cv-koi:server:getitem", "dirtyknife", 1)
	TriggerServerEvent("cv-koi:server:removeitem", "chefknife", 1)
	TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["chefknife"], "add")
	TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["dirtyknife"], "remove")
	uses = Config.uses
	QBCore.Functions.Notify("Your Knife Get Dirty.", "error", 3500)
  end
end)

RegisterNetEvent("cv-koi:client:makesushiavocado", function()
	if uses > 0 then 
	if CheckOnDuty() then
	if exports['qb-inventory']:HasItem("chefknife", 1)  then
	if exports['qb-inventory']:HasItem("rice", 1) and exports['qb-inventory']:HasItem("avocado", 1) and exports['qb-inventory']:HasItem("seaweed", 1) then
    QBCore.Functions.Progressbar("makesushi", "Makeing sushi ...", 5000, false, true, {
   disableMovement = true,
   disableCarMovement = false,
   disableMouse = false,
   disableCombat = true,
}, {
   animDict = "anim@heists@prison_heiststation@cop_reactions",
   anim = "cop_b_idle",
   flags = 49,
}, {}, {}, function() -- Done
	uses = uses -1
   ClearPedTasks(PlayerPedId())
   if exports['qb-inventory']:HasItem("rice", 1) and exports['qb-inventory']:HasItem("avocado", 1) and exports['qb-inventory']:HasItem("seaweed", 1)  then
   TriggerServerEvent("cv-koi:server:getitem", "sushiwithavocado", 1)
   TriggerServerEvent("cv-koi:server:removesushiwithavocadoitems")
   TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["sushiwithavocado"], "add")
   TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["rice"], "remove")
   TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["avocado"], "remove")
   TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["seaweed"], "remove")
      end
end, function() -- Cancel
    ClearPedTasks(PlayerPedId())
    QBCore.Functions.Notify("Cancel", "error")
end)
else
	QBCore.Functions.Notify("You don't have the right things", "error")
end
else
    QBCore.Functions.Notify("You are not on duty", "error")
end
else
	QBCore.Functions.Notify("You don't have a knife", "error")
   end
else 
	TriggerServerEvent("cv-koi:server:getitem", "dirtyknife", 1)
	TriggerServerEvent("cv-koi:server:removeitem", "chefknife", 1)
	TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["chefknife"], "add")
	TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["dirtyknife"], "remove")
	uses = Config.uses
	QBCore.Functions.Notify("Your Knife Get Dirty.", "error", 3500)
  end
end)
   

RegisterNetEvent("cv-koi:client:makesushi", function()
	if uses > 0 then 
	if CheckOnDuty() then
		if exports['qb-inventory']:HasItem("chefknife", 1)  then
		if  exports['qb-inventory']:HasItem("rice", 1) and exports['qb-inventory']:HasItem("avocado", 1) and exports['qb-inventory']:HasItem("seaweed", 1) and exports['qb-inventory']:HasItem("cuttedfish", 1) then
		QBCore.Functions.Progressbar("makesushi", "Makeing sushi ...", 5000, false, true, {
	   disableMovement = true,
	   disableCarMovement = false,
	   disableMouse = false,
	   disableCombat = true,
	}, {
	   animDict = "anim@heists@prison_heiststation@cop_reactions",
	   anim = "cop_b_idle",
	   flags = 49,
	}, {}, {}, function() -- Done
		uses = uses -1
	   ClearPedTasks(PlayerPedId())
	   if exports['qb-inventory']:HasItem("rice", 1) and exports['qb-inventory']:HasItem("avocado", 1) and exports['qb-inventory']:HasItem("seaweed", 1) and exports['qb-inventory']:HasItem("cuttedfish", 1)  then
	TriggerServerEvent("cv-koi:server:getitem", "sushi", 1)
	TriggerServerEvent("cv-koi:server:removesushiitems")
	TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["sushi"], "add")
	TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["rice"], "remove")
	TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["avocado"], "remove")
	TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["seaweed"], "remove")
	TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["cuttedfish"], "remove")
   end
end, function() -- Cancel
    ClearPedTasks(PlayerPedId())
    QBCore.Functions.Notify("Cancel", "error")
end)
else
	QBCore.Functions.Notify("You don't have the right things", "error")
end
else
    QBCore.Functions.Notify("You are not on duty", "error")
end
else
	QBCore.Functions.Notify("You don't have a knife", "error")
   end
else 
	TriggerServerEvent("cv-koi:server:getitem", "dirtyknife", 1)
	TriggerServerEvent("cv-koi:server:removeitem", "chefknife", 1)
	TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["chefknife"], "add")
	TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["dirtyknife"], "remove")
	uses = Config.uses
	QBCore.Functions.Notify("Your Knife Get Dirty.", "error", 3500)
  end
end)

RegisterNetEvent("cv-koi:client:frychicken", function()
	if CheckOnDuty() then
	if exports['qb-inventory']:HasItem("rawchicken", 1) then
    QBCore.Functions.Progressbar("cookegg", "Frying  Chicken...", 5000, false, true, {
   disableMovement = true,
   disableCarMovement = false,
   disableMouse = false,
   disableCombat = true,
}, {
	animDict = "anim@heists@prison_heiststation@cop_reactions",
	anim = "cop_b_idle",
   flags = 49,
}, {}, {}, function() -- Done
   ClearPedTasks(PlayerPedId())
   TriggerServerEvent("cv-koi:server:getitem", "frychicken", 1)
   TriggerServerEvent("cv-koi:server:removeitem", "rawchicken", 1)
   TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["frychicken"], "add")
   TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["rawchicken"], "remove")
end, function() -- Cancel
    ClearPedTasks(PlayerPedId())
    QBCore.Functions.Notify("Cancel", "error")
end)
else
    QBCore.Functions.Notify("You don't have a chicken", "error")
   end
else
    QBCore.Functions.Notify("You are not on duty", "error")
   end
end)

RegisterNetEvent("cv-koi:client:takejobmoney", function()
	if Config.robkoi then
		if StartCoolDownRemaining <= 0 then  
		local dialog = exports['qb-input']:ShowInput({
			header = "Safe",
			submitText = "open",
			inputs = {
				{
					text = "Safe password", -- text you want to be displayed as a place holder
					name = "Safe_password", -- name of the input should be unique otherwise it might override
					type = "password", -- type of the input
					isRequired = true, -- Optional [accepted values: true | false] but will submit the form if no value is inputted
				}
			},
		})
		if dialog ~= nil then
		if dialog.Safe_password == Config.safecode then
		TriggerServerEvent("cv-koi:server:takejobmoney")
		TriggerServerEvent("colldown:server")
	else
		QBCore.Functions.Notify("Wrong code", "error")
	end
end
else
	local minutes = math.floor(StartCoolDownRemaining / 60)
	local seconds = StartCoolDownRemaining - minutes * 60
	QBCore.Functions.Notify("You Have To Wait " .. minutes .. " Minutes And ".. seconds .. " Seconds Before Robbing On This Location Again !", "error")
end
else
	QBCore.Functions.Notify("You can't rob this place", "error")
end
	end)

RegisterNetEvent("cv-koi:client:cracksafe", function()
	if Config.robkoi then
		if StartCoolDownRemaining <= 0 then  
		local safe = exports["pd-safe"]:createSafe({math.random(0,99)})
		if safe then
		TriggerServerEvent("colldown:server")
		TriggerServerEvent("cv-koi:server:takejobmoney")
		if Config.psdispatch then
		exports['ps-dispatch']:Sussafe()
		end
		else
	QBCore.Functions.Notify("You failed", "error")
	end
else
	local minutes = math.floor(StartCoolDownRemaining / 60)
	local seconds = StartCoolDownRemaining - minutes * 60
	QBCore.Functions.Notify("You Have To Wait " .. minutes .. " Minutes And ".. seconds .. " Seconds Before Robbing On This Location Again !", "error")
end
else
	QBCore.Functions.Notify("You can't rob this place", "error")
end
end)

RegisterNetEvent("cv-koi:client:grabcola", function()
	TriggerServerEvent("cv-koi:server:getitem", "kurkakola", 1)
	TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["kurkakola"], "add")
	end)

RegisterNetEvent("cv-koi:client:grabwater", function()
	TriggerServerEvent("cv-koi:server:getitem", "water_bottle", 1)
	TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["water_bottle"], "add")
	end)

RegisterNetEvent("cv-koi:client:grabcoffee", function()
	TriggerServerEvent("cv-koi:server:getitem", "coffee", 1)
	TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["coffee"], "add")
	end)

RegisterNetEvent('cv-koi:client:opentable', function()
		TriggerServerEvent("inventory:server:OpenInventory", "stash", "table 1")
		TriggerEvent("inventory:client:SetCurrentStash", "table 1")
		end)

RegisterNetEvent('cv-koi:client:opentable2', function()
		TriggerServerEvent("inventory:server:OpenInventory", "stash", "table 2")
		TriggerEvent("inventory:client:SetCurrentStash", "table 2")
		end)
		
RegisterNetEvent('cv-koi:client:opentable3', function()
		TriggerServerEvent("inventory:server:OpenInventory", "stash", "table 3")
		TriggerEvent("inventory:client:SetCurrentStash", "table 3")
		end)	

RegisterNetEvent("cv-koi:client:givetablet", function()
	if CheckOnDuty() then
	TriggerServerEvent("cv-koi:server:getitem", "paymenttablet", 1)
	TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["paymenttablet"], "add")
else
	QBCore.Functions.Notify("You are not on duty", "error")
	end
end)




    
---- Target ----    

Citizen.CreateThread(function()
	while true do
	Citizen.Wait(1000)
exports['qb-target']:AddBoxZone("peeone", vector3(-1047.9, -1493.1, 2.78), 1, 1, {
	name = "peeone",
	heading = 35.0,
	debugPoly = false,
	minZ = 1.78,
	maxZ = 3.78,
}, {
	options = {
		{
            type = "client",
            event = "cv-koi:client:toiletpee",
			icon = "fa-solid fa-toilet",
			label = "Pee",
		},
	},
	distance = 2.5
})
end
end)

Citizen.CreateThread(function()
	while true do
	Citizen.Wait(1000)
exports['qb-target']:AddBoxZone("peetwo", vector3(-1048.8, -1491.84, 2.78), 1, 1, {
	name = "peetwo",
	heading = 35.0,
	debugPoly = false,
	minZ = 1.78,
	maxZ = 3.78,
}, {
	options = {
		{
            type = "client",
            event = "cv-koi:client:toiletpee",
			icon = "fa-solid fa-toilet",
			label = "Pee",
		},
	},
	distance = 2.5
})
end
end)

Citizen.CreateThread(function()
	while true do
	Citizen.Wait(1000)
exports['qb-target']:AddBoxZone("peethree", vector3(-1054.16, -1434.71, -1.42), 1, 1, {
	name = "peethree",
	heading = 35.0,
	debugPoly = false,
	minZ = -2.42,
	maxZ = 0.42,
}, {
	options = {
		{
            type = "client",
            event = "cv-koi:client:toiletpee",
			icon = "fa-solid fa-toilet",
			label = "Pee",
		},
	},
	distance = 2.5
})
end
end)

Citizen.CreateThread(function()
	while true do
	Citizen.Wait(1000)
exports['qb-target']:AddBoxZone("washhands", vector3(-1043.34, -1491.95, 2.78), 2, 2, {
	name = "washhands",
	heading = 35.0,
	debugPoly = false,
	minZ = 1.78,
	maxZ = 3.78,
}, {
	options = {
		{
            type = "client",
            event = "cv-koi:client:toiletwashhands",
			icon = "fas fa-hands-wash",
			label = "Wash hands",
		},
	},
	distance = 2.5
})
end
end)

Citizen.CreateThread(function()
	while true do
	Citizen.Wait(1000)
exports['qb-target']:AddBoxZone("washhandstwo", vector3(-1057.14, -1436.86, -1.42), 1, 1, {
	name = "washhandstwo",
	heading = 0.0,
	debugPoly = false,
	minZ = -2.42,
	maxZ = 0.42,
}, {
	options = {
		{
            type = "client",
            event = "cv-koi:client:toiletwashhands",
			icon = "fas fa-hands-wash",
			label = "Wash hands",
		},
	},
	distance = 2.5
})
end
end)

Citizen.CreateThread(function()
	while true do
	Citizen.Wait(1000)
exports['qb-target']:AddBoxZone("PlayerJob.onduty", vector3(-1060.95, -1443.94, -1.42), 0.5, 0.5, {
	name = "PlayerJob.onduty",
	heading = 0.0,
	debugPoly = false,
	minZ = -2.42,
	maxZ = 0.42,
}, {
	options = {
		{
            type = "server",
            event = "QBCore:ToggleDuty",
			icon = "fa-solid fa-clock",
			label = "On/Off duty",
            job = "koi"
		},
		{
            type = "client",
            event = "cv-koi:client:givetablet",
			icon = "fa-solid fa-tablet",
			label = "Tablet",
            job = "koi"
		},
	},
	distance = 1.0
})
end
end)

Citizen.CreateThread(function()
	while true do
	Citizen.Wait(1000)
exports['qb-target']:AddBoxZone("clothes", vector3(-1060.22, -1433.25, -1.42), 2, 2, {
	name = "clothes",
	heading = 0.0,
	debugPoly = false,
	minZ = -2.42,
	maxZ = 0.42,
}, {
	options = {
		{
            type = "client",
            event = "qb-clothing:client:openMenu",
			icon = "fa-solid fa-shirt",
			label = "Clothing",
            job = "koi"
		},
	},
	distance = 1.0
})
end
end)

Citizen.CreateThread(function()
	while true do
	Citizen.Wait(1000)
exports['qb-target']:AddBoxZone("storeage", vector3(-1076.83, -1441.45, -1.31), 2, 2, {
	name = "storeage",
	heading = 0.0,
	debugPoly = false,
	minZ = -2.31,
	maxZ = 0.31,
}, {
	options = {
		{
            type = "client",
            event = "cv-koi:client:storage",
			icon = "fas fa-box",
			label = "Refrigerator",
            job = "koi"
		},
	},
	distance = 1.0
})
end
end)

Citizen.CreateThread(function()
	while true do
	Citizen.Wait(1000)
exports['qb-target']:AddBoxZone("stash", vector3(-1067.33, -1445.27, -1.42), 2, 2, {
	name = "stash",
	heading = 0.0,
	debugPoly = false,
	minZ = -2.42,
	maxZ = 0.42,
}, {
	options = {
		{
            type = "client",
            event = "cv-koi:client:stash",
			icon = "fas fa-box",
			label = "Stash",
            job = "koi"
		},
	},
	distance = 1.0
})
end
end)

Citizen.CreateThread(function()
	while true do
	Citizen.Wait(1000)
exports['qb-target']:AddBoxZone("getknife", vector3(-1079.04, -1446.94, -1.42), 0.5, 0.5, {
	name = "getknife",
	heading = 0.0,
	debugPoly = false,
	minZ = -2.42,
	maxZ = 0.42,
}, {
	options = {
		{
            type = "client",
            event = "cv-koi:client:takeknife",
			icon = "fa-solid fa-utensils",
			label = "Get knife",
            job = "koi"
		},
	},
	distance = 1.0
})
end
end)

Citizen.CreateThread(function()
	while true do
	Citizen.Wait(1000)
exports['qb-target']:AddBoxZone("washknife", vector3(-1071.49, -1439.98, -1.42), 1, 1, {
	name = "washknife",
	heading = 0.0,
	debugPoly = false,
	minZ = -2.42,
	maxZ = 0.42,
}, {
	options = {
		{
            type = "client",
            event = "cv-koi:client:washknife",
			icon = "fa-solid fa-sink",
			label = "Wash knife",
            job = "koi"
		},
	},
	distance = 1.0
})
end
end)

Citizen.CreateThread(function()
	while true do
	Citizen.Wait(1000)
exports['qb-target']:AddBoxZone("cookstake", vector3(-1074.29, -1445.05, -1.42), 1, 1.5, {
	name = "cookstake",
	heading = 0.0,
	debugPoly = false,
	minZ = -2.42,
	maxZ = 0.42,
}, {
	options = {
		{
            type = "client",
            event = "cv-koi:client:cookstake",
			icon = "fa-brands fa-gripfire",
			label = "Cook wagyu",
            job = "koi"
		},
	},
	distance = 1.0
})
end
end)


Citizen.CreateThread(function()
	while true do
	Citizen.Wait(1000)
exports['qb-target']:AddBoxZone("cookeggs", vector3(-1072.17, -1443.8, -1.42), 1.5, 1, {
	name = "cookeggs",
	heading = 125.0,
	debugPoly = false,
	minZ = -2.42,
	maxZ = 0.42,
}, {
	options = {
		{
            type = "client",
            event = "cv-koi:client:cookeggs",
			icon = "fa-brands fa-gripfire",
			label = "Cook eggs",
            job = "koi"
		},
	},
	distance = 1.0
})
end
end)

Citizen.CreateThread(function()
	while true do
	Citizen.Wait(1000)
exports['qb-target']:AddBoxZone("sushi", vector3(-1075.12, -1446.22, -1.42), 2, 0.5, {
	name = "sushi",
	heading = 125.0,
	debugPoly = false,
	minZ = -2.42,
	maxZ = 0.42,
}, {
	options = {
		{
            type = "client",
            event = "cv-koi:client:opensushimenu",
			icon = "fa-solid fa-fish",
			label = "Make sushi",
            job = "koi"
		},
	},
	distance = 1.0
})
end
end)

Citizen.CreateThread(function()
	while true do
	Citizen.Wait(1000)
exports['qb-target']:AddBoxZone("filletfish", vector3(-1078.7, -1444.96, -1.42), 1, 1.5, {
	name = "filletfish",
	heading = 125.0,
	debugPoly = false,
	minZ = -2.42,
	maxZ = 0.42,
}, {
	options = {
		{
            type = "client",
            event = "cv-koi:client:filletfish",
			icon = "fa-solid fa-fish",
			label = "Fillet fish",
            job = "koi"
		},
	},
	distance = 1.0
})
end
end)

Citizen.CreateThread(function()
	while true do
	Citizen.Wait(1000)
exports['qb-target']:AddBoxZone("frychicken", vector3(-1071.56, -1444.59, -1.42), 1.5, 1, {
	name = "frychicken",
	heading = 125.0,
	debugPoly = false,
	minZ = -2.42,
	maxZ = 0.42,
}, {
	options = {
		{
            type = "client",
            event = "cv-koi:client:frychicken",
			icon = "fa-solid fa-drumstick-bite",
			label = "Fry chicken",
            job = "koi"
		},
	},
	distance = 1.0
})
end
end)


Citizen.CreateThread(function()
	while true do
	Citizen.Wait(1000)
exports['qb-target']:AddBoxZone("robkoi", vector3(-1054.99, -1438.25, -1.38), 0.9, 0.9, {
	name = "robkoi",
	heading = 125.0,
	debugPoly = false,
	minZ = -2.42,
	maxZ = 0.42,
}, {
	options = {
		{
            type = "client",
            event = "cv-koi:client:takejobmoney",
			icon = "fa-solid fa-vault",
			label = "Open safe",
		},
		{
            type = "client",
            event = "cv-koi:client:cracksafe",
			icon = "fa-solid fa-vault",
			label = "Crack safe",
		},
	},
	distance = 3.0
})
end
end)

Citizen.CreateThread(function()
	while true do
	Citizen.Wait(1000)
exports['qb-target']:AddBoxZone("koidrink", vector3(-1074.16, -1449.21, -1.42), 1, 4, {
	name = "koidrink",
	heading = 125.0,
	debugPoly = false,
	minZ = -2.42,
	maxZ = 0.42,
}, {
	options = {
		{
            type = "client",
            event = "cv-koi:client:opendrinkmenu",
			icon = "fa-solid fa-martini-glass-citrus",
			label = "Grab drink",
		},
	},
	distance = 1.0
})
end
end)

Citizen.CreateThread(function()
	while true do
	Citizen.Wait(1000)
exports['qb-target']:AddCircleZone("koitable", vector3(-1060.65, -1465.36, -1.02), 1.0, {
	name = "koitable",
	heading = 125.0,
	debugPoly = false,
	minZ = -2.42,
	maxZ = 0.42,
}, {
	options = {
		{
            type = "client",
            event = "cv-koi:client:opentable",
			icon = "fa-solid fa-table",
			label = "Open table",
		},
	},
	distance = 1.0
})
end
end)

Citizen.CreateThread(function()
	while true do
	Citizen.Wait(1000)
exports['qb-target']:AddCircleZone("koitable2", vector3(-1061.96, -1460.72, -1.02), 1.0, {
	name = "koitable2",
	heading = 125.0,
	debugPoly = false,
	minZ = -2.42,
	maxZ = 0.42,
}, {
	options = {
		{
            type = "client",
            event = "cv-koi:client:opentable2",
			icon = "fa-solid fa-table",
			label = "Open table",
		},
	},
	distance = 1.0
})
end
end)

Citizen.CreateThread(function()
	while true do
	Citizen.Wait(1000)
exports['qb-target']:AddCircleZone("koitable3", vector3(-1057.03, -1461.84, -1.02), 1.0, {
	name = "koitable3",
	heading = 125.0,
	debugPoly = false,
	minZ = -2.42,
	maxZ = 0.42,
}, {
	options = {
		{
            type = "client",
            event = "cv-koi:client:opentable3",
			icon = "fa-solid fa-table",
			label = "Open table",
		},
	},
	distance = 1.0
})
end
end)
