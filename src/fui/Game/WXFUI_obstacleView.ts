/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_obstacleView extends fgui.GComponent {

	public m_load:fgui.GLoader;
	public static URL:string = "ui://bq3h5insqz5uku";

	public static createInstance():WXFUI_obstacleView {
		return <WXFUI_obstacleView>(fgui.UIPackage.createObject("Game", "obstacleView"));
	}

	protected onConstruct():void {
		this.m_load = <fgui.GLoader>(this.getChild("load"));
	}
}