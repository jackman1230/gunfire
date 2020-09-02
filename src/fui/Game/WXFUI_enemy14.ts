/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_enemy14 extends fgui.GComponent {

	public m_load:fgui.GLoader;
	public static URL:string = "ui://bq3h5instvmxxou";

	public static createInstance():WXFUI_enemy14 {
		return <WXFUI_enemy14>(fgui.UIPackage.createObject("Game", "enemy14"));
	}

	protected onConstruct():void {
		this.m_load = <fgui.GLoader>(this.getChild("load"));
	}
}