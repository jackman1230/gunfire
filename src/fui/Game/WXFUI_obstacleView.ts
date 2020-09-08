/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_obstacleView extends fairygui.GComponent {

	public m_load:fairygui.GLoader;

	public static URL:string = "ui://bq3h5insqz5uku";

	public static createInstance():WXFUI_obstacleView {
		return <WXFUI_obstacleView><any>(fairygui.UIPackage.createObject("Game","obstacleView"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_load = <fairygui.GLoader><any>(this.getChild("load"));
	}
}