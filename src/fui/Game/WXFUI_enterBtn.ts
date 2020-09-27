/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_enterBtn extends fgui.GButton {

	public m_button:fgui.Controller;
	public m_n5:fgui.GImage;
	public static URL:string = "ui://bq3h5insdr1tnn";

	public static createInstance():WXFUI_enterBtn {
		return <WXFUI_enterBtn>(fgui.UIPackage.createObject("Game", "enterBtn"));
	}

	protected onConstruct():void {
		this.m_button = this.getController("button");
		this.m_n5 = <fgui.GImage>(this.getChild("n5"));
	}
}