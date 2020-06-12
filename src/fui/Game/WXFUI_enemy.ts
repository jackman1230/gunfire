/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_enemy extends fairygui.GComponent {

	public m_enemy:fairygui.GLoader;

	public static URL:string = "ui://bq3h5insoqgwa5";

	public static createInstance():WXFUI_enemy {
		return <WXFUI_enemy><any>(fairygui.UIPackage.createObject("Game","enemy"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_enemy = <fairygui.GLoader><any>(this.getChild("enemy"));
	}
}