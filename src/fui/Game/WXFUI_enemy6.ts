/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_enemy6 extends fgui.GComponent {

	public m_en:fgui.GLoader;
	public static URL:string = "ui://bq3h5instvmxxoo";

	public static createInstance():WXFUI_enemy6 {
		return <WXFUI_enemy6>(fgui.UIPackage.createObject("Game", "enemy6"));
	}

	protected onConstruct():void {
		this.m_en = <fgui.GLoader>(this.getChild("en"));
	}
}