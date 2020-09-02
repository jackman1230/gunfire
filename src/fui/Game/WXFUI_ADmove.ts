/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

import WXFUI_ADItem from "./WXFUI_ADItem";

export default class WXFUI_ADmove extends fgui.GComponent {

	public m_ad:WXFUI_ADItem;
	public m_ani_1:fgui.Transition;
	public m_ani_2:fgui.Transition;
	public static URL:string = "ui://bq3h5inss2x8xs4";

	public static createInstance():WXFUI_ADmove {
		return <WXFUI_ADmove>(fgui.UIPackage.createObject("Game", "ADmove"));
	}

	protected onConstruct():void {
		this.m_ad = <WXFUI_ADItem>(this.getChild("ad"));
		this.m_ani_1 = this.getTransition("ani_1");
		this.m_ani_2 = this.getTransition("ani_2");
	}
}