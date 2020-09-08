/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_jumpBtn extends fairygui.GButton {

	public m_button:fairygui.Controller;
	public m_n3:fairygui.GImage;
	public m_n4:fairygui.GImage;

	public static URL:string = "ui://bq3h5inscqp93n";

	public static createInstance():WXFUI_jumpBtn {
		return <WXFUI_jumpBtn><any>(fairygui.UIPackage.createObject("Game","jumpBtn"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_button = this.getController("button");
		this.m_n3 = <fairygui.GImage><any>(this.getChild("n3"));
		this.m_n4 = <fairygui.GImage><any>(this.getChild("n4"));
	}
}