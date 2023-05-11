
local QBCore = exports["qb-core"]:GetCoreObject()



---- locals ----

local animDictEat = "mp_player_inteat@burger"
local animationEat = "mp_player_int_eat_burger"
local animLengthEat = GetAnimDuration(animDictEat, animationEat)

local animDictDrink = "mp_player_inteat@pnq"
local animationDrink = "loop"
local animLengthDrink = GetAnimDuration(animDictDrink, animationDrink)

---- functions ----

function LoadPropDict(model)
    while not HasModelLoaded(GetHashKey(model)) do
      RequestModel(GetHashKey(model))
      Wait(10)
    end
  end

function AddPropToPlayer(prop1, bone, off1, off2, off3, rot1, rot2, rot3)
    local Player = PlayerPedId()
    local x,y,z = table.unpack(GetEntityCoords(Player))
  
    if not HasModelLoaded(prop1) then
      LoadPropDict(prop1)
    end
  
    prop = CreateObject(GetHashKey(prop1), x, y, z+0.2,  true,  true, true)
    AttachEntityToEntity(prop, Player, GetPedBoneIndex(Player, bone), off1, off2, off3, rot1, rot2, rot3, true, true, false, true, 1, true)
    PlayerHasProp = true
    SetModelAsNoLongerNeeded(prop1)
  end

  local function loadAnimDict(dict)
    if HasAnimDictLoaded(dict) then return end
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
    end
end



---- Events ----
RegisterNetEvent('cv-koi:consumables:client:Eat', function(itemName)
	loadAnimDict(animDictEat) 
	if itemName == "cookedwagyu" then
	AddPropToPlayer("prop_cs_steak", 18905, 0.13,  0.05, 0.02, -50.0,  16.0, 60.0)
	TaskPlayAnim(PlayerPedId(), animDictEat, animationEat, 1.0, 4.0, animLengthEat, 49, 0, 0, 0, 0)
    elseif itemName == "fries" then
	AddPropToPlayer("prop_food_chips", 18905, 0.13,  0.05, 0.02, -50.0,  16.0, 60.0)
	TaskPlayAnim(PlayerPedId(), animDictEat, animationEat, 1.0, 4.0, animLengthEat, 49, 0, 0, 0, 0)
    elseif itemName == "rice" then
	AddPropToPlayer("prop_cs_bowl_01b", 18905, 0.13,  0.05, 0.02, -50.0,  16.0, 60.0)
	TaskPlayAnim(PlayerPedId(), animDictEat, animationEat, 1.0, 4.0, animLengthEat, 49, 0, 0, 0, 0)
    elseif itemName == "cookedeggs" then
	AddPropToPlayer("prop_cs_burger_01", 18905, 0.13,  0.05, 0.02, -50.0,  16.0, 60.0)
	TaskPlayAnim(PlayerPedId(), animDictEat, animationEat, 1.0, 4.0, animLengthEat, 49, 0, 0, 0, 0)
	elseif itemName == "frychicken" then
	AddPropToPlayer("prop_cs_burger_01", 18905, 0.13,  0.05, 0.02, -50.0,  16.0, 60.0)
	TaskPlayAnim(PlayerPedId(), animDictEat, animationEat, 1.0, 4.0, animLengthEat, 49, 0, 0, 0, 0)
	elseif itemName == "sushiwithmayospicy" or "sushi" or "sushiwithavocado" or "sushiwithteriyaki" then
	AddPropToPlayer("sushi_board", 18905, 0.13,  0.05, 0.02, -50.0,  16.0, 60.0)
	TaskPlayAnim(PlayerPedId(), animDictEat, animationEat, 1.0, 4.0, animLengthEat, 49, 0, 0, 0, 0)
	end
	QBCore.Functions.Progressbar("eat_something", ('Eating'), 5000, false, true, {
		disableMovement = false,
		disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function() -- Done
		TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[itemName], "remove")
		ClearPedTasks(PlayerPedId())
		DeleteObject(prop)
		TriggerServerEvent("consumables:server:addHunger", QBCore.Functions.GetPlayerData().metadata["hunger"] + Config.ConsumablesEat[itemName])
		TriggerServerEvent('hud:server:RelieveStress', math.random(2, 4))
	end, function() -- Cancel
		DeleteObject(prop)
		ClearPedTasks(PlayerPedId())
		QBCore.Functions.Notify("Cancel", "error")
	end)
end)

RegisterNetEvent('cv-koi:consumables:client:Drink', function(itemName)
	loadAnimDict(animDictDrink) 
	if itemName == "water_bottle" then
	AddPropToPlayer("prop_ld_flow_bottle", 18905, 0.12,0.008,0.03,240.0,-60.0)
	TaskPlayAnim(PlayerPedId(), animDictDrink, animationDrink, 1.0, 4.0, animLengthDrink, 49, 0, 0, 0, 0)
    elseif itemName == "kurkakola" then
	AddPropToPlayer("prop_ecola_can", 18905, 0.12,0.008,0.03,240.0,-60.0)
	TaskPlayAnim(PlayerPedId(), animDictDrink, animationDrink, 1.0, 4.0, animLengthDrink, 49, 0, 0, 0, 0)
    elseif itemName == "coffee" then
	AddPropToPlayer("p_amb_coffeecup_01", 18905, 0.12,0.008,0.03,240.0,-60.0)
	TaskPlayAnim(PlayerPedId(), animDictDrink, animationDrink, 1.0, 4.0, animLengthDrink, 49, 0, 0, 0, 0)
	end
	QBCore.Functions.Progressbar("drink_something", ('Drinking'), 5000, false, true, {
		disableMovement = false,
		disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function() -- Done
		TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[itemName], "remove")
		ClearPedTasks(PlayerPedId())
		TriggerServerEvent("consumables:server:addThirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + Config.ConsumablesDrink[itemName])
		DeleteObject(prop)
	end, function() -- Cancel
		DeleteObject(prop)
		ClearPedTasks(PlayerPedId())
		QBCore.Functions.Notify("Cancel", "error")
	end)
end)