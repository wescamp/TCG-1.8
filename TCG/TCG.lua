--TCG.lua - Provides tags for use in TCG eras

H = wesnoth.require "lua/helper.lua"

--WML constructs
W = H.set_wml_action_metatable{} --Treats tags as callable functions.
T = H.set_wml_tag_metatable{} --For subtags
V = H.set_wml_var_metatable{} --Contains WML variables.

_ = wesnoth.textdomain "tcg"

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

--This is a proxy for Wesnoth's recruit list that has a fixed length and allows
--duplicates. Every time it changes, it will be copied to the current side's
--real recruit list and to WML variables.
local RecruitList = {}

--If this is a savegame, restores data from WML variables. Otherwise, all
--entries will be nil.
function RecruitList:new()
   local list = {}
   setmetatable(list, self)
   self.__index = self
   local side = V.side_number
   for i = 1, V.recruitListSize do
      list[i] = V['recruitList' .. side .. '_' .. i]
   end
   return list
end

--Copies self to the Wesnoth recruit list and to WML variables.
function RecruitList:set()
   local side = V.side_number
   local recruit = ''
   for i = 1, V.recruitListSize do
      local type = self[i]
      V['recruitList' .. side .. '_' .. i] = type
      if type then
	 recruit = recruit .. type .. ','
      end
   end
   W.set_recruit{
      side = side,
      recruit = recruit
   }
end

--Fills all empty slots with randomly selected types from unitTypeList.
function RecruitList:fill()
   for i = 1, V.recruitListSize do
      if not self[i] then
	 W.set_variable{
	    name = 'typeN',
	    rand = '1..' .. #unitTypeList
	 }
	 self[i] = unitTypeList[V.typeN]
      end
   end
   V.typeN = nil
   self:set()
end

--Removes one instance of V.unit.type from self.
--i: Used only in recursion.
function RecruitList:remove(i)
   i = i or V.recruitListSize
   local type = V.unit.type
   if i < 1 then
      wesnoth.message(
	 'TCG: RecruitList:remove: ' .. type .. _' not on recruit list')
   elseif self[i] == type then
      self[i] = nil
      self:set()
   else
      self:remove(i - 1)
   end
end

function RecruitList:__tostring()
   local result = ''
   for i = 1, V.recruitListSize do
      local type = self[i] or ''
      result = result .. i .. ': ' .. type .. "\n"
   end
   return result
end

--Returns an array of hexes.
--wml: WML table to send to the [store_locations] tag. (The variable is
--automatically provided and will be cleared after use.)
local function getLocations(wml)
   wml.variable = 'hexes'
   W.store_locations(wml)
   local hexes = H.get_variable_array(wml.variable)
   V[wml.variable] = nil
   return hexes
end

--Used for scanning the map. Stores its own dimensions and a boolean for each
--hex which is true if it has been checked.
local Map = {}

function Map:new()
   local map = {}
   setmetatable(map, self)
   self.__index = self
   map.xMax, map.yMax = wesnoth.get_map_size()
   for i = 1, map.xMax do
      map[i] = {}
   end
   return map
end

--Counts the tiles in the castle that hex is in.
--hex: The tile to start counting from.
function Map:countCastle(hex)
   local x = hex.x
   local y = hex.y
   if self[x][y] or not wesnoth.get_terrain_info(hex.terrain).castle then
      return 0
   else
      self[x][y] = true
      local hexes = getLocations{
	 x = x,
	 y = y,
	 radius = 1
      }
      local result = 1
      for i, h in ipairs(hexes) do
	 result = result + self:countCastle(h)
      end
      return result
   end
end

local recruitLists = {}

--If the current side doesn't have a RecruitList, make a new one.
local function confirmList()
   local side = V.side_number
   if not recruitLists[side] then
      recruitLists[side] = RecruitList:new()
   end
end

--Remove one instance of V.unit.type from the current side's RecruitList.
local function removeType()
   confirmList()
   recruitLists[V.side_number]:remove()
end

--Returns the recruitment capacity of the largest castle.
local function biggestCastle()
   keeps = getLocations{
      terrain = 'K*'
   }
   local map = Map:new()
   local result = 0
   for i, hex in ipairs(keeps) do
      result = math.max(result, map:countCastle(hex) - 1)
   end
   return result
end

--Sets the maximum size for recruit lists. Will not be preserved in savegames
--unless used in a preload event.
--n: Number of slots. Default is the biggest castle size on the map.
wesnoth.register_wml_action(
   'set_recruit_list_size',
   function(cfg)
      V.recruitListSize = cfg.n or biggestCastle()
   end)

--Fills the empty slots in the current side's recruit list with random unit
--types.
wesnoth.register_wml_action(
   'fill_recruit_list',
   function()
      confirmList()
      recruitLists[V.side_number]:fill()
   end)

--Removes one instance of unit.type from the current side's recruit list.
wesnoth.register_wml_action('remove_type', removeType)

--Removes one instance of unit.type from the current side's recruit list and
--refills the list.
wesnoth.register_wml_action(
   'replace_type',
   function()
      removeType()
      recruitLists[V.side_number]:fill()
   end)

local idShowRecruit = 'show_recruit'

--Shows recruit list to the player.
wesnoth.register_wml_action(
   idShowRecruit,
   function()
      local side = V.side_number
      W.message{
	 side_for = side,
	 message = tostring(recruitLists[side])
      }
   end)

--Sets a menu item that tells the player exactly what is in their Lua-defined
--recruit list. Useful for finding out which unit type, if any, has been
--duplicated.
wesnoth.register_wml_action(
   'menu_' .. idShowRecruit,
   function()
      W.set_menu_item{
	 id = idShowRecruit,
	 description = _'Show actual recruit list',
	 T.command{
	    T[idShowRecruit]{}
	 }
      }
   end)
