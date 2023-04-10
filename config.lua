Config = {}

--webhooks place your webhook url between the two '
ChestWebhook = '' --will display when someone opens a chest who did it what items they got what chest etc
ShopWebhook = '' --this is what will display when someone sells or buys from nazar

--This is the nazar configuration
Config.NazarSetup = {
    nazarswagon = false, --if true this will spawn nazars wagon with nazar at the set coords. (The wagon can be hard to get set on the groun properly hence why this is optional, it will be tedious to get it set correctly, mainly will only work on perfectly flat ground)
    blip = true, --if true this will place a blip on nazar if not no blip will be there
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
                name = 'coal', --this has to be the database name of the item
                count = 1, --the amount of the item you want it to give
            },
            {
                name = 'iron',
                count = 7,
            },
        },
    },
    {
        huntname = 'Girzzlies east',
        location = {x = -2728.65, y = -1464.78, z = 153.06},
        hintcost = 5,
        Reward = {
            {
                name = 'horsebrush',
                count = 1,
            },
        },
    },
}

--This is the shop configuration
--You can add as many items to sale as you want just copy the line paste it and change it to your new item
--itemdbname is the database name of the item and displayname is what will show in the menu with nazar

--This is what she will purchase from the player
Config.Shop = {
    { itemdbname = 'iron', displayname = 'Iron', price = '5'},
    { itemdbname = 'coal', displayname = 'Coal', price = '2'},
}

-- This is what she will sell to the player
Config.Nazarssellableitems = {
    { itemdbname = 'iron', displayname = 'Iron', price = 3},
    { itemdbname = 'coal', displayname = 'Coal', price = 7},
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
    NoChest = "Someone has already looted this chest!",
    Alreadylooted = "You looted the chest!"
}