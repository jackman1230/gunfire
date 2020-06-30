/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_enemy_fire_13 extends fairygui.GComponent {

	public m_n1:fairygui.GLoader;

	public static URL:string = "ui://bq3h5instvmxxov";

	public static createInstance():WXFUI_enemy_fire_13 {
		return <WXFUI_enemy_fire_13><any>(fairygui.UIPackage.createObject("Game","enemy_fire_13"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_n1 = <fairygui.GLoader><any>(this.getChild("n1"));
	}
}