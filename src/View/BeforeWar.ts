import WXFUI_BeforeWar from "../fui/Game/WXFUI_BeforeWar";
import PopUpView from "./PopUpView";
import { GameManager } from "../Manager/GameManager";
import { ViewManager } from "../Manager/ViewManager";
import { SoundManager } from "../Manager/SoundManager";
import { EventManager } from "../Manager/EventManager";
import GameEvent from "../Control/GameEvent";

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





}