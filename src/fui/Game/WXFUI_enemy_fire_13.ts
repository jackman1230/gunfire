/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_enemy_fire_13 extends fgui.GComponent {

	public m_n1:fgui.GLoader;
	public static URL:string = "ui://bq3h5instvmxxov";

	public static createInstance():WXFUI_enemy_fire_13 {
		return <WXFUI_enemy_fire_13>(fgui.UIPackage.createObject("Game", "enemy_fire_13"));
	}

	protected onConstruct():void {
		this.m_n1 = <fgui.GLoader>(this.getChild("n1"));
	}
}