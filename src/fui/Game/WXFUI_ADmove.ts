/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

import WXFUI_ADItem from "./WXFUI_ADItem";

export default class WXFUI_ADmove extends fairygui.GComponent {

	public m_ad:WXFUI_ADItem;
	public m_ani_1:fairygui.Transition;
	public m_ani_2:fairygui.Transition;

	public static URL:string = "ui://bq3h5inss2x8xs4";

	public static createInstance():WXFUI_ADmove {
		return <WXFUI_ADmove><any>(fairygui.UIPackage.createObject("Game","ADmove"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_ad = <WXFUI_ADItem><any>(this.getChild("ad"));
		this.m_ani_1 = this.getTransition("ani_1");
		this.m_ani_2 = this.getTransition("ani_2");
	}
}