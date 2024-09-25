#include <YSI_Coding\y_hooks>

#define MySQL_USER      "root"
#define MySQL_PASS      "3216"
#define MySQL_BASE      "rtd"
#define MySQL_HOST      "localhost"

#define CloseDialog(%0) ShowPlayerDialog(%0, -1, DIALOG_STYLE_MSGBOX, "", "", "", "");

new MySQL:dbHandle;

enum E_ORM_players {
    ORM:ORM_ID,
    orm_players_ID,
    orm_players_name[MAX_PLAYER_NAME + 1],
    orm_players_email[65],
    orm_players_password[65],
    orm_players_salt[11],
    orm_players_reg_ip[16],
    orm_players_kills,
    orm_players_money,
    orm_players_deaths,
    orm_players_score
};

new ORM_players[MAX_PLAYERS][E_ORM_players];

stock ConnectMySQL()
{
        dbHandle = mysql_connect(MySQL_HOST, MySQL_USER, MySQL_PASS, MySQL_BASE);
        switch(mysql_errno(dbHandle))
        {
                case 0: printf("Database (%s) successfully connected!", MySQL_BASE);
                default: printf("Could not road database (%s) error: %d", MySQL_BASE, mysql_errno(dbHandle));
        }
        return 1;
}

hook OnGameModeInit()
{
    ConnectMySQL();
}

forward OnPlayerDataLoaded(playerid);

hook OnPlayerConnect(playerid)
{
    GetPlayerName(playerid, ORM_players[playerid][orm_players_name], MAX_PLAYER_NAME);
    ORM_players[playerid][ORM_ID] = orm_create("players");

    orm_addvar_int(ORM_players[playerid][ORM_ID], ORM_players[playerid][orm_players_ID], "id");
    orm_addvar_string(ORM_players[playerid][ORM_ID], ORM_players[playerid][orm_players_name], MAX_PLAYER_NAME, "name");
    orm_addvar_string(ORM_players[playerid][ORM_ID], ORM_players[playerid][orm_players_email], 64, "email");
    orm_addvar_string(ORM_players[playerid][ORM_ID], ORM_players[playerid][orm_players_password], 64, "password");
    orm_addvar_string(ORM_players[playerid][ORM_ID], ORM_players[playerid][orm_players_salt], 11, "salt");
    orm_addvar_string(ORM_players[playerid][ORM_ID], ORM_players[playerid][orm_players_reg_ip], 16, "reg_ip");
    orm_addvar_int(ORM_players[playerid][ORM_ID], ORM_players[playerid][orm_players_kills], "kills");
    orm_addvar_int(ORM_players[playerid][ORM_ID], ORM_players[playerid][orm_players_deaths], "deaths");
    orm_addvar_int(ORM_players[playerid][ORM_ID], ORM_players[playerid][orm_players_score], "score");
    orm_addvar_int(ORM_players[playerid][ORM_ID], ORM_players[playerid][orm_players_money], "money");

    orm_setkey(ORM_players[playerid][ORM_ID], "name");
    orm_select(ORM_players[playerid][ORM_ID], "OnPlayerDataLoaded", "d", playerid);

    SetPVarInt(playerid, "WrongPassword", 3);
}

hook OnPlayerDisconnect(playerid, reason) 
{
    if(ORM_players[playerid][orm_players_ID] != 0) {
        orm_update(ORM_players[playerid][ORM_ID]);   
    }
    orm_destroy(ORM_players[playerid][ORM_ID]);

    for(new E_ORM_players:e; e < E_ORM_players; e++)
        ORM_players[playerid][e] = 0;
    return 1;
}

public OnPlayerDataLoaded(playerid)
{
    switch(orm_errno(ORM_players[playerid][ORM_ID])) 
    {
        case ERROR_OK: ShowLogin(playerid);
        case ERROR_NO_DATA: ShowRegistration(playerid);
    }
    orm_setkey(ORM_players[playerid][ORM_ID], "id");
    return 1;
}

stock ShowLogin(playerid)
{
	new dialog[200 - 2 + MAX_PLAYER_NAME];
	format(dialog, sizeof(dialog),
	"{FFFFFF} Welcome back {dba212} %s, {FFFFFF} happy to see you again!\n\
	{dba212} RTDM {FFFFFF}is on a run, and we need your help!\n\n\
	To continue enter your password in line below:",
	ORM_players[playerid][orm_players_name]);

    ShowPlayerDialog(playerid, DLG_LOG, DIALOG_STYLE_INPUT, "{dba212}Authorization{FFFFFF}", dialog, "Enter", "Exit");
}

stock ShowRegistration(playerid)
{
	new dialog[251 - 2 + MAX_PLAYER_NAME];
	format(
        dialog,
        sizeof(dialog),
        "{ff8800}%s {FFFFFF}Welcome to the {dba212}RTDM!\n\
        {FFFFFF}This account is {FF0000}not registered!\n\n\
        {FFFFFF}•The password {FFFFFF}must contain 6 - 32 characters\n\
        •{FFFFFF}Make sure that your {dba212}password is strong",
        ORM_players[playerid][orm_players_name]
	);
	PlayerPlaySound(playerid, 45400, 0.0, 0.0, 0.0);
	ShowPlayerDialog(playerid, DLG_REG, DIALOG_STYLE_INPUT, "{dba212}Registration • {FFFFFF}Create a new password", dialog, "Continue", "Exit");
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch (dialogid)
	{
	    case DLG_REG:
		{
		    if(response)
			{
		    	if(!strlen (inputtext))
 			  	{
				    ShowRegistration(playerid);
				    return SendClientMessage(playerid, 0xFF0000FF, "[WARNING] {FFFFFF}Create new password and press \"Continue\"");
				}
			    if (strlen(inputtext) < 6 || strlen(inputtext) > 32)
				{
                    ShowRegistration (playerid); 
                    return SendClientMessage(playerid, 0xFF0000FF, "[WARNING]{FFFFFF}Password may contains 6 - 32 characters");
 				}
				new Regex:rg_passwordcheck = Regex_New("^[a-zA-z0-9]{1,}$");
				if (Regex_Check(inputtext, rg_passwordcheck))
				{
				    new salt[11];
				    for(new i; i < 11; i++)
					{
					    salt[i] = random (43) + 48;
					}
					salt[10] = 0;
					SHA256_PassHash(inputtext, salt, ORM_players[playerid][orm_players_password], 65);
					strmid(ORM_players[playerid][orm_players_salt], salt, 0, 11, 11);
					printf("%s", ORM_players[playerid][orm_players_salt]);
					PlayerPlaySound(playerid, 45400, 0.0, 0.0, 0.0);
				    ShowPlayerDialog(
                        playerid,
                        DLG_REGEMAIL,
                        DIALOG_STYLE_INPUT,
                        "{dba212}Registration {473dff}• E-mail",
				        "			         {FFFFFF}Enter your {473dff}e-mail {FFFFFF}address\n\
				        {FFFFFF}If you lose {dba212}password {FFFFFF}or {dba212}name {FFFFFF}of your account there will be opportunity to bring it back",
				        "Continue",
                        ""
                    );	
				}
				else
				{
		  			ShowRegistration(playerid);
		  			Regex_Delete(rg_passwordcheck);
		    		return SendClientMessage(playerid, 0xFF0000FF, "[WARNING]{FFFFFF}Password may contains 6 - 32 characters");
				}
	            Regex_Delete(rg_passwordcheck);
			}
			else
			{
				SendClientMessage(playerid, 0xFF0000FF, "Use \"/q\", to leave the server");
                //CloseDialog(playerid);
				return Kick(playerid);
			}
		}
		case DLG_REGEMAIL:
		{
		    if(!strlen(inputtext))
			{
			    PlayerPlaySound(playerid, 45400, 0.0, 0.0, 0.0);
				ShowPlayerDialog(
                    playerid,
                    DLG_REGEMAIL,
                    DIALOG_STYLE_INPUT,
                    "{dba212}Registration {473dff}• E-mail",
				    "			         {FFFFFF}Enter your {473dff}e-mail {FFFFFF}address\n\
				    {FFFFFF}If you lose {dba212}password {FFFFFF}or {dba212}name {FFFFFF}of your account there will be opportunity to bring it back",
				    "Continue",
                    ""
                );
				return SendClientMessage(playerid, 0xFF0000FF, "[WARNING]{FFFFFF}Check your {473dff}e-mail {FFFFFF}address before using it");
			}
			new Regex:rg_emailcheck = Regex_New("^[a-zA-Z0-9.-_]{1,43}@[a-zA-Z]{1,12}.[a-zA-Z]{1,8}$");
			if(Regex_Check(inputtext, rg_emailcheck))
			{
                strmid(ORM_players[playerid][orm_players_email], inputtext, 0, strlen(inputtext), 64);
            }
			else
			{
				PlayerPlaySound(playerid, 45400, 0.0, 0.0, 0.0);
			    ShowPlayerDialog(
                    playerid,
                    DLG_REGEMAIL,
                    DIALOG_STYLE_INPUT,
                    "{dba212}Registration {473dff}• E-mail",
				    "			         {FFFFFF}Enter your {473dff}e-mail {FFFFFF}address\n\
				    {FFFFFF}If you lose {dba212}password {FFFFFF}or {dba212}name {FFFFFF}of your account there will be opportunity to bring it back",
				    "Continue",
                    ""
                );
				Regex_Delete(rg_emailcheck);
				return SendClientMessage(playerid, 0xFF0000FF, "[WARNING]{FFFFFF}Check your {473dff}e-mail {FFFFFF}address before using it");
			}
			Regex_Delete(rg_emailcheck);
  	        GetPlayerIp(playerid, ORM_players[playerid][orm_players_reg_ip], 16);
  	        orm_insert(ORM_players[playerid][ORM_ID], "OnPlayerRegistered", "d", playerid);
            orm_select(ORM_players[playerid][ORM_ID], "PlayerLogin", "d", playerid);
		}
        case DLG_LOG:
        {
            if(response)
            {
                new checkpass[65];
	            SHA256_PassHash(inputtext, ORM_players[playerid][orm_players_salt], checkpass, 65);
	            if(strcmp(ORM_players[playerid][orm_players_password], checkpass, false, 63) == 0 && !isnull(checkpass))
	            {
                    orm_select(ORM_players[playerid][ORM_ID], "PlayerLogin", "d", playerid);
	            }
	            else
	            {
                    new string[100];
                    SetPVarInt(playerid, "WrongPassword", GetPVarInt(playerid, "WrongPassword")-1);
                    if(GetPVarInt(playerid, "WrongPassword") > 0)
                    {
                        PlayerPlaySound(playerid, 21001, 0.0, 0.0, 0.0);
                        format (string, sizeof(string), "[WARNING] {FFFFFF}You used a wrong password. You have %d more tries to get into your account", GetPVarInt(playerid, "WrongPassword"));
                        SendClientMessage(playerid, 0xFF000000, string);
                    }
                    if(GetPVarInt(playerid, "WrongPassword") == 0)
                    {
                        SendClientMessage(playerid, 0xFF0000FF, "[ERROR]{FFFFFF}You entered wrong password too many times");
                        //CloseDialog(playerid);
                        Kick(playerid);
                    }
                    ShowLogin(playerid);
                }
            }
            else
            {
			    SendClientMessage(playerid, 0xFF0000FF, "Use \"/q\", to leave the server");
			    //CloseDialog(playerid);
                return Kick(playerid);
            }
		}
	}
    return 0;
}

forward OnPlayerRegistered(playerid);
public OnPlayerRegistered(playerid)
{
    new Float:pX, Float:pY, Float:pZ;
    GetPlayerPos(playerid, pX, pY, pZ);
    PlayerPlaySound(playerid, 1062, Float:pX, Float:pY, Float:pZ);
    PlayerLogin(playerid);
}