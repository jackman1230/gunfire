
import WXFUI_SuspendView from "../fui/Game/WXFUI_SuspendView";
import { GameManager } from "../Manager/GameManager";
import PopUpView from "./PopUpView";
import { SoundManager } from "../Manager/SoundManager";
import { ViewManager } from "../Manager/ViewManager";

export default class SuspendView extends PopUpView {

    public view: WXFUI_SuspendView;

    constructor() { super() }

    createView(): void {
        this.view = WXFUI_SuspendView.createInstance();

        this.view.m_back.onClick(this, this.goFirstPage);
        this.view.m_continue.onClick(this, this.continueGame);
        this.view.m_restart.onClick(this, this.restartGame);
    }

    private goFirstPage(): void {
        GameManager.instance.suspendGame();
        SoundManager.instance.playSound("btn_click");
        GameManager.instance.goFirstPage();
    }

    private continueGame(): void {
        GameManager.instance.suspendGame();
        SoundManager.instance.playSound("btn_click");
        ViewManager.instance.hidePopUpView(null, true);
    }

    private restartGame(): void {
        GameManager.instance.suspendGame();
        SoundManager.instance.playSound("btn_click");
        GameManager.instance.restartGame();
    }

}