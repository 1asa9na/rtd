#define N_CLASSES 2
#define N_PICKUPS 1

#define MAX_CLASS_NAME 10

#define BOMB_CP_EX_ID_OFFSET 200001
#define N_BOMB_CPS 2
#define N_PERKS 4
#define MAX_PERK_NAME 10

#define MAX_KING_CHARGES 10
#define SKILL_ROOK_TOWERS_EX_ID_OFFSET 400001

#define MAX_ZONE_NAME 24
#define N_ZONES 31
#define ZONE_AREA_EX_ID_OFFSET 500001

// CLASS INFO

enum EClassInfo {
	Float:x,
	Float:y,
	Float:z,
	Float:a,
	title[MAX_CLASS_NAME],
	skin,
	class_color,
	class_color_tag
};

new ClassInfo[N_CLASSES][EClassInfo];

// PLAYER INFO

enum EPlayerInfo {
	bool:is_player_spawned,
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

enum ESkillKingChargeInfo {
	skc_objectid[MAX_KING_CHARGES],
	skc_amount
}

new SkillKingChargeInfo[MAX_PLAYERS][ESkillKingChargeInfo];

enum ESkillRookTowerInfo {
	srt_objectid,
	srt_areaid,
	srt_targetid,
	srt_particleid,
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

new CPInfo[N_BOMB_CPS][ECPInfo];

// ZONE INFO

enum EZoneInfo {
	z_name[MAX_ZONE_NAME],
	Float:z_minx,
	Float:z_miny,
	Float:z_maxx,
	Float:z_maxy,
	z_team,
	z_cp,
	bool:z_is_active,
	Float: z_cp_x,
	Float: z_cp_y,
	Float: z_cp_z,
	z_progress,
	z_timer,
	z_attacker,
	Text:z_textdraw
}

new ZoneInfo[N_ZONES][EZoneInfo];