/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_enemy1 extends fgui.GComponent {

	public m_en:fgui.GLoader;
	public static URL:string = "ui://bq3h5insoqgw9y";

	public static createInstance():WXFUI_enemy1 {
		return <WXFUI_enemy1>(fgui.UIPackage.createObject("Game", "enemy1"));
	}

	protected onConstruct():void {
		this.m_en = <fgui.GLoader>(this.getChild("en"));
	}
}