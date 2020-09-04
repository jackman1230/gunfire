/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

import WXFUI_clickBar from "./WXFUI_clickBar";
import WXFUI_clickBtn from "./WXFUI_clickBtn";

export default class WXFUI_ClickADView extends fgui.GComponent {

	public m_n4:fgui.GGraph;
	public m_hand:fgui.GLoader;
	public m_finger:fgui.GMovieClip;
	public m_bar:WXFUI_clickBar;
	public m_btn:WXFUI_clickBtn;
	public static URL:string = "ui://bq3h5insm5yyxvj";

	public static createInstance():WXFUI_ClickADView {
		return <WXFUI_ClickADView>(fgui.UIPackage.createObject("Game", "ClickADView"));
	}

	protected onConstruct():void {
		this.m_n4 = <fgui.GGraph>(this.getChild("n4"));
		this.m_hand = <fgui.GLoader>(this.getChild("hand"));
		this.m_finger = <fgui.GMovieClip>(this.getChild("finger"));
		this.m_bar = <WXFUI_clickBar>(this.getChild("bar"));
		this.m_btn = <WXFUI_clickBtn>(this.getChild("btn"));
	}
}