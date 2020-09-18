/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_enemy_fire_14 extends fairygui.GComponent {

	public m_n1:fairygui.GLoader;

	public static URL:string = "ui://bq3h5inscdcoxpj";

	public static createInstance():WXFUI_enemy_fire_14 {
		return <WXFUI_enemy_fire_14><any>(fairygui.UIPackage.createObject("Game","enemy_fire_14"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_n1 = <fairygui.GLoader><any>(this.getChild("n1"));
	}
}