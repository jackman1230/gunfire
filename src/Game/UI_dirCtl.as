/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

package Game
{
	import fairygui.*;

	public class UI_dirCtl extends fairygui.GComponent
	{
		public var m_n0:GGraph;
		public var m_n5:GImage;
		public var m_n6:GImage;

		public static const URL:String = "ui://bq3h5inscqp93k";

		public static function createInstance():UI_dirCtl
		{
			return UI_dirCtl(UIPackage.createObject("Game","dirCtl"));
		}

		public function UI_dirCtl()
		{
		}

		protected override function constructFromXML(xml:Object):void
		{
			super.constructFromXML(xml);

			m_n0 = GGraph(this.getChildAt(0));
			m_n5 = GImage(this.getChildAt(1));
			m_n6 = GImage(this.getChildAt(2));
		}
	}
}