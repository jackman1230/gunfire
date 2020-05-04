/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

import WXFUI_BtnCtlView from "./WXFUI_BtnCtlView";

export default class WXFUI_BackGround extends fairygui.GComponent {

	public m_bg:fairygui.GLoader;
	public m_btnCtl:WXFUI_BtnCtlView;

	public static URL:string = "ui://bq3h5insgww20";

	public static createInstance():WXFUI_BackGround {
		return <WXFUI_BackGround><any>(fairygui.UIPackage.createObject("Game","BackGround"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_bg = <fairygui.GLoader><any>(this.getChildAt(0));
		this.m_btnCtl = <WXFUI_BtnCtlView><any>(this.getChildAt(1));
	}
}