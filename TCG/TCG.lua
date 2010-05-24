--TCG.lua

H = wesnoth.require "lua/helper.lua"

--WML constructs
W = H.set_wml_action_metatable{} --Treats tags as callable functions.
T = H.set_wml_tag_metatable{} --For subtags.
V = H.set_wml_var_metatable{} --Contains WML variables.

_ = wesnoth.textdomain "tcg"

local unitTypeList = {

    --Core--

    --0
    'Vampire Bat',
    'Goblin Spearman',
    'Peasant',
    'Ruffian',
    'Woodsman',
    'Mudcrawler',
    'Walking Corpse',

    --1
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

    --2
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

    --3
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

    --4
    'Armageddon Drake',
    'Elvish Sylph',
    'Great Mage',
    'Grand Marshal',
    'Yeti',
    'Ancient Lich',
    'Skeletal Dragon',

    --5
    'Elder Mage',
    'Fire Dragon',

    --RPG Creation Kit--

    --0
    'Ram',
    'Tusklet',
    'Elvish Villager',
    'Goblin Axeman',
    'Goblin Slave',
    'Goblin Tamer',
    'Initiate',
    'Noble Squire',
    'Noble Youth',
    'Nobleman',
    'Vagrant',
    'Brute',
    'Civilian',
    'Farmhand',
    'Rancher',
    'Squire',
    'Swampcrawler',
    'Spirit',
    'Walking Bones',
    'Wose Sapling',

    --1
    'Arctic Wolf',
    'Dog',
    'Giant Ant',
    'Giant Crow',
    'Razorbird',
    'Tusker',
    'White Unicorn',
    'Elvish Tracker',
    'Goblin Chopper',
    'Goblin Roc Rider',
    'Druid Minor',
    'Warrior Mage',
    'Noble Fighter',
    'Royal Fighter',
    'Outcast',
    'Cavalry Archer',
    'Giant Swampcrawler',
    'Silver Hydra',
    'Naga Archer',
    'Orcish Shaman',
    'Mkodo Stalk',
    'Troll Dabbler',

    --2
    'Gorer',
    'Goblin Roc Master',
    'Avatar',
    'Druid',
    'Witch',
    'Noble Commander',
    'Princess',
    'Royal Commander',
    'Outcast Lady',
    'Cockatrice',
    'Green Hydra',
    'Orcish Warlock',
    'Orcish Witch Doctor',
    'Mkodo Tree',
    'Troll Firethrower',
    'Death Baron',
    'Skeleton Rider',
    'Sorcerer Warrior',
    'Wose Shaman',

    --3
    'Dire Wolf',
    'Druid Elder',
    'Battle Princess',
    'Noble Lord',
    'Queen',
    'Royal Lord',
    'Outcast Leader',
    'Captain',
    'Black Hydra',
    'Naga Abomination',
    'Troll Boulderlobber',
    'Troll Firemaster',
    'Necromancer Warrior',

    --4
    'Orcish Champion',
    'Arch Necromancer',

    --Era of Myths--

    --0
    'EOM_Sneak',
    'EOM_Air',
    'EOM_Bloodborn',
    'EOM_Wolf_Cub',
    'EOM_Sky_Shard',

    --1
    'EOM_Crusader',
    'EOM_Legionnaire',
    'EOM_Light_Spirit',
    'EOM_Messenger',
    'EOM_Wizard',
    'EOM_Zealot',
    'EOM_Flappers',
    'EOM_Nailers',
    'EOM_Overgrown_Devling',
    'EOM_Lurker',
    'EOM_Cursers',
    'EOM_Fire',
    'EOM_Razorbird',
    'EOM_Wind_Spirit',
    'EOM_Earth',
    'EOM_Water',
    'EOM_Unicorn',
    'EOM_Vine_Beast',
    'EOM_Falcon',
    'EOM_Cat',
    'EOM_Serpent',
    'EOM_Therian_Hunter',
    'EOM_Therian_Guard',
    'EOM_Therian_Monk',
    'EOM_Therian_Apprentice',
    'EOM_Blood_Apprentice',
    'EOM_Malborn',
    'EOM_Fledgeling',
    'EOM_Thin_Blood',
    'EOM_Gargoyle',
    'EOM_Shapeshifter',
    'EOM_Stalker',
    'EOM_Warrior_Wolf',
    'EOM_Wolf',
    'EOM_Fire_Sprite',
    'EOM_Blackfur',
    'EOM_Water_Dryad',
    'EOM_Courier',
    'EOM_Sky_Crystal',
    'EOM_Weaver',
    'EOM_Seeker',
    'EOM_Gatekeeper',
    'EOM_Scribe',

    --2
    'EOM_Divine_Knight',
    'EOM_Protector',
    'EOM_Quester',
    'EOM_Keeper',
    'EOM_Lantern_Archon',
    'EOM_Claimant',
    'EOM_Great_Wizard',
    'EOM_Mystic',
    'EOM_Militant',
    'EOM_Flyers',
    'EOM_Spikers',
    'EOM_Devling_Soldier',
    'EOM_Devling_Warrior',
    'EOM_Blasphemists',
    'EOM_Fire_Wisp',
    'EOM_Living_Furnace',
    'EOM_Thunderbird',
    'EOM_Zephyr',
    'EOM_Rock_Golem',
    'EOM_Ice_Crab',
    'EOM_Undine',
    'EOM_Silver_Unicorn',
    'EOM_Vine_Tiger',
    'EOM_Prairie_Falcon',
    'EOM_Wildcat',
    'EOM_Cobra',
    'EOM_Sandskipper',
    'EOM_Sea_Snake',
    'EOM_Therian_Tracker',
    'EOM_Therian_Defender',
    'EOM_Aura_Monk',
    'EOM_Therian_Mage',
    'EOM_Therian_Shaman',
    'EOM_Blood_Manipulator',
    'EOM_Flesh_Artisan',
    'EOM_Duelist',
    'EOM_Noble',
    'EOM_Half_Blood',
    'EOM_Marlgoyle',
    'EOM_Blood_Hulk',
    'EOM_Changeling',
    'EOM_Shadow_Pelt',
    'EOM_Rabid_Wolf',
    'EOM_Warrior_Warg',
    'EOM_Dire_Wolf',
    'EOM_Flame_Sprite',
    'EOM_Black_Hunter',
    'EOM_Water_Nymph',
    'EOM_Emissary',
    'EOM_Reaver',
    'EOM_Envoy',
    'EOM_Prophetess',
    'EOM_Pathfinder',
    'EOM_Skyrunner',
    'EOM_Heretic',
    'EOM_Lorekeeper',
    'EOM_Savant',

    --3
    'EOM_Divine_Champion',
    'EOM_Holy_Sentinel',
    'EOM_Sentinel',
    'EOM_Master_of_Light',
    'EOM_Herald',
    'EOM_Prophet',
    'EOM_Sage',
    'EOM_Sicarius',
    'EOM_Attackers',
    'EOM_Staplers',
    'EOM_Devling_Chief',
    'EOM_Devling_Hero',
    'EOM_Offenders',
    'EOM_Fire_Ghost',
    'EOM_Lava_Beast',
    'EOM_Djinn',
    'EOM_Stone_Titan',
    'EOM_Ice_Shell',
    'EOM_Tempest_Spirit',
    'EOM_Gyrfalcon',
    'EOM_Peregrine_Falcon',
    'EOM_Panther',
    'EOM_Tiger',
    'EOM_King_Cobra',
    'EOM_Spitting_Cobra',
    'EOM_Therian_Ranger',
    'EOM_Aura_Master',
    'EOM_Therian_Master',
    'EOM_Therian_Priest',
    'EOM_Sangel',
    'EOM_Sire',
    'EOM_Sword_Dancer',
    'EOM_Day_Hunter',
    'EOM_Twilight_Walker',
    'EOM_Wolfling',
    'EOM_Night_Eye',
    'EOM_Fenrir',
    'EOM_Moon_Blade',
    'EOM_Pack_Leader',
    'EOM_Flame_Spirit',
    'EOM_Water_Shyde',
    'EOM_Reaver',
    'EOM_Ascendant',
    'EOM_Windsong_Herald',
    'EOM_Farstrider',
    'EOM_Stormbringer',
    'EOM_Harbinger',
    'EOM_Oathkeeper',
    'EOM_Arbiter',
    'EOM_Runeforger',

    --4
    'EOM_Seraph',
    'EOM_Abusers',
    'EOM_Methusalem',
    'EOM_Garou',
    'EOM_Librarian',

}

--This is an interface to the WML variables that store the recruit lists.
local recruitList = {}

function recruitList.__newindex(t, i, type)
    V.recruits[wesnoth.current.side]['_'..i] = type
end

function recruitList.__index(t, i)
    return V.recruits[wesnoth.current.side]['_'..i]
end

setmetatable(recruitList, recruitList)

--Copies the internal recruit list to the real recruit list.
local function setRecruitList()
    local recruit = ''
    for i = 1, V.recruitListSize do
	local type = recruitList[i]
	if type then
	    recruit = recruit .. type .. ','
	end
    end
    W.set_recruit{
	side = wesnoth.current.side,
	recruit = recruit
    }
end

--Fills all empty slots with randomly selected types from unitTypeList.
--Obliterates: v
local function fillRecruitList()
    for i = 1, V.recruitListSize do
	if not recruitList[i] then
	    W.set_variable{
		name = 'v',
		rand = '1..' .. #unitTypeList
	    }
	    recruitList[i] = unitTypeList[V.v]
	end
    end
    V.v = nil
    setRecruitList()
end

--Removes the last instance of V.unit.type from the recruit list.
local function removeType()
    for i = V.recruitListSize, 1, -1 do
	if recruitList[i] == V.unit.type then
	    recruitList[i] = nil
	    setRecruitList()
	    break
	end
    end
end

--Returns an array of hexes.
--wml: WML table to send to the [store_locations] tag. (The variable is
--automatically provided.)
--Obliterates: v
local function getLocations(wml)
    wml.variable = 'v'
    W.store_locations(wml)
    local hexes = H.get_variable_array(wml.variable)
    V[wml.variable] = nil
    return hexes
end

--Used for scanning the map. Stores its own dimensions and a boolean for each
--hex which is true if it has been checked.
local Map = {}

function Map:new()
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.xMax, o.yMax = wesnoth.get_map_size()
    for i = 1, o.xMax do
	o[i] = {}
    end
    return o
end

--Counts the tiles in the castle that hex is in.
--hex: The tile to start counting from.
function Map:countCastle(hex)
    local x = hex.x
    local y = hex.y
    if self[x][y] then
	return 0
    else
	self[x][y] = true
	local hexes = getLocations{
	    x = x,
	    y = y,
	    radius = 1,
	    T.filter_radius{
		terrain = 'K*,C*'
	    }
	}
	local result = 1
	for i, h in ipairs(hexes) do
	    result = result + self:countCastle(h)
	end
	return result
    end
end

--Returns the recruitment capacity of the largest castle.
function Map:biggestCastle()

    --Returns a string representing a range from 1 to n.
    --n: The maximum value of the range.
    local function range(n)
	return '1-' .. n
    end

    keeps = getLocations{
	terrain = 'K*',
	x = range(self.xMax),
	y = range(self.yMax)
    }
    local result = 0
    for i, hex in ipairs(keeps) do
	result = math.max(result, self:countCastle(hex) - 1)
    end
    return result
end

--Initializes a TCG battle.
--size: Size of the recruit list. Default is the biggest castle size on the map.
wesnoth.register_wml_action(
    'tcg_init',
    function(cfg)
	size = tonumber(cfg.size)
	if size then
	    V.recruitListSize = size
	else
	    local map = Map:new()
	    V.recruitListSize = map:biggestCastle()
	end
	V.recruits = {}
	local i = 1
	while wesnoth.get_side(i) do
	    V.recruits[i] = {}
	    i = i + 1
	end
    end)

--Fills the empty slots in the current side's recruit list with random unit
--types.
wesnoth.register_wml_action('fill_recruit_list', fillRecruitList)

--Removes the last instance of unit.type from the current side's recruit list.
wesnoth.register_wml_action('remove_type', removeType)

--Removes one instance of unit.type from the current side's recruit list and
--refills the list.
wesnoth.register_wml_action(
    'replace_type',
    function()
	removeType()
	fillRecruitList()
    end)

--Tells the player exactly what is in their Lua-defined recruit list. Useful for
--finding out which unit type, if any, has been duplicated.
wesnoth.register_wml_action(
    'show_recruit',
    function()
	local message = ''
	for i = 1, V.recruitListSize do
	    local type = ''
	    if recruitList[i] then
		type = wesnoth.get_unit_type(recruitList[i]).name
	    end
	    message = message..i..': '..type.."\n"
	end
	W.message{
	    speaker = 'narrator',
	    side_for = wesnoth.current.side,
	    message = message
	}
    end)
