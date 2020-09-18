/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_quedingBtn extends fairygui.GButton {

	public m_button:fairygui.Controller;
	public m_n0:fairygui.GImage;

	public static URL:string = "ui://bq3h5insbuh7xvs";

	public static createInstance():WXFUI_quedingBtn {
		return <WXFUI_quedingBtn><any>(fairygui.UIPackage.createObject("Game","quedingBtn"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_button = this.getController("button");
		this.m_n0 = <fairygui.GImage><any>(this.getChild("n0"));
	}
}