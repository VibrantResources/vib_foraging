Info:

# BEFORE YOU BEGIN, MAKE SURE YOU'VE ADDED THE BELOW ITEMS TO YOUR ITEMS.LUA & THE IMAGES FROM OUR IMAGES FOLDER

DOCUMENTATION: https://vibrantrp.gitbook.io/vibrant-documentation/beefarm

# ITEMS
## OX Items
```lua
 	['schwingleborp_mushrooms'] = {
		label = 'Schwingleborp Mushrooms',
		weight = 100,
		stack = false,
		close = true,
		description = "Some schwingling mushrooms",
	},

	['squishybop_mushrooms'] = {
		label = 'Squishybop Mushrooms',
		weight = 100,
		stack = true,
		close = true,
		description = "Some Squishy, bopping mushrooms",
	},
```

# HOW-TO GUIDE

Mushroom areas can be created within the Config but names of each zone NEED to be unqique as they are used for each zones cooldown and automatic clean up system

After selecting a zone, two timers are started; One being the zone cooldown and the other beig a cleanup. The cleanup timer checks whether the player ever arrived at the zone within a certain time frame. If NOT then the zone cleans itself and the player loses the chance to forage

When interacting with the spawned locals, the player has a chance to receive an aggressive reaction, causing the NPC's the attack the player

Foraged mushrooms can be sold back to the NPC for money

## Special thanks to Baubles for the suggestions