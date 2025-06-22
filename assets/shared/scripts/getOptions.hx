function onCreate()
{
    if (ClientPrefs.data.squish && !PlayState.isPixelStage)
        loadLua("options/goofy_note_press.lua");
    if (ClientPrefs.data.keyStrokes)
        loadLua("options/Keystrokes.lua");
}