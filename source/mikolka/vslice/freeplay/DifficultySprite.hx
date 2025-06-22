package mikolka.vslice.freeplay;

import flixel.graphics.FlxGraphic;
import mikolka.compatibility.funkin.FunkinPath as Paths;

/**
 * The sprite for the difficulty
 */
 class DifficultySprite extends FlxSprite
 {
     /**
      * The difficulty id which this sprite represents.
      */
     public var difficultyId:String;
     public var hasValidTexture = true;
     public var difficultyColor:FlxColor;
 
     public function new(diffId:String)
     {
         super();
 
         difficultyId = diffId;
         var tex:FlxGraphic = null;

         if(tex == null){
             tex = Paths.noGpuImage('menudifficulties/' + diffId);
         }
         if (sys.FileSystem.exists(backend.Paths.getPath('images/freeplay/freeplayDifficulties/freeplay' + diffId + ".xml"))){
            frames = Paths.getSparrowAtlas('freeplay/freeplayDifficulties/freeplay' + diffId);
            animation.addByPrefix("idle", "idle", 24, true);
			animation.play("idle");
         }else{
            tex = Paths.noGpuImage('freeplay/freeplayDifficulties/freeplay' + diffId);
            hasValidTexture = (tex != null);
            if(hasValidTexture) this.loadGraphic(tex);
         }
         try{
             difficultyColor = hasValidTexture ? CoolUtil.dominantColor(this) : FlxColor.GRAY;
         }
         catch(x){
             trace('Failed to get prime color for $diffId: ${x.message}');
             difficultyColor = FlxColor.GRAY;
         }
         x = -((width/2)-106);
     }
 }