/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_backBtn extends fgui.GButton {

	public m_button:fgui.Controller;
	public m_n6:fgui.GImage;
	public static URL:string = "ui://bq3h5insdr1tnr";

	public static createInstance():WXFUI_backBtn {
		return <WXFUI_backBtn>(fgui.UIPackage.createObject("Game", "backBtn"));
	}

	protected onConstruct():void {
		this.m_button = this.getController("button");
		this.m_n6 = <fgui.GImage>(this.getChild("n6"));
	}
}