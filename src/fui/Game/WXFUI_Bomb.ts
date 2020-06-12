/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_Bomb extends fairygui.GComponent {

	public m_boom:fairygui.GLoader;
	public m_boom2:fairygui.GLoader;
	public m_z2:fairygui.Transition;
	public m_t3:fairygui.Transition;

	public static URL:string = "ui://bq3h5insgww20";

	public static createInstance():WXFUI_Bomb {
		return <WXFUI_Bomb><any>(fairygui.UIPackage.createObject("Game","Bomb"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_boom = <fairygui.GLoader><any>(this.getChild("boom"));
		this.m_boom2 = <fairygui.GLoader><any>(this.getChild("boom2"));
		this.m_z2 = this.getTransition("z2");
		this.m_t3 = this.getTransition("t3");
	}
}