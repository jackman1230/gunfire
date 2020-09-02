/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_fireBtn extends fgui.GButton {

	public m_button:fgui.Controller;
	public m_n3:fgui.GImage;
	public m_n4:fgui.GImage;
	public m_n5:fgui.GImage;
	public static URL:string = "ui://bq3h5inscqp93o";

	public static createInstance():WXFUI_fireBtn {
		return <WXFUI_fireBtn>(fgui.UIPackage.createObject("Game", "fireBtn"));
	}

	protected onConstruct():void {
		this.m_button = this.getController("button");
		this.m_n3 = <fgui.GImage>(this.getChild("n3"));
		this.m_n4 = <fgui.GImage>(this.getChild("n4"));
		this.m_n5 = <fgui.GImage>(this.getChild("n5"));
	}
}