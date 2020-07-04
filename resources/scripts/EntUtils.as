package
{
   import nape.constraint.Constraint;
   
   public class EntUtils
   {
       
      
      public function EntUtils()
      {
         super();
      }
      
      public static function destroyJoint(param1:Constraint) : *
      {
         if(param1 != null)
         {
            param1.space = null;
            World.m_world.constraints.remove(param1);
         }
      }
      
      public static function destroyBody(param1:Boner) : *
      {
         if(param1 != null)
         {
            param1.constraints.foreach(World.m_world.constraints.remove);
            param1.space = null;
         }
         World.m_world.bodies.remove(param1);
      }
   }
}
