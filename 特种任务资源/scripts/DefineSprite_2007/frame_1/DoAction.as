btn01.enabled = false;
btn02.onPress = function()
{
   _root.play_soundAction("手枪上子弹");
   _parent.gotoAndPlay("level");
};
