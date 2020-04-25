/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

package Game
{
	import fairygui.*;

	public class UI_fireBtn extends fairygui.GButton
	{
		public var m_button:Controller;
		public var m_n0:GImage;
		public var m_n1:GImage;
		public var m_title:GTextField;

		public static const URL:String = "ui://bq3h5inscqp93o";

		public static function createInstance():UI_fireBtn
		{
			return UI_fireBtn(UIPackage.createObject("Game","fireBtn"));
		}

		public function UI_fireBtn()
		{
		}

		protected override function constructFromXML(xml:Object):void
		{
			super.constructFromXML(xml);

			m_button = this.getControllerAt(0);
			m_n0 = GImage(this.getChildAt(0));
			m_n1 = GImage(this.getChildAt(1));
			m_title = GTextField(this.getChildAt(2));
		}
	}
}