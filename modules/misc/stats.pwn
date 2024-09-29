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
        {%s}Score:{%s} \t\t\t\t%d\n\
        {%s}Money:{%s} \t\t\t\t%d$\n\
        {%s}Kills:{%s} \t\t\t\t%d\n\
        {%s}Deaths:{%s}\t\t\t\t%d\n\
        {%s}KD ratio (%%):{%s}\t\t\t%.02f\n\
        {%s}Zones captured:{%s}\t\t%d\
        ",
        normalcolor, accentcolor, ORM_players[playerid][orm_players_name],
        normalcolor, accentcolor, ORM_players[playerid][orm_players_score],
        normalcolor, accentcolor, ORM_players[playerid][orm_players_money],
        normalcolor, accentcolor, ORM_players[playerid][orm_players_kills],
        normalcolor, accentcolor, ORM_players[playerid][orm_players_deaths],
        normalcolor, accentcolor, ORM_players[playerid][orm_players_kills] / ((ORM_players[playerid][orm_players_deaths]==0)?(1):(ORM_players[playerid][orm_players_deaths])),
        normalcolor, accentcolor, ORM_players[playerid][orm_players_zones_captured]
    );
    ShowPlayerDialog(playerid, DLG_STATS, DIALOG_STYLE_MSGBOX, "Your Stats", string, "Close", "");
}