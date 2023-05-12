Hello this is naor form CoreVersion

Thank you for downloading the script and supporting us 

The items you need to the script work 100%

qb-core > shared > items.lua

```lua
    -- KOI Food
['fish'] 				 	 = {['name'] = 'fish', 			  	  		['label'] = 'Raw Fish', 				['weight'] = 2200, 		['type'] = 'item', 		['image'] = 'rawfish.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Ching Chang Raw fish'},
['cuttedfish'] 				 	 = {['name'] = 'cuttedfish', 			  	  		['label'] = 'Cutted Fish', 				['weight'] = 2200, 		['type'] = 'item', 		['image'] = 'cuttedfish.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Ching Chang Cutted Fish'},
['salmon'] 				 	 = {['name'] = 'salmon', 			  	  		['label'] = 'Salmon', 				['weight'] = 2200, 		['type'] = 'item', 		['image'] = 'salmon.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Ching Chang salmon'},
['rawchicken'] 				 	 = {['name'] = 'rawchicken', 			  	  		['label'] = 'Raw Chicken', 				['weight'] = 2200, 		['type'] = 'item', 		['image'] = 'rawhicken.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Ching Chang Raw Chicken'},
['fries'] 				 	 = {['name'] = 'fries', 			  	  		['label'] = 'Fries', 				['weight'] = 2200, 		['type'] = 'item', 		['image'] = 'fries.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Ching Chang Fries'},
['sushi'] 				 	 = {['name'] = 'sushi', 			  	  		['label'] = 'Sushi', 				['weight'] = 2200, 		['type'] = 'item', 		['image'] = 'sushi.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil, ['description'] = 'Ching Chang Sushi'},
['sushiwithavocado'] 				 	 = {['name'] = 'sushiwithavocado', 			  	  		['label'] = 'Sushi with avocado', 				['weight'] = 2200, 		['type'] = 'item', 		['image'] = 'sushi.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Ching Chang Sushi with avocado'},
['sushiwithmayospicy'] 				 	 = {['name'] = 'sushiwithmayospicy', 			  	  		['label'] = 'Sushi with mayo spicy', 				['weight'] = 2200, 		['type'] = 'item', 		['image'] = 'sushi.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Sushi with mayo spicy'},
['sushiwithteriyaki'] 				 	 = {['name'] = 'sushiwithteriyaki', 			  	  		['label'] = 'Sushi with Teriyaki', 				['weight'] = 2200, 		['type'] = 'item', 		['image'] = 'sushi.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Sushi with Teriyaki'},
['mayospicy'] 				 	 = {['name'] = 'mayospicy', 			  	  		['label'] = 'mayo spicy', 				['weight'] = 2200, 		['type'] = 'item', 		['image'] = 'mayospicy.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = {accept = {'sushi', 'sushiwithavocado'}, reward = 'sushiwithmayospicy',   anim = {['dict'] = 'anim@amb@business@weed@weed_inspecting_high_dry@', ['lib'] = 'weed_inspecting_high_base_inspector', ['text'] = 'Mix sushi', ['timeOut'] = 5000}},   ['description'] = 'mayo spicy'},
['teriyaki'] 				 	 = {['name'] = 'teriyaki', 			  	  		['label'] = 'Teriyaki', 				['weight'] = 2200, 		['type'] = 'item', 		['image'] = 'teriyaki.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = {accept = {'sushi', 'sushiwithavocado'}, reward = 'sushiwithteriyaki',   anim = {['dict'] = 'anim@amb@business@weed@weed_inspecting_high_dry@', ['lib'] = 'weed_inspecting_high_base_inspector', ['text'] = 'Mix sushi', ['timeOut'] = 5000}},   ['description'] = 'Teriyaki'},
['wagyuburger'] 				 	 = {['name'] = 'wagyuburger', 			  	  		['label'] = 'Wagyu meat', 				['weight'] = 2200, 		['type'] = 'item', 	['image'] = 'wagyuburger.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'wagyu burger'},
['eggs'] 				 	 = {['name'] = 'eggs', 			  	  		['label'] = 'eggs', 				['weight'] = 2200, 		['type'] = 'item', 		['image'] = 'eggs.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'eggs'},
['cookedeggs'] 				 	 = {['name'] = 'cookedeggs', 			  	  		['label'] = 'cooked eggs', 				['weight'] = 2200, 		['type'] = 'item', 		['image'] = 'cookedeggs.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'cooked eggs'},
["chefknife"]                          = {["name"] = "chefknife",                           ["label"] = "Chef knife",                     ["weight"] = 7000,         ["type"] = "item",   ["image"] = "chefknife.png",                 ["unique"] = true,         ["useable"] = false,     ["combinable"] = nil, ["description"] = "Chef knife", ["created"] = nil, ["decay"] = 18.0},
["dirtyknife"]           = {["name"] = "dirtyknife",             ["label"] = "Dirty Knife",             ["weight"] = 2200,     ["type"] = "item",      ["image"] = "dirtyknife.png",         ["unique"] = true,         ["useable"] = true,     ["combinable"] = nil, ["description"] = "Dirty chef knife", ["created"] = nil, ["decay"] = 18.0},
["cookedwagyu"]           = {["name"] = "cookedwagyu",             ["label"] = "Cocked Wagyu",             ["weight"] = 2200,     ["type"] = "item",      ["image"] = "cookedwagyu.png",         ["unique"] = true,         ["useable"] = true,     ["combinable"] = nil, ["description"] = "Cocked wagyu", ["created"] = nil, ["decay"] = 18.0},
["rice"]           = {["name"] = "rice",             ["label"] = "Rice",             ["weight"] = 2200,     ["type"] = "item",      ["image"] = "rice.png",         ["unique"] = true,         ["useable"] = false,     ["combinable"] = nil, ["description"] = "Rice", ["created"] = nil, ["decay"] = 18.0},
["avocado"]           = {["name"] = "avocado",             ["label"] = "Avocado",             ["weight"] = 2200,     ["type"] = "item",      ["image"] = "avocado.png",         ["unique"] = true,         ["useable"] = true,     ["combinable"] = nil, ["description"] = "Cocked wagyu", ["created"] = nil, ["decay"] = 18.0},
["seaweed"]           = {["name"] = "seaweed",             ["label"] = "Nori seaweed",             ["weight"] = 2200,     ["type"] = "item",      ["image"] = "seaweed.png",         ["unique"] = true,         ["useable"] = true,     ["combinable"] = nil, ["description"] = "Cocked wagyu", ["created"] = nil, ["decay"] = 18.0},
["frychicken"]           = {["name"] = "frychicken",             ["label"] = "Chili Chicken",             ["weight"] = 2200,     ["type"] = "item",      ["image"] = "chicken.png",         ["unique"] = true,         ["useable"] = true,     ["combinable"] = nil, ["description"] = "Chili Chicken", ["created"] = nil, ["decay"] = 18.0},
    -- KOI Drink ITEMS
['water_bottle']                    = {['name'] = 'water_bottle',                      ['label'] = 'Bottle of Water',           ['weight'] = 500,          ['type'] = 'item',         ['image'] = 'water_bottle.png',            ['unique'] = false,         ['useable'] = true,     ['shouldClose'] = true,       ['combinable'] = nil,   ['description'] = 'For all the thirsty out there'},
['coffee']                          = {['name'] = 'coffee',                            ['label'] = 'Coffee',                    ['weight'] = 200,          ['type'] = 'item',         ['image'] = 'coffee.png',                  ['unique'] = false,         ['useable'] = true,     ['shouldClose'] = true,       ['combinable'] = nil,   ['description'] = 'Pump 4 Caffeine'},
['kurkakola']                       = {['name'] = 'kurkakola',                         ['label'] = 'Cola',                      ['weight'] = 500,          ['type'] = 'item',         ['image'] = 'cola.png',                    ['unique'] = false,         ['useable'] = true,     ['shouldClose'] = true,       ['combinable'] = nil,   ['description'] = 'For all the thirsty out there'},
    -- KOI payment
['paymenttablet']                          = {['name'] = 'paymenttablet',                            ['label'] = 'KOI Tablet',                    ['weight'] = 2000,         ['type'] = 'item',         ['image'] = 'tablet.png',                  ['unique'] = false,         ['useable'] = true,     ['shouldClose'] = true,      ['combinable'] = nil,   ['description'] = 'Expensive tablet'},
```
qb-core > shared > jobs.lua

```lua
    ["koi"] = {
        label = "KOI Restaurant",
        offDutyPay = true,
        defaultDuty = false,
        grades = {
            ['0'] = {
                name = 'Employee',
                payment = 30,
            },
            ['1'] = {
                name = 'Vice Manager',
                payment = 70,
            },
            ['2'] = {
                name = 'Manager',
                isboss = true,
                payment = 130,
            },
        },
    },
```

for the qb-management work go to:

qb-management > client > cl_config.lua

and put this:

```lua
    ['koi'] = {
        vector3(-1054.34, -1440.89, -1.38),
    },
```

for the ps-dispatch work go to:

ps-dispatch > client > cl_extraalerts

and put this:

```lua
---------------------------
---- cv-koi -------
---------------------------

local function Sussafe()
    local currentPos = GetEntityCoords(PlayerPedId())
    local locationInfo = getStreetandZone(currentPos)
    local gender = GetPedGender()
    TriggerServerEvent("dispatch:server:notify", {
        dispatchcodename = "sussafe", -- has to match the codes in sv_dispatchcodes.lua so that it generates the right blip
        dispatchCode = "10-90",
        firstStreet = locationInfo,
        gender = gender,
        camId = camId,
        model = nil,
        plate = nil,
        priority = 2, -- priority
        firstColor = nil,
        automaticGunfire = false,
        origin = {
            x = currentPos.x,
            y = currentPos.y,
            z = currentPos.z
        },
        dispatchMessage = ('Safe crack on KOI'), -- message
        job = {"LEO", "police"} -- type or jobs that will get the alerts
    })
end

exports('Sussafe', Sussafe)
```

then go to ps-dispatch > server > sv_dispatchcodes

and put this:

```lua
	["sussafe"] =  {displayCode = '10-90', description = "Safe crack on KOI", radius = 0, recipientList = {'LEO', 'police'}, blipSprite = 814, blipColour = 5, blipScale = 1.5, blipLength = 2, sound = "robberysound", offset = "false", blipflash = "false"},
```

You need:
qb-target [https://github.com/qbcore-framework/qb-target]

qb-input  [https://github.com/qbcore-framework/qb-input]

qb-core   [https://github.com/qbcore-framework/qb-core]

qb-menu   [https://github.com/qbcore-framework/qb-menu]

qb-management [https://github.com/qbcore-framework/qb-management]

pd-safe   [https://github.com/VHall1/pd-safe]

ps-dispatch [https://github.com/Project-Sloth/ps-dispatch]

The images in the folder "stuff you need for the script to work 100%"

qb-inventory > html > images

and put the images

Have fun :()

CoreVersion discord link: [https://discord.gg/VmPWhNWv8k]

Preview:

![image](https://github.com/CoreVersion/cv-koi/assets/111662813/026698e1-cb3c-4b75-8cdd-571851601032)

![image](https://github.com/CoreVersion/cv-koi/assets/111662813/eb70f00e-d93b-4c98-bb94-6d6eff7e34fd)

![image](https://github.com/CoreVersion/cv-koi/assets/111662813/62f27d36-433a-4796-b400-fce7a191380c)

![image](https://github.com/CoreVersion/cv-koi/assets/111662813/4d54afaf-015a-4db8-b3d8-2f91338191f3)

![image](https://github.com/CoreVersion/cv-koi/assets/111662813/1f0e21b7-ee01-4c1e-889b-3a4523cb62c6)

![image](https://github.com/CoreVersion/cv-koi/assets/111662813/c867295d-bdda-4e3e-b5ca-43e35263491f)

![image](https://github.com/CoreVersion/cv-koi/assets/111662813/9fde8477-c754-4da3-820c-ca0bc1f27886)

![image](https://github.com/CoreVersion/cv-koi/assets/111662813/0145f939-13e9-4646-ba44-41835529e910)

![image](https://github.com/CoreVersion/cv-koi/assets/111662813/ca1e0264-4cd6-4d93-bb71-f43aee6e4f6e)

![image](https://github.com/CoreVersion/cv-koi/assets/111662813/fb770ea0-4054-4639-8af6-65caba078e7b)

![image](https://github.com/CoreVersion/cv-koi/assets/111662813/2f3e5765-abb2-45ff-9e65-1e4c5903b2a7)

![image](https://github.com/CoreVersion/cv-koi/assets/111662813/fa5dc39c-3062-4e34-86dc-ea9383a235fb)

![image](https://github.com/CoreVersion/cv-koi/assets/111662813/68660986-e80b-4f55-9ebc-f06e4a8b2f35)

![image](https://github.com/CoreVersion/cv-koi/assets/111662813/e973386e-1a54-44dc-b59d-9281facab47a)

![image](https://github.com/CoreVersion/cv-koi/assets/111662813/1b56f433-e341-43d1-b067-eb43c65d9c07)

![image](https://github.com/CoreVersion/cv-koi/assets/111662813/0ce3c8ac-437b-4221-a87d-5b01e19c0d40)

![image](https://github.com/CoreVersion/cv-koi/assets/111662813/10211a05-7849-4163-b406-3eb61e586ee3)

![image](https://github.com/CoreVersion/cv-koi/assets/111662813/298af76f-508d-4073-b792-26569b28b2f2)

![image](https://github.com/CoreVersion/cv-koi/assets/111662813/03179633-629a-400e-a9fb-20e0f381537c)

![image](https://github.com/CoreVersion/cv-koi/assets/111662813/c215a582-1120-4ce3-9d28-2a17e73484d3)


