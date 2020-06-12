/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

import WXFUI_dirBtn from "./WXFUI_dirBtn";

export default class WXFUI_dirCtl extends fairygui.GComponent {

	public m_n7:fairygui.GImage;
	public m_funBtn:WXFUI_dirBtn;

	public static URL:string = "ui://bq3h5inscqp93k";

	public static createInstance():WXFUI_dirCtl {
		return <WXFUI_dirCtl><any>(fairygui.UIPackage.createObject("Game","dirCtl"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_n7 = <fairygui.GImage><any>(this.getChild("n7"));
		this.m_funBtn = <WXFUI_dirBtn><any>(this.getChild("funBtn"));
	}
}