stop();
_root.add_deadAction(_root.add_enemys03("enemy04",4879,287,1),4);
if(_root.game_level < 1)
{
   _root.add_enemys01("enemy01",4859,287,5,2,3);
   _root.add_enemys01("enemy01",4899,287,5,3,3);
}
else
{
   _root.add_enemys01("enemy01",4859,287,5,2,1);
   _root.add_enemys01("enemy01",4899,287,5,3,1);
}
