/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

import WXFUI_ADItem from "./WXFUI_ADItem";
import WXFUI_continueBtn from "./WXFUI_continueBtn";

export default class WXFUI_ADReMenList extends fgui.GComponent {

	public m_n6:fgui.GGraph;
	public m_ad_3:WXFUI_ADItem;
	public m_ad_2:WXFUI_ADItem;
	public m_ad_1:WXFUI_ADItem;
	public m_ad_6:WXFUI_ADItem;
	public m_ad_5:WXFUI_ADItem;
	public m_ad_4:WXFUI_ADItem;
	public m_n21:fgui.GImage;
	public m_jixu:WXFUI_continueBtn;
	public static URL:string = "ui://bq3h5insko37xui";

	public static createInstance():WXFUI_ADReMenList {
		return <WXFUI_ADReMenList>(fgui.UIPackage.createObject("Game", "ADReMenList"));
	}

	protected onConstruct():void {
		this.m_n6 = <fgui.GGraph>(this.getChild("n6"));
		this.m_ad_3 = <WXFUI_ADItem>(this.getChild("ad_3"));
		this.m_ad_2 = <WXFUI_ADItem>(this.getChild("ad_2"));
		this.m_ad_1 = <WXFUI_ADItem>(this.getChild("ad_1"));
		this.m_ad_6 = <WXFUI_ADItem>(this.getChild("ad_6"));
		this.m_ad_5 = <WXFUI_ADItem>(this.getChild("ad_5"));
		this.m_ad_4 = <WXFUI_ADItem>(this.getChild("ad_4"));
		this.m_n21 = <fgui.GImage>(this.getChild("n21"));
		this.m_jixu = <WXFUI_continueBtn>(this.getChild("jixu"));
	}
}