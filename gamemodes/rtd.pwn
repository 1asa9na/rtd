#include <a_samp>
#include <Pawn.CMD>
#include <streamer>
#include <sscanf2>
#include <ColAndreas>
#include <YSI_Coding\y_hooks>
#include "..\modules\misc\consts.pwn"
#include "..\modules\misc\enums.pwn"
#include "..\modules\features\weapons.pwn"
#include "..\modules\features\zones.pwn"

/* OFFSETS

BOMB_CP_EX_ID_OFFSET							200001 - 300000
MISSILE_EX_ID_OFFSET							300001 - 400000
SKILL_ROOK_TOWERS_EX_ID_OFFSET					400001 - 500000
ZONE_CP_EX_ID_OFFSET							500001 - 600000

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
	ClassInfo[0][color] = 0xFFFF0480;
	
	ClassInfo[1][x] = 1238.5229;
	ClassInfo[1][y] = 213.6815;
	ClassInfo[1][z] = 19.5547;
	ClassInfo[1][a] = 115.0993;
	strins(ClassInfo[1][title], "GRIBS", 0);
	ClassInfo[1][skin] = 73;
	ClassInfo[1][color] = 0xFF040480;
		
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
	PerkInfo[0][perk_weapon_ammo] = { 50, 500, 5 };
	strins(PerkInfo[0][perk_title], "Pawn", 0);
	
	PerkInfo[1][perk_health] = 75;
	PerkInfo[1][perk_armour] = 0;
	PerkInfo[1][perk_weapons] = { WEAPON_SILENCED, WEAPON_KNIFE, WEAPON_SNIPER };
	PerkInfo[1][perk_weapon_ammo] = { 50, 1, 50 };
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
	CreateObject(3279, 1228.10315, 353.25989, 18.44100,   0.00000, 0.00000, 157.00000);
	CreateObject(13638, 1361.86523, 401.67441, 20.85201,   0.00000, 0.00000, 246.53470);
	CreateObject(18609, 1290.63513, 261.70557, 19.49440,   0.00000, 0.00000, 69.74204);
	CreateObject(1457, 1294.49634, 295.10037, 28.11846,   0.00000, 0.00000, 332.40698);
	CreateObject(3279, 1228.10315, 353.25989, 18.44100,   0.00000, 0.00000, 157.00000);
	CreateObject(13638, 1361.86523, 401.67441, 20.85201,   0.00000, 0.00000, 246.53470);
	CreateObject(18609, 1290.63513, 261.70557, 19.49440,   0.00000, 0.00000, 69.74204);
	CreateObject(1457, 1294.49634, 295.10037, 28.11846,   0.00000, 0.00000, 332.40698);
	CreateObject(3279, 1228.10315, 353.25989, 18.44100,   0.00000, 0.00000, 157.00000);
	CreateObject(13638, 1361.86523, 401.67441, 20.85201,   0.00000, 0.00000, 246.53470);
	CreateObject(18609, 1290.63513, 261.70557, 19.49440,   0.00000, 0.00000, 69.74204);
	CreateObject(1457, 1294.49634, 295.10037, 28.11846,   0.00000, 0.00000, 332.40698);
	CreateObject(11446, 1357.64490, 307.83496, 23.49558,   0.00000, 0.00000, 337.77130);
	CreateObject(11458, 1379.10547, 389.08664, 27.88662,   0.00000, 0.00000, 64.88051);
	CreateObject(3615, 1367.32703, 330.68527, 20.37288,   0.00000, 0.00000, 155.86333);
	CreateObject(16092, 1279.06055, 253.13260, 19.14866,   0.00000, 0.00000, 336.88571);
	CreateObject(11292, 1307.81287, 271.76620, 19.76830,   0.00000, 0.00000, 245.66460);
	CreateObject(1364, 1315.77844, 285.73843, 19.41738,   0.00000, 0.00000, 246.06494);
	CreateObject(1364, 1313.11963, 280.27469, 19.41740,   0.00000, 0.00000, 246.06490);
	CreateObject(1364, 1303.84033, 329.04056, 19.41738,   0.00000, 0.00000, 336.50311);
	CreateObject(10845, 1250.38550, 404.36823, 21.09506,   0.00000, 0.00000, 337.23984);
	CreateObject(6973, 1247.39038, 388.59955, 26.98493,   0.00000, 0.00000, 335.02664);
	CreateObject(19791, 1246.17297, 405.13461, 20.69983,   0.00000, 0.00000, 335.22952);
	CreateObject(1437, 1269.59656, 390.91599, 23.45700,   -39.00000, 0.00000, 251.00000);
	CreateObject(4892, 1387.93250, 175.22810, 21.00030,   0.44000, -0.02000, 333.50061);
	CreateObject(4006, 1342.90637, 125.85070, 39.42012,   0.00000, 0.00000, 337.41333);
	CreateObject(3802, 1356.91077, 94.34752, 28.73923,   0.00000, 0.00000, 0.00000);
	CreateObject(811, 1321.23279, 107.76624, 21.61401,   0.00000, 0.00000, 2.54597);
	CreateObject(811, 1357.14856, 93.83148, 24.99998,   0.00000, 0.00000, 0.00000);
	CreateObject(811, 1350.63440, 95.42824, 24.71455,   0.00000, 0.00000, 2.54597);
	CreateObject(805, 1362.66907, 105.61636, 25.03525,   0.00000, 0.00000, 90.46434);
	CreateObject(805, 1358.57666, 95.79657, 25.17348,   0.00000, 0.00000, 17.72959);
	CreateObject(805, 1326.44055, 104.77839, 22.23219,   0.00000, 0.00000, 336.99939);
	CreateObject(805, 1353.12378, 93.51199, 24.73223,   0.00000, 0.00000, 336.79837);
	CreateObject(3948, 1340.94202, 99.17023, 29.96925,   0.00000, 0.00000, 316.37344);
	CreateObject(800, 1320.55054, 111.52724, 22.60098,   0.00000, 0.00000, 0.00000);
	CreateObject(800, 1339.98804, 151.37172, 22.70112,   0.00000, 0.00000, 69.26617);
	CreateObject(800, 1367.57031, 117.96010, 24.91394,   0.00000, 0.00000, 0.00000);
	CreateObject(800, 1339.05994, 99.61358, 24.21200,   0.00000, 0.00000, 0.00000);
	CreateObject(813, 1365.91650, 137.27994, 22.40617,   0.00000, 0.00000, 2.70423);
	CreateObject(813, 1345.44666, 97.93459, 24.58684,   0.00000, 0.00000, 0.00000);
	CreateObject(813, 1350.55066, 89.04894, 25.19388,   0.00000, 0.00000, 0.00000);
	CreateObject(800, 1360.35425, 99.91250, 26.32801,   0.00000, 0.00000, 0.00000);
	CreateObject(800, 1371.98865, 134.96132, 22.90716,   0.00000, 0.00000, 69.26617);
	CreateObject(3409, 1365.82007, 138.76602, 21.53094,   0.00000, 0.00000, 346.81577);
	CreateObject(2345, 1366.91858, 135.16638, 28.20513,   0.00000, 0.00000, 157.71016);
	CreateObject(10244, 1332.69238, 121.10745, 22.52159,   0.00000, 0.00000, 338.07620);
	CreateObject(16082, 1360.07874, 141.30809, 27.07852,   0.00000, 0.00000, 338.28577);
	CreateObject(18769, 1345.52576, 128.68925, 25.42372,   0.00000, 0.00000, 338.24036);
	CreateObject(3287, 1322.89941, 119.81411, 25.03982,   0.00000, 0.00000, 336.24872);
	CreateObject(939, 1340.16052, 131.54070, 28.49620,   0.00000, 0.00000, 323.61520);
	CreateObject(3257, 1178.27185, 189.68314, 20.43232,   0.00000, 0.00000, 338.15289);
	CreateObject(3673, 1160.15210, 192.55182, 45.36946,   0.00000, 0.00000, 69.03115);
	CreateObject(16092, 1180.23279, 203.15872, 20.23230,   0.00000, 0.00000, 67.93568);
	CreateObject(3256, 1196.45764, 195.94125, 19.23607,   0.00000, 0.00000, 0.00000);
	CreateObject(3256, 1431.60010, 252.63109, 18.30771,   0.00000, 0.00000, 0.00000);
	CreateObject(13758, 1222.47302, 164.76703, 43.00869,   0.00000, 0.00000, 0.49710);
	CreateObject(3031, 1209.37683, 228.00684, 25.38786,   0.00000, 0.00000, 0.00000);
	CreateObject(2098, 1210.23450, 208.29138, 20.17908,   0.00000, 0.00000, 275.45184);
	CreateObject(12957, 1188.44348, 186.29140, 20.85870,   0.00000, 0.00000, 0.00000);
	CreateObject(12957, 1170.07629, 210.34090, 21.47140,   11.00000, 0.00000, 118.00000);
	CreateObject(3885, 1233.08862, 323.83807, 24.64795,   0.00000, 0.00000, 144.13782);
	CreateObject(3885, 1208.22974, 236.88675, 24.12868,   0.00000, 0.00000, 0.00000);
	CreateObject(3885, 1334.65784, 148.81943, 45.27212,   0.00000, 0.00000, 173.30852);
	CreateObject(16601, 1377.40808, 166.45819, 22.62844,   0.00000, 0.00000, 334.47568);
	CreateObject(3575, 1289.63416, 248.20375, 21.08117,   0.00000, 0.00000, 67.24069);
	CreateObject(11295, 1464.16223, 247.77873, 23.90706,   0.00000, 0.00000, 61.00855);
	CreateObject(17008, 1466.53442, 270.25143, 24.03727,   0.00000, 0.00000, 335.25122);
	CreateObject(3279, 1228.10315, 353.25989, 18.44100,   0.00000, 0.00000, 157.00000);
	CreateObject(13638, 1361.86523, 401.67441, 20.85201,   0.00000, 0.00000, 246.53470);
	CreateObject(18609, 1290.63513, 261.70557, 19.49440,   0.00000, 0.00000, 69.74204);
	CreateObject(1457, 1294.49634, 295.10037, 28.11846,   0.00000, 0.00000, 332.40698);
	CreateObject(3279, 1228.10315, 353.25989, 18.44100,   0.00000, 0.00000, 157.00000);
	CreateObject(13638, 1361.86523, 401.67441, 20.85201,   0.00000, 0.00000, 246.53470);
	CreateObject(18609, 1290.63513, 261.70557, 19.49440,   0.00000, 0.00000, 69.74204);
	CreateObject(1457, 1294.49634, 295.10037, 28.11846,   0.00000, 0.00000, 332.40698);
	CreateObject(3374, 1447.51538, 257.98120, 19.73565,   0.00000, 0.00000, 282.39108);
	CreateObject(3374, 1453.97375, 260.11935, 19.56147,   0.00000, 0.00000, 0.00000);
	CreateObject(3374, 1452.11646, 251.97990, 19.56147,   0.00000, 0.00000, 305.71689);
	CreateObject(3359, 1442.41760, 270.46066, 18.07055,   0.00000, 0.00000, 333.74951);
	CreateObject(12912, 1449.12463, 289.17200, 29.23555,   0.00000, 0.00000, 333.68137);
	CreateObject(13367, 1442.61328, 300.26135, 29.71389,   0.00000, 0.00000, 0.00000);
	CreateObject(1358, 1439.14282, 286.10852, 19.41241,   0.00000, 0.00000, 0.00000);
	CreateObject(1358, 1446.27686, 243.49200, 19.68940,   0.00000, 0.00000, 28.91540);
	CreateObject(1358, 1454.38904, 266.72559, 19.46018,   0.00000, 0.00000, 0.00000);
	CreateObject(18228, 1464.52368, 329.72012, 16.71810,   0.00000, 0.00000, 353.61871);
	CreateObject(17031, 1176.07544, 337.26660, 17.05140,   0.00000, 0.00000, 342.66147);
	CreateObject(19905, 1464.71045, 229.34293, 18.26331,   0.00000, 0.00000, 22.55102);
	CreateObject(3392, 1477.06104, 240.06984, 18.44570,   0.00000, 0.00000, 65.55820);
	CreateObject(3391, 1479.36670, 235.04980, 18.43900,   0.00000, 0.00000, 10.92030);
	CreateObject(2977, 1457.14233, 233.21011, 18.33790,   0.00000, 0.00000, 27.74111);
	CreateObject(2977, 1455.97070, 232.63768, 18.33790,   0.00000, 0.00000, 17.59930);
	CreateObject(8408, 1484.69641, 211.88707, 24.97230,   0.00000, 0.00000, 293.77362);
	CreateObject(1260, 1406.58289, 180.95935, 31.74717,   0.00000, 0.00000, 313.90915);
	CreateObject(7909, 1406.79346, 181.01559, 37.58939,   0.00000, 0.00000, 223.51338);
	CreateObject(10838, 1397.40991, 196.28410, 33.92350,   0.00000, 0.00000, 153.64485);
	CreateObject(13831, 1331.72925, -17.12313, 37.85617,   0.00000, 0.00000, 194.44398);
	CreateObject(3715, 1200.88269, 365.25302, 28.61339,   0.00000, 0.00000, 240.90656);
	CreateObject(12929, 1417.34412, 144.15570, 19.93640,   0.00000, -5.00000, 335.00000);
	CreateObject(1447, 1391.68494, 154.38019, 19.78867,   0.00000, 0.00000, 325.52652);
	CreateObject(1447, 1405.60815, 145.56329, 20.37445,   0.00000, 0.00000, 332.60751);
	CreateObject(1447, 1401.08142, 148.68010, 20.27039,   0.00000, 0.00000, 321.89969);
	CreateObject(1447, 1396.10425, 151.51601, 19.83400,   0.00000, 0.00000, 329.61469);
	CreateObject(1458, 1400.34338, 156.06161, 18.75117,   0.00000, 0.00000, 0.00000);
	CreateObject(3576, 1391.97925, 156.52524, 19.61860,   0.00000, 0.00000, 149.35295);
	CreateObject(3576, 1413.65234, 152.25636, 20.84900,   0.00000, 0.00000, 340.83435);
	CreateObject(3066, 1408.82666, 157.68893, 19.61837,   0.00000, 0.00000, 249.30527);
	CreateObject(849, 1407.71802, 147.04535, 19.36053,   0.00000, 0.00000, 0.00000);
	CreateObject(849, 1399.24280, 161.13219, 18.74511,   0.00000, 0.00000, 0.00000);
	CreateObject(849, 1408.26965, 189.73430, 19.46541,   0.00000, 0.00000, 0.00000);
	CreateObject(849, 1420.89624, 201.98228, 19.86741,   0.00000, 0.00000, 0.00000);
	CreateObject(19839, 1414.76892, 165.79225, 19.84510,   0.00000, 0.00000, 358.97040);
	CreateObject(19839, 1415.18774, 159.67160, 19.54410,   0.00000, 0.00000, 0.00000);
	CreateObject(19839, 1411.26123, 160.39397, 19.54410,   0.00000, 0.00000, 0.00000);
	CreateObject(19839, 1411.55505, 163.13071, 19.54410,   0.00000, 0.00000, 0.00000);
	CreateObject(871, 1402.24316, 162.90959, 18.88656,   0.00000, 0.00000, 0.00000);
	CreateObject(871, 1410.05859, 179.06833, 19.76419,   0.00000, 0.00000, 53.42636);
	CreateObject(871, 1420.80212, 173.68660, 20.57314,   0.00000, 0.00000, 0.00000);
	CreateObject(16390, 1419.56348, 149.86996, 21.55675,   0.00000, 0.00000, 336.04471);
	CreateObject(12957, 1444.62280, 250.04201, 19.23352,   0.00000, 0.00000, 0.00000);
	CreateObject(1410, 1442.83997, 229.82521, 19.05146,   0.00000, 0.00000, 356.46475);
	CreateObject(1410, 1434.14001, 276.95578, 19.03543,   0.00000, 0.00000, 156.36214);
	CreateObject(16281, 1452.43323, 274.12555, 20.12174,   0.00000, 0.00000, 213.02989);
	CreateObject(16360, 1332.28308, 442.13339, 18.45880,   0.00000, -1.32000, 0.00000);
	CreateObject(14826, 1340.34387, 431.67484, 19.09834,   0.00000, 0.00000, 331.63828);
	CreateObject(639, 1371.73425, 406.40445, 27.75225,   0.00000, 0.00000, 336.61148);
	CreateObject(6283, 1451.49158, 444.78653, 24.02414,   0.00000, 0.00000, 332.46100);
	CreateObject(9153, 1447.16174, 427.91080, 22.07148,   0.00000, 0.00000, 275.64539);
	CreateObject(3660, 1419.67896, 448.22284, 21.24988,   0.00000, 0.00000, 246.93246);
	CreateObject(1425, 1187.05627, 301.27054, 18.78717,   0.00000, 0.00000, 81.34924);
	CreateObject(3749, 1242.45300, 129.30240, 24.35081,   0.00000, 0.00000, 349.06247);
	CreateObject(8042, 1437.93311, 181.96376, 27.07482,   0.00000, 0.00000, 175.61536);
	CreateObject(16003, 1435.19202, 191.04546, 22.09670,   0.00000, 0.00000, 340.67258);
	CreateObject(3107, 1429.12976, 179.84427, 19.54132,   0.00000, 0.00000, 0.00000);
	CreateObject(16327, 1475.67761, 203.13539, 19.36382,   0.00000, 0.00000, 334.77917);
	CreateObject(5837, 1462.60352, 209.38710, 19.26690,   -3.00000, -1.00000, 17.00000);


	CA_RemoveBuilding(785, 1460.7813, 444.3906, 18.0078, 0.25);
	CA_RemoveBuilding(791, 1460.7813, 444.3906, 18.0078, 0.25);
	CA_Init();
	
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
	
	CPInfo[0][cp_team] = -1;
	CPInfo[0][cp_player] = -1;
	CPInfo[0][occupied] = false;
	CPInfo[0][cp_x] = 1271.5677;
	CPInfo[0][cp_y] = 295.0919;
	CPInfo[0][cp_z] = 20.6563;
	CPInfo[0][cp_mapicon] = 19;
	CPInfo[0][cp_bomb_timer] = -1;
	CPInfo[0][cp_defuse_timer] = -1;
	CPInfo[0][is_active] = false;
	
	CPInfo[1][cp_team] = -1;
	CPInfo[1][cp_player] = -1;
	CPInfo[1][occupied] = false;
	CPInfo[1][cp_x] = 1362.3979;
	CPInfo[1][cp_y] = 321.5292;
	CPInfo[1][cp_z] = 19.5547;
	CPInfo[1][cp_mapicon] = 19;
	CPInfo[1][cp_bomb_timer] = -1;
	CPInfo[1][cp_defuse_timer] = -1;
	CPInfo[1][is_active] = false;
	
	for(new i = 0; i < N_BOMB_CPS; i++) {
		new cp = CreateDynamicCP(CPInfo[i][cp_x], CPInfo[i][cp_y], CPInfo[i][cp_z], 1);
		Streamer_SetIntData(STREAMER_TYPE_CP, cp, E_STREAMER_EXTRA_ID, i + BOMB_CP_EX_ID_OFFSET);
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

CMD:crime(playerid, params[])
{
	new crimeid;
	if(sscanf(params, "i", crimeid)) crimeid = 6;
	PlayCrimeReportForPlayer(playerid, playerid, crimeid);
}

stock DestroyPlayerVehicle(playerid) {
	DestroyVehicle(PlayerInfo[playerid][player_vehicle]);
}

public OnPlayerConnect(playerid)
{
	RemoveBuildingForPlayer(playerid, 785, 1460.7813, 444.3906, 18.0078, 0.25);
	RemoveBuildingForPlayer(playerid, 791, 1460.7813, 444.3906, 18.0078, 0.25);

	PlayerInfo[playerid][kills] = 0;
	PlayerInfo[playerid][deaths] = 0;
	PlayerInfo[playerid][player_perk] = -1;
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

public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
{
	return 1;
}

public OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid, bodypart)
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
	SetPlayerInterior(playerid, 0);
	SetPlayerWorldBounds(playerid, 1496, 1173, 477, 96);
	
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
	new bombcpid = Streamer_GetIntData(STREAMER_TYPE_CP, checkpointid, E_STREAMER_EXTRA_ID) - BOMB_CP_EX_ID_OFFSET;
	if(bombcpid >= N_BOMB_CPS || bombcpid < 0) return 1;
	if(CPInfo[bombcpid][occupied]) {
		SendClientMessage(playerid, 0xFFFF00FF, "Checkpoint is occupied by other player!");
	}
	else {
		CPInfo[bombcpid][occupied] = true;
		if(PlayerInfo[playerid][is_carrying_bomb] && CPInfo[bombcpid][is_active] == false) {
			CPInfo[bombcpid][cp_player] = playerid;
			CPInfo[bombcpid][cp_team] = GetPlayerTeam(playerid);
			ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, false, false, false, true, 2670, 1);
			SendClientMessageToAll(0xFFFF00FF, "Bomb has been planted!");
			CPInfo[bombcpid][cp_bomb_timer] = SetTimerEx("DestroyPickupBomb", 40*1000, false, "ii",	bombcpid, playerid);
			CPInfo[bombcpid][is_active] = true;
			PlayerInfo[playerid][is_carrying_bomb] = false;
		}
		if(CPInfo[bombcpid][cp_team] != GetPlayerTeam(playerid) && CPInfo[bombcpid][is_active])
		{
			CPInfo[bombcpid][cp_player] = playerid;
			ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, false, false, false, true, 2670, 1);
			SendClientMessageToAll(0xFFFF00FF, "Bomb is being defused!");
			CPInfo[bombcpid][cp_defuse_timer] = SetTimerEx("DefusePickupBomb", 10*1000, false, "ii", bombcpid, playerid);
		}
	}
	return 0;
}

public OnPlayerLeaveDynamicCP(playerid, checkpointid)
{
	new bombcpid = Streamer_GetIntData(STREAMER_TYPE_CP, checkpointid, E_STREAMER_EXTRA_ID) - BOMB_CP_EX_ID_OFFSET;
	if(bombcpid >= N_BOMB_CPS || bombcpid < 0) return 1;
	CPInfo[bombcpid][occupied] = false;
	if(CPInfo[checkpointid][cp_player] == playerid && CPInfo[bombcpid][cp_defuse_timer] != -1)
	{
		SendClientMessage(playerid, 0xFFFF00FF, "Bomb defusing has been interrupted!");
		KillTimer(CPInfo[bombcpid][cp_defuse_timer]);
		CPInfo[bombcpid][cp_defuse_timer] = -1;
		
	}
	return 0;
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