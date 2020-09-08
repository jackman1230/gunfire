/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

import WXFUI_clickBar from "./WXFUI_clickBar";
import WXFUI_clickBtn from "./WXFUI_clickBtn";
import WXFUI_RewardView from "./WXFUI_RewardView";

export default class WXFUI_ClickADView extends fairygui.GComponent {

	public m_n4:fairygui.GGraph;
	public m_hand:fairygui.GLoader;
	public m_finger:fairygui.GMovieClip;
	public m_bar:WXFUI_clickBar;
	public m_btn:WXFUI_clickBtn;
	public m_reward:WXFUI_RewardView;

	public static URL:string = "ui://bq3h5insm5yyxvj";

	public static createInstance():WXFUI_ClickADView {
		return <WXFUI_ClickADView><any>(fairygui.UIPackage.createObject("Game","ClickADView"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_n4 = <fairygui.GGraph><any>(this.getChild("n4"));
		this.m_hand = <fairygui.GLoader><any>(this.getChild("hand"));
		this.m_finger = <fairygui.GMovieClip><any>(this.getChild("finger"));
		this.m_bar = <WXFUI_clickBar><any>(this.getChild("bar"));
		this.m_btn = <WXFUI_clickBtn><any>(this.getChild("btn"));
		this.m_reward = <WXFUI_RewardView><any>(this.getChild("reward"));
	}
}