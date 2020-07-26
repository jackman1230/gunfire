/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_damageView extends fairygui.GComponent {

	public m_num:fairygui.GTextField;
	public m_ani:fairygui.Transition;

	public static URL:string = "ui://bq3h5ins8mn4xsm";

	public static createInstance():WXFUI_damageView {
		return <WXFUI_damageView><any>(fairygui.UIPackage.createObject("Game","damageView"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_num = <fairygui.GTextField><any>(this.getChild("num"));
		this.m_ani = this.getTransition("ani");
	}
}