H = wesnoth.require "lua/helper.lua"
W = H.set_wml_action_metatable{} -- Treats tags as callable functions.
_ = wesnoth.textdomain "tcg"

WV = H.set_wml_var_metatable{} -- Contains WML variables.

local unitTypeList = {
   'Vampire Bat',
   'Goblin Spearman',
   'Peasant',
   'Ruffian',
   'Woodsman',
   'Mudcrawler',
   'Walking Corpse',
   'Blood Bat',
   'Drake Burner',
   'Drake Clasher',
   'Drake Fighter',
   'Drake Glider',
   'Dwarvish Fighter',
   'Dwarvish Guardsman',
   'Dwarvish Scout',
   'Dwarvish Thunderer',
   'Dwarvish Ulfserker',
   'Elvish Archer',
   'Elvish Fighter',
   'Elvish Scout',
   'Elvish Shaman',
   'Goblin Impaler',
   'Goblin Rouser',
   'Gryphon Rider',
   'Cavalryman',
   'Dark Adept',
   'Fencer',
   'Heavy Infantryman',
   'Horseman',
   'Mage',
   'Bowman',
   'Spearman',
   'Footpad',
   'Thug',
   'Sergeant',
   'Thief',
   'Poacher',
   'Saurian Augur',
   'Saurian Skirmisher',
   'Pirate Galleon',
   'Transport Galleon',
   'Mermaid Initiate',
   'Merman Fighter',
   'Merman Hunter',
   'Giant Scorpion',
   'Giant Mudcrawler',
   'Tentacle of the Deep',
   'Naga Fighter',
   'Young Ogre',
   'Orcish Archer',
   'Orcish Assassin',
   'Orcish Grunt',
   'Orcish Leader',
   'Troll Whelp',
   'Ghost',
   'Ghoul',
   'Skeleton',
   'Skeleton Archer',
   'Soulless',
   'Wolf',
   'Wolf Rider',
   'Wose',
   'Dread Bat',
   'Drake Flare',
   'Fire Drake',
   'Drake Arbiter',
   'Drake Thrasher',
   'Drake Warrior',
   'Sky Drake',
   'Dwarvish Steelclad',
   'Dwarvish Stalwart',
   'Dwarvish Pathfinder',
   'Dwarvish Thunderguard',
   'Dwarvish Berserker',
   'Elvish Marksman',
   'Elvish Ranger',
   'Elvish Captain',
   'Elvish Hero',
   'Elvish Lord',
   'Elvish Rider',
   'Elvish Druid',
   'Elvish Sorceress',
   'Gryphon',
   'Gryphon Master',
   'Dragoon',
   'Dark Sorcerer',
   'Duelist',
   'Shock Trooper',
   'Knight',
   'Lancer',
   'Red Mage',
   'White Mage',
   'Longbowman',
   'Javelineer',
   'Pikeman',
   'Swordsman',
   'Outlaw',
   'Bandit',
   'Lieutenant',
   'Rogue',
   'Trapper',
   'Saurian Oracle',
   'Saurian Soothsayer',
   'Saurian Ambusher',
   'Mermaid Enchantress',
   'Mermaid Priestess',
   'Merman Warrior',
   'Merman Netcaster',
   'Merman Spearman',
   'Cuttle Fish',
   'Water Serpent',
   'Naga Warrior',
   'Ogre',
   'Orcish Crossbowman',
   'Orcish Slayer',
   'Orcish Warrior',
   'Orcish Ruler',
   'Troll Hero',
   'Troll Shaman',
   'Troll',
   'Troll Rocklobber',
   'Chocobone',
   'Shadow',
   'Wraith',
   'Necrophage',
   'Deathblade',
   'Revenant',
   'Bone Shooter',
   'Goblin Knight',
   'Goblin Pillager',
   'Elder Wose',
   'Drake Flameheart',
   'Inferno Drake',
   'Drake Warden',
   'Drake Enforcer',
   'Drake Blademaster',
   'Hurricane Drake',
   'Dwarvish Lord',
   'Dwarvish Sentinel',
   'Dwarvish Runemaster',
   'Dwarvish Explorer',
   'Dwarvish Dragonguard',
   'Elvish Sharpshooter',
   'Elvish Avenger',
   'Elvish Marshal',
   'Elvish Champion',
   'Elvish High Lord',
   'Elvish Outrider',
   'Elvish Shyde',
   'Elvish Enchantress',
   'Cavalier',
   'Lich',
   'Necromancer',
   'Master at Arms',
   'Iron Mauler',
   'Grand Knight',
   'Paladin',
   'Arch Mage',
   'Silver Mage',
   'Mage of Light',
   'Master Bowman',
   'Halberdier',
   'Royal Guard',
   'Royal Warrior',
   'Fugitive',
   'Highwayman',
   'General',
   'Assassin',
   'Huntsman',
   'Ranger',
   'Saurian Flanker',
   'Mermaid Siren',
   'Mermaid Diviner',
   'Merman Hoplite',
   'Merman Triton',
   'Merman Entangler',
   'Merman Javelineer',
   'Giant Spider',
   'Sea Serpent',
   'Naga Myrmidon',
   'Orcish Slurbow',
   'Orcish Warlord',
   'Orcish Sovereign',
   'Great Troll',
   'Troll Warrior',
   'Death Knight',
   'Nightgaunt',
   'Spectre',
   'Draug',
   'Banebow',
   'Direwolf Rider',
   'Ancient Wose',
   'Armageddon Drake',
   'Elvish Sylph',
   'Great Mage',
   'Grand Marshal',
   'Yeti',
   'Ancient Lich',
   'Skeletal Dragon',
   'Elder Mage',
   'Fire Dragon',
}

minimumGold = 5
minimumGoldHelp =
   'You must have at least '..minimumGold..' gold to summon a unit.'

--! @returns leader for the current side.
local function getLeader()
   return wesnoth.get_units({side = WV.side_number, canrecruit = true})[1]
end

function randomUnit()
   local side = wesnoth.get_side(WV.side_number)
   local leader = getLeader()

   if side.gold < minimumGold then
      W.message{speaker = 'narrator', side_for = WV.side_number,
		message = minimumGoldHelp}

   -- If the side has no leader, do nothing.
   elseif leader then
      local x, y = wesnoth.find_vacant_tile(leader.x, leader.y)

      W.set_variable{name = 'typeN', rand = '1..'..#unitTypeList}
      local type = unitTypeList[WV.typeN]
      WV.typeN = nil

      local cost = wesnoth.get_unit_type(type).cost
      side.gold = side.gold - cost

      W.unit{x = x, y = y,
	     side = WV.side_number,
	     type = type,
	     animate = true,
	     moves = 0}
   end
end

wesnoth.register_wml_action('random_unit', randomUnit)

wesnoth.register_wml_action('auto_random_unit', function()
   local side = wesnoth.get_side(WV.side_number)

   if getLeader() then
      while side.gold >= minimumGold do
	 randomUnit()
      end
   end
end)

wesnoth.register_wml_action('help', function()
   W.message{speaker = 'narrator',
	     side_for = WV.side_number,
	     message = 'Right-click and choose the "Summon" command. A unit will appear next to your leader. You will be charged the cost of the unit that appears. '..minimumGoldHelp..' Remember to summon as much as possible!'}
end)
