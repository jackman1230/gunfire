
import WXFUI_AfterWar from "../fui/Game/WXFUI_AfterWar";
import PopUpView from "./PopUpView";
import { GameManager } from "../Manager/GameManager";
import { SoundManager } from "../Manager/SoundManager";

export default class AfterWar extends PopUpView {

    public view: WXFUI_AfterWar;
    private viewType: number = 1;
    constructor() { super() }

    createView(): void {
        this.view = WXFUI_AfterWar.createInstance();

        this.view.m_continue_1.onClick(this, this.continueGame);
        this.view.m_continue_2.onClick(this, this.restartGame);
        this.view.m_continue_3.onClick(this, this.continueGameByVideo);
        this.view.m_return.onClick(this, this.returnHandle);
        this.view.m_abandon.onClick(this, this.returnHandle);

        this.view.m_coin.text = " 0";
    }

    public updateView(type: number): void {
        this.viewType = type;
        this.updateCoin();
        if (type == 3) {
            this.view.m_abandon.visible = false;
            Laya.timer.once(2000, this, this.showAbondon);
        }
    }

    private showAbondon(): void {
        this.view.m_abandon.visible = true;
    }

    private updateCoin(): void {
        this.view.m_coin.text = " " + GameManager.instance.roleInfo.curlvCoin + " ";
    }
    private continueGame(): void {
        SoundManager.instance.playSound("btn_click");
        // ViewManager.instance.showChapterView();
        GameManager.instance.goFirstPage();
    }

    private restartGame(): void {
        SoundManager.instance.playSound("btn_click");
        GameManager.instance.restartGame();
    }

    private continueGameByVideo(): void {
        SoundManager.instance.playSound("btn_click");
        // this.restartGame();
        GameManager.instance.continueGameByVideo();
    }

    private returnHandle(): void {
        SoundManager.instance.playSound("btn_click");
        GameManager.instance.goFirstPage();
    }
}