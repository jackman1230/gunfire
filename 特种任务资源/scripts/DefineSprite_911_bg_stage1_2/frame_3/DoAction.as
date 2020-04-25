stop();
if(_root.game_level < 1)
{
   _root.add_prisoner("prisoner01",1252,198,2,1,"h");
   _root.add_enemys01("enemy01",1329,84,1000,4,0);
   _root.add_enemys01("enemy01",1572,183,1000,4,0);
}
else
{
   _root.add_enemys01("enemy01",1329,84,1000,4,0);
   if(_root.game_level == 1)
   {
      _root.add_enemys01("enemy01",1572,183,1000,6,0);
      _root.add_enemys01("enemy01",1615,182,1000,6,0);
   }
   else
   {
      _root.add_enemys01("enemy01",1175,312,1000,2,1);
      _root.add_enemys01("enemy01",1250,312,1000,2,1);
      _root.add_enemys01("enemy01",1330,312,1000,1,1);
      _root.add_prisoner("prisoner01",1202,313,1,1,"b");
      _root.add_blocks("04",1491,315);
      _root.add_blocks("01",1572,183);
      _root.add_enemys10("enemy10",1615,182);
   }
}
