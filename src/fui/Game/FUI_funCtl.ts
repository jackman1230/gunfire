/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

module fui.Game {

	export class FUI_funCtl extends fairygui.GComponent {

		public m_n0:FUI_fireBtn;
		public m_jump:FUI_jumpBtn;
		public m_throw:FUI_throwBtn;
		public m_weapon:FUI_weaponBtn;

		public static URL:string = "ui://bq3h5inscqp93m";

		public static createInstance():FUI_funCtl {
			return <FUI_funCtl><any>(fairygui.UIPackage.createObject("Game","funCtl"));
		}

		public constructor() {
			super();
		}

		protected constructFromXML(xml: any): void {
			super.constructFromXML(xml);

			this.m_n0 = <FUI_fireBtn><any>(this.getChildAt(0));
			this.m_jump = <FUI_jumpBtn><any>(this.getChildAt(1));
			this.m_throw = <FUI_throwBtn><any>(this.getChildAt(2));
			this.m_weapon = <FUI_weaponBtn><any>(this.getChildAt(3));
		}
	}
}