/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

import WXFUI_volume from "./WXFUI_volume";

export default class WXFUI_setting extends fairygui.GComponent {

	public m_vol:WXFUI_volume;

	public static URL:string = "ui://bq3h5insugvixpg";

	public static createInstance():WXFUI_setting {
		return <WXFUI_setting><any>(fairygui.UIPackage.createObject("Game","setting"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_vol = <WXFUI_volume><any>(this.getChild("vol"));
	}
}