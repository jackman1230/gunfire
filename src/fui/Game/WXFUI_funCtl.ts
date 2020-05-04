/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

import WXFUI_fireBtn from "./WXFUI_fireBtn";
import WXFUI_jumpBtn from "./WXFUI_jumpBtn";
import WXFUI_throwBtn from "./WXFUI_throwBtn";
import WXFUI_weaponBtn from "./WXFUI_weaponBtn";

export default class WXFUI_funCtl extends fairygui.GComponent {

	public m_n0:WXFUI_fireBtn;
	public m_jump:WXFUI_jumpBtn;
	public m_throw:WXFUI_throwBtn;
	public m_weapon:WXFUI_weaponBtn;

	public static URL:string = "ui://bq3h5inscqp93m";

	public static createInstance():WXFUI_funCtl {
		return <WXFUI_funCtl><any>(fairygui.UIPackage.createObject("Game","funCtl"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_n0 = <WXFUI_fireBtn><any>(this.getChildAt(0));
		this.m_jump = <WXFUI_jumpBtn><any>(this.getChildAt(1));
		this.m_throw = <WXFUI_throwBtn><any>(this.getChildAt(2));
		this.m_weapon = <WXFUI_weaponBtn><any>(this.getChildAt(3));
	}
}