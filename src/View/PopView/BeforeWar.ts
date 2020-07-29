import PopUpView from "../PopUpView";
import WXFUI_BeforeWar from "../../fui/Game/WXFUI_BeforeWar";
import { GameManager } from "../../Manager/GameManager";
import { SoundManager } from "../../Manager/SoundManager";
import { ViewManager } from "../../Manager/ViewManager";
import { EventManager } from "../../Manager/EventManager";
import GameEvent from "../../Control/GameEvent";
import WXFUI_ADItem from "../../fui/Game/WXFUI_ADItem";


export default class BeforeWar extends PopUpView {

    public view: WXFUI_BeforeWar;

    private shopData: any;

    constructor() { super() }

    createView(): void {
        this.view = WXFUI_BeforeWar.createInstance();

        this.view.m_enter.onClick(this, this.enterGame);
        this.shopData = GameManager.instance.levelData.shop;
        this.view.m_item_1.visible = this.view.m_item_2.visible = this.view.m_item_3.visible = this.view.m_item_4.visible = false
        var index: number = 0;
        for (const key in this.shopData) {
            if (this.shopData.hasOwnProperty(key)) {
                index++;
                var d = this.shopData[key];
                // this.view.m_item_1.m_icon.url = "ui://Game/goods_" + d.type;
                this.view["m_item_" + index].visible = true;
                this.view["m_item_" + index].m_coin.text = d.coin + "";
                this.view["m_item_" + index].m_info.text = d.name;
                this.view["m_item_" + index].m_icon.url = "ui://Game/goods_" + d.type;
                this.view["m_item_" + index].m_buy.onClick(this, this.buyItem, [d]);
                this.view["m_item_" + index].m_free.onClick(this, this.buyItemByFree, [d]);
                // this.view.m_item_1.m_free.onClick(this, this.buyItem, [d]);
            }
        }

        this.view.m_ad.m_list.itemRenderer = Laya.Handler.create(this, this.setADItem, null, false);
        this.view.m_ad.m_list.numItems = GameManager.instance.adList.length;
        this.view.m_ad.m_list.width = 136 * GameManager.instance.adList.length;
        this.view.m_ad.m_list.on(fairygui.Events.CLICK_ITEM, this, this.onClickItem);
        // this.showADList();
    }
    public showView(s, c): void {
        super.showView(s, c);
        this.view.m_ad.m_list.x = 0;
        this.showADList();
    }

    private buyItem(d: any): void {
        SoundManager.instance.playSound("btn_press");
        if (GameManager.instance.roleInfo.totalCoin < d.coin) {
            ViewManager.instance.showTipsView("金币不足！");
            return;
        } else {
            ViewManager.instance.showTipsView("金币-" + d.coin);
            GameManager.instance.roleInfo.totalCoin -= d.coin;
            GameManager.instance.buyShopItem(d);
        }

    }

    private buyItemByFree(d: any): void {
        SoundManager.instance.playSound("btn_press");
        ViewManager.instance.showTipsView("敬请期待！@_@");
        EventManager.instance.dispatcherEvt(GameEvent.BUY_SHOP_ITEM_FREE, d);
    }

    private enterGame(): void {
        SoundManager.instance.playSound("btn_click");
        GameManager.instance.enterGame();
        ViewManager.instance.hidePopUpView(this, true);
    }

    private showADList(): void {

        this.adMoveLeft();

    }

    private setADItem(index: number, item: WXFUI_ADItem): void {
        var d: any = GameManager.instance.adList[index];
        item.data = d;
        item.m_icon.url = d.img;
        item.m_name.text = d.title;
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

    private adMoveLeft(): void {
        Laya.Tween.to(this.view.m_ad.m_list, { x: this.view.m_ad.width - 136 * GameManager.instance.adList.length }, GameManager.instance.adTime, null, Laya.Handler.create(this, this.adMoveRight));

    }

    private adMoveRight(): void {
        Laya.Tween.to(this.view.m_ad.m_list, { x: 0 }, GameManager.instance.adTime, null, Laya.Handler.create(this, this.adMoveLeft));
    }

    public hideAllView(): void {
        super.hideAllView();
        Laya.Tween.clearTween(this.view.m_ad.m_list);
    }





}