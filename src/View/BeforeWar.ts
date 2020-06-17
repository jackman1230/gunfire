import WXFUI_BeforeWar from "../fui/Game/WXFUI_BeforeWar";
import PopUpView from "./PopUpView";

export default class BeforeWar extends PopUpView {

    public view: WXFUI_BeforeWar;

    constructor() { super(WXFUI_BeforeWar.URL) }

    createView(): void {
        this.view = WXFUI_BeforeWar.createInstance();
    }





}