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
    SetTimer("UpdateFeed", 1000, true);
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
}


forward UpdateFeed();
public UpdateFeed()
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