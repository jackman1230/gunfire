/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_clickBtn extends fgui.GButton {

	public m_button:fgui.Controller;
	public m_n0:fgui.GImage;
	public static URL:string = "ui://bq3h5insm5yyxvm";

	public static createInstance():WXFUI_clickBtn {
		return <WXFUI_clickBtn>(fgui.UIPackage.createObject("Game", "clickBtn"));
	}

	protected onConstruct():void {
		this.m_button = this.getController("button");
		this.m_n0 = <fgui.GImage>(this.getChild("n0"));
	}
}