/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_enemy4 extends fairygui.GComponent {

	public m_en:fairygui.GLoader;

	public static URL:string = "ui://bq3h5insoqgwa2";

	public static createInstance():WXFUI_enemy4 {
		return <WXFUI_enemy4><any>(fairygui.UIPackage.createObject("Game","enemy4"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_en = <fairygui.GLoader><any>(this.getChild("en"));
	}
}