/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_clickBar extends fairygui.GProgressBar {

	public m_n0:fairygui.GImage;
	public m_bar:fairygui.GImage;

	public static URL:string = "ui://bq3h5insm5yyxvk";

	public static createInstance():WXFUI_clickBar {
		return <WXFUI_clickBar><any>(fairygui.UIPackage.createObject("Game","clickBar"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_n0 = <fairygui.GImage><any>(this.getChild("n0"));
		this.m_bar = <fairygui.GImage><any>(this.getChild("bar"));
	}
}