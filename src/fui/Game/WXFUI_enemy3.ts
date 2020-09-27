/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_enemy3 extends fgui.GComponent {

	public m_en:fgui.GLoader;
	public static URL:string = "ui://bq3h5insoqgwa1";

	public static createInstance():WXFUI_enemy3 {
		return <WXFUI_enemy3>(fgui.UIPackage.createObject("Game", "enemy3"));
	}

	protected onConstruct():void {
		this.m_en = <fgui.GLoader>(this.getChild("en"));
	}
}