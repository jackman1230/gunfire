/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

package Game
{
	import fairygui.*;

	public class UI_player_jump_1 extends fairygui.GComponent
	{
		public var m_xs2:GLoader;
		public var m_ss:GLoader;

		public static const URL:String = "ui://bq3h5inscqp93v";

		public static function createInstance():UI_player_jump_1
		{
			return UI_player_jump_1(UIPackage.createObject("Game","player_jump_1"));
		}

		public function UI_player_jump_1()
		{
		}

		protected override function constructFromXML(xml:Object):void
		{
			super.constructFromXML(xml);

			m_xs2 = GLoader(this.getChildAt(0));
			m_ss = GLoader(this.getChildAt(1));
		}
	}
}