/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_enemy3 extends fairygui.GComponent {

	public m_en:fairygui.GLoader;

	public static URL:string = "ui://bq3h5insoqgwa1";

	public static createInstance():WXFUI_enemy3 {
		return <WXFUI_enemy3><any>(fairygui.UIPackage.createObject("Game","enemy3"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_en = <fairygui.GLoader><any>(this.getChild("en"));
	}
}