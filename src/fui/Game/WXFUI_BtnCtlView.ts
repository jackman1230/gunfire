/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

import WXFUI_dirCtl from "./WXFUI_dirCtl";
import WXFUI_funCtl from "./WXFUI_funCtl";

export default class WXFUI_BtnCtlView extends fairygui.GComponent {

	public m_dirCtl:WXFUI_dirCtl;
	public m_funCtl:WXFUI_funCtl;

	public static URL:string = "ui://bq3h5inscqp93g";

	public static createInstance():WXFUI_BtnCtlView {
		return <WXFUI_BtnCtlView><any>(fairygui.UIPackage.createObject("Game","BtnCtlView"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_dirCtl = <WXFUI_dirCtl><any>(this.getChildAt(0));
		this.m_funCtl = <WXFUI_funCtl><any>(this.getChildAt(1));
	}
}