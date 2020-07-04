package
{
   import com.bit101.display.BigAssCanvas;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import nape.geom.AABB;
   import nape.geom.GeomPoly;
   import nape.geom.GeomPolyList;
   import nape.geom.MarchingSquares;
   import nape.geom.Vec2;
   import nape.shape.Polygon;
   
   public class Composition
   {
       
      
      public function Composition()
      {
         super();
      }
      
      public static function gameClipToBody(param1:BigAssCanvas, param2:int = 128, param3:Vec2 = null, param4:Vec2 = null) : Boner
      {
         var body:Boner = null;
         var bitmap:BigAssCanvas = param1;
         var threshold:int = param2;
         var granularity:Vec2 = param3;
         var offset:Vec2 = param4;
         body = new Boner();
         var originalX:Number = 0;
         var originalY:Number = 0;
         var bounds:AABB = new AABB(0,80,GroundUtils.sectionWidth * GroundUtils.numSections,700);
         var iso:Function = function(param1:Number, param2:Number):Number
         {
            return bitmap.getPixel32(param1,param2) > 4261412864?Number(-1):Number(1);
         };
         var grain:Vec2 = granularity == null?new Vec2(8,8):granularity;
         var polys:GeomPolyList = MarchingSquares.run(iso,bounds,grain,4,null,true);
         polys.foreach(function(param1:GeomPoly):void
         {
            var p:GeomPoly = param1;
            var qolys:GeomPolyList = p.simplify(1).convex_decomposition();
            qolys.foreach(function(param1:GeomPoly):void
            {
               var _loc2_:Polygon = new Polygon(param1,BoxUtils.groundMaterial());
               if(offset)
               {
                  _loc2_.translate(offset);
               }
               body.shapes.add(_loc2_);
            });
         });
         return body;
      }
      
      public static function bitmapToBody(param1:BitmapData, param2:int = 128, param3:Vec2 = null, param4:Vec2 = null) : Boner
      {
         var body:Boner = null;
         var bitmap:BitmapData = param1;
         var threshold:int = param2;
         var granularity:Vec2 = param3;
         var offset:Vec2 = param4;
         body = new Boner();
         var originalX:Number = 0;
         var originalY:Number = 0;
         var bounds:AABB = new AABB(0,0,bitmap.width,bitmap.height);
         var iso:Function = function(param1:Number, param2:Number):Number
         {
            return bitmap.getPixel32(param1,param2) > 4261412864?Number(-1):Number(1);
         };
         var grain:Vec2 = granularity == null?new Vec2(8,8):granularity;
         var polys:GeomPolyList = MarchingSquares.run(iso,bounds,grain,4,null,true);
         polys.foreach(function(param1:GeomPoly):void
         {
            var p:GeomPoly = param1;
            var qolys:GeomPolyList = p.simplify(1).convex_decomposition();
            qolys.foreach(function(param1:GeomPoly):void
            {
               var _loc2_:Polygon = new Polygon(param1,BoxUtils.groundMaterial());
               if(offset)
               {
                  _loc2_.translate(offset);
               }
               body.shapes.add(_loc2_);
            });
         });
         return body;
      }
      
      public static function graphicToBody(param1:DisplayObject, param2:Vec2 = null) : Boner
      {
         var body:Boner = null;
         var oldParent:DisplayObjectContainer = null;
         var graphic:DisplayObject = param1;
         var granularity:Vec2 = param2;
         body = new Boner();
         oldParent = graphic.parent;
         if(oldParent != null)
         {
            oldParent.removeChild(graphic);
         }
         global.mainStage.addChild(graphic);
         var originalX:Number = graphic.x;
         var originalY:Number = graphic.y;
         var bounds:AABB = new AABB(originalX,originalY,GroundUtils.sectionWidth * 5,GroundUtils.sectionHeight);
         var iso:Function = function(param1:Number, param2:Number):Number
         {
            return !!graphic.hitTestPoint(param1,param2,true)?Number(-1):Number(1);
         };
         var grain:Vec2 = granularity == null?new Vec2(8,8):granularity;
         var polys:GeomPolyList = MarchingSquares.run(iso,bounds,granularity,6);
         polys.foreach(function(param1:GeomPoly):void
         {
            var p:GeomPoly = param1;
            var qolys:GeomPolyList = p.simplify(1).convex_decomposition();
            qolys.foreach(function(param1:GeomPoly):void
            {
               body.shapes.add(new Polygon(param1));
            });
         });
         global.mainStage.removeChild(graphic);
         graphic.x = originalX;
         graphic.y = originalY;
         if(oldParent != null)
         {
            oldParent.addChild(graphic);
         }
         return body;
      }
   }
}
