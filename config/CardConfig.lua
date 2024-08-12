ConfigCards = {}

ConfigCards.Item = 'collector_card'
-----------------------------------------------------

ConfigCards.Enabled = true
-----------------------------------------------------

ConfigCards.ptfx = {
    enabled = true, -- Default : true, this is the particles on the cards when you use Eagle Eyes
    dict = "eagle_eye",
    name = "eagle_eye_clue",
    scale = 1.0,
    soundset_ref = "RDRO_Sniper_Tension_Sounds",
    soundset_name = "Heartbeat",
    soundset_delay = 1000 -- Distance * soundset_delay = delay between each sound
}
-----------------------------------------------------

ConfigCards.CardTime = 60 -- Default: 60 = 1 hour, this is time in minutes before card can be collected again
-----------------------------------------------------

ConfigCards.SetItem = 'collector_card_box'
-----------------------------------------------------

ConfigCards.SetsData = {
    [1] = {
        name = "Flora Of North America",
        sellingCurrency = 0, -- 0 | money, 1 | gold, 2 | rol
        sellingPrice = 100
    },
    [2] = {
        name = "Stars Of The Stage",
        sellingCurrency = 0, -- 0 | money, 1 | gold, 2 | rol
        sellingPrice = 100
    },
    [3] = {
        name = "Famous Gunslingers & Outlaws",
        sellingCurrency = 0, -- 0 | money, 1 | gold, 2 | rol
        sellingPrice = 100
    },
    [4] = {
        name = "Vistas, Scenery & Cities Of America",
        sellingCurrency = 0, -- 0 | money, 1 | gold, 2 | rol
        sellingPrice = 100
    },
    [5] = {
        name = "Breeds Of Horses",
        sellingCurrency = 0, -- 0 | money, 1 | gold, 2 | rol
        sellingPrice = 100
    },
    [6] = {
        name = "Artists, Writers & Poets",
        sellingCurrency = 0, -- 0 | money, 1 | gold, 2 | rol
        sellingPrice = 100
    },
    [7] = {
        name = "Fairest Flowers & Gems Of Beauty",
        sellingCurrency = 0, -- 0 | money, 1 | gold, 2 | rol
        sellingPrice = 100
    },
    [8] = {
        name = "Amazing Inventions",
        sellingCurrency = 0, -- 0 | money, 1 | gold, 2 | rol
        sellingPrice = 100
    },
    [9] = {
        name = "Marvels Of Travel  & Locomotion",
        sellingCurrency = 0, -- 0 | money, 1 | gold, 2 | rol
        sellingPrice = 100
    },
    [10] = {
        name = "Fauna Of North America",
        sellingCurrency = 0, -- 0 | money, 1 | gold, 2 | rol
        sellingPrice = 100
    },
    [11] = {
        name = "The World\'s Champions",
        sellingCurrency = 0, -- 0 | money, 1 | gold, 2 | rol
        sellingPrice = 100
    },
    [12] = {
        name = "Prominent Americans",
        sellingCurrency = 0, -- 0 | money, 1 | gold, 2 | rol
        sellingPrice = 100
    }
}
-----------------------------------------------------

-- Collector Cards: 144 cards / 12 cards per set / 12 Sets
ConfigCards.Cards = {
    -- Flora Of North America
    {
        name   = 'Flora Of North America',
        number = 'Card #1',
        model  = 's_inv_cigcard_PLT_01x',
        coords = vector3(2238.9089, -768.6769, 43.4078),
        setId = 1
    },
    {
        name   = 'Flora Of North America',
        number = 'Card #2',
        model  = 's_inv_cigcard_PLT_02x',
        coords = vector3(2718.3381, 710.4100, 79.5452),
        setId = 1
    },
    {
        name   = 'Flora Of North America',
        number = 'Card #3',
        model  = 's_inv_cigcard_PLT_03x',
        coords = vector3(2731.1619, -1189.1556, 49.6752),
        setId = 1
    },
    {
        name   = 'Flora Of North America',
        number = 'Card #4',
        model  = 's_inv_cigcard_PLT_04x',
        coords = vector3(2369.3906, -859.6332, 43.0619),
        setId = 1
    },
    {
        name   = 'Flora Of North America',
        number = 'Card #5',
        model  = 's_inv_cigcard_PLT_05x',
        coords = vector3(2374.0281, -858.4252, 41.9319),
        setId = 1
    },
    {
        name   = 'Flora Of North America',
        number = 'Card #6',
        model  = 's_inv_cigcard_PLT_06x',
        coords = vector3(1522.9819, 449.6942, 90.3621),
        setId = 1
    },
    {
        name   = 'Flora Of North America',
        number = 'Card #7',
        model  = 's_inv_cigcard_PLT_07x',
        coords = vector3(2722.0339, 1309.4908, 73.7420),
        setId = 1
    },
    {
        name   = 'Flora Of North America',
        number = 'Card #8',
        model  = 's_inv_cigcard_PLT_08x',
        coords = vector3(-5617.5947, -2946.2869, 5.5759),
        setId = 1
    },
    {
        name   = 'Flora Of North America',
        number = 'Card #9',
        model  = 's_inv_cigcard_PLT_09x',
        coords = vector3(-1764.2583, -435.9760, 155.2233),
        setId = 1
    },
    {
        name   = 'Flora Of North America',
        number = 'Card #10',
        model  = 's_inv_cigcard_PLT_10x',
        coords = vector3(1825.48, -1246.04, 42.42),
        setId = 1
    },
    {
        name   = 'Flora Of North America',
        number = 'Card #11',
        model  = 's_inv_cigcard_PLT_11x',
        coords = vector3(-2370.3586, 476.8453, 132.2230),
        setId = 1
    },
    {
        name   = 'Flora Of North America',
        number = 'Card #12',
        model  = 's_inv_cigcard_PLT_12x',
        coords = vector3(-5529.8599, -2950.0166, 3.2736),
        setId = 1
    },
    -- Stars Of The Stage
    {
        name   = 'Stars Of The Stage',
        number = 'Card #1',
        model  = 's_inv_cigcard_ACT_01x',
        coords = vector3(1138.7965, -979.7531, 69.3926),
        setId = 2
    },
    {
        name   = 'Stars Of The Stage',
        number = 'Card #2',
        model  = 's_inv_cigcard_ACT_02x',
        coords = vector3(2780.2122, 530.0074, 68.3704),
        setId = 2
    },
    {
        name   = 'Stars Of The Stage',
        number = 'Card #3',
        model  = 's_inv_cigcard_ACT_03x',
        coords = vector3(-5511.8696, -2880.1252, -4.3058),
        setId = 2
    },
    {
        name   = 'Stars Of The Stage',
        number = 'Card #4',
        model  = 's_inv_cigcard_ACT_04x',
        coords = vector3(-2237.7307, 732.5734, 136.3089),
        setId = 2
    },
    {
        name   = 'Stars Of The Stage',
        number = 'Card #5',
        model  = 's_inv_cigcard_ACT_05x',
        coords = vector3(2555.95, -1316.51, 49.21),
        setId = 2
    },
    {
        name   = 'Stars Of The Stage',
        number = 'Card #6',
        model  = 's_inv_cigcard_ACT_06x',
        coords = vector3(2563.7698, -1317.6105, 49.2130),
        setId = 2
    },
    {
        name   = 'Stars Of The Stage',
        number = 'Card #7',
        model  = 's_inv_cigcard_ACT_07x',
        coords = vector3(-380.5824, 727.6285, 116.0200),
        setId = 2
    },
    {
        name   = 'Stars Of The Stage',
        number = 'Card #8',
        model  = 's_inv_cigcard_ACT_08x',
        coords = vector3(-2493.3389, -2432.2336, 60.5997),
        setId = 2
    },
    {
        name   = 'Stars Of The Stage',
        number = 'Card #9',
        model  = 's_inv_cigcard_ACT_09x',
        coords = vector3(-348.9319, 694.9716, 117.5002),
        setId = 2
    },
    {
        name   = 'Stars Of The Stage',
        number = 'Card #10',
        model  = 's_inv_cigcard_ACT_10x',
        coords = vector3(1257.0928, -408.3182, 97.5992),
        setId = 2
    },
    {
        name   = 'Stars Of The Stage',
        number = 'Card #11',
        model  = 's_inv_cigcard_ACT_11x',
        coords = vector3(903.7382, 260.9341, 116.0042),
        setId = 2
    },
    {
        name   = 'Stars Of The Stage',
        number = 'Card #12',
        model  = 's_inv_cigcard_ACT_12x',
        coords = vector3(1305.5599, -1138.5294, 81.2444),
        setId = 2
    },
    -- Famous Gunslingers & Outlaws
    {
        name   = 'Famous Gunslingers & Outlaws',
        number = 'Card #1',
        model  = 's_inv_cigcard_GUN_01x',
        coords = vector3(-231.9508, 818.2557, 124.3055),
        setId = 3
    },
    {
        name   = 'Famous Gunslingers & Outlaws',
        number = 'Card #2',
        model  = 's_inv_cigcard_GUN_02x',
        coords = vector3(-16.2848, 1233.1180, 173.2769),
        setId = 3
    },
    {
        name   = 'Famous Gunslingers & Outlaws',
        number = 'Card #3',
        model  = 's_inv_cigcard_GUN_03x',
        coords = vector3(-424.0702, 1733.3652, 216.5554),
        setId = 3
    },
    {
        name   = 'Famous Gunslingers & Outlaws',
        number = 'Card #4',
        model  = 's_inv_cigcard_GUN_04x',
        coords = vector3(2556.7188, 758.1410, 76.8717),
        setId = 3
    },
    {
        name   = 'Famous Gunslingers & Outlaws',
        number = 'Card #5',
        model  = 's_inv_cigcard_GUN_05x',
        coords = vector3(1296.0873, -1273.0426, 76.1071),
        setId = 3
    },
    {
        name   = 'Famous Gunslingers & Outlaws',
        number = 'Card #6',
        model  = 's_inv_cigcard_GUN_06x',
        coords = vector3(1587.7961, 2193.5977, 324.3895),
        setId = 3
    },
    {
        name   = 'Famous Gunslingers & Outlaws',
        number = 'Card #7',
        model  = 's_inv_cigcard_GUN_07x',
        coords = vector3(-3643.9658, -2624.4241, -13.7338),
        setId = 3
    },
    {
        name   = 'Famous Gunslingers & Outlaws',
        number = 'Card #8',
        model  = 's_inv_cigcard_GUN_08x',
        coords = vector3(-725.2998, -1257.3153, 44.7341),
        setId = 3
    },
    {
        name   = 'Famous Gunslingers & Outlaws',
        number = 'Card #9',
        model  = 's_inv_cigcard_GUN_09x',
        coords = vector3(-5423.4888, -2971.3831, 13.0452),
        setId = 3
    },
    {
        name   = 'Famous Gunslingers & Outlaws',
        number = 'Card #10',
        model  = 's_inv_cigcard_GUN_10x',
        coords = vector3(2489.8003, -419.7399, 44.2337),
        setId = 3
    },
    {
        name   = 'Famous Gunslingers & Outlaws',
        number = 'Card #11',
        model  = 's_inv_cigcard_GUN_11x',
        coords = vector3(2711.8223, -1053.9874, 46.8905),
        setId = 3
    },
    {
        name   = 'Famous Gunslingers & Outlaws',
        number = 'Card #12',
        model  = 's_inv_cigcard_GUN_12x',
        coords = vector3(-2176.1069, 715.2440, 122.6525),
        setId = 3
    },
    -- Vistas, Scenery & Cities Of America
    {
        name   = 'Vistas, Scenery & Cities Of America',
        number = 'Card #1',
        model  = 's_inv_cigcard_LND_01x',
        coords = vector3(1833.4846, -1422.6627, 43.8362),
        setId = 4
    },
    {
        name   = 'Vistas, Scenery & Cities Of America',
        number = 'Card #2',
        model  = 's_inv_cigcard_LND_02x',
        coords = vector3(2753.8804, -1395.8075, 46.2080),
        setId = 4
    },
    {
        name   = 'Vistas, Scenery & Cities Of America',
        number = 'Card #3',
        model  = 's_inv_cigcard_LND_03x',
        coords = vector3(-834.0394, -1286.5319, 53.5716),
        setId = 4
    },
    {
        name   = 'Vistas, Scenery & Cities Of America',
        number = 'Card #4',
        model  = 's_inv_cigcard_LND_04x',
        coords = vector3(-3733.6714, -2611.8369, -12.8579),
        setId = 4
    },
    {
        name   = 'Vistas, Scenery & Cities Of America',
        number = 'Card #5',
        model  = 's_inv_cigcard_LND_05x',
        coords = vector3(-322.8627, -329.7148, 102.4421),
        setId = 4
    },
    {
        name   = 'Vistas, Scenery & Cities Of America',
        number = 'Card #6',
        model  = 's_inv_cigcard_LND_06x',
        coords = vector3(-3551.8970, -3010.4966, 11.8220),
        setId = 4
    },
    {
        name   = 'Vistas, Scenery & Cities Of America',
        number = 'Card #7',
        model  = 's_inv_cigcard_LND_07x',
        coords = vector3(2441.1904, 306.1721, 74.7072),
        setId = 4
    },
    {
        name   = 'Vistas, Scenery & Cities Of America',
        number = 'Card #8',
        model  = 's_inv_cigcard_LND_08x',
        coords = vector3(-331.4270, -366.1998, 88.0785),
        setId = 4
    },
    {
        name   = 'Vistas, Scenery & Cities Of America',
        number = 'Card #9',
        model  = 's_inv_cigcard_LND_09x',
        coords = vector3(-181.3269, 632.4587, 114.0897),
        setId = 4
    },
    {
        name   = 'Vistas, Scenery & Cities Of America',
        number = 'Card #10',
        model  = 's_inv_cigcard_LND_10x',
        coords = vector3(1453.2408, 288.5294, 104.5148),
        setId = 4
    },
    {
        name   = 'Vistas, Scenery & Cities Of America',
        number = 'Card #11',
        model  = 's_inv_cigcard_LND_11x',
        coords = vector3(1302.0393, -1208.6930, 81.2819),
        setId = 4
    },
    {
        name   = 'Vistas, Scenery & Cities Of America',
        number = 'Card #12',
        model  = 's_inv_cigcard_LND_12x',
        coords = vector3(2846.2705, 1374.1913, 68.7967),
        setId = 4
    },
    -- Breeds Of Horses
    {
        name   = 'Breeds Of Horses',
        number = 'Card #1',
        model  = 's_inv_cigcard_HRS_01x',
        coords = vector3(1409.7869, -1286.7872, 78.2428),
        setId = 5
    },
    {
        name   = 'Breeds Of Horses',
        number = 'Card #2',
        model  = 's_inv_cigcard_HRS_02x',
        coords = vector3(2549.9788, -1574.2726, 45.9694),
        setId = 5
    },
    {
        name   = 'Breeds Of Horses',
        number = 'Card #3',
        model  = 's_inv_cigcard_HRS_03x',
        coords = vector3(-626.6384, -73.5814, 82.8523),
        setId = 5
    },
    {
        name   = 'Breeds Of Horses',
        number = 'Card #4',
        model  = 's_inv_cigcard_HRS_04x',
        coords = vector3(1315.0315, -2277.4333, 50.5396),
        setId = 5
    },
    {
        name   = 'Breeds Of Horses',
        number = 'Card #5',
        model  = 's_inv_cigcard_HRS_05x',
        coords = vector3(1311.2131, -1354.3545, 78.0342),
        setId = 5
    },
    {
        name   = 'Breeds Of Horses',
        number = 'Card #6',
        model  = 's_inv_cigcard_HRS_06x',
        coords = vector3(-1298.6433, 408.5544, 95.3838),
        setId = 5
    },
    {
        name   = 'Breeds Of Horses',
        number = 'Card #7',
        model  = 's_inv_cigcard_HRS_07x',
        coords = vector3(-820.9626, 354.5072, 98.0781),
        setId = 5
    },
    {
        name   = 'Breeds Of Horses',
        number = 'Card #8',
        model  = 's_inv_cigcard_HRS_08x',
        coords = vector3(1711.2173, 1514.6246, 147.5255),
        setId = 5
    },
    {
        name   = 'Breeds Of Horses',
        number = 'Card #9',
        model  = 's_inv_cigcard_HRS_09x',
        coords = vector3(-3680.5881, -2554.3044, -13.5937),
        setId = 5
    },
    {
        name   = 'Breeds Of Horses',
        number = 'Card #10',
        model  = 's_inv_cigcard_HRS_10x',
        coords = vector3(-865.0118, 333.8043, 99.8027),
        setId = 5
    },
    {
        name   = 'Breeds Of Horses',
        number = 'Card #11',
        model  = 's_inv_cigcard_HRS_11x',
        coords = vector3(1212.4487, -1275.3651, 77.9136),
        setId = 5
    },
    {
        name   = 'Breeds Of Horses',
        number = 'Card #12',
        model  = 's_inv_cigcard_HRS_12x',
        coords = vector3(1319.3031, -2287.4866, 50.5363),
        setId = 5
    },
    -- Artists, Writers & Poets
    {
        name   = 'Artists, Writers & Poets',
        number = 'Card #1',
        model  = 's_inv_cigcard_ART_01x',
        coords = vector3(1053.0137, -1827.0981, 48.4397),
        setId = 6
    },
    {
        name   = 'Artists, Writers & Poets',
        number = 'Card #2',
        model  = 's_inv_cigcard_ART_02x',
        coords = vector3(-1819.4686, -371.7454, 166.4969),
        setId = 6
    },
    {
        name   = 'Artists, Writers & Poets',
        number = 'Card #3',
        model  = 's_inv_cigcard_ART_03x',
        coords = vector3(1458.5281, 814.0430, 101.1335),
        setId = 6
    },
    {
        name   = 'Artists, Writers & Poets',
        number = 'Card #4',
        model  = 's_inv_cigcard_ART_04x',
        coords = vector3(-881.7477, -1647.1343, 69.5683),
        setId = 6
    },
    {
        name   = 'Artists, Writers & Poets',
        number = 'Card #5',
        model  = 's_inv_cigcard_ART_05x',
        coords = vector3(2920.3789, 1379.0333, 56.2246),
        setId = 6
    },
    {
        name   = 'Artists, Writers & Poets',
        number = 'Card #6',
        model  = 's_inv_cigcard_ART_06x',
        coords = vector3(-980.8656, -1258.8082, 52.6850),
        setId = 6
    },
    {
        name   = 'Artists, Writers & Poets',
        number = 'Card #7',
        model  = 's_inv_cigcard_ART_07x',
        coords = vector3(2824.3479, 280.4843, 51.0772),
        setId = 6
    },
    {
        name   = 'Artists, Writers & Poets',
        number = 'Card #8',
        model  = 's_inv_cigcard_ART_08x',
        coords = vector3(2846.3513, -1244.9381, 47.6545),
        setId = 6
    },
    {
        name   = 'Artists, Writers & Poets',
        number = 'Card #9',
        model  = 's_inv_cigcard_ART_09x',
        coords = vector3(2329.6184, -317.5721, 41.6188),
        setId = 6
    },
    {
        name   = 'Artists, Writers & Poets',
        number = 'Card #10',
        model  = 's_inv_cigcard_ART_10x',
        coords = vector3(-383.1024, 919.4769, 118.5316),
        setId = 6
    },
    {
        name   = 'Artists, Writers & Poets',
        number = 'Card #11',
        model  = 's_inv_cigcard_ART_11x',
        coords = vector3(1115.1459, 485.7841, 97.2841),
        setId = 6
    },
    {
        name   = 'Artists, Writers & Poets',
        number = 'Card #12',
        model  = 's_inv_cigcard_ART_12x',
        coords = vector3(2597.7920, -1031.1896, 45.6760),
        setId = 6
    },
    -- Fairest Flowers & Gems Of Beauty
    {
        name   = 'Fairest Flowers & Gems Of Beauty',
        number = 'Card #1',
        model  = 's_inv_cigcard_GRL_01x',
        coords = vector3(781.7, 849.73, 118.97),
        setId = 7
    },
    {
        name   = 'Fairest Flowers & Gems Of Beauty',
        number = 'Card #2',
        model  = 's_inv_cigcard_GRL_02x',
        coords = vector3(2452.4849, 2096.5459, 173.3784),
        setId = 7
    },
    {
        name   = 'Fairest Flowers & Gems Of Beauty',
        number = 'Card #3',
        model  = 's_inv_cigcard_GRL_03x',
        coords = vector3(2476.3252, 1999.4919, 168.2529),
        setId = 7
    },
    {
        name   = 'Fairest Flowers & Gems Of Beauty',
        number = 'Card #4',
        model  = 's_inv_cigcard_GRL_04x',
        coords = vector3(2751.9517, 1320.4403, 69.9881),
        setId = 7
    },
    {
        name   = 'Fairest Flowers & Gems Of Beauty',
        number = 'Card #5',
        model  = 's_inv_cigcard_GRL_05x',
        coords = vector3(500.5150, 627.1988, 111.7047),
        setId = 7
    },
    {
        name   = 'Fairest Flowers & Gems Of Beauty',
        number = 'Card #6',
        model  = 's_inv_cigcard_GRL_06x',
        coords = vector3(-825.4061, -1348.4664, 43.6294),
        setId = 7
    },
    {
        name   = 'Fairest Flowers & Gems Of Beauty',
        number = 'Card #7',
        model  = 's_inv_cigcard_GRL_07x',
        coords = vector3(-2217.0073, 726.6647, 127.7005),
        setId = 7
    },
    {
        name   = 'Fairest Flowers & Gems Of Beauty',
        number = 'Card #8',
        model  = 's_inv_cigcard_GRL_08x',
        coords = vector3(-1384.5903, 1153.8748, 225.0466),
        setId = 7
    },
    {
        name   = 'Fairest Flowers & Gems Of Beauty',
        number = 'Card #9',
        model  = 's_inv_cigcard_GRL_09x',
        coords = vector3(2946.3726, 583.4391, 44.4635),
        setId = 7
    },
    {
        name   = 'Fairest Flowers & Gems Of Beauty',
        number = 'Card #10',
        model  = 's_inv_cigcard_GRL_10x',
        coords = vector3(2734.8169, -1221.7931, 49.6560),
        setId = 7
    },
    {
        name   = 'Fairest Flowers & Gems Of Beauty',
        number = 'Card #11',
        model  = 's_inv_cigcard_GRL_11x',
        coords = vector3(-253.7329, 638.8944, 118.7465),
        setId = 7
    },
    {
        name   = 'Fairest Flowers & Gems Of Beauty',
        number = 'Card #12',
        model  = 's_inv_cigcard_GRL_12x',
        coords = vector3(572.7988, 1689.1989, 187.6315),
        setId = 7
    },
    -- Amazing Inventions
    {
        name   = 'Amazing Inventions',
        number = 'Card #1',
        model  = 's_inv_cigcard_INV_01x',
        coords = vector3(1585.6456, -1845.1353, 58.6760),
        setId = 8
    },
    {
        name   = 'Amazing Inventions',
        number = 'Card #2',
        model  = 's_inv_cigcard_INV_02x',
        coords = vector3(2724.9419, -1124.3977, 49.5590),
        setId = 8
    },
    {
        name   = 'Amazing Inventions',
        number = 'Card #3',
        model  = 's_inv_cigcard_INV_03x',
        coords = vector3(-2181.6340, 721.0859, 126.2033),
        setId = 8
    },
    {
        name   = 'Amazing Inventions',
        number = 'Card #4',
        model  = 's_inv_cigcard_INV_04x',
        coords = vector3(-955.9500, -1318.1989, 50.6010),
        setId = 8
    },
    {
        name   = 'Amazing Inventions',
        number = 'Card #5',
        model  = 's_inv_cigcard_INV_05x',
        coords = vector3(2955.6340, 1318.1116, 44.7540),
        setId = 8
    },
    {
        name   = 'Amazing Inventions',
        number = 'Card #6',
        model  = 's_inv_cigcard_INV_06x',
        coords = vector3(2899.7842, 623.6471, 57.7236),
        setId = 8
    },
    {
        name   = 'Amazing Inventions',
        number = 'Card #7',
        model  = 's_inv_cigcard_INV_07x',
        coords = vector3(1880.9674, -1343.1703, 42.5087),
        setId = 8
    },
    {
        name   = 'Amazing Inventions',
        number = 'Card #8',
        model  = 's_inv_cigcard_INV_08x',
        coords = vector3(1903.2570, -1860.6189, 47.3746),
        setId = 8
    },
    {
        name   = 'Amazing Inventions',
        number = 'Card #9',
        model  = 's_inv_cigcard_INV_09x',
        coords = vector3(-315.3461, 812.0549, 121.9762),
        setId = 8
    },
    {
        name   = 'Amazing Inventions',
        number = 'Card #10',
        model  = 's_inv_cigcard_INV_10x',
        coords = vector3(2634.9734, -1240.6830, 57.3241),
        setId = 8
    },
    {
        name   = 'Amazing Inventions',
        number = 'Card #11',
        model  = 's_inv_cigcard_INV_11x',
        coords = vector3(2524.2480, 2286.0449, 177.3516),
        setId = 8
    },
    {
        name   = 'Amazing Inventions',
        number = 'Card #12',
        model  = 's_inv_cigcard_INV_12x',
        coords = vector3(1775.1053, -470.4645, 45.5979),
        setId = 8
    },
    -- Marvels Of Travel  & Locomotion
    {
        name   = 'Marvels Of Travel  & Locomotion',
        number = 'Card #1',
        model  = 's_inv_cigcard_VEH_01x',
        coords = vector3(3015.4927, 1335.8304, 42.7178),
        setId = 9
    },
    {
        name   = 'Marvels Of Travel  & Locomotion',
        number = 'Card #2',
        model  = 's_inv_cigcard_VEH_02x',
        coords = vector3(2990.7339, 472.4872, 42.0025),
        setId = 9
    },
    {
        name   = 'Marvels Of Travel  & Locomotion',
        number = 'Card #3',
        model  = 's_inv_cigcard_VEH_03x',
        coords = vector3(1347.5294, -1332.5034, 77.5165),
        setId = 9
    },
    {
        name   = 'Marvels Of Travel  & Locomotion',
        number = 'Card #4',
        model  = 's_inv_cigcard_VEH_04x',
        coords = vector3(-1767.1846, -370.2509, 163.1306),
        setId = 9
    },
    {
        name   = 'Marvels Of Travel  & Locomotion',
        number = 'Card #5',
        model  = 's_inv_cigcard_VEH_05x',
        coords = vector3(1373.4812, 356.8734, 87.8144),
        setId = 9
    },
    {
        name   = 'Marvels Of Travel  & Locomotion',
        number = 'Card #6',
        model  = 's_inv_cigcard_VEH_06x',
        coords = vector3(2797.4292, -1160.9403, 47.9281),
        setId = 9
    },
    {
        name   = 'Marvels Of Travel  & Locomotion',
        number = 'Card #7',
        model  = 's_inv_cigcard_VEH_07x',
        coords = vector3(900.9095, -1792.9851, 43.0802),
        setId = 9
    },
    {
        name   = 'Marvels Of Travel  & Locomotion',
        number = 'Card #8',
        model  = 's_inv_cigcard_VEH_08x',
        coords = vector3(2679.5872, -1563.7129, 45.9697),
        setId = 9
    },
    {
        name   = 'Marvels Of Travel  & Locomotion',
        number = 'Card #9',
        model  = 's_inv_cigcard_VEH_09x',
        coords = vector3(2832.4539, -1414.7710, 45.3944),
        setId = 9
    },
    {
        name   = 'Marvels Of Travel  & Locomotion',
        number = 'Card #10',
        model  = 's_inv_cigcard_VEH_10x',
        coords = vector3(-1096.1108, -578.9144, 82.4161),
        setId = 9
    },
    {
        name   = 'Marvels Of Travel  & Locomotion',
        number = 'Card #11',
        model  = 's_inv_cigcard_VEH_11x',
        coords = vector3(756.4330, -975.4936, 48.7142),
        setId = 9
    },
    {
        name   = 'Marvels Of Travel  & Locomotion',
        number = 'Card #12',
        model  = 's_inv_cigcard_VEH_12x',
        coords = vector3(2488.0071, -1115.8104, 50.3213),
        setId = 9
    },
    -- Fauna Of North America
    {
        name   = 'Fauna Of North America',
        number = 'Card #1',
        model  = 's_inv_cigcard_AML_01x',
        coords = vector3(-2369.2200, 474.2694, 132.2289),
        setId = 10
    },
    {
        name   = 'Fauna Of North America',
        number = 'Card #2',
        model  = 's_inv_cigcard_AML_02x',
        coords = vector3(1465.1240, -1725.7509, 62.2767),
        setId = 10
    },
    {
        name   = 'Fauna Of North America',
        number = 'Card #3',
        model  = 's_inv_cigcard_AML_03x',
        coords = vector3(2008.6644, 621.0639, 158.6559),
        setId = 10
    },
    {
        name   = 'Fauna Of North America',
        number = 'Card #4',
        model  = 's_inv_cigcard_AML_04x',
        coords = vector3(2265.2207, -1217.2723, 42.2189),
        setId = 10
    },
    {
        name   = 'Fauna Of North America',
        number = 'Card #5',
        model  = 's_inv_cigcard_AML_05x',
        coords = vector3(2258.7205, -797.8845, 44.1172),
        setId = 10
    },
    {
        name   = 'Fauna Of North America',
        number = 'Card #6',
        model  = 's_inv_cigcard_AML_06x',
        coords = vector3(2101.3425, -612.4117, 41.8782),
        setId = 10
    },
    {
        name   = 'Fauna Of North America',
        number = 'Card #7',
        model  = 's_inv_cigcard_AML_07x',
        coords = vector3(344.0609, -664.2799, 42.8224),
        setId = 10
    },
    {
        name   = 'Fauna Of North America',
        number = 'Card #8',
        model  = 's_inv_cigcard_AML_08x',
        coords = vector3(2446.5818, 290.0824, 67.2038),
        setId = 10
    },
    {
        name   = 'Fauna Of North America',
        number = 'Card #9',
        model  = 's_inv_cigcard_AML_09x',
        coords = vector3(1874.0229, -775.7093, 42.4603),
        setId = 10
    },
    {
        name   = 'Fauna Of North America',
        number = 'Card #10',
        model  = 's_inv_cigcard_AML_10x',
        coords = vector3(2018.2457, 603.1783, 161.1201),
        setId = 10
    },
    {
        name   = 'Fauna Of North America',
        number = 'Card #11',
        model  = 's_inv_cigcard_AML_11x',
        coords = vector3(218.3478, 984.6891, 190.9001),
        setId = 10
    },
    {
        name   = 'Fauna Of North America',
        number = 'Card #12',
        model  = 's_inv_cigcard_AML_12x',
        coords = vector3(2972.1536, 494.4659, 48.4034),
        setId = 10
    },
    -- The World\'s Champions
    {
        name   = 'The World\'s Champions',
        number = 'Cards #1',
        model  = 's_inv_cigcard_SPT_01x',
        coords = vector3(2540.9097, 697.4770, 80.7458),
        setId = 11
    },
    {
        name   = 'The World\'s Champions',
        number = 'Cards #2',
        model  = 's_inv_cigcard_SPT_02x',
        coords = vector3(-686.6374, 1042.2949, 135.0029),
        setId = 11
    },
    {
        name   = 'The World\'s Champions',
        number = 'Cards #3',
        model  = 's_inv_cigcard_SPT_03x',
        coords = vector3(1445.4869, 374.5126, 89.8868),
        setId = 11
    },
    {
        name   = 'The World\'s Champions',
        number = 'Cards #4',
        model  = 's_inv_cigcard_SPT_04x',
        coords = vector3(2496.8208, -421.2423, 44.3727),
        setId = 11
    },
    {
        name   = 'The World\'s Champions',
        number = 'Cards #5',
        model  = 's_inv_cigcard_SPT_05x',
        coords = vector3(2235.7454, -142.1148, 47.6204),
        setId = 11
    },
    {
        name   = 'The World\'s Champions',
        number = 'Cards #6',
        model  = 's_inv_cigcard_SPT_06x',
        coords = vector3(1186.9805, -102.7468, 94.4628),
        setId = 11
    },
    {
        name   = 'The World\'s Champions',
        number = 'Cards #7',
        model  = 's_inv_cigcard_SPT_07x',
        coords = vector3(2808.5271, -1065.0966, 46.4904),
        setId = 11
    },
    {
        name   = 'The World\'s Champions',
        number = 'Cards #8',
        model  = 's_inv_cigcard_SPT_08x',
        coords = vector3(499.2095, 627.2585, 111.7047),
        setId = 11
    },
    {
        name   = 'The World\'s Champions',
        number = 'Cards #9',
        model  = 's_inv_cigcard_SPT_09x',
        coords = vector3(2878.7476, 1387.3314, 84.0140),
        setId = 11
    },
    {
        name   = 'The World\'s Champions',
        number = 'Cards #10',
        model  = 's_inv_cigcard_SPT_10x',
        coords = vector3(-1020.0111, 1693.1990, 244.3096),
        setId = 11
    },
    {
        name   = 'The World\'s Champions',
        number = 'Cards #11',
        model  = 's_inv_cigcard_SPT_11x',
        coords = vector3(-686.6374, 1042.2949, 135.0029),
        setId = 11
    },
    {
        name   = 'The World\'s Champions',
        number = 'Cards #12',
        model  = 's_inv_cigcard_SPT_12x',
        coords = vector3(2636.7188, -1246.9192, 53.3296),
        setId = 11
    },
    -- Prominent Americans
    {
        name   = 'Prominent Americans',
        number = 'Card #1',
        model  = 'S_INV_CIGCARD_AMER_01X',
        coords = vector3(1052.3210, -1120.3456, 67.8829),
        setId = 12
    },
    {
        name   = 'Prominent Americans',
        number = 'Card #2',
        model  = 'S_INV_CIGCARD_AMER_02X',
        coords = vector3(2132.3665, -640.2084, 42.6086),
        setId = 12
    },
    {
        name   = 'Prominent Americans',
        number = 'Card #3',
        model  = 'S_INV_CIGCARD_AMER_03X',
        coords = vector3(1708.1871, -385.0041, 49.7815),
        setId = 12
    },
    {
        name   = 'Prominent Americans',
        number = 'Card #4',
        model  = 'S_INV_CIGCARD_AMER_04X',
        coords = vector3(-405.5653, 663.2993, 115.5527),
        setId = 12
    },
    {
        name   = 'Prominent Americans',
        number = 'Card #5',
        model  = 'S_INV_CIGCARD_AMER_05X',
        coords = vector3(1415.0455, -1400.0951, 82.1481),
        setId = 12
    },
    {
        name   = 'Prominent Americans',
        number = 'Card #6',
        model  = 'S_INV_CIGCARD_AMER_06X',
        coords = vector3(2274.8926, -1523.3413, 43.6289),
        setId = 12
    },
    {
        name   = 'Prominent Americans',
        number = 'Card #7',
        model  = 'S_INV_CIGCARD_AMER_07X',
        coords = vector3(2360.5107, -1450.2856, 46.0762),
        setId = 12
    },
    {
        name   = 'Prominent Americans',
        number = 'Card #8',
        model  = 'S_INV_CIGCARD_AMER_08X',
        coords = vector3(2636.3364, -925.6525, 43.0660),
        setId = 12
    },
    {
        name   = 'Prominent Americans',
        number = 'Card #9',
        model  = 'S_INV_CIGCARD_AMER_09X',
        coords = vector3(594.8870, 708.9436, 118.5272),
        setId = 12
    },
    {
        name   = 'Prominent Americans',
        number = 'Card #10',
        model  = 'S_INV_CIGCARD_AMER_10X',
        coords = vector3(1391.5024, -836.9624, 68.3656),
        setId = 12
    },
    {
        name   = 'Prominent Americans',
        number = 'Card #11',
        model  = 'S_INV_CIGCARD_AMER_11X',
        coords = vector3(1625.3075, -364.0681, 75.8971),
        setId = 12
    },
    {
        name   = 'Prominent Americans',
        number = 'Card #12',
        model  = 'S_INV_CIGCARD_AMER_12X',
        coords = vector3(2090.5178, -1816.0092, 42.9285),
        setId = 12
    }
}
