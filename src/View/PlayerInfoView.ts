import WXFUI_PlayerInfoView from "../fui/Game/WXFUI_PlayerInfoView";
import { GameManager } from "../Manager/GameManager";
import { EventManager } from "../Manager/EventManager";
import GameEvent from "../Control/GameEvent";
import { GoodsType, GameData } from "../Data/GameData";
import { PlayerData } from "../Data/PlayerData";
import { SoundManager } from "../Manager/SoundManager";
import { ViewManager } from "../Manager/ViewManager";

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
            GameManager.instance.roleInfo.blood++;
            if (GameManager.instance.roleInfo.blood > 3)
                GameManager.instance.roleInfo.blood = 3;
            this.updatePlayerBlood();
        } else if (t == GoodsType.GoodsType_MAC) {
            if (GameManager.instance.roleInfo.weaponType == PlayerData.WEAPON_MAC) {
                GameManager.instance.roleInfo.bulletNum += GameManager.instance.roleInfo.addMacNum;
            } else {
                GameManager.instance.roleInfo.bulletNum = GameManager.instance.roleInfo.addMacNum;
                GameManager.instance.roleInfo.weaponType = PlayerData.WEAPON_MAC;
            }
            EventManager.instance.dispatcherEvt(GameEvent.CHANGE_PLAYER_WEAPON, GameManager.instance.roleInfo.weaponType);
            this.updateBulletNum();
        } else if (t == GoodsType.GoodsType_RIF) {
            if (GameManager.instance.roleInfo.weaponType == PlayerData.WEAPON_RIFLE) {
                GameManager.instance.roleInfo.bulletNum += GameManager.instance.roleInfo.addRifNum;
            } else {
                GameManager.instance.roleInfo.bulletNum = GameManager.instance.roleInfo.addRifNum;
                GameManager.instance.roleInfo.weaponType = PlayerData.WEAPON_RIFLE;
            }
            this.updateBulletNum();
            EventManager.instance.dispatcherEvt(GameEvent.CHANGE_PLAYER_WEAPON, GameManager.instance.roleInfo.weaponType);

        } else if (t == GoodsType.GoodsType_GRE) {
            GameManager.instance.roleInfo.bombNum += GameManager.instance.roleInfo.addBombNum;
            this.updateGreNum();
        } else if (t == GoodsType.GoodsType_COIN) {
            var coin: number = this.getRandomCoin();
            GameManager.instance.roleInfo.curlvCoin += coin;
            GameManager.instance.roleInfo.totalCoin += coin;
            this.updateCoin();
        }
    }

    private decPlayerBlood(): void {
        // GameManager.instance.roleInfo.blood--;
        // if (GameManager.instance.roleInfo.blood < 0) GameManager.instance.roleInfo.blood = 0;
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
        for (let i = 3; i > 0; i--) {
            if (i <= GameManager.instance.roleInfo.blood) {
                this.view["m_blood_" + i].visible = true;
            } else {
                this.view["m_blood_" + i].visible = false;
            }
        }
    }

    public getRandomCoin(): number {
        return Math.floor((Math.random() * 100) * GameData.RANDOM_COIN / 100);
    }


}