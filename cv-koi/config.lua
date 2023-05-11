Config = {}

Config.job = "koi" -- job

Config.robkoi = true -- if pepole can ron KOI

Config.psdispatch = true -- true = show ps dispatch | false = disable ps dispatch (no dispatch showing)

Config.OnDutyOnly = true -- if pepole need to be on duty

Config.uses = 5 --  how many uses to knife gets dirty

Config.safecode = "5555" -- safe code for open the safe(works only if robkoi = true)

Config.paymenttabletitem = "paymenttablet"

Config.Safeobject = {
    [1] = {
        ['model'] = "prop_ld_int_safe_01", -- Model To Spawn
        ['coords'] = vector4(-1054.96, -1438.36, -1.55, 179.54),
        ['heading'] = 359.59,
    }, 
}

Config.Locations = {
    ["restaurants"] = {
        [1] = {label = "KOI", blip = 93, scale = 0.8, color = 2, coords = vector4(-1043.1500, -1471.7100, 5.0582, 212.31)},
    },
}

Config.ConsumablesEat = {

    ["fries"] = math.random(35, 54),
    ["sushi"] = math.random(40, 50),
    ["sushiwithavocado"] = math.random(35, 54),
    ["sushiwithmayospicy"] = math.random(40, 50),
    ["sushiwithteriyaki"] = math.random(40, 50),
    ["cookedeggs"] = math.random(35, 54),
    ["cookedwagyu"] = math.random(40, 50),
    ["rice"] = math.random(35, 54),
    ["frychicken"] = math.random(40, 50),
}

Config.ConsumablesDrink = {
    ["water_bottle"] = math.random(35, 54),
    ["kurkakola"] = math.random(35, 54),
    ["coffee"] = math.random(40, 50),
}

Config.Items = {
    label = "KOI Refrigerator",
    slots = 31,
    items = {
        [1] = {
            name = "fish",
            price = 0,
            amount = 100,
            type = "item",
            slot = 1,
        },
        [2] = {
            name = "salmon",
            price = 0,
            amount = 100,
            type = "item",
            slot = 2,
        },
        [3] = {
            name = "rawchicken",
            price = 0,
            amount = 100,
            type = "item",
            slot = 3,
        },
        [4] = {
            name = "fries",
            price = 0,
            amount = 100,
            info = {},
            type = "item",
            slot = 4,
        },
        [5] = {
            name = "mayospicy",
            price = 0,
            amount = 100,
            type = "item",
            slot = 5,
        },
        [6] = {
            name = "teriyaki",
            price = 0,
            amount = 100,
            type = "item",
            slot = 6,
        },
        [7] = {
            name = "wagyuburger",
            price = 0,
            amount = 100,
            info = {},
            type = "item",
            slot = 7,
        },
        [8] = {
            name = "eggs",
            price = 0,
            amount = 100,
            info = {},
            type = "item",
            slot = 8,
        },
        [9] = {
            name = "rice",
            price = 0,
            amount = 100,
            info = {},
            type = "item",
            slot = 9,
        },
        [10] = {
            name = "avocado",
            price = 0,
            amount = 100,
            info = {},
            type = "item",
            slot = 10,
        },
        [11] = {
            name = "seaweed",
            price = 0,
            amount = 10,
            info = {},
            type = "item",
            slot = 11,
        },
    }
}

