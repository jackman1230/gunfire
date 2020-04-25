stopAllSounds();
_root.play_soundAction("游戏结束");
_parent.count_score();
_root.clean_fire();
btn.onPress = function()
{
   _root.play_soundAction("手枪上子弹");
   _root.restart_game();
};
