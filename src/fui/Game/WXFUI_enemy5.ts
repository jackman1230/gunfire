/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_enemy5 extends fgui.GComponent {

	public m_en:fgui.GLoader;
	public static URL:string = "ui://bq3h5insdhktem";

	public static createInstance():WXFUI_enemy5 {
		return <WXFUI_enemy5>(fgui.UIPackage.createObject("Game", "enemy5"));
	}

	protected onConstruct():void {
		this.m_en = <fgui.GLoader>(this.getChild("en"));
	}
}