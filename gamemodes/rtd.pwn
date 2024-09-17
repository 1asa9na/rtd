#include <a_samp>
#include <Pawn.CMD>
#include <streamer>
#include <sscanf2>
#include <ColAndreas>
#include <YSI_Coding\y_hooks>
#include "..\modules\misc\consts.pwn"
#include "..\modules\misc\enums.pwn"
#include "..\modules\features\weapons.pwn"

/* OFFSETS

MISSILE_EX_ID_OFFSET							300001 - 300050
SKILL_KING_CHARGES_EX_ID_OFFSET					400001 - 500000

*/

main() {}

public OnGameModeInit()
{
	ClassInfo[0][x] = 1446.9613;
	ClassInfo[0][y] = 349.7412;
	ClassInfo[0][z] = 18.8417;
	ClassInfo[0][a] = 117.9194;
	strins(ClassInfo[0][title], "BLYADS", 0);
	ClassInfo[0][skin] = 29;
	ClassInfo[0][color] = 0xFFFF0404;
	
	ClassInfo[1][x] = 1238.5229;
	ClassInfo[1][y] = 213.6815;
	ClassInfo[1][z] = 19.5547;
	ClassInfo[1][a] = 115.0993;
	strins(ClassInfo[1][title], "GRIBS", 0);
	ClassInfo[1][skin] = 73;
	ClassInfo[1][color] = 0xFF0404FF;
	
	CA_Init();
	
	SetGameModeText("My first open.mp gamemode!");
	UsePlayerPedAnims();
	DisableInteriorEnterExits();
	LimitPlayerMarkerRadius(100.0);
	
	
	for(new class = 0; class < N_CLASSES; class++) {
		AddPlayerClassEx(
			class,
			ClassInfo[class][skin],
			ClassInfo[class][x],
			ClassInfo[class][y],
			ClassInfo[class][z],
			ClassInfo[class][a],
			0, 1,
			0, 1,
			0, 1
		);
	}
	
	// PERKS
	
	PerkInfo[0][perk_health] = 100;
	PerkInfo[0][perk_armour] = 0;
	PerkInfo[0][perk_weapons] = { WEAPON_DEAGLE, WEAPON_MP5, WEAPON_GRENADE };
	PerkInfo[0][perk_weapon_ammo] = { 100, 500, 20 };
	strins(PerkInfo[0][perk_title], "Pawn", 0);
	
	PerkInfo[1][perk_health] = 75;
	PerkInfo[1][perk_armour] = 0;
	PerkInfo[1][perk_weapons] = { WEAPON_SILENCED, WEAPON_KNIFE, WEAPON_SNIPER };
	PerkInfo[1][perk_weapon_ammo] = { 100, 1, 50 };
	strins(PerkInfo[1][perk_title], "Bishop", 0);
	
	PerkInfo[2][perk_health] = 50;
	PerkInfo[2][perk_armour] = 50;
	PerkInfo[2][perk_weapons] = { WEAPON_KATANA, WEAPON_M4, WEAPON_SHOTGSPA };
	PerkInfo[2][perk_weapon_ammo] = { 1, 500, 100 };
	strins(PerkInfo[2][perk_title], "Rook", 0);
	
	PerkInfo[3][perk_health] = 1;
	PerkInfo[3][perk_armour] = 100;
	PerkInfo[3][perk_weapons] = { WEAPON_RIFLE, WEAPON_SPRAYCAN, WEAPON_GOLFCLUB };
	PerkInfo[3][perk_weapon_ammo] = { 50, 500, 1 };
	strins(PerkInfo[3][perk_title], "King", 0);
	
	// OBJECTS
	CreateObject(3279,	1228.10315, 353.25989,	18.44100,	0.00000,	0.00000,	157.00000);
	CreateObject(13638, 1361.86523, 401.67441,	20.85201,	0.00000,	0.00000,	246.53470);
	CreateObject(18609,	1290.63513,	261.70557,	19.49440,	0.00000,	0.00000,	69.74204);
	CreateObject(1457,	1294.49634,	295.10037,	28.11846,   0.00000,	0.00000,	332.40698);
	CA_CreateObject(3279,	1228.10315, 353.25989,	18.44100,	0.00000,	0.00000,	157.00000, true);
	CA_CreateObject(13638, 1361.86523, 401.67441,	20.85201,	0.00000,	0.00000,	246.53470, true);
	CA_CreateObject(18609,	1290.63513,	261.70557,	19.49440,	0.00000,	0.00000,	69.74204, true);
	CA_CreateObject(1457,	1294.49634,	295.10037,	28.11846,   0.00000,	0.00000,	332.40698, true);
	
	// PICKUPS
	
	PickupInfo[0][is_picked_up] = false;
	PickupInfo[0][pickup_x] = 1306.4250;
	PickupInfo[0][pickup_y] = 351.7848;
	PickupInfo[0][pickup_z] = 19.5547;
	PickupInfo[0][pickup_object] = 1654;
	PickupInfo[0][picked_up_by_team] = 255;
	
	for(new i = 0; i < N_PICKUPS; i++) {	
		CreatePickup(PickupInfo[i][pickup_object], 1, PickupInfo[i][pickup_x], PickupInfo[i][pickup_y], PickupInfo[i][pickup_z], -1);
	}
	
	// CHECKPOINTS
	
	CPInfo[1][cp_team] = -1;
	CPInfo[1][cp_player] = -1;
	CPInfo[1][occupied] = false;
	CPInfo[1][cp_x] = 1271.5677;
	CPInfo[1][cp_y] = 295.0919;
	CPInfo[1][cp_z] = 20.6563;
	CPInfo[1][cp_mapicon] = 19;
	CPInfo[1][cp_bomb_timer] = -1;
	CPInfo[1][cp_defuse_timer] = -1;
	CPInfo[1][is_active] = false;
	
	CPInfo[2][cp_team] = -1;
	CPInfo[2][cp_player] = -1;
	CPInfo[2][occupied] = false;
	CPInfo[2][cp_x] = 1362.3979;
	CPInfo[2][cp_y] = 321.5292;
	CPInfo[2][cp_z] = 19.5547;
	CPInfo[2][cp_mapicon] = 19;
	CPInfo[2][cp_bomb_timer] = -1;
	CPInfo[2][cp_defuse_timer] = -1;
	CPInfo[2][is_active] = false;
	
	for(new i = 1; i < N_CPS; i++) {
		CreateDynamicCP(CPInfo[i][cp_x], CPInfo[i][cp_y], CPInfo[i][cp_z], 1);
		CreateDynamicMapIcon(CPInfo[i][cp_x], CPInfo[i][cp_y], CPInfo[i][cp_z], CPInfo[i][cp_mapicon], 0);
	}
	
	return 1;
}

// COMMANDS

CMD:rustler(playerid, params[])
{
	new Float:fX, Float:fY, Float:fZ, Float:fangle;
	GetPlayerPos(playerid, fX, fY, fZ);
	GetPlayerFacingAngle(playerid, fangle);
	DestroyPlayerVehicle(playerid);
	PlayerInfo[playerid][player_vehicle] = CreateVehicle(476, fX, fY, fZ, fangle, random(256), random(256), -1);
	PutPlayerInVehicle(playerid, PlayerInfo[playerid][player_vehicle], 0);
}

CMD:st(playerid, params[])
{
	SendClientMessage(playerid, PASTEL_DEEP_GRAY, "Sending to team selection in 5 seconds!");
	SetTimerEx("SwitchPlayerTeam", 5000, false, "i", playerid);
}

forward SwitchPlayerTeam(playerid);
public SwitchPlayerTeam(playerid)
{
	if (GetPlayerAnimationIndex(playerid) == 1189)
    {
		PlayerInfo[playerid][player_change_team] = true;
		SetPlayerLastDamager(playerid, INVALID_PLAYER_ID, 44);
		SetPlayerHealth(playerid, 0);
	} else SendClientMessage(playerid, PASTEL_DEEP_GRAY, "You need to be standing still!");
}
CMD:cjump(playerid, params[])
{
	new vehicleid = GetPlayerVehicleID(playerid);
	if(GetVehicleModel(vehicleid) == 401)
	{
		new Float:ang_v;
		new Float:lin_v;
		if(sscanf(params, "ff", ang_v, lin_v)) {
			ang_v = 0.2;
			lin_v = 0.25;
		}
		new Float:vA, Float:vX, Float:vY, Float:vZ;
		GetVehicleVelocity(vehicleid, vX, vY, vZ);
		GetVehicleZAngle(vehicleid, vA);
		SetVehicleAngularVelocity(vehicleid, floatsin(vA - 90, degrees) * ang_v, floatcos(vA + 90, degrees) * ang_v, 0);
		SetVehicleVelocity(vehicleid, vX, vY, vZ + lin_v);
	}
}

stock DestroyPlayerVehicle(playerid) {
	DestroyVehicle(PlayerInfo[playerid][player_vehicle]);
}

public OnPlayerConnect(playerid)
{
	PlayerInfo[playerid][kills] = 0;
	PlayerInfo[playerid][deaths] = 0;
	PlayerInfo[playerid][is_player_spawned] = false;
	PlayerInfo[playerid][is_carrying_bomb] = false;
	PlayerInfo[playerid][player_change_team] = true;
	PlayerInfo[playerid][current_textdraw] = CreatePlayerTextDraw(playerid, 0, 0, "initial textdraw");
	SetPlayerColor(playerid, 0x808080FF);
	
	GivePlayerMoney(playerid, 50);
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	for(new i = 0; i < N_PICKUPS; i++) {	
		RemovePlayerMapIcon(playerid, i);
	}
	PlayerTextDrawDestroy(playerid, PlayerInfo[playerid][current_textdraw]);
	new PlayerText:class_textdraw = CreatePlayerTextDraw(playerid, 320, 200, ClassInfo[classid][title]);
	PlayerTextDrawAlignment(playerid, class_textdraw, 2);
	PlayerTextDrawFont(playerid, class_textdraw, 2);
	PlayerTextDrawShow(playerid, class_textdraw);
	PlayerInfo[playerid][current_textdraw] = class_textdraw;
	SetPlayerPos(playerid, ClassInfo[classid][x],	ClassInfo[classid][y],	ClassInfo[classid][z]);
	SetPlayerFacingAngle(playerid, ClassInfo[classid][a]);
	SetPlayerCameraPos(playerid, ClassInfo[classid][x] - 4 * floatcos(117.9194 - 90.0, degrees), ClassInfo[classid][y] - 4 * floatsin(117.9194 - 90.0, degrees), ClassInfo[classid][z] + 1);
	SetPlayerCameraLookAt(playerid, ClassInfo[classid][x],	ClassInfo[classid][y],	ClassInfo[classid][z]);
	InterpolateCameraPos(
		playerid,
		ClassInfo[(classid - 1) % N_CLASSES][x] - 4 * floatcos(117.9194 - 90.0, degrees),
		ClassInfo[(classid - 1) % N_CLASSES][y] - 4 * floatsin(117.9194 - 90.0, degrees),
		ClassInfo[(classid - 1) % N_CLASSES][z] + 1,
		ClassInfo[classid][x] - 4 * floatcos(117.9194 - 90.0, degrees),
		ClassInfo[classid][y] - 4 * floatsin(117.9194 - 90.0, degrees),
		ClassInfo[classid][z] + 1,
		1000,
		CAMERA_MOVE
	);
	InterpolateCameraLookAt(
		playerid,
		ClassInfo[(classid - 1) % N_CLASSES][x],
		ClassInfo[(classid - 1) % N_CLASSES][y],
		ClassInfo[(classid - 1) % N_CLASSES][z],
		ClassInfo[classid][x],
		ClassInfo[classid][y],
		ClassInfo[classid][z],
		1000,
		CAMERA_MOVE
	);

	ApplyAnimation(playerid, "benchpress", "gym_bp_celebrate", 4.1, true, false, false, false, 0, 1);
	return 1;
}

public OnPlayerSpawn(playerid)
{
	SetPlayerInterior(playerid, 0);
	// SetPlayerWorldBounds(playerid, 1455.7026, 1166.9702, 417.8921, 177.7630);
	
	new classid = GetPlayerTeam(playerid);
	SetPlayerColor(playerid, ClassInfo[classid][color]);
	PlayerTextDrawDestroy(playerid, PlayerInfo[playerid][current_textdraw]);
	
	for(new i = 0; i < 3; i++) GivePlayerWeapon(playerid, PerkInfo[PlayerInfo[playerid][player_perk]][perk_weapons][i], PerkInfo[PlayerInfo[playerid][player_perk]][perk_weapon_ammo][i]);
	SetPlayerHealth(playerid, PerkInfo[PlayerInfo[playerid][player_perk]][perk_health]);
	SetPlayerArmour(playerid, PerkInfo[PlayerInfo[playerid][player_perk]][perk_armour]);
	
	PlayerInfo[playerid][is_player_spawned] = true;
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	PlayerInfo[playerid][is_player_spawned] = false;
	SetPlayerColor(playerid, 0xFF808080);
	
	if (PlayerInfo[playerid][is_carrying_bomb] == true) {
		PlayerInfo[playerid][is_carrying_bomb] = false;
		PickupInfo[0][is_picked_up] = false;
		PickupInfo[0][picked_up_by_team] = 255;
		SendClientMessage(playerid, 0xFFFF0000, "You have lost the bomb!");
	}
	
	if(PlayerInfo[playerid][player_change_team]) {
		ForceClassSelection(playerid);
	} else PlayerInfo[playerid][deaths] ++;
	
	return 1;
}

stock ForcePerkSelection(playerid)
{
	SpawnPlayer(playerid);
	TogglePlayerSpectating(playerid, true);
	InterpolateCameraPos(playerid, 366.1500, 1762.8300, 158.9100, 366.1500, 1762.8300, 158.9100, 1000);
	InterpolateCameraLookAt(playerid, 365.3100, 1763.3800, 158.0600, 365.3100, 1763.3800, 158.0600, 1000);
	new string[(MAX_PERK_NAME + 1) * N_PERKS - 1];
	strins(string, PerkInfo[0][perk_title], 0);
	for(new i = 1; i < N_PERKS; i++) {
		strcat(string, "\n");
		strcat(string, PerkInfo[i][perk_title]);
	}
	ShowPlayerDialog(playerid, 1001, DIALOG_STYLE_LIST, "Perk Selection", string, "Continue", "Back");
}

public OnPlayerRequestSpawn(playerid)
{
	ForcePerkSelection(playerid);
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid) {
		case 1001: {
			if(response == 1) {
				PlayerInfo[playerid][player_perk] = listitem;
				PlayerInfo[playerid][player_change_team] = false;
				TogglePlayerSpectating(playerid, false);
			} else {
				ForcePerkSelection(playerid);
			}
		}
	}
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	switch(pickupid) {
		case 0: {
			if(PickupInfo[pickupid][is_picked_up] == false) {
				SendClientMessage(playerid, -1, "Bomb was picked up");
				PlayerInfo[playerid][is_carrying_bomb] = true;
				PickupInfo[pickupid][is_picked_up] = true;
			}
			else {
				SendClientMessage(playerid, 0xFFFF0000, "Bomb was already picked up");	
			}
		}
	}
	return 1;
}

public OnPlayerEnterDynamicCP(playerid, checkpointid)
{
	switch(checkpointid) {
		case 1..2: {
			if(CPInfo[checkpointid][occupied]) {
				SendClientMessage(playerid, 0xFFFF00FF, "Checkpoint is occupied by other player!");
			}
			else {
				CPInfo[checkpointid][occupied] = true;
				if(PlayerInfo[playerid][is_carrying_bomb] && CPInfo[checkpointid][is_active] == false) {
					CPInfo[checkpointid][cp_player] = playerid;
					CPInfo[checkpointid][cp_team] = GetPlayerTeam(playerid);
					ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, false, false, false, true, 2670, 1);
					SendClientMessageToAll(0xFFFF00FF, "Bomb has been planted!");
					CPInfo[checkpointid][cp_bomb_timer] = SetTimerEx("DestroyPickupBomb", 40*1000, false, "ii",	checkpointid, playerid);
					CPInfo[checkpointid][is_active] = true;
					PlayerInfo[playerid][is_carrying_bomb] = false;
				}
				if(CPInfo[checkpointid][cp_team] != GetPlayerTeam(playerid) && CPInfo[checkpointid][is_active])
				{
					CPInfo[checkpointid][cp_player] = playerid;
					ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, false, false, false, true, 2670, 1);
					SendClientMessageToAll(0xFFFF00FF, "Bomb is being defused!");
					CPInfo[checkpointid][cp_defuse_timer] = SetTimerEx("DefusePickupBomb", 10*1000, false, "ii", checkpointid, playerid);
				}
			}	
		}	
	}
}

public OnPlayerLeaveDynamicCP(playerid, checkpointid)
{
	CPInfo[checkpointid][occupied] = false;
	switch(checkpointid) {
		case 1..2: {
			if(CPInfo[checkpointid][cp_player] == playerid && CPInfo[checkpointid][cp_defuse_timer] != -1)
			{
				SendClientMessage(playerid, 0xFFFF00FF, "Bomb defusing has been interrupted!");
				KillTimer(CPInfo[checkpointid][cp_defuse_timer]);
				CPInfo[checkpointid][cp_defuse_timer] = -1;
				
			}
		}	
	}
}

forward DestroyPickupBomb(checkpointid, playerid);
public DestroyPickupBomb(checkpointid, playerid)
{
	SendClientMessageToAll(0xFFFF00FF, "Bomb has been exploded!");
	CreateExplosion(CPInfo[checkpointid][cp_x], CPInfo[checkpointid][cp_y], CPInfo[checkpointid][cp_z], 6, 50);
	
	KillTimer(CPInfo[checkpointid][cp_bomb_timer]);
	KillTimer(CPInfo[checkpointid][cp_defuse_timer]);
	CPInfo[checkpointid][cp_bomb_timer] = -1;
	CPInfo[checkpointid][cp_defuse_timer] = -1;
	
	CPInfo[checkpointid][is_active] = false;
	CPInfo[checkpointid][cp_team] = -1;
	PickupInfo[0][is_picked_up] = false;
	PickupInfo[0][picked_up_by_team] = -1;
	new player_score = GetPlayerScore(playerid);
	SetPlayerScore(playerid, player_score + 10);
}

forward DefusePickupBomb(checkpointid, playerid);
public DefusePickupBomb(checkpointid, playerid)
{
	SendClientMessageToAll(0xFFFF00FF, "Bomb has been defused!");
	
	KillTimer(CPInfo[checkpointid][cp_bomb_timer]);
	KillTimer(CPInfo[checkpointid][cp_defuse_timer]);
	CPInfo[checkpointid][cp_bomb_timer] = -1;
	CPInfo[checkpointid][cp_defuse_timer] = -1;
	
	CPInfo[checkpointid][is_active] = false;
	CPInfo[checkpointid][cp_team] = -1;
	PickupInfo[0][is_picked_up] = false;
	PickupInfo[0][picked_up_by_team] = -1;
	PlayerInfo[playerid][is_carrying_bomb] = false;
	new player_score = GetPlayerScore(playerid);
	SetPlayerScore(playerid, player_score + 10);
}