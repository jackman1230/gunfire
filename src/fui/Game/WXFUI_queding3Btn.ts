/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_queding3Btn extends fgui.GButton {

	public m_button:fgui.Controller;
	public m_n0:fgui.GImage;
	public static URL:string = "ui://bq3h5insk6saxww";

	public static createInstance():WXFUI_queding3Btn {
		return <WXFUI_queding3Btn>(fgui.UIPackage.createObject("Game", "queding3Btn"));
	}

	protected onConstruct():void {
		this.m_button = this.getController("button");
		this.m_n0 = <fgui.GImage>(this.getChild("n0"));
	}
}