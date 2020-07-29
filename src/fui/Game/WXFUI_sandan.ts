/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_sandan extends fairygui.GComponent {

	public m_zidan:fairygui.GLoader;

	public static URL:string = "ui://bq3h5insvmpqxud";

	public static createInstance():WXFUI_sandan {
		return <WXFUI_sandan><any>(fairygui.UIPackage.createObject("Game","sandan"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_zidan = <fairygui.GLoader><any>(this.getChild("zidan"));
	}
}