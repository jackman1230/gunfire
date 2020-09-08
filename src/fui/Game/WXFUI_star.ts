/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_star extends fairygui.GComponent {

	public m_ctl:fairygui.Controller;
	public m_n18:fairygui.GImage;
	public m_n19:fairygui.GImage;
	public m_n16:fairygui.GImage;
	public m_n17:fairygui.GImage;
	public m_n20:fairygui.GImage;
	public m_n21:fairygui.GImage;

	public static URL:string = "ui://bq3h5inscde5xqp";

	public static createInstance():WXFUI_star {
		return <WXFUI_star><any>(fairygui.UIPackage.createObject("Game","star"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_ctl = this.getController("ctl");
		this.m_n18 = <fairygui.GImage><any>(this.getChild("n18"));
		this.m_n19 = <fairygui.GImage><any>(this.getChild("n19"));
		this.m_n16 = <fairygui.GImage><any>(this.getChild("n16"));
		this.m_n17 = <fairygui.GImage><any>(this.getChild("n17"));
		this.m_n20 = <fairygui.GImage><any>(this.getChild("n20"));
		this.m_n21 = <fairygui.GImage><any>(this.getChild("n21"));
	}
}