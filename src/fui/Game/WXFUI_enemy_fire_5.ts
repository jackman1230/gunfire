/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_enemy_fire_5 extends fgui.GComponent {

	public m_mor:fgui.GLoader;
	public m_people:fgui.GMovieClip;
	public static URL:string = "ui://bq3h5insdhktej";

	public static createInstance():WXFUI_enemy_fire_5 {
		return <WXFUI_enemy_fire_5>(fgui.UIPackage.createObject("Game", "enemy_fire_5"));
	}

	protected onConstruct():void {
		this.m_mor = <fgui.GLoader>(this.getChild("mor"));
		this.m_people = <fgui.GMovieClip>(this.getChild("people"));
	}
}