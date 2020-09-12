/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

import WXFUI_queding2Btn from "./WXFUI_queding2Btn";
import WXFUI_guanbi2Btn from "./WXFUI_guanbi2Btn";

export default class WXFUI_noVideoTips extends fgui.GComponent {

	public m_n33:fgui.GImage;
	public m_queding:WXFUI_queding2Btn;
	public m_guanbi:WXFUI_guanbi2Btn;
	public static URL:string = "ui://bq3h5insk6saxwr";

	public static createInstance():WXFUI_noVideoTips {
		return <WXFUI_noVideoTips>(fgui.UIPackage.createObject("Game", "noVideoTips"));
	}

	protected onConstruct():void {
		this.m_n33 = <fgui.GImage>(this.getChild("n33"));
		this.m_queding = <WXFUI_queding2Btn>(this.getChild("queding"));
		this.m_guanbi = <WXFUI_guanbi2Btn>(this.getChild("guanbi"));
	}
}