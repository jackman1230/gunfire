/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_Bomb extends fgui.GComponent {

	public m_boom:fgui.GLoader;
	public m_boom2:fgui.GLoader;
	public m_boom3:fgui.GLoader;
	public m_z2:fgui.Transition;
	public m_t3:fgui.Transition;
	public m_t4:fgui.Transition;
	public static URL:string = "ui://bq3h5insgww20";

	public static createInstance():WXFUI_Bomb {
		return <WXFUI_Bomb>(fgui.UIPackage.createObject("Game", "Bomb"));
	}

	protected onConstruct():void {
		this.m_boom = <fgui.GLoader>(this.getChild("boom"));
		this.m_boom2 = <fgui.GLoader>(this.getChild("boom2"));
		this.m_boom3 = <fgui.GLoader>(this.getChild("boom3"));
		this.m_z2 = this.getTransition("z2");
		this.m_t3 = this.getTransition("t3");
		this.m_t4 = this.getTransition("t4");
	}
}