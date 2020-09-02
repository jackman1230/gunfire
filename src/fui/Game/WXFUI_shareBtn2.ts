/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_shareBtn2 extends fgui.GButton {

	public m_button:fgui.Controller;
	public m_n6:fgui.GImage;
	public static URL:string = "ui://bq3h5insdr1to4";

	public static createInstance():WXFUI_shareBtn2 {
		return <WXFUI_shareBtn2>(fgui.UIPackage.createObject("Game", "shareBtn2"));
	}

	protected onConstruct():void {
		this.m_button = this.getController("button");
		this.m_n6 = <fgui.GImage>(this.getChild("n6"));
	}
}