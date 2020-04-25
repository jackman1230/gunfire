/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

module fui.Game {

	export class FUI_player_stay_2 extends fairygui.GComponent {

		public m_xs:fairygui.GLoader;
		public m_ss:fairygui.GLoader;

		public static URL:string = "ui://bq3h5inscqp940";

		public static createInstance():FUI_player_stay_2 {
			return <FUI_player_stay_2><any>(fairygui.UIPackage.createObject("Game","player_stay_2"));
		}

		public constructor() {
			super();
		}

		protected constructFromXML(xml: any): void {
			super.constructFromXML(xml);

			this.m_xs = <fairygui.GLoader><any>(this.getChildAt(0));
			this.m_ss = <fairygui.GLoader><any>(this.getChildAt(1));
		}
	}
}