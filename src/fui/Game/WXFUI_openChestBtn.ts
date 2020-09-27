/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_openChestBtn extends fgui.GButton {

	public m_button:fgui.Controller;
	public m_n0:fgui.GImage;
	public m_n1:fgui.GImage;
	public m_n2:fgui.GTextField;
	public static URL:string = "ui://bq3h5insvmpqxu9";

	public static createInstance():WXFUI_openChestBtn {
		return <WXFUI_openChestBtn>(fgui.UIPackage.createObject("Game", "openChestBtn"));
	}

	protected onConstruct():void {
		this.m_button = this.getController("button");
		this.m_n0 = <fgui.GImage>(this.getChild("n0"));
		this.m_n1 = <fgui.GImage>(this.getChild("n1"));
		this.m_n2 = <fgui.GTextField>(this.getChild("n2"));
	}
}