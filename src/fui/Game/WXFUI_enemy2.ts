/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_enemy2 extends fgui.GComponent {

	public m_en:fgui.GLoader;
	public static URL:string = "ui://bq3h5insoqgwa0";

	public static createInstance():WXFUI_enemy2 {
		return <WXFUI_enemy2>(fgui.UIPackage.createObject("Game", "enemy2"));
	}

	protected onConstruct():void {
		this.m_en = <fgui.GLoader>(this.getChild("en"));
	}
}