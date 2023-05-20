string StuntText() {
    // get the current playground (black magic)
    auto playground = cast<CGamePlayground>(cast<CGameCtnApp>(GetApp()).CurrentPlayground);
    auto ScriptAPI = cast<CTrackManiaPlayer>(playground.Players[0]).ScriptAPI;
    // tostring because ScriptAPI.StuntLast is an int of enum ESceneVehiclePhyStuntFigure
    currentStunt = tostring(ScriptAPI.StuntLast);
    int stuntAngle = ScriptAPI.StuntAngle;
    int stuntCombo = ScriptAPI.StuntCombo;
    bool isMaster = ScriptAPI.StuntMasterJump;
    
    // do the exclamation marks (1 per 180 degrees) (important)
    string tmp = " ";
    for (int i = 0; i <= (stuntAngle / 180 - 1); i++) 
    {
        tmp = tmp + "!";        
    }
    string exclamationMarks = (stuntAngle >= 720 ? " !!!!" : tmp);
    
    // this is actually just 1 line over several lines
    return (currentStunt == "None" ? "" : 
    (stuntCombo > 0 ? ((stuntCombo + 1) + "X Chained ") : "") 
    + (tostring(isMaster) == "true" ? "Master " : "")
    + getStuntName(ScriptAPI.StuntLast) 
    + " " 
    + (tostring(stuntAngle) == "0" ? "" : tostring(stuntAngle)) 
    + exclamationMarks);
}

string stuntIncreaseDecrease(int prev, int now) 
{
    if (prev == now) {
        return "";
    } else if (prev < now) {
        return "+" + (now - prev);
    }
    return "UHHHHHHHHHHHHHHH";
}


string getStuntName(int Stunt) 
{
    string[] stunts;
    stunts.InsertLast("None");
    stunts.InsertLast("Straight Jump");
    stunts.InsertLast("Flip");
    stunts.InsertLast("Backflip");
    stunts.InsertLast("Spin");
    stunts.InsertLast("Aerial");
    stunts.InsertLast("Alley Oop");
    stunts.InsertLast("Roll");
    stunts.InsertLast("Corkscrew");
    stunts.InsertLast("Spin-off");
    stunts.InsertLast("Rodeo");
    stunts.InsertLast("Flip-flap");
    stunts.InsertLast("Twister");
    stunts.InsertLast("Freestyle");
    stunts.InsertLast("Spinning Mix");
    stunts.InsertLast("Flipping Chaos");
    stunts.InsertLast("Rolling Madness");
    stunts.InsertLast("Wreck");
    stunts.InsertLast("Wrecking Straight Jump");
    stunts.InsertLast("Wrecking Flip");
    stunts.InsertLast("Wrecking Backflip");
    stunts.InsertLast("Wrecking Spin");
    stunts.InsertLast("Wrecking Aerial");
    stunts.InsertLast("Wrecking Alley Oop");
    stunts.InsertLast("Wrecking Roll");
    stunts.InsertLast("Wrecking Corkscrew");
    stunts.InsertLast("Wrecking Spinoff");
    stunts.InsertLast("Wrecking Rodeo");
    stunts.InsertLast("Wrecking Flip-flap");
    stunts.InsertLast("Wrecking Twister");
    stunts.InsertLast("Wrecking Freestyle");
    stunts.InsertLast("Wrecking Spinning Mix");
    stunts.InsertLast("Wrecking Flipping Chaos");
    
    if (Math::Rand(0, 999) == 0) {
        stunts.InsertLast("Rick Rolling Madness");
    } else {
        stunts.InsertLast("Wrecking Roll Madness");
    }
    stunts.InsertLast("Time Penalty");
    stunts.InsertLast("Respawn Penalty");
    stunts.InsertLast("Grind");
    stunts.InsertLast("Reset");

    return stunts[Stunt];
}
