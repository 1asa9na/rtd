#include <YSI_Coding\y_hooks>

CMD:stats(playerid, params[])
{
    new accentcolor[7];
	format(accentcolor, 7, "%x", PASTEL_TEAL_LIGHT);

	new normalcolor[7];
	format(normalcolor, 7, "%x", PASTEL_PEACH_LIGHT);

    new string[512];
    format(
        string,
        sizeof(string),
        "\
        {%s}Name:{%s}  \t\t\t\t%s\n\
        {%s}Score:{%s} \t\t\t\t%d points\n\
        {%s}Money:{%s} \t\t\t\t%d$\n\
        {%s}Kills:{%s} \t\t\t\t%d kills\n\
        {%s}Deaths:{%s}\t\t\t\t%d deaths\n\
        {%s}KD ratio (%%):{%s}\t\t\t%.02f\n\
        {%s}Zones captured:{%s}\t\t%d zones\
        ",
        normalcolor, accentcolor, ORM_players[playerid][orm_players_name],
        normalcolor, accentcolor, ORM_players[playerid][orm_players_score],
        normalcolor, accentcolor, ORM_players[playerid][orm_players_money],
        normalcolor, accentcolor, ORM_players[playerid][orm_players_kills],
        normalcolor, accentcolor, ORM_players[playerid][orm_players_deaths],
        normalcolor, accentcolor, floatdiv(ORM_players[playerid][orm_players_kills], ((ORM_players[playerid][orm_players_deaths]==0)?(1):(ORM_players[playerid][orm_players_deaths]))),
        normalcolor, accentcolor, ORM_players[playerid][orm_players_zones_captured]
    );
    ShowPlayerDialog(playerid, DLG_STATS, DIALOG_STYLE_MSGBOX, "Your Stats", string, "Close", "");
}

CMD:chelp(playerid, params[])
{
    new string[(MAX_PERK_NAME + 1) * N_PERKS - 1];
	strins(string, PerkInfo[0][perk_title], 0);
    for(new i = 1; i < N_PERKS; i++) {
		strcat(string, "\n");
		strcat(string, PerkInfo[i][perk_title]);
	}
	ShowPlayerDialog(playerid, DLG_PERKLIST, DIALOG_STYLE_LIST, "Perk List", string, "Select", "Close");
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch(dialogid)
    {
        case DLG_PERKLIST:
        {
            if(response)
            {
                new accentcolor[7];
                format(accentcolor, 7, "%x", PASTEL_TEAL_LIGHT);

                new normalcolor[7];
                format(normalcolor, 7, "%x", PASTEL_PEACH_LIGHT);

                new string[512];
                format(
                    string,
                    sizeof(string),
                    "\
                    {%s}Perk name:{%s}\t\t\t\t%s\n\
                    {%s}Health:{%s}   \t\t\t\t%d\n\
                    {%s}Armour:{%s}   \t\t\t\t%d\n\n\
                    ",
                    normalcolor, accentcolor, PerkInfo[listitem][perk_title],
                    normalcolor, accentcolor, PerkInfo[listitem][perk_health],
                    normalcolor, accentcolor, PerkInfo[listitem][perk_armour]
                );

                for(new i = 0; i < MAX_PERK_WEAPONS; i++)
                {
                    new source[56 - 10 + 12 + 32 + 1 + 5];
                    new weapon[32];
                    GetWeaponName(PerkInfo[listitem][perk_weapons][i], weapon, 32);
                    format(source, sizeof(source), "{%s}Weapon %d:{%s}  \t\t\t\t%s\n\t\t\t\t\t%d ammo\n\n", normalcolor, i + 1, accentcolor, weapon, PerkInfo[listitem][perk_weapon_ammo][i]);
                    strcat(string, source);
                }
                ShowPlayerDialog(playerid, DLG_PERKINFO, DIALOG_STYLE_MSGBOX, PerkInfo[listitem][perk_title], string, "Close", "");
            }
        }
    }
}