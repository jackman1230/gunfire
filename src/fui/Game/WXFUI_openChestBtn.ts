/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_openChestBtn extends fairygui.GButton {

	public m_button:fairygui.Controller;
	public m_n0:fairygui.GImage;
	public m_n1:fairygui.GImage;
	public m_n2:fairygui.GTextField;

	public static URL:string = "ui://bq3h5insvmpqxu9";

	public static createInstance():WXFUI_openChestBtn {
		return <WXFUI_openChestBtn><any>(fairygui.UIPackage.createObject("Game","openChestBtn"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_button = this.getController("button");
		this.m_n0 = <fairygui.GImage><any>(this.getChild("n0"));
		this.m_n1 = <fairygui.GImage><any>(this.getChild("n1"));
		this.m_n2 = <fairygui.GTextField><any>(this.getChild("n2"));
	}
}