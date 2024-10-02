#include <YSI_Coding\y_hooks>

hook OnCharacterSpawn(playerid)
{
    switch(PlayerInfo[playerid][player_perk]) {
		case 3: {
			AddKingCharges(playerid, MAX_KING_CHARGES);
		}
	}
}

hook OnPlayerConnect(playerid)
{
	for(new i = 0; i < MAX_KING_CHARGES; i++) SkillKingChargeInfo[playerid][skc_objectid][i] = -1;
}

stock AddKingCharges(playerid, amount)
{
	for(new i = 0; i < amount; i++)
	{
		new slot = FindEmptyKingChargeSlot(playerid);
		if(slot == -1) break;
		new Float:pX, Float:pY, Float:pZ;
		new obj = CreateObject(18693, pX, pY, pZ, 0, 0, 0);
		SkillKingChargeInfo[playerid][skc_objectid][slot] = obj;
		AttachObjectToPlayer(obj, playerid, floatsin((180 * slot + 90) / MAX_KING_CHARGES - 90, degrees), 0.0, floatcos((180 * slot + 90) / MAX_KING_CHARGES - 90, degrees), 0, 0, 0);
	}
	SendClientMessage(playerid, PASTEL_GREEN_DARK, "King charges have been given!");
}

stock FindEmptyKingChargeSlot(playerid)
{
	new
        i = 0;
    while (i < MAX_KING_CHARGES && SkillKingChargeInfo[playerid][skc_objectid][i] != -1)
    {
        i++;
    }
    if (i == MAX_KING_CHARGES) return -1;
    return i;
}

stock RemoveKingCharges(playerid)
{
	for(new i = 0; i < MAX_KING_CHARGES; i++)
	{
		DestroyObject(SkillKingChargeInfo[playerid][skc_objectid][i]);
		SkillKingChargeInfo[playerid][skc_objectid][i] = -1;
	}
	SendClientMessage(playerid, PASTEL_GREEN_DARK, "King charges have been removed!");
}

hook OnPlayerDeath(playerid, killerid, reason)
{
    switch(PlayerInfo[playerid][player_perk]) {
		case 3: {
			RemoveKingCharges(playerid);
		}
		case 2: {
			DestroyRookTower(playerid);
		}
	}
    return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	switch(PlayerInfo[playerid][player_perk]) {
		case 3: {
            RemoveKingCharges(playerid);
		}
		case 2: {
			DestroyRookTower(playerid);
		}
	}
    return 1;
}

stock DestroyRookTower(playerid)
{
	DestroyDynamicArea(SkillRookTowerInfo[playerid][srt_areaid]);
	SkillRookTowerInfo[playerid][srt_areaid] = -1;
	DestroyDynamicObject(SkillRookTowerInfo[playerid][srt_objectid]);
	SkillRookTowerInfo[playerid][srt_objectid] = -1;
	SkillRookTowerInfo[playerid][srt_targetid] = INVALID_PLAYER_ID;
	SkillRookTowerInfo[playerid][srt_is_created] = false;
	KillTimer(SkillRookTowerInfo[playerid][srt_timerid]);
	SkillRookTowerInfo[playerid][srt_timerid] = -1;
	SendClientMessage(playerid, PASTEL_LAVENDER_DARK, "Your tower has been destroyed!");
}

hook OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
{
    if(issuerid != INVALID_PLAYER_ID)
	{
		if(PlayerInfo[issuerid][player_perk] == 1 && bodypart == 9)
		{
			SetPlayerLastDamager(playerid, issuerid, weaponid);
			SetPlayerHealth(playerid, 0);
			return 1;
		}
	}
	
	if(PlayerInfo[playerid][player_perk] == 3 && issuerid != INVALID_PLAYER_ID) {
		ShootKingCharge(playerid, issuerid);
		return 1;
	}
	
	return 0;
}

stock ShootKingCharge(playerid, targetid)
{
	for(new i = 0; i < MAX_KING_CHARGES; i++) {
		if(SkillKingChargeInfo[playerid][skc_objectid][i] != -1) {
			new string[10];
			format(string, 10, "Charge %d!", i);
			SendClientMessage(playerid, PASTEL_GREEN_DARK, string);
			new Float:dX, Float:dY, Float:dZ,
				Float:oX, Float:oY, Float:oZ;
			new Float:charge_velocity = 70.0;
			GetPlayerPos(targetid, dX, dY, dZ);
			GetPlayerPos(playerid, oX, oY, oZ);

			DestroyObject(SkillKingChargeInfo[playerid][skc_objectid][i]);
			SkillKingChargeInfo[playerid][skc_objectid][i] = -1;
			new temp_object = CreateDynamicObject(18693, oX, oY, oZ + 1, 0, 0, 0);
			new Float:length = floatsqroot(floatpower(dX - oX, 2) + floatpower(dY - oY, 2) + floatpower(dZ - oZ, 2));
			MoveDynamicObject(temp_object, dX, dY, dZ, charge_velocity, 0, 0, 0);
			SetTimerEx(
				"DestroyKingCharge",
				floatround(length / charge_velocity * 1000),
				false,
				"ii",
				playerid,
				temp_object
			);
			break;
		}
	}
}

forward DestroyKingCharge(playerid, objectid);
public DestroyKingCharge(playerid, objectid)
{
	new Float:oX, Float:oY, Float:oZ;
	GetDynamicObjectPos(objectid, oX, oY, oZ);
	DestroyDynamicObject(objectid);
	CreateCustomExplosion(playerid, oX, oY, oZ, 6, 10);
}

CMD:tower(playerid, params[])
{
	if(PlayerInfo[playerid][player_perk] == 2)
	{
		if(SkillRookTowerInfo[playerid][srt_is_created]) DestroySkillRookTower(playerid);
		new Float:pX, Float:pY, Float:pZ, Float:pA;

		GetPlayerPos(playerid, pX, pY, pZ);
		GetPlayerFacingAngle(playerid, pA);

		pX -= floatcos(pA - 90, degrees);
		pY -= floatsin(pA - 90, degrees);

		CA_FindZ_For2DCoord(pX, pY, pZ);

		SkillRookTowerInfo[playerid][srt_objectid] = CreateDynamicObject(2985, pX, pY, pZ, 0.0, 0.0, pA + 90);
		SkillRookTowerInfo[playerid][srt_areaid] = CreateDynamicSphere(pX, pY, pZ, 20);
		Streamer_SetIntData(STREAMER_AREA_TYPE_SPHERE, SkillRookTowerInfo[playerid][srt_areaid], E_STREAMER_EXTRA_ID, playerid + SKILL_ROOK_TOWERS_EX_ID_OFFSET);
		SkillRookTowerInfo[playerid][srt_is_created] = true;
		SendClientMessage(playerid, PASTEL_LAVENDER_DARK, "You have created the tower!");
	}
	else
	{
		SendClientMessage(playerid, PASTEL_LAVENDER_DARK, "You have to be a Rook!");
	}
}

stock DestroySkillRookTower(playerid)
{
	DestroyDynamicArea(SkillRookTowerInfo[playerid][srt_areaid]);
	DestroyDynamicObject(SkillRookTowerInfo[playerid][srt_objectid]);
	KillTimer(SkillRookTowerInfo[playerid][srt_timerid]);
}

hook OnPlayerEnterDynamicArea(playerid, areaid)
{
	new issuerid = Streamer_GetIntData(STREAMER_AREA_TYPE_SPHERE, areaid, E_STREAMER_EXTRA_ID) - SKILL_ROOK_TOWERS_EX_ID_OFFSET;
	if(IsPlayerConnected(issuerid))
	{
		if(GetPlayerTeam(playerid) != GetPlayerTeam(issuerid))
		{
			SendClientMessage(issuerid, -1, "SOMEONE ENTERED AREA");
			SkillRookTowerAimPlayer(issuerid, playerid);
		}
	}
	return 1;
}

stock SkillRookTowerAimPlayer(playerid, hitid)
{
	SkillRookTowerInfo[playerid][srt_targetid] = hitid;
	SkillRookTowerInfo[playerid][srt_timerid] = SetTimerEx("ScanRookTower", 200, true, "dd", playerid, hitid);
}

hook OnPlayerLeaveDynamicArea(playerid, areaid)
{
	new issuerid = Streamer_GetIntData(STREAMER_AREA_TYPE_SPHERE, areaid, E_STREAMER_EXTRA_ID) - SKILL_ROOK_TOWERS_EX_ID_OFFSET;
	if(issuerid >= MAX_PLAYERS || issuerid < 0) return 1;
	if(playerid == SkillRookTowerInfo[issuerid][srt_targetid])
	{
		SendClientMessage(issuerid, -1, "SOMEONE LEFT AREA");
		KillTimer(SkillRookTowerInfo[issuerid][srt_timerid]);
		SkillRookTowerInfo[issuerid][srt_timerid] = -1;
		SkillRookTowerInfo[issuerid][srt_targetid] = INVALID_PLAYER_ID;

		foreach(new i : Player)
		{
			if(IsPlayerInDynamicArea(i, areaid) && GetPlayerTeam(i) != GetPlayerTeam(issuerid))
			{
				SkillRookTowerAimPlayer(issuerid, i);
				return 0;
			}
		}
	}
	return 0;
}

forward ScanRookTower(playerid, hitid);
public ScanRookTower(playerid, hitid)
{
	new target_state = GetPlayerState(hitid);
	if(target_state != 7 && target_state != 9)
	{
		new
		Float:oX, Float:oY, Float:oZ,
		Float:dX, Float:dY, Float:dZ,
		Float:aZ;

		GetDynamicObjectPos(SkillRookTowerInfo[playerid][srt_objectid], oX, oY, oZ);
		GetPlayerPos(hitid, dX, dY, dZ);
		new Float:length = floatsqroot(floatpower(dX - oX, 2) + floatpower(dY - oY, 2));

		aZ = acos((dX - oX) / length);
		if((dY - oY) / length < 0) aZ = -aZ;

		DestroyDynamicObject(SkillRookTowerInfo[playerid][srt_particleid]);
		SkillRookTowerInfo[playerid][srt_particleid] = CreateDynamicObject(18695, oX, oY, oZ - 0.5, 0, 0, aZ - 90);

		SetDynamicObjectRot(SkillRookTowerInfo[playerid][srt_objectid], 0.0, 0.0, aZ);

		GivePlayerDamage(hitid, playerid, 1, WEAPON_M4, 1);
	}
}

stock GivePlayerDamage(targetid, playerid, Float:amount, weaponid, bodypart)
{
	new Float:armour, Float:health;
	GetPlayerArmour(targetid, armour);
	GetPlayerHealth(targetid, health);
	CallLocalFunction("OnPlayerGiveDamage", "iifii", playerid, targetid, amount, weaponid, bodypart);
	CallLocalFunction("OnPlayerTakeDamage", "iifii", targetid, targetid, amount, weaponid, bodypart);
	SetPlayerLastDamager(targetid, playerid, WEAPON_M4);

	new target_state = GetPlayerState(targetid);
	if(target_state != 7 && target_state != 9)
	{
		if(amount < armour)
		{
			SetPlayerArmour(targetid, armour - amount);
		}
		else
		{
			if(amount < armour + health)
			{
				SetPlayerArmour(targetid, 0);
				SetPlayerHealth(targetid, health - (amount - armour));
			}
			else
			{
				SetPlayerHealth(targetid, health - amount);
			}
		}
	}
}