/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_abandon extends fgui.GButton {

	public m_button:fgui.Controller;
	public m_n7:fgui.GImage;
	public static URL:string = "ui://bq3h5insunfjxqr";

	public static createInstance():WXFUI_abandon {
		return <WXFUI_abandon>(fgui.UIPackage.createObject("Game", "abandon"));
	}

	protected onConstruct():void {
		this.m_button = this.getController("button");
		this.m_n7 = <fgui.GImage>(this.getChild("n7"));
	}
}