/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_enemy13 extends fgui.GComponent {

	public m_load:fgui.GLoader;
	public static URL:string = "ui://bq3h5instvmxxot";

	public static createInstance():WXFUI_enemy13 {
		return <WXFUI_enemy13>(fgui.UIPackage.createObject("Game", "enemy13"));
	}

	protected onConstruct():void {
		this.m_load = <fgui.GLoader>(this.getChild("load"));
	}
}