/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_dirBtn extends fairygui.GComponent {

	public m_n1:fairygui.GImage;

	public static URL:string = "ui://bq3h5insiasdl2";

	public static createInstance():WXFUI_dirBtn {
		return <WXFUI_dirBtn><any>(fairygui.UIPackage.createObject("Game","dirBtn"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_n1 = <fairygui.GImage><any>(this.getChild("n1"));
	}
}