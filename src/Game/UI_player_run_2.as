/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

package Game
{
	import fairygui.*;

	public class UI_player_run_2 extends fairygui.GComponent
	{
		public var m_xs:GLoader;
		public var m_ss:GLoader;

		public static const URL:String = "ui://bq3h5inscqp93z";

		public static function createInstance():UI_player_run_2
		{
			return UI_player_run_2(UIPackage.createObject("Game","player_run_2"));
		}

		public function UI_player_run_2()
		{
		}

		protected override function constructFromXML(xml:Object):void
		{
			super.constructFromXML(xml);

			m_xs = GLoader(this.getChildAt(0));
			m_ss = GLoader(this.getChildAt(1));
		}
	}
}