/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_buyBtn extends fgui.GButton {

	public m_button:fgui.Controller;
	public m_n5:fgui.GImage;
	public static URL:string = "ui://bq3h5insdr1tno";

	public static createInstance():WXFUI_buyBtn {
		return <WXFUI_buyBtn>(fgui.UIPackage.createObject("Game", "buyBtn"));
	}

	protected onConstruct():void {
		this.m_button = this.getController("button");
		this.m_n5 = <fgui.GImage>(this.getChild("n5"));
	}
}