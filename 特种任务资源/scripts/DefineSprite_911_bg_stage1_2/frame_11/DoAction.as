stop();
if(_root.game_level < 1)
{
   _root.add_enemys01("enemy01",5561,276,1000,4,2);
   _root.add_deadAction(_root.add_enemys01("enemy01",5826,278,1000,4,2),7);
}
else
{
   _root.add_enemys01("enemy01",5561,276,1000,4,2);
   _root.add_enemys01("enemy01",5602,277,1000,4,2);
   _root.add_enemys01("enemy01",5638,279,1000,4,2);
   _root.add_deadAction(_root.add_enemys01("enemy01",5826,278,1000,4,2),7);
   _root.add_enemys01("enemy01",5860,277,1000,4,2);
   _root.add_enemys01("enemy01",5975,270,1000,4,2);
}
