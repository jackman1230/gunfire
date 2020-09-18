/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

import WXFUI_queding3Btn from "./WXFUI_queding3Btn";
import WXFUI_videoBtn from "./WXFUI_videoBtn";

export default class WXFUI_showVideoView extends fairygui.GComponent {

	public m_n33:fairygui.GImage;
	public m_queding:WXFUI_queding3Btn;
	public m_gou:WXFUI_videoBtn;
	public m_n37:fairygui.GImage;

	public static URL:string = "ui://bq3h5insk6saxwv";

	public static createInstance():WXFUI_showVideoView {
		return <WXFUI_showVideoView><any>(fairygui.UIPackage.createObject("Game","showVideoView"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_n33 = <fairygui.GImage><any>(this.getChild("n33"));
		this.m_queding = <WXFUI_queding3Btn><any>(this.getChild("queding"));
		this.m_gou = <WXFUI_videoBtn><any>(this.getChild("gou"));
		this.m_n37 = <fairygui.GImage><any>(this.getChild("n37"));
	}
}