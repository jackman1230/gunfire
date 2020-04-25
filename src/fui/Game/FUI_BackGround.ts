/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

module fui.Game {

	export class FUI_BackGround extends fairygui.GComponent {

		public m_bg:fairygui.GLoader;
		public m_btnCtl:FUI_BtnCtlView;

		public static URL:string = "ui://bq3h5insgww20";

		public static createInstance():FUI_BackGround {
			return <FUI_BackGround><any>(fairygui.UIPackage.createObject("Game","BackGround"));
		}

		public constructor() {
			super();
		}

		protected constructFromXML(xml: any): void {
			super.constructFromXML(xml);

			this.m_bg = <fairygui.GLoader><any>(this.getChildAt(0));
			this.m_btnCtl = <FUI_BtnCtlView><any>(this.getChildAt(1));
		}
	}
}