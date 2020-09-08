/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_continueBtn extends fairygui.GButton {

	public m_button:fairygui.Controller;
	public m_n4:fairygui.GImage;

	public static URL:string = "ui://bq3h5insdr1tnk";

	public static createInstance():WXFUI_continueBtn {
		return <WXFUI_continueBtn><any>(fairygui.UIPackage.createObject("Game","continueBtn"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_button = this.getController("button");
		this.m_n4 = <fairygui.GImage><any>(this.getChild("n4"));
	}
}