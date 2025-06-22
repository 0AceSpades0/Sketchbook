package;
import flixel.FlxState;

class Init extends flixel.FlxState 
{
    override public function create():Void
    {
        FlxG.mouse.useSystemCursor = true;
        super.create();
        if (FlxG.save.data.leftFlashing)
            FlxG.switchState(new states.TitleState());
        else
            FlxG.switchState(new states.FlashingState());
    }
}