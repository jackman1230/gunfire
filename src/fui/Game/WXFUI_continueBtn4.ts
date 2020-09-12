/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_continueBtn4 extends fgui.GButton {

	public m_button:fgui.Controller;
	public m_n7:fgui.GImage;
	public static URL:string = "ui://bq3h5insdr1tnu";

	public static createInstance():WXFUI_continueBtn4 {
		return <WXFUI_continueBtn4>(fgui.UIPackage.createObject("Game", "continueBtn4"));
	}

	protected onConstruct():void {
		this.m_button = this.getController("button");
		this.m_n7 = <fgui.GImage>(this.getChild("n7"));
	}
}