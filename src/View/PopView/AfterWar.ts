import PopUpView from "../PopUpView";
import WXFUI_AfterWar from "../../fui/Game/WXFUI_AfterWar";
import { SoundManager } from "../../Manager/SoundManager";
import { GameManager } from "../../Manager/GameManager";
import WXFUI_ADItem from "../../fui/Game/WXFUI_ADItem";
import { EventManager } from "../../Manager/EventManager";
import GameEvent from "../../Control/GameEvent";
import { MooSnowSDK } from "../../Manager/MooSnowSDK";



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

        this.view.m_ad_1.m_list.on(fairygui.Events.CLICK_ITEM, this, this.onClickItem);
        this.view.m_ad_2.m_list.on(fairygui.Events.CLICK_ITEM, this, this.onClickItem);
        this.view.m_ad_3.m_list.on(fairygui.Events.CLICK_ITEM, this, this.onClickItem);
        this.view.m_ad_4.m_list.on(fairygui.Events.CLICK_ITEM, this, this.onClickItem);

        EventManager.instance.addNotice(GameEvent.SHOW_AD_LIST, this, this.showADList);


    }

    public showView(s, c): void {
        super.showView(s, c);
        this.view.m_ad_1.m_list.y = 0;
        this.showADList();
        MooSnowSDK.showBanner(false);
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
        MooSnowSDK.showVideo(2, null);

    }

    private returnHandle(): void {
        SoundManager.instance.playSound("btn_click");
        GameManager.instance.goFirstPage();
    }

    private _tweenNum: Laya.Tween;
    private showADList(): void {
        if (GameManager.instance.adList.length < 1) return;
        EventManager.instance.offNotice(GameEvent.SHOW_AD_LIST, this, this.showADList);
        Laya.Tween.clearTween(this.view.m_ad_1.m_list);
        this.view.m_ad_1.m_list.numItems = this.view.m_ad_2.m_list.numItems = GameManager.instance.adList.length;
        this.view.m_ad_3.m_list.numItems = this.view.m_ad_4.m_list.numItems = GameManager.instance.adListRever.length;
        this.view.m_ad_1.m_list.height = this.view.m_ad_2.m_list.height = this.view.m_ad_3.m_list.height = this.view.m_ad_4.m_list.height = 160 * GameManager.instance.adList.length + 2;
        this.adMoveUp();
    }

    private onClickItem(e: WXFUI_ADItem): void {
        var m: moosnowAdRow = e.data as moosnowAdRow;
        console.log("ad--", m);
        moosnow.platform.navigate2Mini(m, (res) => {
            console.log('跳转成功 ', res)
        }, (res) => {
            console.log('跳转失败 ', res)
        });
    }

    private setADItem1(index: number, item: WXFUI_ADItem): void {
        var d: any = GameManager.instance.adList[index];
        if (!d) return;
        item.data = d;
        item.m_icon.url = d.img;
        item.m_name.text = d.title;
    }
    private setADItem2(index: number, item: WXFUI_ADItem): void {
        var d: any = GameManager.instance.adList[index];
        if (!d) return;
        item.data = d;
        item.m_icon.url = d.img;
        item.m_name.text = d.title;
    }
    private setADItem3(index: number, item: WXFUI_ADItem): void {
        var d: any = GameManager.instance.adListRever[index];
        if (!d) return;
        item.data = d;
        item.m_icon.url = d.img;
        item.m_name.text = d.title;
    }
    private setADItem4(index: number, item: WXFUI_ADItem): void {
        var d: any = GameManager.instance.adListRever[index];
        if (!d) return;
        item.data = d;
        item.m_icon.url = d.img;
        item.m_name.text = d.title;
    }

    private adMoveDown(): void {
        this._tweenNum = Laya.Tween.to(this.view.m_ad_1.m_list, { y: 0 }, GameManager.instance.adTime, null, Laya.Handler.create(this, this.adMoveUp));
        this._tweenNum.update = Laya.Handler.create(this, this.updateTween, null, false);

    }

    private adMoveUp(): void {
        this._tweenNum = Laya.Tween.to(this.view.m_ad_1.m_list, { y: this.view.m_ad_1.height - 160 * GameManager.instance.adList.length }, GameManager.instance.adTime, null, Laya.Handler.create(this, this.adMoveDown));
        this._tweenNum.update = Laya.Handler.create(this, this.updateTween, null, false);

    }

    private updateTween(): void {
        // console.log("updateTween--", this.view.m_ad_1.m_list.y);
        this.view.m_ad_4.m_list.y = this.view.m_ad_3.m_list.y = this.view.m_ad_2.m_list.y = this.view.m_ad_1.m_list.y;
    }

    public hideAllView(): void {
        super.hideAllView();
        Laya.Tween.clearTween(this.view.m_ad_1.m_list);
        MooSnowSDK.hideBanner();
    }
}