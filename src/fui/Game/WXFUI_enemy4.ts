/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_enemy4 extends fgui.GComponent {

	public m_en:fgui.GLoader;
	public static URL:string = "ui://bq3h5insoqgwa2";

	public static createInstance():WXFUI_enemy4 {
		return <WXFUI_enemy4>(fgui.UIPackage.createObject("Game", "enemy4"));
	}

	protected onConstruct():void {
		this.m_en = <fgui.GLoader>(this.getChild("en"));
	}
}