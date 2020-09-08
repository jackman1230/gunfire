/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_ADItemBig2 extends fairygui.GComponent {

	public m_n0:fairygui.GImage;
	public m_icon:fairygui.GLoader;
	public m_name:fairygui.GTextField;

	public static URL:string = "ui://bq3h5insihitxus";

	public static createInstance():WXFUI_ADItemBig2 {
		return <WXFUI_ADItemBig2><any>(fairygui.UIPackage.createObject("Game","ADItemBig2"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_n0 = <fairygui.GImage><any>(this.getChild("n0"));
		this.m_icon = <fairygui.GLoader><any>(this.getChild("icon"));
		this.m_name = <fairygui.GTextField><any>(this.getChild("name"));
	}
}