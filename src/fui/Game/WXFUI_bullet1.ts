/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_bullet1 extends fairygui.GComponent {

	public m_n0:fairygui.GImage;
	public m_n1:fairygui.GImage;

	public static URL:string = "ui://bq3h5insyqv7at";

	public static createInstance():WXFUI_bullet1 {
		return <WXFUI_bullet1><any>(fairygui.UIPackage.createObject("Game","bullet1"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_n0 = <fairygui.GImage><any>(this.getChild("n0"));
		this.m_n1 = <fairygui.GImage><any>(this.getChild("n1"));
	}
}