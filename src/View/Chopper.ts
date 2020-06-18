
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

export default class Chopper extends Enemy {

    constructor() { super() }

    public createView(d: EnemyInfo) {
        super.initData(d);
        Laya.Scene.load("ChopperBody.scene", Laya.Handler.create(this, this.loadComplete));
    };

    public setFire(): void {
        var p: Laya.Point = new Laya.Point(this.view.width / 2, this.view.height)
        ViewManager.instance.createChopperBomb(BombData.BOMB_CHOPPER, ViewManager.instance.getBodyCenterPos(this.scene), p);

    }


    public setDeath(): void {
        if (this.isDeath) return;
        this.isDeath = true;
        Laya.timer.clearAll(this);
        this.enemy.url = "ui://Game/boom_4";
        this.enemy.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.dispose));

        // var p: Laya.Point = new Laya.Point();
        // p.x = this.scene.x + this.scene.width / 2;
        // p.y = this.scene.y + this.scene.height / 2;
        // ViewManager.instance.createGoods(1, p);
    }

    protected recover(): void {
        Laya.Pool.recover("chopper", this);
    }

    public get component(): fairygui.GComponent {
        return this.enemy.component;
    }

    public get bodyLoader(): fairygui.GLoader {
        return this.enemy.component.getChildAt(0).asLoader;
    }
}