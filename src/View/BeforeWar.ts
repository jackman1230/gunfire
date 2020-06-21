import WXFUI_BeforeWar from "../fui/Game/WXFUI_BeforeWar";
import PopUpView from "./PopUpView";
import { GameManager } from "../Manager/GameManager";
import { ViewManager } from "../Manager/ViewManager";
import { SoundManager } from "../Manager/SoundManager";

export default class BeforeWar extends PopUpView {

    public view: WXFUI_BeforeWar;

    constructor() { super() }

    createView(): void {
        this.view = WXFUI_BeforeWar.createInstance();

        this.view.m_enter.onClick(this, this.enterGame);
    }

    private enterGame(): void {
        SoundManager.instance.playSound("btn_click");
        GameManager.instance.enterGame();
        ViewManager.instance.hidePopUpView(this, true);
    }





}