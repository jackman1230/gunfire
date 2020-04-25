stop();
_root.add_deadAction(_root.add_enemys03("enemy04",5430,287,1),5);
if(_root.game_level < 1)
{
   _root.add_enemys01("enemy01",5452,287,5,2,3);
   _root.add_enemys01("enemy01",5497,287,5,3,3);
}
else
{
   _root.add_enemys01("enemy01",5452,287,5,2,1);
   _root.add_enemys01("enemy01",5497,287,5,4,1);
}
