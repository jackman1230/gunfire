/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_freeBtn extends fairygui.GButton {

	public m_button:fairygui.Controller;
	public m_n6:fairygui.GImage;
	public m_t0:fairygui.Transition;

	public static URL:string = "ui://bq3h5insdr1tnp";

	public static createInstance():WXFUI_freeBtn {
		return <WXFUI_freeBtn><any>(fairygui.UIPackage.createObject("Game","freeBtn"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_button = this.getController("button");
		this.m_n6 = <fairygui.GImage><any>(this.getChild("n6"));
		this.m_t0 = this.getTransition("t0");
	}
}