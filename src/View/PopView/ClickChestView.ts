import PopUpView from "../PopUpView";
import WXFUI_ClickChestView from "../../fui/Game/WXFUI_ClickChestView";
import { SoundManager } from "../../Manager/SoundManager";
import { EventManager } from "../../Manager/EventManager";
import GameEvent from "../../Control/GameEvent";
import { GoodsType } from "../../Data/GameData";
import { GameManager } from "../../Manager/GameManager";
import { ViewManager } from "../../Manager/ViewManager";
import { MooSnowSDK } from "../../Manager/MooSnowSDK";



export default class ClickChestView extends PopUpView {

    public view: WXFUI_ClickChestView;

    constructor() { super() }

    createView(): void {
        this.view = WXFUI_ClickChestView.createInstance();

    }

    private timeOut: number = 0;
    private clickTimeOut: number = 0;
    private clickNum: number = 0;
    private randomNum: number = 7;
    public updateView(): void {
        this.view.m_clickBtn.onClick(this, this.clickBtn);
        this.view.m_bar.value = 0;
        this.view.m_box.url = "ui://Game/chestClose";
        this.clickNum = 0;
        this.randomNum = this.getRandomValue();
    }

    private addTimeOut(): void {
        clearInterval(this.timeOut);
        this.timeOut = setInterval(() => {
            this.decValue();
        }, 500);

    }

    private clickBtn(): void {
        SoundManager.instance.playSound("btn_click");
        var v: number = this.getRandomValue();
        this.view.m_bar.value += v;
        this.addTimeOut();
        if (this.view.m_bar.value >= 100) {
            clearInterval(this.timeOut);
            this.view.m_bar.value = 100;
            this.clickSuccess();
        }
        this.view.m_bar.m_title.text = this.view.m_bar.value + "%";
        this.clickNum++;
        if (this.clickNum == this.randomNum) {
            MooSnowSDK.showBanner(true);
            this.clickTimeOut = setTimeout(() => {
                this.clickSuccess();
            }, 3000);
        }
    }

    private decValue(): void {
        this.view.m_bar.value -= 5;
        if (this.view.m_bar.value <= 0)
            this.view.m_bar.value = 0;
        this.view.m_bar.m_title.text = this.view.m_bar.value + "%";
    }

    public clickSuccess(): void {
        MooSnowSDK.hideBanner();
        clearInterval(this.timeOut);
        clearTimeout(this.clickTimeOut);
        this.view.m_clickBtn.offClick(this, this.clickBtn);
        GameManager.instance.suspendGame();
        ViewManager.instance.hidePopUpView(ViewManager.instance.clickChestView);
        EventManager.instance.dispatcherEvt(GameEvent.CHANGE_PLAYER_GOODS, GoodsType.GoodsType_OPEN_BOX);

    }

    private getRandomValue(): number {
        return Math.ceil(Math.random() * 4) + 5;
    }


}