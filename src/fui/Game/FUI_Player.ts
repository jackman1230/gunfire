/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

module fui.Game {

	export class FUI_Player extends fairygui.GComponent {

		public m_n5:FUI_player_run_1;
		public m_n7:FUI_player_jump_1;
		public m_n8:FUI_player_stay_1;
		public m_n9:FUI_player_jump_2;
		public m_n10:FUI_player_run_2;
		public m_n11:FUI_player_stay_2;

		public static URL:string = "ui://bq3h5inscqp92";

		public static createInstance():FUI_Player {
			return <FUI_Player><any>(fairygui.UIPackage.createObject("Game","Player"));
		}

		public constructor() {
			super();
		}

		protected constructFromXML(xml: any): void {
			super.constructFromXML(xml);

			this.m_n5 = <FUI_player_run_1><any>(this.getChildAt(0));
			this.m_n7 = <FUI_player_jump_1><any>(this.getChildAt(1));
			this.m_n8 = <FUI_player_stay_1><any>(this.getChildAt(2));
			this.m_n9 = <FUI_player_jump_2><any>(this.getChildAt(3));
			this.m_n10 = <FUI_player_run_2><any>(this.getChildAt(4));
			this.m_n11 = <FUI_player_stay_2><any>(this.getChildAt(5));
		}
	}
}