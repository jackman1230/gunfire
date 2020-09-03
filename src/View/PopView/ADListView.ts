import PopUpView from "../PopUpView";
import WXFUI_AfterWar from "../../fui/Game/WXFUI_AfterWar";
import { SoundManager } from "../../Manager/SoundManager";
import { GameManager } from "../../Manager/GameManager";
import WXFUI_ADItem from "../../fui/Game/WXFUI_ADItem";
import WXFUI_ADListView from "../../fui/Game/WXFUI_ADListView";
import { ViewManager } from "../../Manager/ViewManager";
import { EventManager } from "../../Manager/EventManager";
import GameEvent from "../../Control/GameEvent";
import { MooSnowSDK } from "../../Manager/MooSnowSDK";



export default class ADListView extends PopUpView {

    public view: WXFUI_ADListView;
    private floor: number = 0;
    private ceil: number = 0;
    public type: number = 0;
    constructor() { super() }

    createView(): void {
        this.view = WXFUI_ADListView.createInstance();

        this.view.m_jixu.onClick(this, this.continueGame);

        this.view.m_time.text = " 0";

        this.view.m_ad_1.m_list.itemRenderer = Laya.Handler.create(this, this.setADItem1, null, false);
        this.view.m_ad_2.m_list.itemRenderer = Laya.Handler.create(this, this.setADItem2, null, false);


        this.view.m_ad_1.m_list.on(fairygui.Events.CLICK_ITEM, this, this.onClickItem);
        this.view.m_ad_2.m_list.on(fairygui.Events.CLICK_ITEM, this, this.onClickItem);

        EventManager.instance.addNotice(GameEvent.SHOW_AD_LIST, this, this.showADList);

    }

    public showView(s, c): void {
        super.showView(s, c);
        var pro: number = ViewManager.instance.getProportion();
        if (pro > 0)
            this.view.m_n6.setScale(1 + pro, 1 + pro);
        this.view.m_ad_1.m_list.x = this.view.m_ad_2.m_list.x = 0;
        this.showADList();

        this.view.m_ctl.selectedIndex = 0;
        this.timer = 4;
        this.showTxt();
        this.showTimer();

        this.adMoveLeft();
        var d: any = MooSnowSDK.getAllConfig();
        if (d && d.exportAutoNavigate && d.exportAutoNavigate != 0) {//开启自动跳转一个随机游戏
            this.gotoRandomGame();
        }
    }
    private timer: number = 4;
    private showTimer(): void {
        Laya.timer.loop(1000, this, this.showTxt);
    }

    private showTxt(): void {
        this.timer--;
        if (this.timer <= 0) {
            this.view.m_ctl.selectedIndex = 1;
            Laya.timer.clear(this, this.showTxt);
        }
        this.view.m_time.text = this.timer + "";
    }

    private continueGame(): void {
        SoundManager.instance.playSound("btn_click");
        ViewManager.instance.adListView.hideAllView();
        if (this.type == 1) {
            GameManager.instance.goFirstPage();
        }
    }


    private _tweenNum: Laya.Tween;
    private showADList(): void {
        if (GameManager.instance.adList.length < 1) return;
        EventManager.instance.offNotice(GameEvent.SHOW_AD_LIST, this, this.showADList);

        this.view.m_ad_1.m_list.width = 240 * GameManager.instance.adList.length;
        this.view.m_ad_2.m_list.width = 240 * GameManager.instance.adList.length;

        this.view.m_ad_1.m_list.numItems = GameManager.instance.adList.length;
        this.view.m_ad_2.m_list.numItems = GameManager.instance.adList.length;
        this.view.m_ad_2.m_list.x = this.view.m_ad_1.m_list.x = 0;
    }

    private onClickItem(e: WXFUI_ADItem): void {
        var m: moosnowAdRow = e.data as moosnowAdRow;
        console.log("ad--", m);
        if (!m) return;
        moosnow.platform.navigate2Mini(m, (res) => {
            console.log('跳转成功 ', res)
        }, (res) => {
            console.log('跳转失败 ', res)
        });
    }

    private setADItem1(index: number, item: WXFUI_ADItem): void {
        var d: any = GameManager.instance.adOriList[index];
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

    private adMoveLeft(): void {
        // console.log("adMoveLeft--");

        this._tweenNum = Laya.Tween.to(this.view.m_ad_1.m_list, { x: this.view.m_ad_1.width - 240 * GameManager.instance.adOriList.length }, GameManager.instance.adTime, null, Laya.Handler.create(this, this.adMoveRight));
        this._tweenNum.update = Laya.Handler.create(this, this.updateTween, null, false);

    }

    private adMoveRight(): void {
        // console.log("adMoveRight--");
        this._tweenNum = Laya.Tween.to(this.view.m_ad_1.m_list, { x: 0 }, GameManager.instance.adTime, null, Laya.Handler.create(this, this.adMoveLeft));
        this._tweenNum.update = Laya.Handler.create(this, this.updateTween, null, false);

    }

    private updateTween(): void {
        // if (this.floor > 6)
        this.view.m_ad_2.m_list.x = this.view.m_ad_1.m_list.x;
    }

    public hideAllView(): void {
        super.hideAllView();
        Laya.Tween.clearTween(this.view.m_ad_1.m_list);
        Laya.timer.clearAll(this);
    }

    private gotoRandomGame(): void {
        var n: number = Math.floor(Math.random() * GameManager.instance.adList.length);
        var d: any = GameManager.instance.adList[n];
        if (!d) return;
        moosnow.platform.navigate2Mini(d, (res) => {
            console.log('跳转成功 ', res)
        }, (res) => {
            console.log('跳转失败 ', res)
        });
    }
}