/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_loadingBar extends fairygui.GProgressBar {

	public m_n0:fairygui.GImage;
	public m_bar:fairygui.GImage;
	public m_title:fairygui.GTextField;

	public static URL:string = "ui://bq3h5insvmpqxu5";

	public static createInstance():WXFUI_loadingBar {
		return <WXFUI_loadingBar><any>(fairygui.UIPackage.createObject("Game","loadingBar"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_n0 = <fairygui.GImage><any>(this.getChild("n0"));
		this.m_bar = <fairygui.GImage><any>(this.getChild("bar"));
		this.m_title = <fairygui.GTextField><any>(this.getChild("title"));
	}
}