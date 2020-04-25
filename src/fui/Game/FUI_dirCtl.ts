/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

module fui.Game {

	export class FUI_dirCtl extends fairygui.GComponent {

		public m_n0:fairygui.GGraph;
		public m_n5:fairygui.GImage;
		public m_n6:fairygui.GImage;

		public static URL:string = "ui://bq3h5inscqp93k";

		public static createInstance():FUI_dirCtl {
			return <FUI_dirCtl><any>(fairygui.UIPackage.createObject("Game","dirCtl"));
		}

		public constructor() {
			super();
		}

		protected constructFromXML(xml: any): void {
			super.constructFromXML(xml);

			this.m_n0 = <fairygui.GGraph><any>(this.getChildAt(0));
			this.m_n5 = <fairygui.GImage><any>(this.getChildAt(1));
			this.m_n6 = <fairygui.GImage><any>(this.getChildAt(2));
		}
	}
}