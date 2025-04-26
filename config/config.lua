Config = {}

Config.defaultlang = 'en_lang'
-----------------------------------------------------

Config.devMode       = false
-----------------------------------------------------

-- If you want to use BCC-UserLog API's
-- Global toggle for using playtime restrictions
Config.useBccUserlog = true
-----------------------------------------------------

Config.keys = {
    collect = 0x760A9C6F, -- [G]
    nazar   = 0x760A9C6F, -- [G]
    chest   = 0x760A9C6F, -- [G]
}
-----------------------------------------------------

Config.CurrencyTypes = {
    ['money'] = 0,
    ['gold']  = 1,
    ['rol']   = 2
}
-----------------------------------------------------

Config.cooldown   = {
    buyHint = 15   -- Cooldown for Buying a Chest Hint in Minutes
}
-----------------------------------------------------

-- webhooks display when someone opens a chest / buys or sells with nazar
Config.Webhook = ''
Config.WebhookTitle = 'BCC-Nazar'
Config.WebhookAvatar = ''
-----------------------------------------------------

Config.nazar = {
    model = 'cs_mp_travellingsaleswoman', -- model used for nazar
    music = true, -- Play Nazars Music
    volume = 20, -- Music Volume Level 0-100
    blip = {
        show = true, -- Show Blip On Map
        sprite = 2119977580, -- Default: 2119977580
        name = 'Madam Nazar', -- Name of Blip on Map
        color = 'RED', -- Blip Colors Shown Below
    },
    autoRespawn = true,                   -- If true, Nazar will auto respawn in different locations every X minutes otherwise every server restart
    timeRespawn = 1800000,                -- Time between spawns in milliseconds (30 minutes here)
    location = { --You can add as many locations as you would like. Script will randomly pick one at each server restart!
        {
            nazarCoords = vector3(-1047.19, 450.55, 56.81),
            nazarHeading = 178.68,
            wagon = false, -- Spawn nazars wagon (NOTE: Wagon can be hard to set on the ground properly. Works best on perfectly flat ground)
            wagonCoords = vector3(-1043.98, 451.66, 56.71)
        },
        {
            nazarCoords = vector3(-1526.77, -312.55, 142.55),
            nazarHeading = 12.82,
            wagon = true,
            wagonCoords = vector3(-1522.95, -311.68, 142.39),
        },
    }
}
-----------------------------------------------------

Config.jobPermissions = {
    enabled = false, -- Set to false to disable job restrictions for hints
    allowedJobs = {
        collector = { minGrade = 0, maxGrade = 5 }
        -- Add more jobs as needed
    }
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