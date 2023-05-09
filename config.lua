Config = {}

--webhooks place your webhook url between the two '
ChestWebhook = '' --will display when someone opens a chest who did it what items they got what chest etc
ShopWebhook = '' --this is what will display when someone sells or buys from nazar

--This is the nazar configuration
Config.NazarSetup = {
    Music = true, --if true nazars rdo music will play
    MusicVolume = 20, --audio level of the music 0-100
    nazarswagon = false, --if true this will spawn nazars wagon with nazar at the set coords. (The wagon can be hard to get set on the groun properly hence why this is optional, it will be tedious to get it set correctly, mainly will only work on perfectly flat ground)
    blip = true, --if true this will place a blip on nazar if not no blip will be there
    BlipHash = 2119977580, --blips hash
    BlipName = "Madam Nazar", --blips name
    BlipColor = "BLIP_MODIFIER_MP_COLOR_10", --blips color
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
    hintcooldown = 300000, --this is the cooldown between hints
}

--This is the treasure chest setup you can not add anymore sadly only configure the existing ones there are 20 in total and i can add more if enough people want more
Config.TreasureLocations = {
    {
        huntname = 'Grizzlies West', --the name that will show when buying a hint from nazar
        location = {x = -960.33, y = 1630.17, z = 246.58}, --the location of the chest
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
        location = {x = -2728.65, y = -1464.78, z = 153.06},
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
        location = {x = -2260.32, y = 115.96, z = 248.63}, 
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
        location = {x = -1814.82, y = -1546.38, z = 95.36}, 
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
        location = {x = -3340.63, y = -3399.11, z = 31.46}, 
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
        location = {x = -1495.65, y = 3129.55, z = 492.6}, 
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
        location = {x = 922.24, y = 2065.61, z = 310.88}, 
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
        location = {x = 1663.53, y = -7164.55, z = 93.17}, 
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
        location = {x = 2299.25, y = -621.2, z = 41.25}, 
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

------ Card Setup -----
Config.CardsEnable = true --if true collectable cards will be enabled
Config.CardRespawnTime = 30000 --how often in ms the cards will respawn
Config.CollectableCards = {
    {
        coords = {x = 1486.19, y = 791.14, z = 99.81}, --coords the card will spawn at
        carditem = 'water', --item to give database name
        carditemdisplayname = 'Water', --this is the name of the carditem that will show in the items recieved notification
        cardname = 'Collector Card 1', --display name that will be shown in the prompt to pick card up (MAKE SURE THESE ARE UNIQUE NAMES OTHERWISE IT WILL BREAK)
    },
    {
        coords = {x = 1489.69, y = 783.15, z = 99.74}, --coords the card will spawn at
        carditem = 'iron', --item to give database name
        carditemdisplayname = 'Iron', --this is the name of the carditem that will show in the items recieved notification
        cardname = 'Collector Card 2', --display name that will be shown in the prompt to pick card up (MAKE SURE THESE ARE UNIQUE NAMES OTHERWISE IT WILL BREAK)
    },
}

--This is the shop configuration
--You can add as many items to sale as you want just copy the line paste it and change it to your new item
--itemdbname is the database name of the item and displayname is what will show in the menu with nazar

--This is what she will sell to the player
Config.Shop = {
    { itemdbname = 'lockpick', displayname = 'Lock Pick', price = '5', currencytype = 'gold'},
    { itemdbname = 'dynamite', displayname = 'Dynamite', price = '20', currencytype = 'gold'},
    { itemdbname = 'robbingkit', displayname = 'Robbing Kit', price = '10', currencytype = 'gold'},
    { itemdbname = 'consumable_lock_breaker', displayname = 'Advanced Lock Pick', price = '10', currencytype = 'gold'},
}

-- This is what she will buy from the seller
Config.Nazarssellableitems = {
    { itemdbname = 'stolenmerch', displayname = 'Stolen Items', price = 12, currencytype = 'cash'},
    { itemdbname = 'gold_nugget', displayname = 'Gold Nugget', price = 3, currencytype = 'cash'},
    { itemdbname = 'diamond', displayname = 'Diamond', price = 10, currencytype = 'cash'},
    { itemdbname = 'goldbar', displayname = 'Gold Bar', price = 50, currencytype = 'cash'},
    { itemdbname = 'pipe', displayname = 'Pipe', price = 4, currencytype = 'cash'},
    { itemdbname = 'rollingpaper', displayname = 'Rolling Paper', price = 2, currencytype = 'cash'},
    { itemdbname = 'beer', displayname = 'Old Beer', price = 5, currencytype = 'cash'},
    { itemdbname = 'book', displayname = 'Dusty Book', price = 3, currencytype = 'cash'},
    { itemdbname = 'aligatorto', displayname = 'Alligator Tooth', price = 4, currencytype = 'cash'},
    { itemdbname = 'heroin', displayname = 'Heroin', price = 5, currencytype = 'cash'},
}

------------------- TRANSLATE HERE --------------
Config.Language = {
    TreasureBlipName = 'Treasure?',
    TreasurePromptTitle = 'Search the chest for clues',
    TreasurePrompt_search = "Search Chest",
    TalkToNPCText = 'Press "G" to see what Madam Nazar is offering',

    Menu_Title_Hint = 'Hint Shop',
    Menu_Title_Sell = 'Sell',
    Menu_Title_Buy = 'Buy',
    Menu_SubTitle_Hint = 'Purchase Hints',
    Menu_SubTitle_Sell = 'Sell Items',
    Menu_SubTitle_Buy = 'Buy Items',
    SubMenu_Head_Hint = "Buy Hints",
    Nazar = 'Madam Nazar',
    SubMenu_Head_Sell = "Sell Items",
    SubMenu_Head_Buy = "Buy Items",
    SubMenu_Hint = 'Purchase a Hint ',
    Shopmenu_sell = "Sell ",
    Shopmenu_for = " for ",
    Shopmenu_buy = "Buy ",
    input_button = "confirm",
    input_placeholder = "insert amount",
    input_header = "amount",
    HintNotify = "A clue to some treasure has been marked",
    NoHintNotify = "I have nothing to offer currently come back later",
    NoItem = "You do not have this item.",
    NoMoney = "You do not have enough cash.",
    NoGold = "You do not have enugh gold", -- added by mrtb
    NoChest = "Someone has already looted this chest!",
    Alreadylooted = "You looted the chest!",
    ChestLooted = 'Items Recieved: '
}

--[[--------BLIP_COLORS----------
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
WHITE         = 'BLIP_MODIFIER_MP_COLOR_32']]