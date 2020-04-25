/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

package Game
{
	import fairygui.*;

	public class UI_funCtl extends fairygui.GComponent
	{
		public var m_n0:UI_fireBtn;
		public var m_jump:UI_jumpBtn;
		public var m_throw:UI_throwBtn;
		public var m_weapon:UI_weaponBtn;

		public static const URL:String = "ui://bq3h5inscqp93m";

		public static function createInstance():UI_funCtl
		{
			return UI_funCtl(UIPackage.createObject("Game","funCtl"));
		}

		public function UI_funCtl()
		{
		}

		protected override function constructFromXML(xml:Object):void
		{
			super.constructFromXML(xml);

			m_n0 = UI_fireBtn(this.getChildAt(0));
			m_jump = UI_jumpBtn(this.getChildAt(1));
			m_throw = UI_throwBtn(this.getChildAt(2));
			m_weapon = UI_weaponBtn(this.getChildAt(3));
		}
	}
}