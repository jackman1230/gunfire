/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

import WXFUI_dirBtn from "./WXFUI_dirBtn";

export default class WXFUI_PlayerDirView extends fgui.GComponent {

	public m_bg:fgui.GImage;
	public m_dirBtn:WXFUI_dirBtn;
	public m_mask:fgui.GLoader;
	public static URL:string = "ui://bq3h5insiasdl1";

	public static createInstance():WXFUI_PlayerDirView {
		return <WXFUI_PlayerDirView>(fgui.UIPackage.createObject("Game", "PlayerDirView"));
	}

	protected onConstruct():void {
		this.m_bg = <fgui.GImage>(this.getChild("bg"));
		this.m_dirBtn = <WXFUI_dirBtn>(this.getChild("dirBtn"));
		this.m_mask = <fgui.GLoader>(this.getChild("mask"));
	}
}