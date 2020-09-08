import PopUpView from "../PopUpView";
import WXFUI_AfterWar from "../../fui/Game/WXFUI_AfterWar";
import { SoundManager } from "../../Manager/SoundManager";
import { GameManager } from "../../Manager/GameManager";
import WXFUI_ADItem from "../../fui/Game/WXFUI_ADItem";
import { EventManager } from "../../Manager/EventManager";
import GameEvent from "../../Control/GameEvent";
import { MooSnowSDK } from "../../Manager/MooSnowSDK";
import { ViewManager } from "../../Manager/ViewManager";



export default class AfterWar extends PopUpView {

    public view: WXFUI_AfterWar;
    private viewType: number = 1;

    private hotNum: number = 6;
    private adList: any[] = [];
    constructor() { super() }

    createView(): void {
        this.view = WXFUI_AfterWar.createInstance();

        this.view.m_continue_1.onClick(this, this.continueGame);
        this.view.m_continue_2.onClick(this, this.restartGame);
        this.view.m_continue_3.onClick(this, this.continueGameByVideo);
        this.view.m_return.onClick(this, this.returnHandle);
        this.view.m_abandon.onClick(this, this.abandonHandle);

        this.view.m_coin.text = " 0";

        this.view.m_ad_1.m_list.itemRenderer = Laya.Handler.create(this, this.setADItem1, null, false);
        this.view.m_ad_2.m_list.itemRenderer = Laya.Handler.create(this, this.setADItem2, null, false);

        this.view.m_ad_1.m_list.on(fairygui.Events.CLICK_ITEM, this, this.onClickItem);
        this.view.m_ad_2.m_list.on(fairygui.Events.CLICK_ITEM, this, this.onClickItem);

        EventManager.instance.addNotice(GameEvent.SHOW_AD_LIST, this, this.showADList);

        this.view.m_adHot.m_jixu.onClick(this, this.hideADHot);


    }

    private clickHotAdItem(n: number): void {
        var m: moosnowAdRow = this.view.m_adHot["m_ad_" + n].data as moosnowAdRow;
        if (!m) return;
        console.log("ad--", m);
        moosnow.platform.navigate2Mini(m, (res) => {
            console.log('跳转成功 ', res)
        }, (res) => {
            console.log('跳转失败 ', res)
            // ViewManager.instance.showADListView();
            this.changeAdItem(n);
        });

    }

    private changeAdItem(n: number): void {
        var d: any = this.getRandomAdItem();
        if (!d) return;
        this.view.m_adHot["m_ad_" + n].data = d;
        this.view.m_adHot["m_ad_" + n].m_icon.url = d.img;
        this.view.m_adHot["m_ad_" + n].m_name.text = d.title;
    }

    private hideADHot(): void {
        // this.view.m_adHot.visible = false;
        MooSnowSDK.hideBanner();
        ViewManager.instance.showADListView(1);
    }

    public showView(s, c): void {
        super.showView(s, c);
        this.view.m_ad_1.m_list.y = 0;
        this.view.m_adHot.visible = false;
        if (GameManager.instance.platform == moosnow.APP_PLATFORM.WX) {
            this.showADList();
            MooSnowSDK.showBanner(false);
            this.view.m_ad_1.visible = this.view.m_ad_2.visible = true;
        }
        if (GameManager.instance.platform == moosnow.APP_PLATFORM.QQ) {
            MooSnowSDK.hideBanner();
            MooSnowSDK.showQQADBox(false, true);
            this.view.m_ad_1.visible = this.view.m_ad_2.visible = false;
        }

    }

    private showHotAdList(): void {
        for (let i = 1; i <= 6; i++) {
            var d: any = this.getRandomAdItem();
            if (!d) continue;
            this.view.m_adHot["m_ad_" + i].data = d;
            this.view.m_adHot["m_ad_" + i].m_icon.url = d.img;
            this.view.m_adHot["m_ad_" + i].m_name.text = d.title;
            this.view.m_adHot["m_ad_" + i].onClick(this, this.clickHotAdItem, [i]);
        }
    }
    /**
     * 显示关卡战斗之后界面
     * @param type 1胜利界面，2失败界面，3放弃界面
     */
    public updateView(type: number): void {
        this.viewType = type;
        this.updateCoin();
        if (type == 3) {
            this.view.m_abandon.visible = false;
            Laya.timer.once(2000, this, this.showAbondon);
            ViewManager.instance.showADListView();
        } else if (type == 1) {
            this.view.m_adHot.visible = true;
            this.adList = GameManager.instance.adList.concat();
            this.showHotAdList();
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
        MooSnowSDK.endGame(GameManager.instance.choiseLevel, true);
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

    private abandonHandle(): void {
        SoundManager.instance.playSound("btn_click");
        GameManager.instance.goFirstPage();
        MooSnowSDK.endGame(GameManager.instance.choiseLevel, false);
    }

    private returnHandle(): void {
        SoundManager.instance.playSound("btn_click");
        GameManager.instance.goFirstPage();
    }

    private _tweenNum: Laya.Tween;
    private showADList(): void {
        if (GameManager.instance.adList.length < 1) return;
        if (GameManager.instance.platform != moosnow.APP_PLATFORM.WX) return
        EventManager.instance.offNotice(GameEvent.SHOW_AD_LIST, this, this.showADList);
        Laya.Tween.clearTween(this.view.m_ad_1.m_list);
        this.view.m_ad_1.m_list.numItems = GameManager.instance.adList.length;
        this.view.m_ad_2.m_list.numItems = GameManager.instance.adListRever.length;
        this.view.m_ad_1.m_list.height = this.view.m_ad_2.m_list.height = 311 * GameManager.instance.adList.length + 2;
        this.adMoveUp();
    }

    private onClickItem(e: WXFUI_ADItem): void {
        var m: moosnowAdRow = e.data as moosnowAdRow;
        console.log("ad--", m);
        moosnow.platform.navigate2Mini(m, (res) => {
            console.log('跳转成功 ', res)
        }, (res) => {
            console.log('跳转失败 ', res)
            ViewManager.instance.showADListView();
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
        this._tweenNum = Laya.Tween.to(this.view.m_ad_1.m_list, { y: this.view.m_ad_1.height - 311 * GameManager.instance.adList.length }, GameManager.instance.adTime, null, Laya.Handler.create(this, this.adMoveDown));
        this._tweenNum.update = Laya.Handler.create(this, this.updateTween, null, false);

    }

    private updateTween(): void {
        // console.log("updateTween--", this.view.m_ad_1.m_list.y);
        this.view.m_ad_2.m_list.y = this.view.m_ad_1.m_list.y;
    }

    public hideAllView(): void {
        super.hideAllView();
        Laya.Tween.clearTween(this.view.m_ad_1.m_list);
        MooSnowSDK.hideBanner();
        for (let i = 1; i <= 6; i++) {
            this.view.m_adHot["m_ad_" + i].offClick(this, this.clickHotAdItem, [i]);
        }
    }

    private getRandomAdItem(): any {
        if (this.adList.length > 0) {
        } else {
            this.adList = GameManager.instance.adList.concat();
        }
        var n: number = Math.floor(Math.random() * this.adList.length);
        var d: any = this.adList.splice(n, 1)[0];
        console.log("d---", d);
        return d;
    }
}