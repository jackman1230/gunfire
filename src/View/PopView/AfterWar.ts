import PopUpView from "../PopUpView";
import WXFUI_AfterWar from "../../fui/Game/WXFUI_AfterWar";
import { SoundManager } from "../../Manager/SoundManager";
import { GameManager } from "../../Manager/GameManager";
import WXFUI_ADItem from "../../fui/Game/WXFUI_ADItem";



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

        this.view.m_ad_1.m_list.itemRenderer = Laya.Handler.create(this, this.setADItem1, null, false);
        this.view.m_ad_2.m_list.itemRenderer = Laya.Handler.create(this, this.setADItem2, null, false);
        this.view.m_ad_3.m_list.itemRenderer = Laya.Handler.create(this, this.setADItem3, null, false);
        this.view.m_ad_4.m_list.itemRenderer = Laya.Handler.create(this, this.setADItem4, null, false);

        this.view.m_ad_1.m_list.numItems = this.view.m_ad_2.m_list.numItems = this.view.m_ad_3.m_list.numItems = this.view.m_ad_4.m_list.numItems = 10;
        this.view.m_ad_1.m_list.height = this.view.m_ad_2.m_list.height = this.view.m_ad_3.m_list.height = this.view.m_ad_4.m_list.height = 160 * 10 + 2;
        this.view.m_ad_1.m_list.on(fairygui.Events.CLICK_ITEM, this, this.onClickItem);
        this.view.m_ad_2.m_list.on(fairygui.Events.CLICK_ITEM, this, this.onClickItem);
        this.view.m_ad_3.m_list.on(fairygui.Events.CLICK_ITEM, this, this.onClickItem);
        this.view.m_ad_4.m_list.on(fairygui.Events.CLICK_ITEM, this, this.onClickItem);
    }

    public showView(s, c): void {
        super.showView(s, c);
        this.view.m_ad_1.m_list.y = 0;
        this.showADList();
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

    private _tweenNum: Laya.Tween;
    private showADList(): void {
        this.adMoveUp();
    }

    private onClickItem(e: WXFUI_ADItem): void {
        // console.log(this.view.m_ad.m_list.getChildIndex(e));

    }

    private setADItem1(index: number, item: WXFUI_ADItem): void {

    }
    private setADItem2(index: number, item: WXFUI_ADItem): void {

    }
    private setADItem3(index: number, item: WXFUI_ADItem): void {

    }
    private setADItem4(index: number, item: WXFUI_ADItem): void {

    }

    private set tweenNum(v: number) {

    }

    private adMoveDown(): void {
        this._tweenNum = Laya.Tween.to(this.view.m_ad_1.m_list, { y: 0 }, 5000, null, Laya.Handler.create(this, this.adMoveUp));
        this._tweenNum.update = Laya.Handler.create(this, this.updateTween, null, false);

    }

    private adMoveUp(): void {
        this._tweenNum = Laya.Tween.to(this.view.m_ad_1.m_list, { y: this.view.m_ad_1.height - 160 * 10 }, 5000, null, Laya.Handler.create(this, this.adMoveDown));
        this._tweenNum.update = Laya.Handler.create(this, this.updateTween, null, false);

    }

    private updateTween(): void {
        // console.log("updateTween--", this.view.m_ad_1.m_list.y);
        this.view.m_ad_4.m_list.y = this.view.m_ad_3.m_list.y = this.view.m_ad_2.m_list.y = this.view.m_ad_1.m_list.y;
    }

    public hideAllView(): void {
        super.hideAllView();
        Laya.Tween.clearTween(this.view.m_ad_1.m_list);
    }
}