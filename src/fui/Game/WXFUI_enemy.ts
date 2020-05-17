/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_enemy extends fairygui.GComponent {

	public m_ctl:fairygui.Controller;
	public m_enemy:fairygui.GLoader;
	public m_n21:fairygui.GImage;
	public m_n27:fairygui.GImage;
	public m_gre:fairygui.Transition;
	public m_mis:fairygui.Transition;

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
		this.m_n21 = <fairygui.GImage><any>(this.getChildAt(1));
		this.m_n27 = <fairygui.GImage><any>(this.getChildAt(2));
		this.m_gre = this.getTransitionAt(0);
		this.m_mis = this.getTransitionAt(1);
	}
}