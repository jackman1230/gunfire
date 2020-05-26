/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_enemy extends fairygui.GComponent {

	public m_ctl:fairygui.Controller;
	public m_enemy:fairygui.GLoader;
	public m_firePos1:fairygui.GTextField;
	public m_firePos2:fairygui.GTextField;
	public m_firePos3:fairygui.GTextField;
	public m_firePos4:fairygui.GTextField;
	public m_firePos5:fairygui.GTextField;

	public static URL:string = "ui://bq3h5insoqgwa5";

	public static createInstance():WXFUI_enemy {
		return <WXFUI_enemy><any>(fairygui.UIPackage.createObject("Game","enemy"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_ctl = this.getControllerAt(0);
		this.m_enemy = <fairygui.GLoader><any>(this.getChildAt(0));
		this.m_firePos1 = <fairygui.GTextField><any>(this.getChildAt(1));
		this.m_firePos2 = <fairygui.GTextField><any>(this.getChildAt(2));
		this.m_firePos3 = <fairygui.GTextField><any>(this.getChildAt(3));
		this.m_firePos4 = <fairygui.GTextField><any>(this.getChildAt(4));
		this.m_firePos5 = <fairygui.GTextField><any>(this.getChildAt(5));
	}
}