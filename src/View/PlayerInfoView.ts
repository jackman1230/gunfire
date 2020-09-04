import WXFUI_PlayerInfoView from "../fui/Game/WXFUI_PlayerInfoView";
import { GameManager } from "../Manager/GameManager";
import { EventManager } from "../Manager/EventManager";
import GameEvent from "../Control/GameEvent";
import { GoodsType, GameData } from "../Data/GameData";
import { PlayerData } from "../Data/PlayerData";
import { SoundManager } from "../Manager/SoundManager";
import { ViewManager } from "../Manager/ViewManager";
import { MooSnowSDK } from "../Manager/MooSnowSDK";

export default class PlayerInfoView {

    public view: WXFUI_PlayerInfoView;


    constructor() { this.createView() }

    createView(): void {
        this.view = fairygui.UIPackage.createObject("Game", "PlayerInfoView") as WXFUI_PlayerInfoView;

        EventManager.instance.addNotice(GameEvent.CHANGE_PLAYER_GOODS, this, this.changePlayerGoods);
        EventManager.instance.addNotice(GameEvent.USE_PLAYER_BULLET, this, this.usePlyerBullet);
        EventManager.instance.addNotice(GameEvent.USE_PLAYER_BOMB, this, this.decBombNum);
        // EventManager.instance.addNotice(GameEvent.ENEMY_BOMB_HIT_PLAYER, this, this.decPlayerBlood);
        EventManager.instance.addNotice(GameEvent.DEC_PLAYER_BLOOD, this, this.updatePlayerBlood);
        // EventManager.instance.addNotice(GameEvent.BUY_SHOP_ITEM, this, this.buyShopItem);
        // EventManager.instance.addNotice(GameEvent.BUY_SHOP_ITEM_FREE, this, this.decPlayerBlood);


        this.updateAllView();

        this.view.m_pause.onClick(this, this.pauseGame);
        // Laya.stage.on(Laya.Event.CLICK, this, this.click);
        this.layout();
    }

    private layout(): void {
        if (Laya.Browser.onWeiXin) {
            let wxInfo = wx.getSystemInfoSync();
            var h: number = (wxInfo.windowHeight / 750) * 1334;//游戏所展示的宽度
            // this.view.x = 100 * (wxInfo.windowWidth / h);
            this.view.x = 80 * (Laya.stage.width / 1334);
            if ((wxInfo.windowWidth / wxInfo.windowHeight) > 2) {
                this.view.m_pause.x = 1050;
            } else
                this.view.m_pause.x = 950;
        } else {
            var h: number = (Laya.Browser.height / 750) * 1334;//游戏所展示的宽度
            this.view.x = 100 * (Laya.Browser.width / h);
        }
        this.view.y = 0;
    }

    public updateAllView(): void {
        this.updateBulletNum();
        this.updatePlayerBlood();
        this.updateGreNum();
        this.updateCoin();
        this.updateLevel();
    }

    private updateLevel(): void {
        this.view.m_level.text = " 第" + GameManager.instance.curLevel + "关 ";
    }


    private pauseGame(): void {
        SoundManager.instance.playSound("btn_press");
        ViewManager.instance.showSuspendView();
        GameManager.instance.suspendGame();
    }

    private changePlayerGoods(t: number): void {
        if (t == GoodsType.GoodsType_MED) {

            GameManager.instance.roleInfo.blood += 2;
            if (GameManager.instance.roleInfo.blood > GameManager.instance.oriBlood)
                GameManager.instance.roleInfo.blood = GameManager.instance.oriBlood;
            this.updatePlayerBlood();
            ViewManager.instance.createAddGold(t, 1, true);
        } else if (t == GoodsType.GoodsType_MAC) {
            if (GameManager.instance.roleInfo.weaponType == PlayerData.WEAPON_MAC) {
                GameManager.instance.roleInfo.bulletNum += GameManager.instance.roleInfo.addMacNum;
            } else {
                GameManager.instance.roleInfo.bulletNum = GameManager.instance.roleInfo.addMacNum;
                GameManager.instance.roleInfo.weaponType = PlayerData.WEAPON_MAC;
            }
            EventManager.instance.dispatcherEvt(GameEvent.CHANGE_PLAYER_WEAPON, GameManager.instance.roleInfo.weaponType);
            this.updateBulletNum();
            ViewManager.instance.createAddGold(t, GameManager.instance.roleInfo.addMacNum, true);

        } else if (t == GoodsType.GoodsType_RIF) {
            if (GameManager.instance.roleInfo.weaponType == PlayerData.WEAPON_RIFLE) {
                GameManager.instance.roleInfo.bulletNum += GameManager.instance.roleInfo.addRifNum;
            } else {
                GameManager.instance.roleInfo.bulletNum = GameManager.instance.roleInfo.addRifNum;
                GameManager.instance.roleInfo.weaponType = PlayerData.WEAPON_RIFLE;
            }
            this.updateBulletNum();
            EventManager.instance.dispatcherEvt(GameEvent.CHANGE_PLAYER_WEAPON, GameManager.instance.roleInfo.weaponType);
            ViewManager.instance.createAddGold(t, GameManager.instance.roleInfo.addRifNum, true);
        } else if (t == GoodsType.GoodsType_GRE) {
            GameManager.instance.roleInfo.bombNum += GameManager.instance.roleInfo.addBombNum;
            this.updateGreNum();
            ViewManager.instance.createAddGold(t, GameManager.instance.roleInfo.addBombNum, true);
        } else if (t == GoodsType.GoodsType_COIN) {
            var coin: number = this.getRandomCoin();
            GameManager.instance.roleInfo.curlvCoin += coin;
            GameManager.instance.roleInfo.totalCoin += coin;
            this.updateCoin();
            ViewManager.instance.createAddGold(t, coin, true);
        } else if (t == GoodsType.GoodsType_BOX) {
            if (MooSnowSDK.misTouchNum == 0) {//没有误触，直接开箱
                this.showBoxGoods();
            } else if (MooSnowSDK.misTouchNum > 0) {
                GameManager.instance.misTouchNum++;
                if (GameManager.instance.misTouchNum >= MooSnowSDK.misTouchNum) {
                    GameManager.instance.misTouchNum = 0;
                    ViewManager.instance.showClickChestView();
                } else {
                    this.showBoxGoods();
                }
            }
        } else if (t == GoodsType.GoodsType_OPEN_BOX) {
            this.showBoxGoods();
        }
    }

    private showBoxGoods(): void {
        this.changePlayerGoods(GoodsType.GoodsType_MED);
        Laya.timer.once(500, this, this.changePlayerGoods, [GoodsType.GoodsType_RIF]);
        Laya.timer.once(1000, this, this.showGetGoods, [GoodsType.GoodsType_GRE]);
    }



    private showGetGoods(t: number): void {
        this.changePlayerGoods(t);
    }

    private decPlayerBlood(): void {
        this.updatePlayerBlood();
    }

    private usePlyerBullet(): void {
        if (GameManager.instance.roleInfo.weaponType == PlayerData.WEAPON_PIS) return;
        GameManager.instance.roleInfo.bulletNum--;
        if (GameManager.instance.roleInfo.bulletNum <= 0) {
            GameManager.instance.roleInfo.weaponType = PlayerData.WEAPON_PIS;
            EventManager.instance.dispatcherEvt(GameEvent.CHANGE_PLAYER_WEAPON, PlayerData.WEAPON_PIS);
        }
        this.updateBulletNum();
    }

    private decBombNum(): void {
        GameManager.instance.roleInfo.bombNum--;
        this.updateGreNum();
    }

    public updateBulletNum(): void {
        this.view.m_bullet.text = GameManager.instance.roleInfo.bulletNum + "";
    }

    public updateGreNum(): void {
        this.view.m_gre.text = GameManager.instance.roleInfo.bombNum + "";
    }

    public updateCoin(): void {
        this.view.m_coin.text = GameManager.instance.roleInfo.totalCoin + "";
    }

    public updatePlayerBlood(): void {
        if (GameManager.instance.roleInfo.blood == 6) {
            this.view.m_blood_3.m_ctl.selectedIndex = this.view.m_blood_2.m_ctl.selectedIndex = this.view.m_blood_1.m_ctl.selectedIndex = 0;
        } else if (GameManager.instance.roleInfo.blood == 5) {
            this.view.m_blood_2.m_ctl.selectedIndex = this.view.m_blood_1.m_ctl.selectedIndex = 0;
            this.view.m_blood_3.m_ctl.selectedIndex = 1;
        } else if (GameManager.instance.roleInfo.blood == 4) {
            this.view.m_blood_2.m_ctl.selectedIndex = this.view.m_blood_1.m_ctl.selectedIndex = 0;
            this.view.m_blood_3.m_ctl.selectedIndex = 2;
        } else if (GameManager.instance.roleInfo.blood == 3) {
            this.view.m_blood_1.m_ctl.selectedIndex = 0;
            this.view.m_blood_2.m_ctl.selectedIndex = 1;
            this.view.m_blood_3.m_ctl.selectedIndex = 2;
        } else if (GameManager.instance.roleInfo.blood == 2) {
            this.view.m_blood_1.m_ctl.selectedIndex = 0;
            this.view.m_blood_2.m_ctl.selectedIndex = 2;
            this.view.m_blood_3.m_ctl.selectedIndex = 2;
        } else if (GameManager.instance.roleInfo.blood == 1) {
            this.view.m_blood_1.m_ctl.selectedIndex = 1;
            this.view.m_blood_2.m_ctl.selectedIndex = 2;
            this.view.m_blood_3.m_ctl.selectedIndex = 2;
        } else {
            this.view.m_blood_1.m_ctl.selectedIndex = 2;
            this.view.m_blood_2.m_ctl.selectedIndex = 2;
            this.view.m_blood_3.m_ctl.selectedIndex = 2;
        }

        // var n: number = Math.floor(GameManager.instance.roleInfo.blood / 2);
        // var t: number = GameManager.instance.roleInfo.blood % 2;
        // for (let i = 3; i > 0; i--) {
        //     if (t > 0)
        //         this.view["m_blood_" + i].m_ctl.selectedIndex = 1;
        //     if (i <= n) {
        //         this.view["m_blood_" + i].m_ctl.selectedIndex = 0;
        //     }
        // }
    }

    public getRandomCoin(): number {
        return Math.floor((Math.random() * 100) * GameData.RANDOM_COIN / 100);
    }

    public getRandomGoodsType(): number {
        return Math.ceil(Math.random() * 5);
    }


}