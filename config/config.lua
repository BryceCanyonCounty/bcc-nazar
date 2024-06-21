Config = {}

-- Set Language
Config.defaultlang = 'en_lang'
-----------------------------------------------------

Config.keys = {
    collect = 0x760A9C6F, -- [G]
    nazar   = 0x760A9C6F, -- [G]
    chest   = 0x760A9C6F, -- [G]
}
-----------------------------------------------------
Config.UseVORPMenu = true
-----------------------------------------------------
--will display when someone opens a chest who did it what items they got what chest etc
--this is what will display when someone sells or buys from nazar
Config.Webhook = ''  --webhooks place your webhook url between the two
Config.WebhookTitle = 'BCC-Nazar'
Config.WebhookAvatar = ''
-----------------------------------------------------

--This is the nazar configuration
Config.NazarSetup = {
    Model = 'cs_mp_travellingsaleswoman', -- model used for nazar
    Music = true, --if true nazars rdo music will play
    MusicVolume = 20, --audio level of the music 0-100
    nazarswagon = false, --if true this will spawn nazars wagon with nazar at the set coords. (The wagon can be hard to get set on the groun properly hence why this is optional, it will be tedious to get it set correctly, mainly will only work on perfectly flat ground)
    blip = true, --if true this will place a blip on nazar if not no blip will be there
    BlipHash = 2119977580, --blips hash
    BlipName = "Madam Nazar", --blips name
    BlipColor = "RED", -- Blip Colors Shown Below
    nazarspawn = { --You can add as many locations as you would like the script will randomly pick one each server restart!
        {
            nazarspawncoords = {x = -1047.19, y = 450.55, z = 56.81, h = 178.68}, --to get coords use xyz paste then manually add the heading to the table
            nazarwagonspawncoords = {x = -1043.98, y = 451.66, z = 56.71, h = 53.18} --where the wagon will spawn
        },
        {
            nazarspawncoords = {x = -1526.77, y = -312.55, z = 142.55, h = 12.82},
            nazarwagonspawncoords = {x = -1522.95, y = -311.68, z = 142.39, h = 282.76},
        },
    }, --where she will be
    hintCooldown = 300000, --this is the cooldown between hints
    randomQuotes = {
        [1] = "Your every move is watched! Avoid even the smallest misdemeanor!",
        [2] = "I see a lazy river. Flowing beside a scorched town.",
        [3] = "I see cliffs in a silent desert.",
        [4] = "I see a strange man in a tall hat... he frightens me.",
        [5] = "I smell lupins... so many lupins. They fill the valley floor!",
        [6] = "I see grizzled mountains and hungry eyes.",
        [7] = "I see an emerald covered in filth, lying on a beautiful plain.",
        [8] = "I hear birds, beautiful birds singing in a cage!",
        [9] = "I see great and furious judgment descending from the clouds to strike you down!",
        [10] = "I see a scorched land. A river; along a border that cannot be crossed.",
        [11] = "Have you seen... Gavin?",
        [12] = "I see beautiful trees in an arid land.",
        [13] = "I see a great stone window, looking down upon a cold river.",
        [14] = "I see trees! Such... tall... trees!",
        [15] = "I see numbers. One, two, three. I see numbers. Seven, six, four. I see numbers. Five, one, one, two.", 
        [16] = "I see wet ground, and figures in the dark. And the spirit of a lonely girl",
        [17] = "I see mists... and fog. I see thunder and lightning! I see a sky covered by clouds. I see... snow! I see... a bright sun in a clear sky.",
        [18] = "I see a ridge in the land… and a falconer… and a black smoke rising to the east.",
        [19] = "I see a man with red hair… And a red mark upon his face. He does not belong here.",
        [20] = "I see the ruins of a battle fought long ago.",
        [21] = "Remember, the stars favor those who leave no stone unturned.",
        [22] = "Take care... Your next drink will go to your head..."
    }
}
-----------------------------------------------------

--This is the treasure chest setup you can not add anymore sadly only configure the existing ones there are 20 in total and i can add more if enough people want more
Config.TreasureLocations = {
    {
        huntname = 'Grizzlies West', --the name that will show when buying a hint from nazar
        location = vector3(-960.33, 1630.17, 246.58), --the location of the chest
        hintcost = 5, --set to 0 if you dont want to charge the player for getting a hint
        Reward = { --this is the rewards -- you can add as many rewards per chest as you want use the existing rewards as a guide to add more
            {
                displayname = 'Diamond', --the name of the item that the notification will display
                name = 'diamond', --this has to be the database name of the item
                count = 1, --the amount of the item you want it to give
            },
            {
                displayname = 'Golden Nugget',
                name = 'gold_nugget',
                count = 2,
            },
            {
                displayname = 'Iron',
                name = 'iron',
                count = 5,
            },
        },
    },
    {
        huntname = 'Girzzlies east',
        location = vector3(-2728.65, -1464.78, 153.06),
        hintcost = 5,
        Reward = {
            {
                displayname = 'Diamond', --the name of the item that the notification will display
                name = 'book',
                count = 2,
            },
            {
                displayname = 'Diamond', --the name of the item that the notification will display
                name = 'rollingpaper',
                count = 5,
            },
            {
                displayname = 'Diamond', --the name of the item that the notification will display
                name = 'beer',
                count = 2,
            },
        },
    },
    {
        huntname = 'Big Valley',
        location = vector3(-2260.32, 115.96, 248.63),
        hintcost = 5,
        Reward = {
            {
                displayname = 'Diamond', --the name of the item that the notification will display
                name = 'stolenmerch',
                count = 2,
            },
            {
                displayname = 'Diamond', --the name of the item that the notification will display
                name = 'pipe',
                count = 1,
            },
        },
    },
    {
        huntname = 'Manzanita Post',
        location = vector3(-1814.82, -1546.38, 95.36),
        hintcost = 5,
        Reward = {
            {
                displayname = 'Diamond', --the name of the item that the notification will display
                name = 'lockpick',
                count = 1,
            },
            {
                displayname = 'Diamond', --the name of the item that the notification will display
                name = 'aligatorto',
                count = 4,
            },
            {
                displayname = 'Diamond', --the name of the item that the notification will display
                name = 'cigar',
                count = 2,
            },
        },
    },
    {
        huntname = 'Lake Don Julio',
        location = vector3(-3340.63, -3399.11, 31.46),
        hintcost = 5,
        Reward = {
            {
                displayname = 'Diamond', --the name of the item that the notification will display
                name = 'heroin',
                count = 2,
            },
            {
                displayname = 'Diamond', --the name of the item that the notification will display
                name = 'book',
                count = 1,
            },
            {
                displayname = 'Diamond', --the name of the item that the notification will display
                name = 'lockpick',
                count = 1,
            },
            {
                displayname = 'Diamond', --the name of the item that the notification will display
                name = 'gold_nugget',
                count = 2,
            },
        },
    },
    {
        huntname = 'Glacier',
        location = vector3(-1495.65, 3129.55, 492.6),
        hintcost = 10,
        Reward = {
            {
                displayname = 'Diamond', --the name of the item that the notification will display
                name = 'goldbar',
                count = 1,
            },
            {
                displayname = 'Diamond', --the name of the item that the notification will display
                name = 'lockpick',
                count = 1,
            },
        },
    },
    {
        huntname = 'Ambarinor',
        location = vector3(922.24, 2065.61, 310.88),
        hintcost = 5,
        Reward = {
            {
                displayname = 'Diamond', --the name of the item that the notification will display
                name = 'gold_nugget',
                count = 3,
            },
            {
                displayname = 'Diamond', --the name of the item that the notification will display
                name = 'stolenmerch',
                count = 1,
            },
        },
    },
    {
        huntname = 'Guarma',
        location = vector3(1663.53, -7164.55, 93.17),
        hintcost = 5,
        Reward = {
            {
                displayname = 'Diamond', --the name of the item that the notification will display
                name = 'goldbar',
                count = 1,
            },
            {
                displayname = 'Diamond', --the name of the item that the notification will display
                name = 'stolenmerch',
                count = 1,
            },
            {
                displayname = 'Diamond', --the name of the item that the notification will display
                name = 'gold_nugget',
                count = 2,
            },
        },
    },
    {
        huntname = 'Lagras',
        location = vector3(2299.25, -621.2, 41.25),
        hintcost = 5,
        Reward = {
            {
                displayname = 'Diamond', --the name of the item that the notification will display
                name = 'gold_nugget',
                count = 3,
            },
            {
                displayname = 'Diamond', --the name of the item that the notification will display
                name = 'aligatorto',
                count = 2,
            },
        },
    },
}
-----------------------------------------------------

--This is the shop configuration
--You can add as many items to sale as you want just copy the line paste it and change it to your new item
--itemdbname is the database name of the item and displayname is what will show in the menu with nazar

Config.CurrencyTypes = {
    ['money'] = 0,
    ['gold'] = 1,
    ['rol'] = 2
}

--This is what she will sell to the player
Config.Shop = {
    { itemdbname = 'lockpick', displayname = 'Lock Pick', price = '5', currencytype = 'gold'},
    { itemdbname = 'dynamite', displayname = 'Dynamite', price = '20', currencytype = 'gold '},
    { itemdbname = 'robbingkit', displayname = 'Robbing Kit', price = '10', currencytype = 'gold'},
    { itemdbname = 'consumable_lock_breaker', displayname = 'Advanced Lock Pick', price = '10', currencytype = 'gold'},
}
-----------------------------------------------------

-- This is what she will buy from the seller
Config.NazarsSellableItems = {
    { itemdbname = 'stolenmerch', displayname = 'Stolen Items', price = 12, currencytype = 'money'},
    { itemdbname = 'gold_nugget', displayname = 'Gold Nugget', price = 3, currencytype = 'gold'},
    { itemdbname = 'diamond', displayname = 'Diamond', price = 10, currencytype = 'money'},
    { itemdbname = 'goldbar', displayname = 'Gold Bar', price = 50, currencytype = 'money'},
    { itemdbname = 'pipe', displayname = 'Pipe', price = 4, currencytype = 'money'},
    { itemdbname = 'rollingpaper', displayname = 'Rolling Paper', price = 2, currencytype = 'money'},
    { itemdbname = 'beer', displayname = 'Old Beer', price = 5, currencytype = 'money'},
    { itemdbname = 'book', displayname = 'Dusty Book', price = 3, currencytype = 'money'},
    { itemdbname = 'aligatorto', displayname = 'Alligator Tooth', price = 4, currencytype = 'money'},
    { itemdbname = 'heroin', displayname = 'Heroin', price = 5, currencytype = 'money'},
}

-----------------------------------------------------

Config.BlipColors = {
    LIGHT_BLUE    = 'BLIP_MODIFIER_MP_COLOR_1',
    DARK_RED      = 'BLIP_MODIFIER_MP_COLOR_2',
    PURPLE        = 'BLIP_MODIFIER_MP_COLOR_3',
    ORANGE        = 'BLIP_MODIFIER_MP_COLOR_4',
    TEAL          = 'BLIP_MODIFIER_MP_COLOR_5',
    LIGHT_YELLOW  = 'BLIP_MODIFIER_MP_COLOR_6',
    PINK          = 'BLIP_MODIFIER_MP_COLOR_7',
    GREEN         = 'BLIP_MODIFIER_MP_COLOR_8',
    DARK_TEAL     = 'BLIP_MODIFIER_MP_COLOR_9',
    RED           = 'BLIP_MODIFIER_MP_COLOR_10',
    LIGHT_GREEN   = 'BLIP_MODIFIER_MP_COLOR_11',
    TEAL2         = 'BLIP_MODIFIER_MP_COLOR_12',
    BLUE          = 'BLIP_MODIFIER_MP_COLOR_13',
    DARK_PUPLE    = 'BLIP_MODIFIER_MP_COLOR_14',
    DARK_PINK     = 'BLIP_MODIFIER_MP_COLOR_15',
    DARK_DARK_RED = 'BLIP_MODIFIER_MP_COLOR_16',
    GRAY          = 'BLIP_MODIFIER_MP_COLOR_17',
    PINKISH       = 'BLIP_MODIFIER_MP_COLOR_18',
    YELLOW_GREEN  = 'BLIP_MODIFIER_MP_COLOR_19',
    DARK_GREEN    = 'BLIP_MODIFIER_MP_COLOR_20',
    BRIGHT_BLUE   = 'BLIP_MODIFIER_MP_COLOR_21',
    BRIGHT_PURPLE = 'BLIP_MODIFIER_MP_COLOR_22',
    YELLOW_ORANGE = 'BLIP_MODIFIER_MP_COLOR_23',
    BLUE2         = 'BLIP_MODIFIER_MP_COLOR_24',
    TEAL3         = 'BLIP_MODIFIER_MP_COLOR_25',
    TAN           = 'BLIP_MODIFIER_MP_COLOR_26',
    OFF_WHITE     = 'BLIP_MODIFIER_MP_COLOR_27',
    LIGHT_YELLOW2 = 'BLIP_MODIFIER_MP_COLOR_28',
    LIGHT_PINK    = 'BLIP_MODIFIER_MP_COLOR_29',
    LIGHT_RED     = 'BLIP_MODIFIER_MP_COLOR_30',
    LIGHT_YELLOW3 = 'BLIP_MODIFIER_MP_COLOR_31',
    WHITE         = 'BLIP_MODIFIER_MP_COLOR_32'
}