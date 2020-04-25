/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

package Game
{
	import fairygui.*;

	public class UI_Player extends fairygui.GComponent
	{
		public var m_n5:UI_player_run_1;
		public var m_n7:UI_player_jump_1;
		public var m_n8:UI_player_stay_1;
		public var m_n9:UI_player_jump_2;
		public var m_n10:UI_player_run_2;
		public var m_n11:UI_player_stay_2;

		public static const URL:String = "ui://bq3h5inscqp92";

		public static function createInstance():UI_Player
		{
			return UI_Player(UIPackage.createObject("Game","Player"));
		}

		public function UI_Player()
		{
		}

		protected override function constructFromXML(xml:Object):void
		{
			super.constructFromXML(xml);

			m_n5 = UI_player_run_1(this.getChildAt(0));
			m_n7 = UI_player_jump_1(this.getChildAt(1));
			m_n8 = UI_player_stay_1(this.getChildAt(2));
			m_n9 = UI_player_jump_2(this.getChildAt(3));
			m_n10 = UI_player_run_2(this.getChildAt(4));
			m_n11 = UI_player_stay_2(this.getChildAt(5));
		}
	}
}