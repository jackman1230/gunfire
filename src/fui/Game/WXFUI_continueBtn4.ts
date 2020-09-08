/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_continueBtn4 extends fairygui.GButton {

	public m_button:fairygui.Controller;
	public m_n7:fairygui.GImage;

	public static URL:string = "ui://bq3h5insdr1tnu";

	public static createInstance():WXFUI_continueBtn4 {
		return <WXFUI_continueBtn4><any>(fairygui.UIPackage.createObject("Game","continueBtn4"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_button = this.getController("button");
		this.m_n7 = <fairygui.GImage><any>(this.getChild("n7"));
	}
}