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

local RecruitList = {}

function RecruitList:new()
   local list = {}
   setmetatable(list, self)
   self.__index = self
   local side = WV.side_number
   for i = 1, recruitListSize do
      list[i] = WV['recruitList'..side..'_'..i]
   end
   return list
end

function RecruitList:set()
   local side = WV.side_number
   local recruit = ''
   for i = 1, recruitListSize do
      local type = self[i]
      WV['recruitList'..side..'_'..i] = type
      if type then
	 recruit = recruit..type..','
      end
   end
   W.set_recruit{side = side, recruit = recruit}
end

function RecruitList:fill()
   for i = 1, recruitListSize do
      if not self[i] then
	 W.set_variable{name = 'typeN', rand = '1..'..#unitTypeList}
	 self[i] = unitTypeList[WV.typeN]
      end
   end
   WV.typeN = nil
   self:set()
end

function RecruitList:remove(i)
   i = i or recruitListSize
   local type = WV.unit.type
   if i < 1 then
      wesnoth.message(
	 'TCG: RecruitList:remove: '..type..' not on recruit list.')
   elseif self[i] == type then
      self[i] = nil
      self:set()
   else
      self:remove(i - 1)
   end
end

local recruitLists = {}

local function confirmList()
   local side = WV.side_number
   if not recruitLists[side] then
      recruitLists[side] = RecruitList:new()
   end
end

local function removeType()
   confirmList()
   recruitLists[WV.side_number]:remove()
end

wesnoth.register_wml_action(
   'set_recruit_list_size',
   function(cfg)
      recruitListSize = cfg.n
   end
)

wesnoth.register_wml_action(
   'fill_recruit_list',
   function()
      confirmList()
      recruitLists[WV.side_number]:fill()
   end
)

wesnoth.register_wml_action('remove_type', removeType)

wesnoth.register_wml_action(
   'replace_type',
   function()
      removeType()
      recruitLists[WV.side_number]:fill()
   end
)
