/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_addGold extends fairygui.GComponent {

	public m_num:fairygui.GTextField;
	public m_icon:fairygui.GLoader;
	public m_com:fairygui.GGroup;
	public m_ani:fairygui.Transition;

	public static URL:string = "ui://bq3h5ins8mn4xsz";

	public static createInstance():WXFUI_addGold {
		return <WXFUI_addGold><any>(fairygui.UIPackage.createObject("Game","addGold"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_num = <fairygui.GTextField><any>(this.getChild("num"));
		this.m_icon = <fairygui.GLoader><any>(this.getChild("icon"));
		this.m_com = <fairygui.GGroup><any>(this.getChild("com"));
		this.m_ani = this.getTransition("ani");
	}
}