/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_enemy12 extends fgui.GComponent {

	public m_load:fgui.GLoader;
	public static URL:string = "ui://bq3h5insdx35l5";

	public static createInstance():WXFUI_enemy12 {
		return <WXFUI_enemy12>(fgui.UIPackage.createObject("Game", "enemy12"));
	}

	protected onConstruct():void {
		this.m_load = <fgui.GLoader>(this.getChild("load"));
	}
}