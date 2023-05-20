string currentStunt;
string currentText;
string previousText = "";
int stuntAngle = 0;
int stuntCombo = 0;
int stuntPoints = 0;
int stuntPointsIncrease = 0;
int stuntPointsNow = 0;
int stuntPointsPrev = 0;
int previousTime = 0;
bool isNewStunt = false;
bool instantStunt = false;
bool isMaster;
bool isEnabled;

void Main() {  }

void UpdateStuntVars() 
{
    auto playground = cast<CGamePlayground>(cast<CGameCtnApp>(GetApp()).CurrentPlayground);
    auto ScriptAPI = cast<CTrackManiaPlayer>(playground.Players[0]).ScriptAPI;
    // tostring because ScriptAPI.StuntLast is an int of enum ESceneVehiclePhyStuntFigure
    currentStunt = tostring(ScriptAPI.StuntLast);
    stuntAngle = ScriptAPI.StuntAngle;
    stuntCombo = ScriptAPI.StuntCombo;
    stuntPointsIncrease = ScriptAPI.StuntPoints;
    isMaster = ScriptAPI.StuntMasterJump;
}


float now()
{
    // i did this because im tired af
    return Math::Round(Time::get_Now() / 1000);
}


void Render()
{
    try 
    {
        if (!isEnabled) return;
        UpdateStuntVars();
        stuntPointsNow = stuntPoints;

        auto app = cast<CGameCtnApp>(GetApp());
        auto decorationName = app.RootMap.DecorationName;
        vec4 fillColor = (decorationName != "Night48" ? s_dayColor : s_nightColor);
        currentText = StuntText();
        if (previousText != currentText) 
        {
            isNewStunt = true;
            instantStunt = true;
            previousTime = now();
        }
        if (instantStunt) 
        { 
            stuntPoints += stuntPointsIncrease;
            instantStunt = false;
        }
        if (stuntPointsIncrease == 0)
        {
            stuntPoints = 0;
            stuntPointsPrev = 0; 
            stuntPointsNow = 0;
            isNewStunt = false;
        }
        else if (previousTime == (now() - 5))
        {
            isNewStunt = false;
        }
        nvg::BeginPath();
        nvg::FontSize(Draw::GetWidth() / 45);
        nvg::FillColor(fillColor);
        auto bounds = nvg::TextBounds(currentText);
        // ty auris and chips for the .contains
        bool shouldStraightJump = s_stuntPoints or !currentStunt.Contains("StraightJump");
        if (shouldStraightJump and isNewStunt) 
        {
            nvg::Text((Draw::GetWidth() / 2) - (bounds.x / 2), Draw::GetHeight() / 5, currentText);
            if (s_stuntPoints) 
            {
                bounds = nvg::TextBounds("+" + tostring(stuntPointsIncrease));
                nvg::Text((Draw::GetWidth() / 2) - (bounds.x / 2), Draw::GetHeight() / 4, "+" + tostring(stuntPointsIncrease));
            }
        }
        if (s_stuntPoints) 
        {
            bounds = nvg::TextBounds(tostring(stuntPoints));
            nvg::Text(((Draw::GetWidth()) - bounds.x) - (Draw::GetWidth() / 20), Draw::GetHeight() / 3, tostring(stuntPoints) + " Pts.");
        }
        nvg::ClosePath();
        if (stuntPointsNow > stuntPointsPrev) 
        {
            stuntPointsPrev = stuntPointsNow;
        }
        previousText = currentText;
    } catch { }
}


void RenderMenu()
{
    if (UI::MenuItem("\\$ff3" + Icons::Plus + "\\$z StuntMaster", "", isEnabled)) 
    {
        isEnabled = !isEnabled;
    }
}
