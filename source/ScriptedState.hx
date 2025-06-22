package;

#if HSCRIPT_ALLOWED
import mikolka.vslice.components.crash.UserErrorSubstate;
import psychlua.HScript;
import crowplexus.iris.Iris;
import crowplexus.hscript.Expr.Error as IrisError;
import crowplexus.hscript.Printer;
#end

class ScriptedState extends backend.MusicBeatState {
    #if HSCRIPT_ALLOWED
	var hscript:HScript;
	var gotError:Bool;
	#end

    public function new(){super();}

    override function create(){
         hscript = new HScript(null, returnScriptPath());
        if(hscript.exists('create')){
			hscript.call('create');
			super.create();
		}
    }

    override function update(elapsed:Float){
        if(hscript.exists('update')){
			hscript.call('update');
			super.update(elapsed);
		}
    }

    override function destroy(){
        if(hscript.exists('destroy')){
			hscript.call('destroy');
			super.destroy();
		}
    }

    override function stepHit(){
        if(hscript.exists('stepHit')){
			hscript.call('stepHit');
			super.stepHit();
		}
    }

    override function beatHit(){
        if(hscript.exists('beatHit')){
			hscript.call('beatHit');
			super.beatHit();
		}
    }

    public function returnScriptPath() return backend.Paths.getPath("states/ScriptedState.hx");
}