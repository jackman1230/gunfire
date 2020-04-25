btn01.onPress = function()
{
   var _loc4_ = _root.check_correct();
   if(_loc4_ == true)
   {
      _root.play_soundAction("手枪上子弹");
      this.enabled = false;
      _root.end_set_key();
      _parent.gotoAndPlay("set_key2");
   }
   else
   {
      light._visible = 1;
      light._y = this[_loc4_]._y;
   }
};
btn02.onPress = function()
{
   _root.play_soundAction("手枪上子弹");
   _root.reset_org_key();
};
