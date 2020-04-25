stop();
_root.add_deadAction(_root.add_enemys01("enemy01",2372,-22,1000,4,0),1);
if(_root.game_level < 1)
{
   _root.add_blocks("02",2672,-201);
   _root.add_enemys01("enemy01",2725,-205,5,1,3);
}
else
{
   if(_root.game_level != 1)
   {
      _root.add_enemys01("enemy01",2513,-106,1000,2,0);
      _root.add_enemys01("enemy01",2575,-106,1000,4,0);
   }
   _root.add_blocks("01",2672,-201);
   _root.add_enemys01("enemy01",2725,-205,1000,3,0);
   _root.add_enemys01("enemy01",2754,-205,1000,6,0);
}
_root.add_deadAction(_root.add_enemys01("enemy01",2770,-205,1000,6,0),3);
