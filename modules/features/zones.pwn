#include <YSI_Coding\y_hooks>

new gBonusZone;
new gBonusZoneMoney;
new gBonusZoneScore;

new gDangerZone;

hook OnGameModeInit()
{
    strins(ZoneInfo[0][z_name], "Helicopter platform", 0);
    ZoneInfo[0][z_minx] = 1173;
    ZoneInfo[0][z_miny] = 371;
    ZoneInfo[0][z_maxx] = 1296;
    ZoneInfo[0][z_maxy] = 477;
    ZoneInfo[0][z_cp_x] = 1260.4614;
    ZoneInfo[0][z_cp_y] = 407.6312;
    ZoneInfo[0][z_cp_z] = 32.9776;

    strins(ZoneInfo[1][z_name], "Small Xoomer", 0);
    ZoneInfo[1][z_minx] = 1296;
    ZoneInfo[1][z_miny] = 404;
    ZoneInfo[1][z_maxx] = 1365;
    ZoneInfo[1][z_maxy] = 477;
    ZoneInfo[1][z_cp_x] = 1334.0259;
    ZoneInfo[1][z_cp_y] = 437.3464;
    ZoneInfo[1][z_cp_z] = 19.2656;

    strins(ZoneInfo[2][z_name], "Burnt Hostel", 0);
    ZoneInfo[2][z_minx] = 1296;
    ZoneInfo[2][z_miny] = 371;
    ZoneInfo[2][z_maxx] = 1341;
    ZoneInfo[2][z_maxy] = 404;
    ZoneInfo[2][z_cp_x] = 1323.2012;
    ZoneInfo[2][z_cp_y] = 392.2362;
    ZoneInfo[2][z_cp_z] = 19.5547;

    strins(ZoneInfo[3][z_name], "Garage", 0);
    ZoneInfo[3][z_minx] = 1341;
    ZoneInfo[3][z_miny] = 304;
    ZoneInfo[3][z_maxx] = 1365;
    ZoneInfo[3][z_maxy] = 404;
    ZoneInfo[3][z_cp_x] = 1358.7297;
    ZoneInfo[3][z_cp_y] = 333.6328;
    ZoneInfo[3][z_cp_z] = 20.5547;

    strins(ZoneInfo[4][z_name], "Shopping District", 0);
    ZoneInfo[4][z_minx] = 1278;
    ZoneInfo[4][z_miny] = 319;
    ZoneInfo[4][z_maxx] = 1341;
    ZoneInfo[4][z_maxy] = 371;
    ZoneInfo[4][z_cp_x] = 1302.4327;
    ZoneInfo[4][z_cp_y] = 343.3603;
    ZoneInfo[4][z_cp_z] = 25.6946;

    strins(ZoneInfo[5][z_name], "Gas Station", 0);
    ZoneInfo[5][z_minx] = 1365;
    ZoneInfo[5][z_miny] = 440;
    ZoneInfo[5][z_maxx] = 1414;
    ZoneInfo[5][z_maxy] = 477;
    ZoneInfo[5][z_cp_x] = 1393.4185;
    ZoneInfo[5][z_cp_y] = 465.4929;
    ZoneInfo[5][z_cp_z] = 20.1437;

    strins(ZoneInfo[6][z_name], "Office Roof", 0);
    ZoneInfo[6][z_minx] = 1365;
    ZoneInfo[6][z_miny] = 368;
    ZoneInfo[6][z_maxx] = 1414;
    ZoneInfo[6][z_maxy] = 440;
    ZoneInfo[6][z_cp_x] = 1379.9146;
    ZoneInfo[6][z_cp_y] = 390.4728;
    ZoneInfo[6][z_cp_z] = 28.7555;

    strins(ZoneInfo[7][z_name], "CIA HQ", 0);
    ZoneInfo[7][z_minx] = 1414;
    ZoneInfo[7][z_miny] = 397;
    ZoneInfo[7][z_maxx] = 1496;
    ZoneInfo[7][z_maxy] = 477;
    ZoneInfo[7][z_cp_x] = 1466.7400;
    ZoneInfo[7][z_cp_y] = 444.1445;
    ZoneInfo[7][z_cp_z] = 22.9485;

    strins(ZoneInfo[8][z_name], "Blyads Base", 0);
    ZoneInfo[8][z_minx] = 1414;
    ZoneInfo[8][z_miny] = 317;
    ZoneInfo[8][z_maxx] = 1496;
    ZoneInfo[8][z_maxy] = 397;
    ZoneInfo[8][z_cp_x] = 0;
    ZoneInfo[8][z_cp_y] = 0;
    ZoneInfo[8][z_cp_z] = 0;

    strins(ZoneInfo[9][z_name], "Outpost", 0);
    ZoneInfo[9][z_minx] = 1365;
    ZoneInfo[9][z_miny] = 317;
    ZoneInfo[9][z_maxx] = 1414;
    ZoneInfo[9][z_maxy] = 368;
    ZoneInfo[9][z_cp_x] = 1368.6953;
    ZoneInfo[9][z_cp_y] = 328.2244;
    ZoneInfo[9][z_cp_z] = 21.0030;

    strins(ZoneInfo[10][z_name], "Real Estate Agency", 0);
    ZoneInfo[10][z_minx] = 1365;
    ZoneInfo[10][z_miny] = 287;
    ZoneInfo[10][z_maxx] = 1439;
    ZoneInfo[10][z_maxy] = 317;
    ZoneInfo[10][z_cp_x] = 1382.4747;
    ZoneInfo[10][z_cp_y] = 305.1288;
    ZoneInfo[10][z_cp_z] = 22.5555;

    strins(ZoneInfo[11][z_name], "Warehouse", 0);
    ZoneInfo[11][z_minx] = 1229;
    ZoneInfo[11][z_miny] = 335;
    ZoneInfo[11][z_maxx] = 1278;
    ZoneInfo[11][z_maxy] = 371;
    ZoneInfo[11][z_cp_x] = 1259.2855;
    ZoneInfo[11][z_cp_y] = 357.3672;
    ZoneInfo[11][z_cp_z] = 23.5555;

    strins(ZoneInfo[12][z_name], "East Tower", 0);
    ZoneInfo[12][z_minx] = 1173;
    ZoneInfo[12][z_miny] = 335;
    ZoneInfo[12][z_maxx] = 1229;
    ZoneInfo[12][z_maxy] = 371;
    ZoneInfo[12][z_cp_x] = 1227.0121;
    ZoneInfo[12][z_cp_y] = 353.2835;
    ZoneInfo[12][z_cp_z] = 35.5191;

    strins(ZoneInfo[13][z_name], "Big Farm", 0);
    ZoneInfo[13][z_minx] = 1439;
    ZoneInfo[13][z_miny] = 260;
    ZoneInfo[13][z_maxx] = 1496;
    ZoneInfo[13][z_maxy] = 317;
    ZoneInfo[13][z_cp_x] = 1460.7114;
    ZoneInfo[13][z_cp_y] = 271.2300;
    ZoneInfo[13][z_cp_z] = 19.1675;

    strins(ZoneInfo[14][z_name], "Montgomery Rocks", 0);
    ZoneInfo[14][z_minx] = 1173;
    ZoneInfo[14][z_miny] = 274;
    ZoneInfo[14][z_maxx] = 1209;
    ZoneInfo[14][z_maxy] = 335;
    ZoneInfo[14][z_cp_x] = 1179.5271;
    ZoneInfo[14][z_cp_y] = 327.9113;
    ZoneInfo[14][z_cp_z] = 27.2508;

    strins(ZoneInfo[15][z_name], "Hazardous Well", 0);
    ZoneInfo[15][z_minx] = 1278;
    ZoneInfo[15][z_miny] = 274;
    ZoneInfo[15][z_maxx] = 1301;
    ZoneInfo[15][z_maxy] = 319;
    ZoneInfo[15][z_cp_x] = 1294.3438;
    ZoneInfo[15][z_cp_y] = 295.0281;
    ZoneInfo[15][z_cp_z] = 27.5555;

    strins(ZoneInfo[16][z_name], "Sprunk Factory", 0);
    ZoneInfo[16][z_minx] = 1301;
    ZoneInfo[16][z_miny] = 245;
    ZoneInfo[16][z_maxx] = 1341;
    ZoneInfo[16][z_maxy] = 319;
    ZoneInfo[16][z_cp_x] = 1318.6965;
    ZoneInfo[16][z_cp_y] = 257.8930;
    ZoneInfo[16][z_cp_z] = 25.0555;

    strins(ZoneInfo[17][z_name], "Smokehouse Tower", 0);
    ZoneInfo[17][z_minx] = 1399;
    ZoneInfo[17][z_miny] = 214;
    ZoneInfo[17][z_maxx] = 1439;
    ZoneInfo[17][z_maxy] = 287;
    ZoneInfo[17][z_cp_x] = 1428.3981;
    ZoneInfo[17][z_cp_y] = 252.6131;
    ZoneInfo[17][z_cp_z] = 32.4561;

    strins(ZoneInfo[18][z_name], "Parking", 0);
    ZoneInfo[18][z_minx] = 1341;
    ZoneInfo[18][z_miny] = 214;
    ZoneInfo[18][z_maxx] = 1365;
    ZoneInfo[18][z_maxy] = 304;
    ZoneInfo[18][z_cp_x] = 1360.4661;
    ZoneInfo[18][z_cp_y] = 242.6955;
    ZoneInfo[18][z_cp_z] = 19.5669;

    strins(ZoneInfo[19][z_name], "Well Stacked Pizza", 0);
    ZoneInfo[19][z_minx] = 1365;
    ZoneInfo[19][z_miny] = 214;
    ZoneInfo[19][z_maxx] = 1399;
    ZoneInfo[19][z_maxy] = 287;
    ZoneInfo[19][z_cp_x] = 1375.6653;
    ZoneInfo[19][z_cp_y] = 255.2755;
    ZoneInfo[19][z_cp_z] = 24.2750;

    strins(ZoneInfo[20][z_name], "Christine's Cafeteria", 0);
    ZoneInfo[20][z_minx] = 1301;
    ZoneInfo[20][z_miny] = 200;
    ZoneInfo[20][z_maxx] = 1341;
    ZoneInfo[20][z_maxy] = 245;
    ZoneInfo[20][z_cp_x] = 1312.8135;
    ZoneInfo[20][z_cp_y] = 220.4762;
    ZoneInfo[20][z_cp_z] = 25.0223;

    strins(ZoneInfo[21][z_name], "Gribs Base", 0);
    ZoneInfo[21][z_minx] = 1222;
    ZoneInfo[21][z_miny] = 200;
    ZoneInfo[21][z_maxx] = 1301;
    ZoneInfo[21][z_maxy] = 274;
    ZoneInfo[21][z_cp_x] = 0;
    ZoneInfo[21][z_cp_y] = 0;
    ZoneInfo[21][z_cp_z] = 0;

    strins(ZoneInfo[22][z_name], "Crippen Memorial", 0);
    ZoneInfo[22][z_minx] = 1209;
    ZoneInfo[22][z_miny] = 274;
    ZoneInfo[22][z_maxx] = 1278;
    ZoneInfo[22][z_maxy] = 335;
    ZoneInfo[22][z_cp_x] = 1241.7764;
    ZoneInfo[22][z_cp_y] = 326.6162;
    ZoneInfo[22][z_cp_z] = 19.7555;

    strins(ZoneInfo[23][z_name], "Southern Storage", 0);
    ZoneInfo[23][z_minx] = 1173;
    ZoneInfo[23][z_miny] = 200;
    ZoneInfo[23][z_maxx] = 1222;
    ZoneInfo[23][z_maxy] = 274;
    ZoneInfo[23][z_cp_x] = 1199.2114;
    ZoneInfo[23][z_cp_y] = 242.6883;
    ZoneInfo[23][z_cp_z] = 19.5547;

    strins(ZoneInfo[24][z_name], "Abandoned Mall", 0);
    ZoneInfo[24][z_minx] = 1173;
    ZoneInfo[24][z_miny] = 96;
    ZoneInfo[24][z_maxx] = 1244;
    ZoneInfo[24][z_maxy] = 200;
    ZoneInfo[24][z_cp_x] = 1195.6024;
    ZoneInfo[24][z_cp_y] = 150.1254;
    ZoneInfo[24][z_cp_z] = 20.4758;

    strins(ZoneInfo[25][z_name], "Motorhome Rental", 0);
    ZoneInfo[25][z_minx] = 1244;
    ZoneInfo[25][z_miny] = 136;
    ZoneInfo[25][z_maxx] = 1341;
    ZoneInfo[25][z_maxy] = 200;
    ZoneInfo[25][z_cp_x] = 1294.3120;
    ZoneInfo[25][z_cp_y] = 174.2238;
    ZoneInfo[25][z_cp_z] = 20.9106;

    strins(ZoneInfo[26][z_name], "Liquor Shop", 0);
    ZoneInfo[26][z_minx] = 1341;
    ZoneInfo[26][z_miny] = 168;
    ZoneInfo[26][z_maxx] = 1399;
    ZoneInfo[26][z_maxy] = 214;
    ZoneInfo[26][z_cp_x] = 1356.6455;
    ZoneInfo[26][z_cp_y] = 191.4068;
    ZoneInfo[26][z_cp_z] = 24.2271;

    strins(ZoneInfo[27][z_name], "Mafia Headquarters", 0);
    ZoneInfo[27][z_minx] = 1244;
    ZoneInfo[27][z_miny] = 96;
    ZoneInfo[27][z_maxx] = 1341;
    ZoneInfo[27][z_maxy] = 136;
    ZoneInfo[27][z_cp_x] = 1338.5804;
    ZoneInfo[27][z_cp_y] = 127.0019;
    ZoneInfo[27][z_cp_z] = 27.0878;

    strins(ZoneInfo[28][z_name], "Private Warehouse", 0);
    ZoneInfo[28][z_minx] = 1341;
    ZoneInfo[28][z_miny] = 96;
    ZoneInfo[28][z_maxx] = 1496;
    ZoneInfo[28][z_maxy] = 168;
    ZoneInfo[28][z_cp_x] = 1414.9597;
    ZoneInfo[28][z_cp_y] = 145.1922;
    ZoneInfo[28][z_cp_z] = 20.8732;

    strins(ZoneInfo[29][z_name], "Western Edge", 0);
    ZoneInfo[29][z_minx] = 1399;
    ZoneInfo[29][z_miny] = 168;
    ZoneInfo[29][z_maxx] = 1496;
    ZoneInfo[29][z_maxy] = 214;
    ZoneInfo[29][z_cp_x] = 1434.4448;
    ZoneInfo[29][z_cp_y] = 188.9247;
    ZoneInfo[29][z_cp_z] = 21.8291;

    strins(ZoneInfo[30][z_name], "White Whale", 0);
    ZoneInfo[30][z_minx] = 1439;
    ZoneInfo[30][z_miny] = 214;
    ZoneInfo[30][z_maxx] = 1496;
    ZoneInfo[30][z_maxy] = 260;
    ZoneInfo[30][z_cp_x] = 1478.8613;
    ZoneInfo[30][z_cp_y] = 238.0277;
    ZoneInfo[30][z_cp_z] = 19.4633;

    for(new i = 0; i < N_ZONES; i++)
    {
        GangZoneCreate(ZoneInfo[i][z_minx], ZoneInfo[i][z_miny], ZoneInfo[i][z_maxx], ZoneInfo[i][z_maxy]);
        if(i != 8 && i != 21)
        {
            ZoneInfo[i][z_cp] = CreateDynamicSphere(ZoneInfo[i][z_cp_x], ZoneInfo[i][z_cp_y], ZoneInfo[i][z_cp_z], 4);
            ZoneInfo[i][z_team] = -1;
            Streamer_SetIntData(STREAMER_TYPE_AREA, ZoneInfo[i][z_cp], E_STREAMER_EXTRA_ID, i + ZONE_AREA_EX_ID_OFFSET);
            ZoneInfo[i][z_textdraw] = TextDrawCreate(20, 300, "Test");
            TextDrawAlignment(ZoneInfo[i][z_textdraw], 1);
            TextDrawFont(ZoneInfo[i][z_textdraw], 1);

            Create3DTextLabel(ZoneInfo[i][z_name], PASTEL_TEAL_LIGHT, ZoneInfo[i][z_cp_x], ZoneInfo[i][z_cp_y], ZoneInfo[i][z_cp_z], 25.0 , 0, 1);
        }
        else ZoneInfo[i][z_cp] = -1;
        ZoneInfo[8][z_team] = 0;
        ZoneInfo[21][z_team] = 1;
        ZoneInfo[i][z_is_active] = false;
        ZoneInfo[i][z_progress] = 0;
        ZoneInfo[i][z_timer] = -1;

        gBonusZone = -1;
        gDangerZone = -1;
    }
}

hook OnPlayerConnect(playerid)
{
    for(new i = 0; i < N_ZONES; i++)
    {
        GangZoneShowForPlayer(playerid, i, (ZoneInfo[i][z_team] == -1)?(0xFFFFFF80):(ClassInfo[ZoneInfo[i][z_team]][class_color]));
    }
    return 1;
}

hook OnPlayerEnterDynamicArea(playerid, areaid)
{
    new zoneid = Streamer_GetIntData(STREAMER_TYPE_AREA, areaid, E_STREAMER_EXTRA_ID) - ZONE_AREA_EX_ID_OFFSET;
    if(zoneid >= N_ZONES || zoneid < 0) return 1;
    if(GetPlayerTeam(playerid) != ZoneInfo[zoneid][z_team] && ZoneInfo[zoneid][z_is_active] == false) StartZoneCapture(zoneid, playerid);
    return 0;
}

stock StartZoneCapture(zoneid, playerid)
{
    TextDrawSetString(ZoneInfo[zoneid][z_textdraw], "Capturing... 0/100");
    TextDrawShowForPlayer(playerid, ZoneInfo[zoneid][z_textdraw]);
    ZoneInfo[zoneid][z_is_active] = true;
    ZoneInfo[zoneid][z_attacker] = playerid;
    ZoneInfo[zoneid][z_timer] = SetTimerEx("ZoneCaptureProgress", 1000, true, "i", zoneid);
    GangZoneFlashForAll(zoneid, ClassInfo[GetPlayerTeam(playerid)][class_color]);
    ZoneStartCaptureMsg(playerid, zoneid);
}

forward ZoneCaptureProgress(zoneid);
public ZoneCaptureProgress(zoneid)
{
    new attacker_state = GetPlayerState(ZoneInfo[zoneid][z_attacker]);
    if(attacker_state != 7 && attacker_state != 9)
    {
        ZoneInfo[zoneid][z_progress] += 10;
        new string[20];
        format(string, sizeof(string), "Capturing... %d/100", ZoneInfo[zoneid][z_progress]);
        TextDrawSetString(ZoneInfo[zoneid][z_textdraw], string);
        TextDrawShowForPlayer(ZoneInfo[zoneid][z_attacker], ZoneInfo[zoneid][z_textdraw]);
    }
    if(ZoneInfo[zoneid][z_progress] >= 100) EndZoneCapture(zoneid, ZoneInfo[zoneid][z_attacker], true);
}

hook OnPlayerLeaveDynamicArea(playerid, areaid)
{
    new zoneid = Streamer_GetIntData(STREAMER_TYPE_AREA, areaid, E_STREAMER_EXTRA_ID) - ZONE_AREA_EX_ID_OFFSET;
    if(zoneid >= N_ZONES || zoneid < 0) return 1;
    if(ZoneInfo[zoneid][z_attacker] == playerid) EndZoneCapture(zoneid, playerid, false);
    return 0;
}

stock EndZoneCapture(zoneid, playerid, bool:success)
{
    KillTimer(ZoneInfo[zoneid][z_timer]);
    GangZoneStopFlashForAll(zoneid);
    if(success) {
        new delta_money = random(4500) + 3000;
		new delta_score = random(3) + 2;
		ORM_players[playerid][orm_players_money] += delta_money;
		ORM_players[playerid][orm_players_score] += delta_score;
        ORM_players[playerid][orm_players_zones_captured] ++;
        ZoneCapturedMsg(playerid, zoneid, delta_money, delta_score);
        GangZoneShowForAll(zoneid, ClassInfo[GetPlayerTeam(playerid)][class_color]);
        ZoneInfo[zoneid][z_team] = GetPlayerTeam(playerid);
        if(zoneid == gBonusZone)
        {
            ORM_players[playerid][orm_players_money] += gBonusZoneMoney;
            ORM_players[playerid][orm_players_score] += gBonusZoneScore;
            BonusZoneCapturedMsg(playerid);
            gBonusZone = -1;
        }

    }
    TextDrawHideForPlayer(playerid, ZoneInfo[zoneid][z_textdraw]);
    ZoneInfo[zoneid][z_is_active] = false;
    ZoneInfo[zoneid][z_progress] = 0;
    ZoneInfo[zoneid][z_attacker] = INVALID_PLAYER_ID;
}

stock ZoneStartCaptureMsg(playerid, zoneid)
{
    new string[37 - 8 + 18 + MAX_ZONE_NAME];
    new playername[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playername);
    new zonecolor[7];
    if(ZoneInfo[zoneid][z_team] == -1) strins(zonecolor, "FFFFFF", 0);
    else format(zonecolor, 7, "%x", ClassInfo[ZoneInfo[zoneid][z_team]][class_color]);
	new normalcolor[7];
	format(normalcolor, 7, "%x", PASTEL_PEACH_LIGHT);
    format(string, sizeof(string), "{%s}You started capturing {%s}%s{%s}!", normalcolor, zonecolor, ZoneInfo[zoneid][z_name], normalcolor);
    SendClientMessage(playerid, -1, string);
}

stock BonusZoneCapturedMsg(playerid)
{
    new accentcolor[7];
	format(accentcolor, 7, "%x", PASTEL_TURQUOISE_LIGHT);

	new normalcolor[7];
	format(normalcolor, 7, "%x", PASTEL_BROWN_LIGHT);

    new string[90 - 20 + 42 + MAX_ZONE_NAME + 5 + 2];
    format(string, sizeof(string), "{%s}You've got the bonus from {%s}%s{%s}, recieved {%s}%d${%s} cash and {%s}%d{%s} score!", normalcolor, accentcolor, ZoneInfo[gBonusZone], normalcolor, accentcolor, gBonusZoneMoney, normalcolor,accentcolor, gBonusZoneScore, normalcolor);
    SendClientMessage(playerid, -1, string);

    new playername[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playername, MAX_PLAYER_NAME);

    new playercolor[7];
	format(playercolor, 7, "%x", ClassInfo[GetPlayerTeam(playerid)][class_color]);

    new stringtoall[90 - 24 + 48 + MAX_PLAYER_NAME + MAX_ZONE_NAME + 5 + 2];
    format(stringtoall, sizeof(stringtoall), "{%s}%s{%s} got the bonus from {%s}%s{%s}, recieved {%s}%d${%s} cash and {%s}%d{%s} score!", playercolor, playername, normalcolor, accentcolor, ZoneInfo[gBonusZone], normalcolor, accentcolor, gBonusZoneMoney, normalcolor,accentcolor, gBonusZoneScore, normalcolor);
    SendClientMessageToAll(-1, stringtoall);
}

stock ZoneCapturedMsg(playerid, zoneid, money, score)
{
    new string[82 - 20 + 42 + MAX_ZONE_NAME + 4 + 1];
    new playername[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playername);
    new zonecolor[7];
    new zonecolortag = 'w';
    if(ZoneInfo[zoneid][z_team] == -1) strins(zonecolor, "FFFFFF", 0);
    else 
    {
        format(zonecolor, 7, "%x", ClassInfo[ZoneInfo[zoneid][z_team]][class_color]);
        zonecolortag = ClassInfo[ZoneInfo[zoneid][z_team]][class_color_tag];
    }
    new accentcolor[7];
	format(accentcolor, 7, "%x", PASTEL_TEAL_LIGHT);

	new normalcolor[7];
	format(normalcolor, 7, "%x", PASTEL_PEACH_LIGHT);

    format(string, sizeof(string), "{%s}You have captured {%s}%s{%s}, recieved {%s}%d${%s} cash and {%s}%d{%s} score!", normalcolor, zonecolor, ZoneInfo[zoneid][z_name], normalcolor, accentcolor, money, normalcolor, accentcolor, score, normalcolor);
    SendClientMessage(playerid, -1, string);
    new feedstring[34 - 8 + 2 + MAX_PLAYER_NAME + MAX_ZONE_NAME];
    format(feedstring, sizeof(feedstring), "~%c~%s~w~ has captured the ~%c~%s", ClassInfo[GetPlayerTeam(playerid)][class_color_tag], playername, zonecolortag, ZoneInfo[zoneid][z_name]);
    AddFeedMessage(feedstring);
}

hook MinuteUpdate()
{
    if(gMinutes % 2 == 0)
    {
        UpdateBonusZone();
    }
    else
    {
        UpdateDangerZone();
    }
}

stock UpdateBonusZone()
{
    new accentcolor[7];
	format(accentcolor, 7, "%x", PASTEL_TURQUOISE_LIGHT);

	new normalcolor[7];
	format(normalcolor, 7, "%x", PASTEL_BROWN_LIGHT);

    if(gBonusZone != -1)
    {
        new string[63 - 6 + 12 + MAX_ZONE_NAME];
        format(string, sizeof(string), "{%s}%s{%s} is not a bonus zone anymore. Setting a new bonus...", accentcolor, ZoneInfo[gBonusZone][z_name], normalcolor);
        SendClientMessageToAll(-1, string);
    }
    new bonuszone = -1;

    while(bonuszone == 8 || bonuszone == 21 || bonuszone == -1) {
        bonuszone = random(N_ZONES);
        print("gde blyad");
    }
    gBonusZone = bonuszone;

    ZoneInfo[bonuszone][z_team] = -1;
    GangZoneShowForAll(bonuszone, 0xFFFFFF80);

    new delta_money = random(60000) + 15000;
	new delta_score = random(40) + 15;

    gBonusZoneMoney = delta_money;
    gBonusZoneScore = delta_score;

    new string1[28 - 6 + 12 + MAX_ZONE_NAME];
    new string2[68 - 14 + 30 + 5 + 2];
    format(string1, sizeof(string1), "{%s}New bonus zone:{%s} %s", normalcolor, accentcolor, ZoneInfo[bonuszone][z_name]);
    format(string2, sizeof(string2), "{%s}Capture this zone to get {%s}%d${%s} cash and {%s}%d{%s} score!", normalcolor, accentcolor, delta_money, normalcolor, accentcolor, delta_score, normalcolor);
    SendClientMessageToAll(-1, string1);
    SendClientMessageToAll(-1, string2);
}

stock UpdateDangerZone()
{
    new accentcolor[7];
	format(accentcolor, 7, "%x", PASTEL_TURQUOISE_DARK);

	new normalcolor[7];
	format(normalcolor, 7, "%x", PASTEL_BROWN_LIGHT);

    new dangerzone = -1;

    while(dangerzone == 8 || dangerzone == 21 || dangerzone == -1) dangerzone = random(N_ZONES);
    gDangerZone = dangerzone;

    new string[63 - 8 + 18 + MAX_ZONE_NAME];
    format(string, sizeof(string), "{%s}New danger zone:{%s} %s{%s}. Beware of entering this zone!", normalcolor, accentcolor, ZoneInfo[dangerzone][z_name], normalcolor);
    SendClientMessageToAll(-1, string);
}

hook SecondUpdate()
{
    if(gDangerZone != -1)
    {
        if(gSeconds % 10 == 0)
        {
            new Float:rX = ZoneInfo[gDangerZone][z_minx] + (ZoneInfo[gDangerZone][z_maxx] - ZoneInfo[gDangerZone][z_minx]) / 5 * random(5);
            new Float:rY = ZoneInfo[gDangerZone][z_miny] + (ZoneInfo[gDangerZone][z_maxy] - ZoneInfo[gDangerZone][z_miny]) / 5 * random(5);

            new Float:rZ;

            CA_FindZ_For2DCoord(rX, rY, rZ);

            new obj = CreateDynamicObject(18693, rX, rY, rZ + 50, 0, 0, 0);
            MoveDynamicObject(obj, rX, rY, rZ, 25);
            SetTimerEx("DestroyDangerZoneObject", 2000, false, "ifff", obj, rX, rY, rZ);
        }
    }
}

forward DestroyDangerZoneObject(obj, Float:rX, Float:rY, Float:rZ);
public DestroyDangerZoneObject(obj, Float:rX, Float:rY, Float:rZ)
{
    CreateExplosion(rX, rY, rZ, 6, 15.0);
    DestroyDynamicObject(obj);
}