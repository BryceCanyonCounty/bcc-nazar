# bcc-nazar

#### Discover Hidden Riches with Madam Nazar!
Are you ready to embark on a thrilling quest for hidden treasures in the wild frontier of RedM? Meet Madam Nazar, the enigmatic and ever-changing merchant who holds the key to your fortune!

## Features

- Spawns Madam Nazar at a random location at server start/restart
- Enable or disable a blip on Madam Nazar's location
- Madam Nazar can give the player a treasure chest to find and gain rewards
- The chests are on a global cooldown (when a player starts a hunt, no one else can start a hunt for the specified time)
- Madam Nazar can buy and sell things making her a good option for a moving black market
- Create as many treasure hunt locations as you want
- Webhooks to track player actions
- Option to have a wagon spawn with nazar
- Version check to help you keep up to date on new features and bug fixes!
- Option to set the type of currency for items in nazars shop! (Cash/Gold/Rol)
- Option to enable her music from RDO to play when near!
- Card Collecting Added! (Spawns cards around the map at set coords. Use a card in inventory to view in your hand.)
- Feature to pack cards of same type in a box (can unpack too)

## Dependencies

- [vorp_core](https://github.com/VORPCORE/vorp-core-lua)
- [vorp_inventory](https://github.com/VORPCORE/vorp_inventory-lua)
- [feather-menu](https://github.com/FeatherFramework/feather-menu/releases)
- [bcc-utils](https://github.com/BryceCanyonCounty/bcc-utils)

## Installation

- Make sure dependencies are installed/updated and ensured before this script
- Add `bcc-nazar` folder to your resources folder
- Add `ensure bcc-nazar` to your resources.cfg
- Run the included database file `nazar.sql`
- Add images from `img` folder to: `...\vorp_inventory\html\img\items`
- Restart server

## GitHub
https://github.com/BryceCanyonCounty/bcc-nazar
