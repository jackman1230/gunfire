import PopUpView from "../PopUpView";
import WXFUI_SuspendView from "../../fui/Game/WXFUI_SuspendView";
import { SoundManager } from "../../Manager/SoundManager";
import { GameManager } from "../../Manager/GameManager";
import { ViewManager } from "../../Manager/ViewManager";
import { MooSnowSDK } from "../../Manager/MooSnowSDK";



export default class SuspendView extends PopUpView {

    public view: WXFUI_SuspendView;

    constructor() { super() }

    createView(): void {
        this.view = WXFUI_SuspendView.createInstance();

        this.view.m_back.onClick(this, this.goFirstPage);
        this.view.m_continue.onClick(this, this.continueGame);
        this.view.m_restart.onClick(this, this.restartGame);

    }

    public showViewNoTween(): void {
        super.showViewNoTween();
        MooSnowSDK.showBanner(false);
    }

    private goFirstPage(): void {
        SoundManager.instance.playSound("btn_click");
        GameManager.instance.suspendGame();
        MooSnowSDK.endGame(GameManager.instance.choiseLevel, true);
        Laya.timer.frameOnce(1, this, () => {
            ViewManager.instance.hideSuspendView();
            GameManager.instance.goFirstPage();
        })
    }

    private continueGame(): void {
        SoundManager.instance.playSound("btn_click");
        GameManager.instance.suspendGame();
        Laya.timer.frameOnce(1, this, () => {
            ViewManager.instance.hideSuspendView();
        })
    }

    private restartGame(): void {
        SoundManager.instance.playSound("btn_click");
        GameManager.instance.suspendGame();
        MooSnowSDK.endGame(GameManager.instance.choiseLevel, true);
        Laya.timer.frameOnce(1, this, () => {
            ViewManager.instance.hideSuspendView();
            GameManager.instance.restartGame();
        })
    }
    public hideAllView(): void {
        super.hideAllView();
        MooSnowSDK.hideBanner();
    }

}