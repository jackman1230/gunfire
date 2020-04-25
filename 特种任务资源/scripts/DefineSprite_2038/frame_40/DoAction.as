btn01.onPress = function()
{
   _root.play_soundAction("手枪上子弹");
};
btn02.onPress = function()
{
   _root.play_soundAction("手枪上子弹");
   gotoAndStop("help");
   play();
};
btn03.onPress = function()
{
   _root.play_soundAction("手枪上子弹");
   gotoAndStop("set_key1");
   play();
};
btn01.enabled = false;
