/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_enemy11 extends fgui.GComponent {

	public m_load:fgui.GLoader;
	public static URL:string = "ui://bq3h5insdx35l4";

	public static createInstance():WXFUI_enemy11 {
		return <WXFUI_enemy11>(fgui.UIPackage.createObject("Game", "enemy11"));
	}

	protected onConstruct():void {
		this.m_load = <fgui.GLoader>(this.getChild("load"));
	}
}