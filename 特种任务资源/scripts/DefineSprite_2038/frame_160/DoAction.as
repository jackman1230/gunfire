btn04.onPress = function()
{
   _root.play_soundAction("手枪上子弹");
   _root.game_level = 0.5;
   _parent.gotoAndStop("select");
};
btn05.onPress = function()
{
   _root.play_soundAction("手枪上子弹");
   _root.game_level = 1;
   _parent.gotoAndStop("select");
};
btn06.onPress = function()
{
   _root.play_soundAction("手枪上子弹");
   _root.game_level = 2;
   _parent.gotoAndStop("select");
};
stop();
