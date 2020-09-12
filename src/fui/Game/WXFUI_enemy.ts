/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_enemy extends fgui.GComponent {

	public m_enemy:fgui.GLoader;
	public static URL:string = "ui://bq3h5insoqgwa5";

	public static createInstance():WXFUI_enemy {
		return <WXFUI_enemy>(fgui.UIPackage.createObject("Game", "enemy"));
	}

	protected onConstruct():void {
		this.m_enemy = <fgui.GLoader>(this.getChild("enemy"));
	}
}