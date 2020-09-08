/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_blood extends fairygui.GComponent {

	public m_ctl:fairygui.Controller;
	public m_n0:fairygui.GImage;
	public m_n1:fairygui.GImage;
	public m_n4:fairygui.GImage;

	public static URL:string = "ui://bq3h5instckhxvn";

	public static createInstance():WXFUI_blood {
		return <WXFUI_blood><any>(fairygui.UIPackage.createObject("Game","blood"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_ctl = this.getController("ctl");
		this.m_n0 = <fairygui.GImage><any>(this.getChild("n0"));
		this.m_n1 = <fairygui.GImage><any>(this.getChild("n1"));
		this.m_n4 = <fairygui.GImage><any>(this.getChild("n4"));
	}
}