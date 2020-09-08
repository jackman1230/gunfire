/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_shareBtn2 extends fairygui.GButton {

	public m_button:fairygui.Controller;
	public m_n6:fairygui.GImage;

	public static URL:string = "ui://bq3h5insdr1to4";

	public static createInstance():WXFUI_shareBtn2 {
		return <WXFUI_shareBtn2><any>(fairygui.UIPackage.createObject("Game","shareBtn2"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_button = this.getController("button");
		this.m_n6 = <fairygui.GImage><any>(this.getChild("n6"));
	}
}