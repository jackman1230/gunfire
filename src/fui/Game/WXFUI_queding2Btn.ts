/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_queding2Btn extends fgui.GButton {

	public m_button:fgui.Controller;
	public m_n0:fgui.GImage;
	public static URL:string = "ui://bq3h5insk6saxwu";

	public static createInstance():WXFUI_queding2Btn {
		return <WXFUI_queding2Btn>(fgui.UIPackage.createObject("Game", "queding2Btn"));
	}

	protected onConstruct():void {
		this.m_button = this.getController("button");
		this.m_n0 = <fgui.GImage>(this.getChild("n0"));
	}
}