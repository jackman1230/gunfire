/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

package Game
{
	import fairygui.*;

	public class UI_BtnCtlView extends fairygui.GComponent
	{
		public var m_dirCtl:UI_dirCtl;
		public var m_funCtl:UI_funCtl;

		public static const URL:String = "ui://bq3h5inscqp93g";

		public static function createInstance():UI_BtnCtlView
		{
			return UI_BtnCtlView(UIPackage.createObject("Game","BtnCtlView"));
		}

		public function UI_BtnCtlView()
		{
		}

		protected override function constructFromXML(xml:Object):void
		{
			super.constructFromXML(xml);

			m_dirCtl = UI_dirCtl(this.getChildAt(0));
			m_funCtl = UI_funCtl(this.getChildAt(1));
		}
	}
}