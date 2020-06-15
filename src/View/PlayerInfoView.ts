import WXFUI_PlayerInfoView from "../fui/Game/WXFUI_PlayerInfoView";
import { GameManager } from "../Manager/GameManager";
import { EventManager } from "../Manager/EventManager";
import GameEvent from "../Control/GameEvent";
import { GoodsType } from "../Data/GameData";
import { PlayerData } from "../Data/PlayerData";

export default class PlayerInfoView {

    public view: WXFUI_PlayerInfoView;


    constructor() { }

    createView(): void {
        this.view = fairygui.UIPackage.createObject("Game", "PlayerInfoView") as WXFUI_PlayerInfoView;
        fairygui.GRoot.inst.addChild(this.view);

        EventManager.instance.addNotice(GameEvent.CHANGE_PLAYER_GOODS, this, this.changePlayerGoods);
        EventManager.instance.addNotice(GameEvent.USE_PLAYER_BULLET, this, this.usePlyerBullet);
        EventManager.instance.addNotice(GameEvent.USE_PLAYER_BOMB, this, this.changePlayerGoods);
        EventManager.instance.addNotice(GameEvent.ENEMY_BOMB_HIT_PLAYER, this, this.changePlayerGoods);
        EventManager.instance.addNotice(GameEvent.ENEMY_BULLET_HIT_PLAYER, this, this.changePlayerGoods);


    }

    private changePlayerGoods(t: number): void {
        if (t == GoodsType.GoodsType_MED) {
            GameManager.instance.roleInfo.blood++;
            this.updatePlayerBlood();
        } else if (t == GoodsType.GoodsType_MAC) {
            if (GameManager.instance.roleInfo.weaponType == PlayerData.WEAPON_MAC) {
                GameManager.instance.roleInfo.bulletNum += GameManager.instance.roleInfo.addMacNum;
            } else
                GameManager.instance.roleInfo.bulletNum = GameManager.instance.roleInfo.addMacNum;
            this.updateBulletNum();
        } else if (t == GoodsType.GoodsType_RIF) {
            if (GameManager.instance.roleInfo.weaponType == PlayerData.WEAPON_RIFLE) {
                GameManager.instance.roleInfo.bulletNum += GameManager.instance.roleInfo.addRifNum;
            } else
                GameManager.instance.roleInfo.bulletNum = GameManager.instance.roleInfo.addRifNum;
            this.updateBulletNum();
        } else if (t == GoodsType.GoodsType_GRE) {
            GameManager.instance.roleInfo.bombNum += GameManager.instance.roleInfo.addBombNum;
            this.updateGreNum();
        }
    }

    private decPlayerBlood(): void {
        GameManager.instance.roleInfo.blood--;
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

    private updateBulletNum(): void {
        this.view.m_bullet.text = GameManager.instance.roleInfo.bulletNum + "";
    }

    private updateGreNum(): void {
        this.view.m_gre.text = GameManager.instance.roleInfo.bombNum + "";
    }

    private updatePlayerBlood(): void {
        if (GameManager.instance.roleInfo.blood <= 0) {
            EventManager.instance.dispatcherEvt(GameEvent.PLAYER_DEATH);

        }
        for (let i = 3; i > 0; i--) {
            if (i >= GameManager.instance.roleInfo.blood) {
                this.view["m_blood_" + i].visible = true;
            } else {
                this.view["m_blood_" + i].visible = false;

            }


        }
    }


}