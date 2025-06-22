package options.typedefs;

import options.Option;

typedef OptionJson = {
    var type:OptionType;
    var name:String;
    var desc:String;
    var variable:String;
    @:optional var options:Array<String>;
}