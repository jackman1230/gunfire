/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_continueBtn2 extends fairygui.GButton {

	public m_button:fairygui.Controller;
	public m_n5:fairygui.GImage;

	public static URL:string = "ui://bq3h5insdr1tns";

	public static createInstance():WXFUI_continueBtn2 {
		return <WXFUI_continueBtn2><any>(fairygui.UIPackage.createObject("Game","continueBtn2"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_button = this.getController("button");
		this.m_n5 = <fairygui.GImage><any>(this.getChild("n5"));
	}
}