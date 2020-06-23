/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

import WXFUI_dirBtn from "./WXFUI_dirBtn";

export default class WXFUI_dirCtlView extends fairygui.GComponent {

	public m_bg:fairygui.GImage;
	public m_dirBtn:WXFUI_dirBtn;
	public m_mask:fairygui.GLoader;

	public static URL:string = "ui://bq3h5insiasdl1";

	public static createInstance():WXFUI_dirCtlView {
		return <WXFUI_dirCtlView><any>(fairygui.UIPackage.createObject("Game","dirCtlView"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_bg = <fairygui.GImage><any>(this.getChild("bg"));
		this.m_dirBtn = <WXFUI_dirBtn><any>(this.getChild("dirBtn"));
		this.m_mask = <fairygui.GLoader><any>(this.getChild("mask"));
	}
}