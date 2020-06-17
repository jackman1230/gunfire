/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_continueBtn3 extends fairygui.GButton {

	public m_button:fairygui.Controller;
	public m_n6:fairygui.GImage;

	public static URL:string = "ui://bq3h5insdr1tnt";

	public static createInstance():WXFUI_continueBtn3 {
		return <WXFUI_continueBtn3><any>(fairygui.UIPackage.createObject("Game","continueBtn3"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_button = this.getController("button");
		this.m_n6 = <fairygui.GImage><any>(this.getChild("n6"));
	}
}