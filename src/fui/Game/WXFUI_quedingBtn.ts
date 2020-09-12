/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_quedingBtn extends fgui.GButton {

	public m_button:fgui.Controller;
	public m_n0:fgui.GImage;
	public static URL:string = "ui://bq3h5insbuh7xvs";

	public static createInstance():WXFUI_quedingBtn {
		return <WXFUI_quedingBtn>(fgui.UIPackage.createObject("Game", "quedingBtn"));
	}

	protected onConstruct():void {
		this.m_button = this.getController("button");
		this.m_n0 = <fgui.GImage>(this.getChild("n0"));
	}
}