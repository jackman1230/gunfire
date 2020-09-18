/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

import WXFUI_shareBtn1 from "./WXFUI_shareBtn1";
import WXFUI_shareBtn2 from "./WXFUI_shareBtn2";

export default class WXFUI_share extends fairygui.GComponent {

	public m_n2:fairygui.GImage;
	public m_share1:WXFUI_shareBtn1;
	public m_share2:WXFUI_shareBtn2;

	public static URL:string = "ui://bq3h5insdr1to2";

	public static createInstance():WXFUI_share {
		return <WXFUI_share><any>(fairygui.UIPackage.createObject("Game","share"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_n2 = <fairygui.GImage><any>(this.getChild("n2"));
		this.m_share1 = <WXFUI_shareBtn1><any>(this.getChild("share1"));
		this.m_share2 = <WXFUI_shareBtn2><any>(this.getChild("share2"));
	}
}