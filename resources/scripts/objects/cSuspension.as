package objects
{
   import nape.constraint.DistanceJoint;
   import nape.constraint.LineJoint;
   
   public class cSuspension
   {
       
      
      var prismatic:LineJoint;
      
      var spring:DistanceJoint;
      
      var spring2:DistanceJoint = null;
      
      var spring3:DistanceJoint = null;
      
      var parent:cObject;
      
      var reticule:Boner;
      
      var axle:Boner;
      
      var stabiliser:Boner;
      
      public var translationDistance:Number;
      
      public function cSuspension(param1:cObject, param2:Boner, param3:Boner, param4:Boner, param5:Number = -1, param6:Number = 1)
      {
         super();
         this.parent = param1;
         this.reticule = param2;
         this.axle = param3;
         this.stabiliser = param4;
         this.prismatic = BoxUtils.NewLineJoint(this.reticule,this.axle,true);
         this.spring = BoxUtils.NewDistanceJoint(this.reticule,this.axle,true);
         if(this.stabiliser != null)
         {
            this.spring2 = BoxUtils.NewDistanceJoint(this.axle,this.stabiliser,true,false);
            this.parent.addJoint(this.spring2);
         }
      }
      
      public function removeMe() : *
      {
         EntUtils.destroyJoint(this.prismatic);
         EntUtils.destroyJoint(this.spring);
         EntUtils.destroyJoint(this.spring2);
      }
      
      public function limit(param1:Number) : Number
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(param1 > 1)
         {
            param1 = 1;
         }
         return param1;
      }
      
      public function update() : *
      {
      }
   }
}
