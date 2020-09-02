/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_enemy10 extends fgui.GComponent {

	public m_load:fgui.GLoader;
	public static URL:string = "ui://bq3h5insqz5ukr";

	public static createInstance():WXFUI_enemy10 {
		return <WXFUI_enemy10>(fgui.UIPackage.createObject("Game", "enemy10"));
	}

	protected onConstruct():void {
		this.m_load = <fgui.GLoader>(this.getChild("load"));
	}
}