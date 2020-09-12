/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_PopUpView extends fgui.GComponent {

	public m_mask:fgui.GLoader;
	public m_load:fgui.GLoader;
	public m_t0:fgui.Transition;
	public static URL:string = "ui://bq3h5insmtpio6";

	public static createInstance():WXFUI_PopUpView {
		return <WXFUI_PopUpView>(fgui.UIPackage.createObject("Game", "PopUpView"));
	}

	protected onConstruct():void {
		this.m_mask = <fgui.GLoader>(this.getChild("mask"));
		this.m_load = <fgui.GLoader>(this.getChild("load"));
		this.m_t0 = this.getTransition("t0");
	}
}