/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_enemy1 extends fairygui.GComponent {

	public m_en:fairygui.GLoader;
	public m_firePos:fairygui.GTextField;

	public static URL:string = "ui://bq3h5insoqgw9y";

	public static createInstance():WXFUI_enemy1 {
		return <WXFUI_enemy1><any>(fairygui.UIPackage.createObject("Game","enemy1"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_en = <fairygui.GLoader><any>(this.getChildAt(0));
		this.m_firePos = <fairygui.GTextField><any>(this.getChildAt(1));
	}
}