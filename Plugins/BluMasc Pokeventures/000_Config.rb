#-------------------------------------------------------------------------------
# Adventure: code for sending pokemon adventuring
#-------------------------------------------------------------------------------
module PokeventureConfig
  Updatesteps = 25 # How many steps should be taken before the Adventure progresses
  CustomMusic = "Mystery Dungeon Guild" # Custom music to play in the menue. Must be in the BGM folder
  #Item Collection
  CollectRandomItem = true #Collect Items from the Table below
  CollectItemsFromBattles = true # Collect Items from defeated Pokemon
  Items = {
    :common => [:EXPCANDYXS, :EXPCANDYS, :EXPCANDYM, :POKETOY, :POKEBALL, :FRESHWATER, :REPEL],
    :uncommon => [:TR00,:TR01,:TR02,:TR03,:TR04,:TR05,:TR06,:TR07,:TR08,:TR09,:TR10,:TR11,
					:TR12,:TR13,:TR14,:TR15,:TR16,:TR17,:TR18,:TR19,:TR20,:TR21,:TR22,:TR23,
					:TR24,:TR25,:TR26,:TR27,:TR28,:TR29,:TR30,:TR31,:TR32,:TR33,:TR34,:TR35,
					:TR36,:TR37,:TR38,:TR39,:TR40,:TR41,:TR42,:TR43,:TR44,:TR45,:TR46,:TR47,
					:TR48,:TR49,:TR50,:TR51,:TR52,:TR53,:TR54,:TR55,:TR56,:TR57,:TR58,:TR59,
					:TR60,:TR61,:TR62,:TR63,:TR64,:TR65,:TR66,:TR67,:TR68,:TR69,:TR70,:TR71,
					:TR72,:TR73,:TR74,:TR75,:TR76,:TR77,:TR78,:TR79,:TR80,:TR81,:TR82,:TR83,
					:TR84,:TR85,:TR86,:TR87,:TR88,:TR89,:TR90,:TR91,:TR92,:TR93,:TR94,:TR95,
					:TR96,:TR97,:TR98,:TR99],
	:rare => [:EXPCANDYXL, :LEMONADE, :ENERGYROOT, :RELICSTATUE, :PEARL, 
				  :BIGPEARL, :SUPERREPEL],  
    :ultrarare => [:MASTERBALL, :ABILITYPATCH, :BOTTLECAP, :GOLDBOTTLECAP, :BEASTBALL, :ABILITYCAPSULE, :PEARLSTRING],
  }
  ChanceToGetEnemyItem = 5 # as a 1 in x chance
  # Friends
  FindFriends = true # If there is Space should there be a chance for wild pokèmon to join you.
  ChanceToFindFriend = 1 # as a 1 in x chance
  AreFoundFriendsBrilliant = true #have higher ivs and a higher shiny chance
  # Exp
  GainExp = true # should the pokemon gain exp through adventuring
  # Wild Pokemon
  GlobalPkmn = true # should this script use the global encounter list everywhere instead of the specific map encounters.
  PkmnList = [:PIKACHU,:CHARMANDER,:SQUIRTLE,:BULBASAUR,:EEVEE]
  GlobalLeveling = true # makes the level of the encounters balanced around the number of badges instead of the location (always on if globalPkmn is on)
  #level per badge [min,max] can add more if you have more badges in your game
  PkmnLevel = [
	[2,10],		#0 Badges
	[11,20],	#1 Badge
	[21,30],	#2 Badges...
	[31,40],
	[41,50],
	[51,60],
	[61,70],
	[71,80],
	[81,90]		#8Badges
  ]
  # Trigering Abilities
  # Enter all the functions of Abilities that should be triggered after battle here (like Pickup and Honeygather )
  def self.pbAdventureAbilities(pkmn)
	pbPickup(pkmn)
	pbHoneyGather(pkmn)
  end
end

#-------------------------------------------------------------------------------
# EncounterTypes
#-------------------------------------------------------------------------------
GameData::EncounterType.register({
  :id => :Adventure,
  :type => :none,
  :trigger_chance => 1,
  :old_slots => [50, 20, 10, 5, 5, 5, 5],
})

SaveData.register(:adventure_party) do
  ensure_class :Adventure 
  save_value { $Adventure  }
  load_value { |value| $Adventure = value }
  new_game_value {
    Adventure.new
  }
end

Events.onStepTaken += proc { |_sender,_e|
  $Adventure.newStep
}

