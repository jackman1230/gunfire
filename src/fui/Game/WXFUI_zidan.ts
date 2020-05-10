/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_zidan extends fairygui.GComponent {

	public m_zidan:fairygui.GLoader;

	public static URL:string = "ui://bq3h5insyqv7ax";

	public static createInstance():WXFUI_zidan {
		return <WXFUI_zidan><any>(fairygui.UIPackage.createObject("Game","zidan"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_zidan = <fairygui.GLoader><any>(this.getChildAt(0));
	}
}