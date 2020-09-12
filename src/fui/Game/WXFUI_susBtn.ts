/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_susBtn extends fgui.GButton {

	public m_button:fgui.Controller;
	public m_n3:fgui.GImage;
	public static URL:string = "ui://bq3h5insiasdl3";

	public static createInstance():WXFUI_susBtn {
		return <WXFUI_susBtn>(fgui.UIPackage.createObject("Game", "susBtn"));
	}

	protected onConstruct():void {
		this.m_button = this.getController("button");
		this.m_n3 = <fgui.GImage>(this.getChild("n3"));
	}
}