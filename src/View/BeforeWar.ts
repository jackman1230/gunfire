import WXFUI_BeforeWar from "../fui/Game/WXFUI_BeforeWar";
import PopUpView from "./PopUpView";
import { GameManager } from "../Manager/GameManager";

export default class BeforeWar extends PopUpView {

    public view: WXFUI_BeforeWar;

    constructor() { super() }

    createView(): void {
        this.view = WXFUI_BeforeWar.createInstance();

        this.view.m_enter.onClick(this, this.enterGame);
    }

    private enterGame(): void {
        GameManager.instance.enterGame();
    }





}