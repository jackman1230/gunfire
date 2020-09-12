/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_enemy_fire_11 extends fgui.GComponent {

	public m_tank:fgui.GLoader;
	public m_fire:fgui.GMovieClip;
	public static URL:string = "ui://bq3h5insqz5uks";

	public static createInstance():WXFUI_enemy_fire_11 {
		return <WXFUI_enemy_fire_11>(fgui.UIPackage.createObject("Game", "enemy_fire_11"));
	}

	protected onConstruct():void {
		this.m_tank = <fgui.GLoader>(this.getChild("tank"));
		this.m_fire = <fgui.GMovieClip>(this.getChild("fire"));
	}
}