#include "vehicle_missiles.pwn"

enum EPlayerLastDamagerInfo
{
	player_last_damagerid,
	player_last_damagerid_weapon
}

new PlayerLastDamagerInfo[MAX_PLAYERS][EPlayerLastDamagerInfo];

stock SetPlayerLastDamager(playerid, issuerid, weapon)
{
	new string[48];
	format(string, sizeof(string), "SET LAST DAMAGER %d TO PLAYER %d WITH WEAPON %d", issuerid, playerid, weapon);
	SendClientMessage(issuerid, -1, string);
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
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			new Float:pX, Float:pY, Float:pZ;
			GetPlayerPos(i, pX, pY, pZ);
			
			new Float:length = floatsqroot(floatpower(pX - fX, 2) + floatpower(pY - fY, 2) + floatpower(pZ - fZ, 2));
			if(length < radius) SetPlayerLastDamager(i, playerid, 51);
		}
	}
}

hook OnPlayerDeath(playerid)
{
		if(killerid == INVALID_PLAYER_ID)
	{
		new t_killerid, t_reason;
		GetPlayerLastDamager(playerid, t_killerid, t_reason);
		killerid = t_killerid;
		reason = t_reason;
	    SendDeathMessage(killerid,playerid,reason);
	}
	else {
	    SendDeathMessage(killerid,playerid,reason);
		PlayerInfo[killerid][kills] ++;
	}
	return 1
}

hook OnGameModeInit()
{
	print("MODULE WEAPONS LOADED");
}