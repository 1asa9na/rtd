#include <YSI_Coding\y_hooks>

hook OnPlayerDisconnect(playerid, reason)
{
	switch(PlayerInfo[playerid][player_perk]) {
		case 3: {
            for(new i = 0; i < 5; i++)
            {
                RemovePlayerAttachedObject(playerid, i);
            }
		}
	}
	return 1;
}

hook OnPlayerSpawn(playerid)
{
    switch(PlayerInfo[playerid][player_perk]) {
		case 3: {
			for(new i = 0; i < 5; i++) {
				SetPlayerAttachedObject(playerid, i, 18693, 1, floatcos((180 * i + 90) / 5 - 90, degrees), 0.0, floatsin((180 * i + 90) / 5 - 90, degrees));
			}
		}
	}
    return 1;
}

hook OnPlayerDeath(playerid)
{
    switch(PlayerInfo[playerid][player_perk]) {
		case 3: {
            for(new i = 0; i < 5; i++) RemovePlayerAttachedObject(playerid, i);
		}
	}
    return 1;
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
		for(new i = 0; i < 5; i++) {
			if(IsPlayerAttachedObjectSlotUsed(playerid, i)) {
				new Float:iX, Float:iY, Float:iZ,
					Float:oX, Float:oY, Float:oZ;
				new Float:charge_velocity = 70.0;
				GetPlayerPos(issuerid, iX, iY, iZ);
				GetPlayerPos(playerid, oX, oY, oZ);

                RemovePlayerAttachedObject(playerid, i);
				new temp_object = CreateDynamicObject(18693, oX, oY, oZ, 0, 0, 0);
				new Float:length = floatsqroot(floatpower(iX - oX, 2) + floatpower(iY - oY, 2) + floatpower(iZ - oZ, 2));
				MoveDynamicObject(temp_object, iX, iY, iZ, charge_velocity, 0, 0, 0);
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
		return 1;
	}
	
	return 0;
}

stock DestroyKingCharge(playerid, objectid)
{
	new Float:oX, Float:oY, Float:oZ;
	GetDynamicObjectPos(objectid, oX, oY, oZ);
	DestroyDynamicObject(objectid);
	CreateCustomExplosion(playerid, oX, oY, oZ, 6, 10);
}

CMD:tower(playerid, params[])
{
	if(SkillRookTowerInfo[playerid][srt_is_created]) DestroySkillRookTower(playerid);
	new Float:pX, Float:pY, Float:pZ, Float:pA;

	GetPlayerPos(playerid, &Float:pX, &Float:pY, &Float:pZ);
	GetPlayerFacingAngle(playerid, &Float:pA);

	pX -= floatcos(pA - 90, degrees);
	pY -= floatsin(pA - 90, degrees);

	CA_FindZ_For2DCoord(Float:pX, Float:pY, &Float:pZ)

	SkillRookTowerInfo[playerid][srt_objectid] = CreateDynamicObject(18849, pX, pY, pZ, 0.0, 0.0, pA);
	SkillRookTowerInfo[playerid][srt_areaid] = CreateDynamicSphere(pX, pY, pZ, 20);
}

stock DestroySkillRookTower(playerid)
{
	DestroyDynamicArea(SkillRookTowerInfo[playerid][srt_areaid]);
	DestroyDynamicObject(SkillRookTowerInfo[playerid][srt_objectid]);
	KillTimer(SkillRookTowerInfo[playerid][srt_timerid]);

	SkillRookTowerInfo[playerid][srt_is_created] = false;
}