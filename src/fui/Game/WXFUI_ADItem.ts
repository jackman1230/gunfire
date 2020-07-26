/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_ADItem extends fairygui.GComponent {

	public m_n0:fairygui.GImage;
	public m_icon:fairygui.GLoader;
	public m_name:fairygui.GTextField;

	public static URL:string = "ui://bq3h5inss2x8ir";

	public static createInstance():WXFUI_ADItem {
		return <WXFUI_ADItem><any>(fairygui.UIPackage.createObject("Game","ADItem"));
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