/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_star extends fgui.GComponent {

	public m_ctl:fgui.Controller;
	public m_n18:fgui.GImage;
	public m_n19:fgui.GImage;
	public m_n16:fgui.GImage;
	public m_n17:fgui.GImage;
	public m_n20:fgui.GImage;
	public m_n21:fgui.GImage;
	public static URL:string = "ui://bq3h5inscde5xqp";

	public static createInstance():WXFUI_star {
		return <WXFUI_star>(fgui.UIPackage.createObject("Game", "star"));
	}

	protected onConstruct():void {
		this.m_ctl = this.getController("ctl");
		this.m_n18 = <fgui.GImage>(this.getChild("n18"));
		this.m_n19 = <fgui.GImage>(this.getChild("n19"));
		this.m_n16 = <fgui.GImage>(this.getChild("n16"));
		this.m_n17 = <fgui.GImage>(this.getChild("n17"));
		this.m_n20 = <fgui.GImage>(this.getChild("n20"));
		this.m_n21 = <fgui.GImage>(this.getChild("n21"));
	}
}