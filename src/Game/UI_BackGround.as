/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

package Game
{
	import fairygui.*;

	public class UI_BackGround extends fairygui.GComponent
	{
		public var m_bg:GLoader;
		public var m_btnCtl:UI_BtnCtlView;

		public static const URL:String = "ui://bq3h5insgww20";

		public static function createInstance():UI_BackGround
		{
			return UI_BackGround(UIPackage.createObject("Game","BackGround"));
		}

		public function UI_BackGround()
		{
		}

		protected override function constructFromXML(xml:Object):void
		{
			super.constructFromXML(xml);

			m_bg = GLoader(this.getChildAt(0));
			m_btnCtl = UI_BtnCtlView(this.getChildAt(1));
		}
	}
}