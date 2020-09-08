/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

import WXFUI_quedingBtn from "./WXFUI_quedingBtn";

export default class WXFUI_RewardView extends fairygui.GComponent {

	public m_n12:fairygui.GGraph;
	public m_n6:fairygui.GImage;
	public m_n7:fairygui.GImage;
	public m_btn:WXFUI_quedingBtn;
	public m_n10:fairygui.GLoader;
	public m_n11:fairygui.GTextField;

	public static URL:string = "ui://bq3h5insbuh7xvr";

	public static createInstance():WXFUI_RewardView {
		return <WXFUI_RewardView><any>(fairygui.UIPackage.createObject("Game","RewardView"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_n12 = <fairygui.GGraph><any>(this.getChild("n12"));
		this.m_n6 = <fairygui.GImage><any>(this.getChild("n6"));
		this.m_n7 = <fairygui.GImage><any>(this.getChild("n7"));
		this.m_btn = <WXFUI_quedingBtn><any>(this.getChild("btn"));
		this.m_n10 = <fairygui.GLoader><any>(this.getChild("n10"));
		this.m_n11 = <fairygui.GTextField><any>(this.getChild("n11"));
	}
}