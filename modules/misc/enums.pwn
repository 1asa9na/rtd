#define N_CLASSES 2
#define N_PICKUPS 1
#define N_CPS 3
#define N_PERKS 4
#define MAX_PERK_NAME 10

#define SKILL_KING_CHARGES_EX_ID_OFFSET 400001

// CLASS INFO

enum EClassInfo {
	Float:x,
	Float:y,
	Float:z,
	Float:a,
	title[32],
	skin,
	color
};

new ClassInfo[N_CLASSES][EClassInfo];

// PLAYER INFO

enum EPlayerInfo {
	bool:is_player_spawned,
	kills,
	deaths,
	bool:is_carrying_bomb,
	PlayerText:current_textdraw,
	player_vehicle,
	player_perk,
	bool:player_change_team,
	player_drunk_timer,
	bool:player_stinger,
	player_stinger_missile
};

new PlayerInfo[MAX_PLAYERS][EPlayerInfo];

// ROOK TOWER INFO

enum ESkillRookTowerInfo {
	srt_objectid,
	srt_areaid,
	srt_timerid,
	bool:srt_is_created
}

new SkillRookTowerInfo[MAX_PLAYERS][ESkillRookTowerInfo];

// PERK INFO

enum EPerkInfo {
	perk_health,
	perk_armour,
	perk_weapons[3],
	perk_weapon_ammo[3],
	perk_title[MAX_PERK_NAME]
}

new PerkInfo[N_PERKS][EPerkInfo];

// PICKUP INFO

enum EPickupInfo {
	bool:is_picked_up,
	picked_up_by_team,
	Float:pickup_x,
	Float:pickup_y,
	Float:pickup_z,
	pickup_object,
	pickup_mapicon,
	pickup_timer
}

new PickupInfo[N_PICKUPS][EPickupInfo];

// CP INFO

enum ECPInfo {
	cp_player,
	cp_team,
	bool:occupied,
	Float:cp_x,
	Float:cp_y,
	Float:cp_z,
	cp_mapicon,
	cp_bomb_timer,
	cp_defuse_timer,
	bool:is_active
}

new CPInfo[N_CPS][ECPInfo];