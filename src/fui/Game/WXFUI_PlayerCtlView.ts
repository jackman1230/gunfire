/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

import WXFUI_fireBtn from "./WXFUI_fireBtn";
import WXFUI_jumpBtn from "./WXFUI_jumpBtn";
import WXFUI_throwBtn from "./WXFUI_throwBtn";

export default class WXFUI_PlayerCtlView extends fgui.GComponent {

	public m_fire:WXFUI_fireBtn;
	public m_jump:WXFUI_jumpBtn;
	public m_bomb:WXFUI_throwBtn;
	public static URL:string = "ui://bq3h5insiasdl0";

	public static createInstance():WXFUI_PlayerCtlView {
		return <WXFUI_PlayerCtlView>(fgui.UIPackage.createObject("Game", "PlayerCtlView"));
	}

	protected onConstruct():void {
		this.m_fire = <WXFUI_fireBtn>(this.getChild("fire"));
		this.m_jump = <WXFUI_jumpBtn>(this.getChild("jump"));
		this.m_bomb = <WXFUI_throwBtn>(this.getChild("bomb"));
	}
}