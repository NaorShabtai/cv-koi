
local QBCore = exports["qb-core"]:GetCoreObject()



---- locals ----

local isOpen = false
local tabletObj = nil
local tabletDict = "amb@code_human_in_bus_passenger_idles@female@tablet@base"
local tabletAnim = "base"
local tabletProp = "prop_cs_tablet"
local tabletBone = 60309
local tabletOffset = vector3(0.03, 0.002, -0.0)
local tabletRot = vector3(10.0, 160.0, 0.0)


---- functions ----

local function CheckOnDuty()
	if Config.OnDutyOnly then
	return QBCore.Functions.GetPlayerData().job.onduty
	end
	return true
end

local function doAnimation()
    if not isOpen then return end
    -- Animation
    RequestAnimDict(tabletDict)
    while not HasAnimDictLoaded(tabletDict) do Citizen.Wait(100) end
    -- Model
    RequestModel(tabletProp)
    while not HasModelLoaded(tabletProp) do Citizen.Wait(100) end

    local plyPed = PlayerPedId()
    tabletObj = CreateObject(tabletProp, 0.0, 0.0, 0.0, true, true, false)
    local tabletBoneIndex = GetPedBoneIndex(plyPed, tabletBone)

    AttachEntityToEntity(tabletObj, plyPed, tabletBoneIndex, tabletOffset.x, tabletOffset.y, tabletOffset.z, tabletRot.x, tabletRot.y, tabletRot.z, true, false, false, false, 2, true)
    SetModelAsNoLongerNeeded(tabletProp)

    CreateThread(function()
        while isOpen do
            Wait(0)
            if not IsEntityPlayingAnim(plyPed, tabletDict, tabletAnim, 3) then
                TaskPlayAnim(plyPed, tabletDict, tabletAnim, 3.0, 3.0, -1, 49, 0, 0, 0, 0)
            end
        end


        ClearPedSecondaryTask(plyPed)
        Citizen.Wait(250)
        DetachEntity(tabletObj, true, false)
        DeleteEntity(tabletObj)
    end)
end


---- Events ----
RegisterNetEvent('cv-koi:client:payment')
AddEventHandler('cv-koi:client:payment', function()
    if CheckOnDuty() then
    isOpen = true
    doAnimation()
    payment = exports['qb-input']:ShowInput({
        header = "Payment",
        submitText = "Bill",
        inputs = {
            {
                text = "Citizen ID (#ID)", -- text you want to be displayed as a place holder
                name = "citizenid", -- name of the input should be unique otherwise it might override
                type = "number", -- type of the input
                isRequired = true, -- Optional [accepted values: true | false] but will submit the form if no value is inputted
            },
            {
                text = "Bill Price ($)", -- text you want to be displayed as a place holder
                name = "billprice", -- name of the input should be unique otherwise it might override
                type = "number", -- type of the input - number will not allow non-number characters in the field so only accepts 0-9
                isRequired = false, -- Optional [accepted values: true | false] but will submit the form if no value is inputted
            },
            {
                text = "Bill Type", -- text you want to be displayed as a input header
                name = "billtype", -- name of the input should be unique otherwise it might override
                type = "radio", -- type of the input - Radio is useful for "or" options e.g; billtype = Cash OR Bill OR bank
                options = { -- The options (in this case for a radio) you want displayed, more than 6 is not recommended
                    { value = "cash", text = "Cash" }, -- Options MUST include a value and a text option
                    { value = "bank", text = "Bank" }  -- Options MUST include a value and a text option
                },
            }
        },
    })
    TriggerServerEvent("cv-koi:server:pay", payment)
    isOpen = false
else
    QBCore.Functions.Notify("You are not on duty", "error")
   end
end)

