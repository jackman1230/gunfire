/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_enemyStay_5 extends fgui.GComponent {

	public m_en:fgui.GLoader;
	public m_people:fgui.GMovieClip;
	public static URL:string = "ui://bq3h5insdhktei";

	public static createInstance():WXFUI_enemyStay_5 {
		return <WXFUI_enemyStay_5>(fgui.UIPackage.createObject("Game", "enemyStay_5"));
	}

	protected onConstruct():void {
		this.m_en = <fgui.GLoader>(this.getChild("en"));
		this.m_people = <fgui.GMovieClip>(this.getChild("people"));
	}
}