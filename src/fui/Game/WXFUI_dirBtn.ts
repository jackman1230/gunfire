/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_dirBtn extends fgui.GComponent {

	public m_n1:fgui.GImage;
	public static URL:string = "ui://bq3h5insiasdl2";

	public static createInstance():WXFUI_dirBtn {
		return <WXFUI_dirBtn>(fgui.UIPackage.createObject("Game", "dirBtn"));
	}

	protected onConstruct():void {
		this.m_n1 = <fgui.GImage>(this.getChild("n1"));
	}
}