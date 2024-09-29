#include <YSI_Coding\y_hooks>

#define MAX_MISSILES 10
#define MISSILE_EX_ID_OFFSET 300001
#define MISSILE_VELOCITY 50
#define MISSILE_HEIGHT 100
#define MISSILE_CONTACT 2
#define MISSILE_STEP 5
#define MISSILE_STINGER_STEP 10
#define MISSILE_STINGER_VELOCITY 70
#define MISSILE_EXPLOSION_RADIUS 7.0
#define MISSILE_COOLDOWN 60

#define MAX_STATVEHS 17
#define STATVEH_EX_ID_OFFSET 400001

// COOLDOWNS

new bool:RustlerCooldown[MAX_PLAYERS];
new MissileCooldown[MAX_PLAYERS];

// VEHICLES INFO 

enum EVehicleInfo {
	vehid,
	veh_modelid,
	Float:vehX,
	Float:vehY,
	Float:vehZ,
	Float:vehA,
	veh_objectid,
	Float:veh_oX,
	Float:veh_oY,
	Float:veh_oZ,
}

new VehicleInfo[MAX_STATVEHS][EVehicleInfo];

// WHOOPIE MISSILE INFO

enum EWMInfo {
	wm_type,
	wm_targetid,
	wm_playerid,
	wm_objectid,
	bool:wm_faced_obstacle
};

new WMInfo[MAX_MISSILES][EWMInfo];

hook OnGameModeInit()
{
	for(new i=0; i < MAX_MISSILES; i++)
	{
		WMInfo[i][wm_objectid] = -1;
		WMInfo[i][wm_targetid] = -1;
		WMInfo[i][wm_playerid] = -1;
		WMInfo[i][wm_faced_obstacle] = false;
	}
	
	// VEHICLES
	
	VehicleInfo[0][veh_modelid] = 401;
	VehicleInfo[0][vehX] = 1252.3234;
	VehicleInfo[0][vehY] = 247.3649;
	VehicleInfo[0][vehZ] = 19.5547;
	VehicleInfo[0][vehA] = 68.4121;
	VehicleInfo[0][veh_objectid] = -1;
	
	VehicleInfo[1][veh_modelid] = 404;
	VehicleInfo[1][vehX] = 1204.5350;
	VehicleInfo[1][vehY] = 267.3818;
	VehicleInfo[1][vehZ] = 19.5547;
	VehicleInfo[1][vehA] = 336.2913;
	VehicleInfo[1][veh_objectid] = -1;
	
	VehicleInfo[2][veh_modelid] = 413;
	VehicleInfo[2][vehX] = 1228.4899;
	VehicleInfo[2][vehY] = 299.6678;
	VehicleInfo[2][vehZ] = 19.5547;
	VehicleInfo[2][vehA] = 157.2198;
	VehicleInfo[2][veh_objectid] = -1;
	
	VehicleInfo[3][veh_modelid] = 415;
	VehicleInfo[3][vehX] = 1221.7859;
	VehicleInfo[3][vehY] = 301.9800;
	VehicleInfo[3][vehZ] = 19.5547;
	VehicleInfo[3][vehA] = 157.2198;
	VehicleInfo[3][veh_objectid] = -1;
	
	VehicleInfo[4][veh_modelid] = 423;
	VehicleInfo[4][vehX] = 1341.4185;
	VehicleInfo[4][vehY] = 332.9185;
	VehicleInfo[4][vehZ] = 20.0376;
	VehicleInfo[4][vehA] = 66.1840;
	VehicleInfo[4][veh_objectid] = -1;
	
	VehicleInfo[5][veh_modelid] = 429;
	VehicleInfo[5][vehX] = 1355.1538;
	VehicleInfo[5][vehY] = 364.0742;
	VehicleInfo[5][vehZ] = 20.0255;
	VehicleInfo[5][vehA] = 65.7257;
	VehicleInfo[5][veh_objectid] = -1;
	
	VehicleInfo[6][veh_modelid] = 434;
	VehicleInfo[6][vehX] = 1415.2637;
	VehicleInfo[6][vehY] = 377.1012;
	VehicleInfo[6][vehZ] = 19.3042;
	VehicleInfo[6][vehA] = 76.3792;
	VehicleInfo[6][veh_objectid] = -1;
	
	VehicleInfo[7][veh_modelid] = 442;
	VehicleInfo[7][vehX] = 1420.0203;
	VehicleInfo[7][vehY] = 367.5028;
	VehicleInfo[7][vehZ] = 19.0526;
	VehicleInfo[7][vehA] = 162.1000;
	VehicleInfo[7][veh_objectid] = -1;
	
	VehicleInfo[8][veh_modelid] = 456;
	VehicleInfo[8][vehX] = 1409.5997;
	VehicleInfo[8][vehY] = 320.1427;
	VehicleInfo[8][vehZ] = 18.9372;
	VehicleInfo[8][vehA] = 226.8040;
	VehicleInfo[8][veh_objectid] = -1;
	
	VehicleInfo[9][veh_modelid] = 462;
	VehicleInfo[9][vehX] = 1425.1090;
	VehicleInfo[9][vehY] = 275.1043;
	VehicleInfo[9][vehZ] = 19.5547;
	VehicleInfo[9][vehA] = 68.4127;
	VehicleInfo[9][veh_objectid] = -1;
	
	VehicleInfo[10][veh_modelid] = 470;
	VehicleInfo[10][vehX] = 1391.0519;
	VehicleInfo[10][vehY] = 265.4253;
	VehicleInfo[10][vehZ] = 19.5669;
	VehicleInfo[10][vehA] = 157.7136;
	VehicleInfo[10][veh_objectid] = -1;
	
	VehicleInfo[11][veh_modelid] = 477;
	VehicleInfo[11][vehX] = 1337.6892;
	VehicleInfo[11][vehY] = 285.5739;
	VehicleInfo[11][vehZ] = 19.5615;
	VehicleInfo[11][vehA] = 248.4245;
	VehicleInfo[11][veh_objectid] = -1;
	
	VehicleInfo[12][veh_modelid] = 486;
	VehicleInfo[12][vehX] = 1294.9200;
	VehicleInfo[12][vehY] = 218.1724;
	VehicleInfo[12][vehZ] = 19.5547;
	VehicleInfo[12][vehA] = 69.1963;
	VehicleInfo[12][veh_objectid] = -1;
	
	VehicleInfo[13][veh_modelid] = 503;
	VehicleInfo[13][vehX] = 1288.4561;
	VehicleInfo[13][vehY] = 188.6687;
	VehicleInfo[13][vehZ] = 20.2564;
	VehicleInfo[13][vehA] = 129.3569;
	VehicleInfo[13][veh_objectid] = -1;
	
	VehicleInfo[14][veh_modelid] = 506;
	VehicleInfo[14][vehX] = 1288.8064;
	VehicleInfo[14][vehY] = 162.4481;
	VehicleInfo[14][vehZ] = 20.4670;
	VehicleInfo[14][vehA] = 11.0725;
	VehicleInfo[14][veh_objectid] = -1;
	
	VehicleInfo[15][veh_modelid] = 535;
	VehicleInfo[15][vehX] = 1239.2605;
	VehicleInfo[15][vehY] = 181.1548;
	VehicleInfo[15][vehZ] = 19.8765;
	VehicleInfo[15][vehA] = 334.2556;
	VehicleInfo[15][veh_objectid] = 18848;
	VehicleInfo[15][veh_oX] = 0.0;
	VehicleInfo[15][veh_oY] = -1.8;
	VehicleInfo[15][veh_oZ] = 0.0;

	VehicleInfo[16][veh_modelid] = 497;
	VehicleInfo[16][vehX] = 1249.8494;
	VehicleInfo[16][vehY] = 405.6464;
	VehicleInfo[16][vehZ] = 32.9776;
	VehicleInfo[16][vehA] = 247.6255;
	VehicleInfo[16][veh_objectid] = -1;
	
	for(new i = 0; i < MAX_STATVEHS; i++) {
		VehicleInfo[i][vehid] = AddStaticVehicle(
			VehicleInfo[i][veh_modelid],
			VehicleInfo[i][vehX],
			VehicleInfo[i][vehY],
			VehicleInfo[i][vehZ],
			VehicleInfo[i][vehA],
			-1,
			-1
		);
		if(VehicleInfo[i][veh_objectid] != -1)
		{
			new objectid = CreateDynamicObject(VehicleInfo[i][veh_objectid], 0, 0, 0, 0, 0, 0);
			AttachDynamicObjectToVehicle(objectid, VehicleInfo[i][vehid], VehicleInfo[i][veh_oX], VehicleInfo[i][veh_oY], VehicleInfo[i][veh_oZ], 0, 0, 0);
		}
	}
}

hook OnPlayerConnect(playerid)
{
	RustlerCooldown[playerid] = false;
	MissileCooldown[playerid] = 0;
	return 1;
}

hook OnCharacterSpawn(playerid)
{
	SetPlayerLastDamager(playerid, INVALID_PLAYER_ID, 47);
	PlayerInfo[playerid][player_stinger] = false;
	return 1;
}

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if(GetVehicleModel(vehicleid) == 423 && ispassenger == 0) {
		EnablePlayerCameraTarget(playerid, true);
	}
	return 0;
}

hook OnPlayerExitVehicle(playerid, vehicleid)
{
	if(GetVehicleModel(vehicleid) == 535) {
		PlayerInfo[playerid][player_stinger] = false;
	}
	return 0;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	// called on shooting
	if((newkeys & KEY_FIRE) && !(oldkeys & KEY_FIRE)) {
		new vehicleid = GetPlayerVehicleID(playerid);
		switch(GetVehicleModel(vehicleid)) {
			case 476: {
				if(RustlerCooldown[playerid] == false)
				{
					// rustler coords
					new Float:fX, Float:fY, Float:fZ;
			        GetVehiclePos(vehicleid, fX, fY, fZ);
					// rustler rotation matrix
			        new
					Float:rightX, Float:rightY, Float:rightZ,
					Float:atX, Float:atY, Float:atZ;
					// change missile velocity
					new missile_velocity = 100;

					new Float:rw, Float:rx, Float:ry, Float:rz;
					
			        GetVehicleRotationQuat(vehicleid, rw, rx, ry, rz);

					rightX = 2 * (rw*rw + rx*rx) - 1;
					rightY = 2 * (rx*ry - rw*rz);
					rightZ = 2 * (rx*rz + rw*ry);

					atX = 2 * (ry*rx + rw*rz);
					atY = 2 * (rw*rw + ry*ry) - 1;
					atZ = 2 * (ry*rz - rw*rx);
					
					new Float:distance = 300.0;			
					
					new Float:flX, Float:flY, Float:flZ,
						Float:frX, Float:frY, Float:frZ,
						Float:dflX, Float:dflY, Float:dflZ,
						Float:dfrX, Float:dfrY, Float:dfrZ;	
					// origin coords of left missile
					flX = fX + atX * 5 - rightX * 2;
					flY = fY + atY * 5 - rightY * 2;
					flZ = fZ + atZ * 5 - rightZ * 2;
					// destination coords of left missile
					dflX = fX + atX * distance - rightX * 2;
					dflY = fY + atY * distance - rightY * 2;
					dflZ = fZ + atZ * distance - rightZ * 2;
					// origin coords of right missile
					frX = fX + atX * 5 + rightX * 2;
					frY = fY + atY * 5 + rightY * 2;
					frZ = fZ + atZ * 5 + rightZ * 2;
					// destination coords of right missile
					dfrX = fX + atX * distance + rightX * 2;
					dfrY = fY + atY * distance + rightY * 2;
					dfrZ = fZ + atZ * distance + rightZ * 2;
					// create objects
					new Float:temp_X, Float:temp_Y, Float:temp_Z;
					new l_obstacle = CA_RayCastLine(flX, flY, flZ, dflX, dflY, dflZ, temp_X, temp_Y, temp_Z);
					if(l_obstacle != 0) {
						dflX = temp_X;
						dflY = temp_Y;
						dflZ = temp_Z;		
					}
					
					new r_obstacle = CA_RayCastLine(frX, frY, frZ, dfrX, dfrY, dfrZ, temp_X, temp_Y, temp_Z);
					if(r_obstacle != 0) {
						dfrX = temp_X;
						dfrY = temp_Y;
						dfrZ = temp_Z;		
					}
		
			        new l_obj = CreateObject(345, flX, flY, flZ, 0.0, 0.0, 0.0);
					// calculate absolute length from origin to destination 
					new Float:l_length = floatsqroot(floatpower(dflX - flX, 2) + floatpower(dflY - flY, 2) + floatpower(dflZ - flZ, 2));
					new r_obj = CreateObject(345, frX, frY, frZ, 0.0, 0.0, 0.0);
					new Float:r_length = floatsqroot(floatpower(dfrX - frX, 2) + floatpower(dfrY - frY, 2) + floatpower(dfrZ - frZ, 2));
					// calculate time for destroying object
					SetTimerEx("DestroyDeagleObject", floatround(l_length / missile_velocity * 1000), false, "ii", playerid, l_obj);
					// move missile
					MoveObject(l_obj, dflX, dflY, dflZ, missile_velocity);
					SetTimerEx("DestroyDeagleObject", floatround(r_length / missile_velocity * 1000), false, "ii", playerid, r_obj);
					MoveObject(r_obj, dfrX, dfrY, dfrZ, missile_velocity);
					RustlerCooldown[playerid] = true;
					SetTimerEx("ReleaseRustlerCooldown", 500, false, "i", playerid);
				} else SendClientMessage(playerid, PASTEL_GRAY_DARK, "COOLDOWN");
			}
			case 535: {
				if(PlayerInfo[playerid][player_stinger] == false)
				{
					if(MissileCooldown[playerid] == 0)
					{
						PlayerInfo[playerid][player_stinger] = true;
						new missileid = LaunchPlayerMissile(playerid, playerid, 3);
						if(missileid == -1) return 1;
						AttachCameraToDynamicObject(playerid, WMInfo[missileid][wm_objectid]);
						MissileCooldown[playerid] = MISSILE_COOLDOWN;
					}
					MissileCoolDownMessage(playerid);
				} else
				{
					DestroyMissile(PlayerInfo[playerid][player_stinger_missile]);
					PlayerInfo[playerid][player_stinger] = false;
					SetCameraBehindPlayer(playerid);
				}
			}
		}
	}
	return 1;
}

forward ReleaseRustlerCooldown(playerid);
hook ReleaseRustlerCooldown(playerid)
{
	RustlerCooldown[playerid] = false;
}

forward DestroyDeagleObject(playerid, objectid);
hook DestroyDeagleObject(playerid, objectid)
{
	new Float:fX, Float:fY, Float:fZ;
	GetObjectPos(objectid, fX, fY, fZ);
	DestroyObject(objectid);
	CreateCustomExplosion(playerid, fX, fY, fZ, 0, MISSILE_EXPLOSION_RADIUS);
}

hook OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	new vehicleid = GetPlayerVehicleID(playerid);
	switch(GetVehicleModel(vehicleid)) {
		case 423: if(MissileCooldown[playerid] == 0) LaunchPlayerMissile(playerid, clickedplayerid, 1); else MissileCoolDownMessage(playerid);
		case 413: if(MissileCooldown[playerid] == 0) LaunchPlayerMissile(playerid, clickedplayerid, 2); else MissileCoolDownMessage(playerid);
	}
	return 0;
}

hook SecondUpdate()
{
	for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && MissileCooldown[i] > 0) MissileCooldown[i]--;
}

stock MissileCoolDownMessage(playerid)
{
	new accentcolor[7];
	format(accentcolor, 7, "%x", PASTEL_TEAL_LIGHT);

	new normalcolor[7];
	format(normalcolor, 7, "%x", PASTEL_PEACH_LIGHT);

	new string[64 - 8 + 18 + 2];
	format(string, sizeof(string), "{%s}Wait {%s}%d seconds{%s} before launching the missile again!", normalcolor, accentcolor, MissileCooldown[playerid], normalcolor);
	SendClientMessage(playerid, -1, string);
}

stock LaunchPlayerMissile(playerid, victimid, type) {
	MissileCooldown[playerid] = MISSILE_COOLDOWN;
	new Float:oX, Float:oY, Float:oZ,
		Float:dX, Float:dY, Float:dZ,
		Float:tX, Float:tY, Float:tZ;
		
	GetPlayerPos(playerid, oX, oY, oZ);
	dX = oX;
	dY = oY;
	dZ = oZ + MISSILE_HEIGHT;
	new upper_obstacle = CA_RayCastLine(oX, oY, oZ, dX, dY, dZ, tX, tY, tZ);
	if(upper_obstacle != 0) {
		return -1;
	}
	
	new missileid = FindEmptyMissileSlot();
	if(missileid == -1)
	{
		SendClientMessage(playerid, PASTEL_CORAL_DARK, "Missiles overflow!");
		return -1;
	}
	new objectid = CreateDynamicObject(345, oX, oY, oZ, 0, 0, 0);
	
	Streamer_SetIntData(STREAMER_TYPE_OBJECT, objectid, E_STREAMER_EXTRA_ID, missileid + MISSILE_EX_ID_OFFSET);
	
	WMInfo[missileid][wm_playerid] = playerid;
	WMInfo[missileid][wm_targetid] = victimid;
	WMInfo[missileid][wm_objectid] = objectid;
	WMInfo[missileid][wm_type] = type;
	WMInfo[missileid][wm_faced_obstacle] = false;

	MoveDynamicObject(objectid, dX, dY, dZ, MISSILE_VELOCITY, 0, 0, 0);
	SendClientMessage(playerid, PASTEL_CORAL_DARK, "Missile Launched!");
	
	return missileid;
}

hook OnDynamicObjectMoved(objectid)
{
	new missileid = Streamer_GetIntData(STREAMER_TYPE_OBJECT, objectid, E_STREAMER_EXTRA_ID) - MISSILE_EX_ID_OFFSET;
	if(0 > missileid || missileid >= MAX_MISSILES) return 1;
	new target_state = GetPlayerState(WMInfo[missileid][wm_targetid]);
	if(target_state != 7 && target_state != 9 && WMInfo[missileid][wm_faced_obstacle] == false) {
		switch(WMInfo[missileid][wm_type]) {
			case 1: MoveCheckpointMissile(missileid);
			case 2: MoveStepMissile(missileid);
			case 3: MoveStingerMissile(missileid);
		}
	} else {
		switch(WMInfo[missileid][wm_type]) {
			case 3: SetCameraBehindPlayer(WMInfo[missileid][wm_playerid]);
		}
		DestroyMissile(missileid);
	}
	return 0;
}

stock MoveCheckpointMissile(missileid)
{
	new Float:oX, Float:oY, Float:oZ,
		Float:dX, Float:dY, Float:dZ;
		
	GetDynamicObjectPos(WMInfo[missileid][wm_objectid], oX, oY, oZ);
	GetPlayerPos(WMInfo[missileid][wm_targetid], dX, dY, dZ);
	if(floatsqroot(floatpower(dX - oX, 2) + floatpower(dY - oY, 2) + floatpower(dZ - oZ, 2)) < MISSILE_CONTACT)
	{
		DestroyMissile(missileid);
		return 1;
	}
	new Float:tX, Float:tY, Float:tZ;
	new obstacle = CA_RayCastLine(oX, Float:oY, Float:oZ, Float:dX, Float:dY, Float:dZ, Float:tX, Float:tY, Float:tZ);
	if(obstacle != 0)
	{
		dX = tX;
		dY = tY;
		dZ = tZ;
		WMInfo[missileid][wm_faced_obstacle] = true;
	}
	MoveDynamicObject(WMInfo[missileid][wm_objectid], dX, dY, dZ, MISSILE_VELOCITY, 0, 0, 0);
	return 0;
}

stock MoveStepMissile(missileid)
{
	new Float:oX, Float:oY, Float:oZ,
		Float:dX, Float:dY, Float:dZ,
		Float:sX, Float:sY, Float:sZ;
		
	GetDynamicObjectPos(WMInfo[missileid][wm_objectid], oX, oY, oZ);
	GetPlayerPos(WMInfo[missileid][wm_targetid], dX, dY, dZ);
	
	new Float:length = floatsqroot(floatpower(dX - oX, 2) + floatpower(dY - oY, 2) + floatpower(dZ - oZ, 2));
	
	if(length < MISSILE_CONTACT) 
	{
		DestroyMissile(missileid);
		return 1;
	}
	
	sX = (dX - oX) / length * MISSILE_STEP;
	sY = (dY - oY) / length * MISSILE_STEP;
	sZ = (dZ - oZ) / length * MISSILE_STEP;
	
	dX = oX + sX;
	dY = oY + sY;
	dZ = oZ + sZ;

	new Float:tX, Float:tY, Float:tZ;
	new obstacle = CA_RayCastLine(oX, Float:oY, Float:oZ, Float:dX, Float:dY, Float:dZ, Float:tX, Float:tY, Float:tZ);
	if(obstacle != 0)
	{
		dX = tX;
		dY = tY;
		dZ = tZ;
		WMInfo[missileid][wm_faced_obstacle] = true;
	}
	
	MoveDynamicObject(WMInfo[missileid][wm_objectid], dX, dY, dZ, MISSILE_VELOCITY, 0, 0, 0);
	return 0;
}

stock MoveStingerMissile(missileid)
{
	if(PlayerInfo[WMInfo[missileid][wm_playerid]][player_stinger])
	{
		new Float:oX, Float:oY, Float:oZ,
			Float:dX, Float:dY, Float:dZ,
			Float:nX, Float:nY, Float:nZ;
		GetPlayerCameraFrontVector(WMInfo[missileid][wm_playerid], nX, nY, nZ);
		GetDynamicObjectPos(WMInfo[missileid][wm_objectid], oX, oY, oZ);
		dX = oX + nX * MISSILE_STINGER_STEP;
		dY = oY + nY * MISSILE_STINGER_STEP;
		dZ = oZ + nZ * MISSILE_STINGER_STEP;
		new Float:tX, Float:tY, Float:tZ;
		new obstacle = CA_RayCastLine(oX, Float:oY, Float:oZ, Float:dX, Float:dY, Float:dZ, Float:tX, Float:tY, Float:tZ);
		if(obstacle != 0)
		{
			dX = tX;
			dY = tY;
			dZ = tZ;
			WMInfo[missileid][wm_faced_obstacle] = true;
		}
		MoveDynamicObject(WMInfo[missileid][wm_objectid], dX, dY, dZ, MISSILE_STINGER_VELOCITY, 0, 0, 0);
		return 0;
	} else
	{
		DestroyMissile(missileid);
		PlayerInfo[WMInfo[missileid][wm_playerid]][player_stinger] = false;
		SetCameraBehindPlayer(WMInfo[missileid][wm_playerid]);
		return 1;
	}
}

stock DestroyMissile(missileid)
{
	new Float:oX, Float:oY, Float:oZ;
	GetDynamicObjectPos(WMInfo[missileid][wm_objectid], oX, oY, oZ);
	WMInfo[missileid][wm_targetid] = -1;
	DestroyDynamicObject(WMInfo[missileid][wm_objectid]);
	CreateCustomExplosion(WMInfo[missileid][wm_playerid], oX, oY, oZ, 6, 20);
}

stock FindEmptyMissileSlot()
{
    new
        i = 0;
    while (i < MAX_MISSILES && WMInfo[i][wm_targetid] != -1)
    {
        i++;
    }
    if (i == MAX_MISSILES) return -1;
    return i;
}