/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_TipsPopView extends fairygui.GComponent {

	public m_tips:fairygui.GTextField;
	public m_play:fairygui.Transition;

	public static URL:string = "ui://bq3h5insugvixpf";

	public static createInstance():WXFUI_TipsPopView {
		return <WXFUI_TipsPopView><any>(fairygui.UIPackage.createObject("Game","TipsPopView"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_tips = <fairygui.GTextField><any>(this.getChild("tips"));
		this.m_play = this.getTransition("play");
	}
}