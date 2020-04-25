/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

module fui.Game {

	export class FUI_BtnCtlView extends fairygui.GComponent {

		public m_dirCtl:FUI_dirCtl;
		public m_funCtl:FUI_funCtl;

		public static URL:string = "ui://bq3h5inscqp93g";

		public static createInstance():FUI_BtnCtlView {
			return <FUI_BtnCtlView><any>(fairygui.UIPackage.createObject("Game","BtnCtlView"));
		}

		public constructor() {
			super();
		}

		protected constructFromXML(xml: any): void {
			super.constructFromXML(xml);

			this.m_dirCtl = <FUI_dirCtl><any>(this.getChildAt(0));
			this.m_funCtl = <FUI_funCtl><any>(this.getChildAt(1));
		}
	}
}