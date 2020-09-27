/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_sanBeiBtn extends fgui.GButton {

	public m_button:fgui.Controller;
	public m_n0:fgui.GImage;
	public static URL:string = "ui://bq3h5inslpi5xxf";

	public static createInstance():WXFUI_sanBeiBtn {
		return <WXFUI_sanBeiBtn>(fgui.UIPackage.createObject("Game", "sanBeiBtn"));
	}

	protected onConstruct():void {
		this.m_button = this.getController("button");
		this.m_n0 = <fgui.GImage>(this.getChild("n0"));
	}
}