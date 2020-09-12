/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_continueBtn2 extends fgui.GButton {

	public m_button:fgui.Controller;
	public m_n5:fgui.GImage;
	public static URL:string = "ui://bq3h5insdr1tns";

	public static createInstance():WXFUI_continueBtn2 {
		return <WXFUI_continueBtn2>(fgui.UIPackage.createObject("Game", "continueBtn2"));
	}

	protected onConstruct():void {
		this.m_button = this.getController("button");
		this.m_n5 = <fgui.GImage>(this.getChild("n5"));
	}
}