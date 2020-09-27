/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_nextBtn extends fgui.GButton {

	public m_button:fgui.Controller;
	public m_n0:fgui.GImage;
	public static URL:string = "ui://bq3h5insk6saxwy";

	public static createInstance():WXFUI_nextBtn {
		return <WXFUI_nextBtn>(fgui.UIPackage.createObject("Game", "nextBtn"));
	}

	protected onConstruct():void {
		this.m_button = this.getController("button");
		this.m_n0 = <fgui.GImage>(this.getChild("n0"));
	}
}