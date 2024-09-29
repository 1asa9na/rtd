#include <YSI_Coding\y_hooks>

#define MAX_FEED_MSG            65
#define N_FEED_MSG              5
#define FEED_MSG_TIMER          30

enum E_FeedMsgs
{
    feed_msg[MAX_FEED_MSG],
    feed_msg_elapsed,
    bool:feed_msg_visible,
    Text:feed_msg_textdraw
};

new FeedMsgs[N_FEED_MSG][E_FeedMsgs];

new gSeconds;
new gMinutes;
new Text:gSecondTimer;

new Text:TeamTextDraws[N_CLASSES];

stock AddFeedMessage(const string[])
{
    for(new i = 0; i < N_FEED_MSG - 1; i++)
    {
        strcpy(FeedMsgs[i][feed_msg], FeedMsgs[i + 1][feed_msg]);
        FeedMsgs[i][feed_msg_elapsed] = FeedMsgs[i + 1][feed_msg_elapsed];
        FeedMsgs[i][feed_msg_visible] = FeedMsgs[i + 1][feed_msg_visible];
    }
    strcpy(FeedMsgs[N_FEED_MSG - 1][feed_msg], string);
    FeedMsgs[N_FEED_MSG - 1][feed_msg_elapsed] = FEED_MSG_TIMER;
    FeedMsgs[N_FEED_MSG - 1][feed_msg_visible] = true;
    UpdateFeedText();
}

hook OnGameModeInit()
{
    gSeconds = 0;
    gSecondTimer = TextDrawCreate(600, 240, "00:00");
    TextDrawAlignment(gSecondTimer, 2);
    TextDrawFont(gSecondTimer, 1);
    TextDrawLetterSize(gSecondTimer, 0.3, 1);
    TextDrawSetShadow(gSecondTimer, 0);
    TextDrawSetOutline(gSecondTimer, 1);
    for(new i = 0; i < N_CLASSES; i++)
    {
        TeamTextDraws[i] = TextDrawCreate(570 + (i % 2) * 60, 250 + floatround(i / 2, floatround_tozero) * 10, "~r~test~n~0");
        TextDrawAlignment(TeamTextDraws[i], (i % 2)?(3):(1));
        TextDrawFont(TeamTextDraws[i], 1);
        TextDrawLetterSize(TeamTextDraws[i], 0.2, 0.7);
        TextDrawSetShadow(TeamTextDraws[i], 0);
        TextDrawSetOutline(TeamTextDraws[i], 1);
    }
	SetTimer("SecondUpdate", 1000, true);
    SetTimer("MinuteUpdate", 60000, true);
    for(new i = 0; i < N_FEED_MSG; i++)
    {
        FeedMsgs[i][feed_msg_textdraw] = TextDrawCreate(320, 410 - i * 12, " ");
        TextDrawAlignment(FeedMsgs[i][feed_msg_textdraw], 2);
        TextDrawFont(FeedMsgs[i][feed_msg_textdraw], 1);
        TextDrawSetShadow(FeedMsgs[i][feed_msg_textdraw], 0);
        TextDrawSetOutline(FeedMsgs[i][feed_msg_textdraw], 1);
        TextDrawLetterSize(FeedMsgs[i][feed_msg_textdraw], 0.3, 1);
    }
}

hook OnPlayerConnect(playerid)
{
    UpdateFeedText();
    for(new i = 0; i < N_CLASSES; i++) TextDrawShowForPlayer(playerid, TeamTextDraws[i]);
    TextDrawShowForPlayer(playerid, gSecondTimer);
}

forward MinuteUpdate();
public MinuteUpdate()
{
    gMinutes++;
}

forward SecondUpdate();
public SecondUpdate()
{
	UpdateFeed();
    new string[6];
    format(string, sizeof(string), "%02d:%02d", floatround(gSeconds / 60, floatround_tozero), gSeconds % 60);
    TextDrawSetString(gSecondTimer, string);
    TextDrawShowForAll(gSecondTimer);

    for(new i = 0; i < N_ZONES; i++) if(ZoneInfo[i][z_team] != -1 && i != 8 && i != 21) ClassInfo[ZoneInfo[i][z_team]][team_score] ++;

    for(new i = 0; i < N_CLASSES; i++)
    {
        new teamstring[10 + MAX_CLASS_NAME];
        format(teamstring, sizeof(teamstring), "~%c~%s~n~%d", ClassInfo[i][class_color_tag], ClassInfo[i][title], ClassInfo[i][team_score]);
        TextDrawSetString(TeamTextDraws[i], teamstring);
        TextDrawShowForAll(TeamTextDraws[i]);
    }

	gSeconds++;

    if(gSeconds == 600) {
        gSeconds = 0;
        new maxscore = 0;
        new winteam = -1;
        for(new i = 0; i < N_CLASSES; i++) {
            if(maxscore < ClassInfo[i][team_score])
            {
                maxscore = ClassInfo[i][team_score];
                winteam = i;
            }
            else if(maxscore == ClassInfo[i][team_score]) winteam = -1;

            ClassInfo[i][team_score] = 0;
        }
        if(winteam != -1)
        {
            TeamWonMsg(winteam);
            new money = 15000;
            new score = 20;
            TeamMateWonMsg(winteam, money, score);
        }
        for(new i = 0; i < N_ZONES; i++) if(ZoneInfo[i][z_team] != -1 && i != 8 && i != 21)
        {
            ZoneInfo[i][z_team] = -1;
            GangZoneShowForAll(i, 0xFFFFFF80);
        }
    }
}

stock TeamWonMsg(teamid)
{
    new string[31 - 4 + 1 + MAX_CLASS_NAME];
    format(string, sizeof(string), "~%c~%s~w~ team won this period", ClassInfo[teamid][class_color_tag], ClassInfo[teamid][title]);
    AddFeedMessage(string);
}

stock TeamMateWonMsg(teamid, money, score)
{
    new accentcolor[7];
	format(accentcolor, 7, "%x", PASTEL_TEAL_LIGHT);

	new normalcolor[7];
	format(normalcolor, 7, "%x", PASTEL_PEACH_LIGHT);

    new string[79 - 14 + 30 + 5 + 2];
    format(string, sizeof(string), "{%s}Your team won this period, recieved {%s}%d${%s} cash and {%s}%d{%s} score!", normalcolor, accentcolor, money, normalcolor, accentcolor, score, normalcolor);

    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        if(IsPlayerConnected(i) && GetPlayerTeam(i) == teamid)
        {
            SendClientMessage(i, -1, string);
            ORM_players[i][orm_players_money] += money;
            ORM_players[i][orm_players_score] += score;
        }
    }
}

stock UpdateFeed()
{
    for(new i = 0; i < N_FEED_MSG; i++)
    {
        if(FeedMsgs[i][feed_msg_visible] && FeedMsgs[i][feed_msg_elapsed] <= 0) RemoveFeedMessage(i);
        else FeedMsgs[i][feed_msg_elapsed]--;
    }
}

stock RemoveFeedMessage(index)
{
    FeedMsgs[index][feed_msg] = 0;
    strcpy(FeedMsgs[index][feed_msg], "\0");
    FeedMsgs[index][feed_msg_visible] = false;
    UpdateFeedText();
}

stock UpdateFeedText()
{
    for(new i = 0; i < N_FEED_MSG; i ++)
    {
        TextDrawSetString(FeedMsgs[i][feed_msg_textdraw], FeedMsgs[i][feed_msg]);
        for(new j = 0; j < MAX_PLAYERS; j++) TextDrawShowForPlayer(j, FeedMsgs[i][feed_msg_textdraw]);
    }
}

CMD:addfeed(playerid, params[])
{
    new string[MAX_FEED_MSG];
    if(sscanf(params, "s[65]", string))
    {
        strins(string, "Test", 0);
    }
    AddFeedMessage(string);
}