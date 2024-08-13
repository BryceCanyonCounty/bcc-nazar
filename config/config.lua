Config = {}

Config.defaultlang = 'en_lang'
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

Config.quotes = {
    [1]  = 'Your every move is watched! Avoid even the smallest misdemeanor!',
    [2]  = 'I see a lazy river. Flowing beside a scorched town.',
    [3]  = 'I see cliffs in a silent desert.',
    [4]  = 'I see a strange man in a tall hat... he frightens me.',
    [5]  = 'I smell lupins... so many lupins. They fill the valley floor!',
    [6]  = 'I see grizzled mountains and hungry eyes.',
    [7]  = 'I see an emerald covered in filth, lying on a beautiful plain.',
    [8]  = 'I hear birds, beautiful birds singing in a cage!',
    [9]  = 'I see great and furious judgment descending from the clouds to strike you down!',
    [10] = 'I see a scorched land. A river; along a border that cannot be crossed.',
    [11] = 'Have you seen... Gavin?',
    [12] = 'I see beautiful trees in an arid land.',
    [13] = 'I see a great stone window, looking down upon a cold river.',
    [14] = 'I see trees! Such... tall... trees!',
    [15] = 'I see numbers. One, two, three. I see numbers. Seven, six, four. I see numbers. Five, one, one, two.',
    [16] = 'I see wet ground, and figures in the dark. And the spirit of a lonely girl',
    [17] = 'I see mists... and fog. I see thunder and lightning! I see a sky covered by clouds. I see... snow! I see... a bright sun in a clear sky.',
    [18] = 'I see a ridge in the land… and a falconer… and a black smoke rising to the east.',
    [19] = 'I see a man with red hair… And a red mark upon his face. He does not belong here.',
    [20] = 'I see the ruins of a battle fought long ago.',
    [21] = 'Remember, the stars favor those who leave no stone unturned.',
    [22] = 'Take care... Your next drink will go to your head...'
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