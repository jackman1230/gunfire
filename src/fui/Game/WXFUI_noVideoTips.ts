/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

import WXFUI_queding2Btn from "./WXFUI_queding2Btn";
import WXFUI_guanbi2Btn from "./WXFUI_guanbi2Btn";

export default class WXFUI_noVideoTips extends fairygui.GComponent {

	public m_n33:fairygui.GImage;
	public m_queding:WXFUI_queding2Btn;
	public m_guanbi:WXFUI_guanbi2Btn;

	public static URL:string = "ui://bq3h5insk6saxwr";

	public static createInstance():WXFUI_noVideoTips {
		return <WXFUI_noVideoTips><any>(fairygui.UIPackage.createObject("Game","noVideoTips"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_n33 = <fairygui.GImage><any>(this.getChild("n33"));
		this.m_queding = <WXFUI_queding2Btn><any>(this.getChild("queding"));
		this.m_guanbi = <WXFUI_guanbi2Btn><any>(this.getChild("guanbi"));
	}
}