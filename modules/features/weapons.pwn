#include "vehicle_missiles.pwn"
#include "skill_abilities.pwn"
#include <YSI_Coding\y_hooks>

enum EPlayerLastDamagerInfo
{
	player_last_damagerid,
	player_last_damagerid_weapon
}

new PlayerLastDamagerInfo[MAX_PLAYERS][EPlayerLastDamagerInfo];

stock SetPlayerLastDamager(playerid, issuerid, weapon)
{
	PlayerLastDamagerInfo[playerid][player_last_damagerid] = issuerid;
	PlayerLastDamagerInfo[playerid][player_last_damagerid_weapon] = weapon;
}

stock GetPlayerLastDamager(playerid, &issuerid, &weapon)
{
	issuerid = PlayerLastDamagerInfo[playerid][player_last_damagerid];
	weapon = PlayerLastDamagerInfo[playerid][player_last_damagerid_weapon];
}

stock CreateCustomExplosion(playerid, Float:fX, Float:fY, Float:fZ, type, Float:radius)
{
	CreateExplosion(fX, fY, fZ, type, radius);
	foreach(new i : Player)
	{
		new Float:pX, Float:pY, Float:pZ;
		GetPlayerPos(i, pX, pY, pZ);
		
		new Float:length = floatsqroot(floatpower(pX - fX, 2) + floatpower(pY - fY, 2) + floatpower(pZ - fZ, 2));
		if(length < radius) SetPlayerLastDamager(i, playerid, 51);
	}
}

hook OnPlayerDeath(playerid, killerid, reason)
{
	if(killerid == INVALID_PLAYER_ID)
	{
		new t_killerid, t_reason;
		GetPlayerLastDamager(playerid, t_killerid, t_reason);
		killerid = t_killerid;
		reason = t_reason;
	}
	if(killerid == playerid) killerid = INVALID_PLAYER_ID;
	SendDeathMessage(killerid,playerid,reason);
	if(killerid != INVALID_PLAYER_ID)
	{
		new delta_money = random(4500) + 3000;
		new delta_score = random(3) + 2;
		ORM_players[killerid][orm_players_money] += delta_money;
		ORM_players[killerid][orm_players_score] += delta_score;
		ORM_players[killerid][orm_players_kills] ++;
		OnPlayerKillMsg(killerid, playerid, delta_money, delta_score);
	}
	return 1;
}

stock OnPlayerKillMsg(killerid, playerid, money, score)
{
	new playercolor[7];
    format(playercolor, 7, "%x", ClassInfo[GetPlayerTeam(playerid)][class_color]);

	new accentcolor[7];
	format(accentcolor, 7, "%x", PASTEL_TEAL_LIGHT);

	new normalcolor[7];
	format(normalcolor, 7, "%x", PASTEL_PEACH_LIGHT);

	new string[74 - 20 + MAX_PLAYER_NAME + 42 + 1 + 3];
	format(string, sizeof(string), "{%s}You killed {%s}%s, {%s}recieved {%s}%d$ {%s}cash and {%s}%d {%s}score", normalcolor, playercolor, ORM_players[playerid][orm_players_name], normalcolor, accentcolor, money, normalcolor, accentcolor, score, normalcolor);
	SendClientMessage(killerid, -1, string);
}

hook OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	switch(weaponid) {
		case WEAPON_SILENCED: {
			if(fX != 0 || fY != 0 || fZ != 0) {
				new Float:dX, Float:dY, Float:dZ,
					Float:oX, Float:oY, Float:oZ;
				GetPlayerLastShotVectors(playerid, oX, oY, oZ, dX, dY, dZ);
				CreateCustomExplosion(playerid, dX, dY, dZ, 1, 1);
			}
			return 0;
		}
		case WEAPON_DEAGLE: {
			new Float:hX, Float:hY, Float:hZ,
				Float:oX, Float:oY, Float:oZ,
				Float:nX, Float:nY, Float:nZ,
				Float:vX, Float:vY, Float:vZ,
				Float:angular_velocity = 1,
				Float:linear_velocity = 1,
				Float:player_velocity = 5;
			switch(hittype) {
				case BULLET_HIT_TYPE_PLAYER: {
					GetPlayerPos(playerid, oX, oY, oZ);
					GetPlayerPos(hitid, hX, hY, hZ);
					GetPlayerVelocity(hitid, vX, vY, vZ);
					new Float:dist = floatsqroot(floatpower(hX - oX, 2) + floatpower(hY - oY, 2) + floatpower(hZ - oZ, 2));
					nX = (hX - oX) / dist;
					nY = (hY - oY) / dist;
					nZ = (hZ - oZ) / dist;
					SetPlayerVelocity(hitid, vX + nX * player_velocity, vY + nY * player_velocity, vZ + floatabs(nZ * player_velocity) + 0.1);
					SetPlayerLastDamager(hitid, playerid, WEAPON_DEAGLE);
				}
				case BULLET_HIT_TYPE_VEHICLE: {
					if(IsVehicleOccupied(hitid) != -1) {
						GetPlayerPos(playerid, oX, oY, oZ);
						GetVehiclePos(hitid, hX, hY, hZ);
						GetVehicleVelocity(hitid, vX, vY, vZ);
						new Float:dist = floatsqroot(floatpower(hX - oX, 2) + floatpower(hY - oY, 2) + floatpower(hZ - oZ, 2));
						nX = (hX - oX) / dist;
						nY = (hY - oY) / dist;
						nZ = (hZ - oZ) / dist;
						SetVehicleVelocity(hitid, vX + nX * linear_velocity, vY + nY * linear_velocity, vZ + floatabs(nZ * linear_velocity));
						SetVehicleAngularVelocity(hitid, nX * angular_velocity, nY * angular_velocity, nZ * angular_velocity);
						SetPlayerLastDamager(IsVehicleOccupied(hitid), playerid, WEAPON_DEAGLE);
					}
				}			
			}
			return 0;
		}
		case WEAPON_RIFLE: {
			if(hittype == BULLET_HIT_TYPE_PLAYER) {
				SetPlayerDrunkLevel(hitid, GetPlayerDrunkLevel(hitid) + 1000);
				PlayerInfo[hitid][player_drunk_timer] = SetTimerEx("RemovePlayerDrunk", 5000, false, "i", hitid);
				return 0;
			}
		}
	}
	return 1;
}

stock IsVehicleOccupied(vehicleid)
{
	foreach(new i : Player) {
		if(IsPlayerInVehicle(i, vehicleid))
		{
			return i;
		}
	}
	return -1;
}

stock RemovePlayerDrunk(hitid)
{
	PlayerInfo[hitid][is_player_drunk] = false;
	SetPlayerDrunkLevel(hitid, 0);
}

hook OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
{
	new Float:pX, Float:pY, Float:pZ;
	GetPlayerPos(playerid, pX, pY, pZ);
	PlayerPlaySound(playerid, 4600, Float:pX, Float:pY, Float:pZ);

	new Float:iX, Float:iY, Float:iZ;
	GetPlayerPos(issuerid, iX, iY, iZ);
	PlayerPlaySound(issuerid, 17802, Float:iX, Float:iY, Float:iZ);

	if(PlayerInfo[issuerid][player_perk] == 1 && bodypart == BODY_PART_HEAD)
	{
		amount = 200;
	}
}

hook OnGameModeInit()
{
	print("MODULE WEAPONS LOADED");
}