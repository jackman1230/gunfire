/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_PopUpView extends fairygui.GComponent {

	public m_mask:fairygui.GLoader;
	public m_load:fairygui.GLoader;
	public m_t0:fairygui.Transition;

	public static URL:string = "ui://bq3h5insmtpio6";

	public static createInstance():WXFUI_PopUpView {
		return <WXFUI_PopUpView><any>(fairygui.UIPackage.createObject("Game","PopUpView"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_mask = <fairygui.GLoader><any>(this.getChild("mask"));
		this.m_load = <fairygui.GLoader><any>(this.getChild("load"));
		this.m_t0 = this.getTransition("t0");
	}
}