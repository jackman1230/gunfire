
import WXFUI_Player from "../fui/Game/WXFUI_Player";
import PlayerAni from "./PlayerAni";
import { ViewManager } from "../Manager/ViewManager";
import WXFUI_enemy from "../fui/Game/WXFUI_enemy";
import EnemyBody from "./Body/EnemyBody";
import GameEvent from "../Control/GameEvent";
import { EventManager } from "../Manager/EventManager";
import Enemy from "./Enemy";
import { EnemyInfo } from "../Data/PlayerData";
import { BombData } from "../Data/GameData";
import { GameManager } from "../Manager/GameManager";
import { SoundManager } from "../Manager/SoundManager";

export default class Chopper extends Enemy {

    constructor() { super() }

    public createView(d: EnemyInfo) {
        super.initData(d);
        Laya.Scene.load("ChopperBody.scene", Laya.Handler.create(this, this.loadComplete));
    };

    protected activeEnemy(s: Laya.Sprite): void {
        //角色距离靠近至500，激活攻击
        if (this.isActive) return;
        if (this.isDeath) return;
        if (this.box.owner == s) {
            this.isActive = true;
            this.setFire();
            Laya.timer.loop(2000, this, this.setFire);
        }
    }

    public setFire(): void {
        var p: Laya.Point = new Laya.Point(this.view.width / 2, this.view.height)
        ViewManager.instance.createChopperBomb(BombData.BOMB_CHOPPER, ViewManager.instance.getBodyCenterPos(this.scene), p);
        SoundManager.instance.playSound("bombDrop");

    }


    public setDeath(): void {
        if (this.isDeath) return;
        this.isDeath = true;
        Laya.timer.clearAll(this);
        this.enemy.url = "ui://Game/boom_5";
        this.enemy.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.dispose));

        if (this.isBoss) {
            GameManager.instance.bossDeath = true;
        }
        SoundManager.instance.playSound("boom");
        // this.createGoods();
    }

    protected recover(): void {
        Laya.Pool.recover("chopper", this);
    }

}