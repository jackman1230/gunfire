
import WXFUI_Player from "../fui/Game/WXFUI_Player";
import PlayerAni from "./PlayerAni";
import { ViewManager } from "../Manager/ViewManager";
import WXFUI_enemy from "../fui/Game/WXFUI_enemy";
import EnemyBody from "./Body/EnemyBody";
import GameEvent from "../Control/GameEvent";
import { EventManager } from "../Manager/EventManager";
import { GameData } from "../Data/GameData";
import { ObstacleInfo } from "../Data/PlayerData";

export default class ObstacleView {
    public scene: Laya.Sprite;
    public view: fairygui.GComponent;
    public load: fairygui.GLoader;

    public type: number = 1;

    protected direction: number = 0;
    protected box: Laya.BoxCollider;

    protected isDeath: boolean = false;

    protected blood: number = 1;

    protected pos: Laya.Point;

    constructor() { }

    public createView(d: ObstacleInfo) {
        this.type = d.type;
        this.blood = d.blood;
        this.pos = d.pos;

        Laya.Scene.load("ObstacleView" + this.type + ".scene", Laya.Handler.create(this, this.loadComplete));
    };

    public loadComplete(s: Laya.Sprite) {
        this.view = fairygui.UIPackage.createObject("Game", "enemy") as fairygui.GComponent;
        this.view.setPivot(0.5, 0.5);
        this.load = this.view.getChildAt(0) as fairygui.GLoader;
        this.scene = s;
        this.initView();
    };

    public initView(): void {
        this.load.url = "ui://Game/enemy" + this.type;
        this.scene.addChild(this.view.displayObject);
        this.scene.addComponent(EnemyBody);
        this.box = this.scene.getComponent(Laya.BoxCollider);

        this.isDeath = false;

        this.scene.x = this.pos.x;
        this.scene.y = this.pos.y;
        ViewManager.instance.warView.scene.addChild(this.scene);
        EventManager.instance.addNotice(GameEvent.PLAYER_BULLET_HIT_ENEMY, this, this.beHit);
        EventManager.instance.addNotice(GameEvent.PLAYER_BOMB_HIT_ENEMY, this, this.beHit);

    }

    public beHit(s: any): void {
        if (this.isDeath) return;
        if (s.o == this.box.owner) {
            this.blood--;
            Laya.timer.clear(this, this.setColor);
            if (this.blood <= 0) {
                this.setDeath();
            } else {
                this.load.color = "#ff0000";
                Laya.timer.once(200, this, this.setColor);
            }
        }
    }

    protected setColor(): void {
        this.load.color = "#ffffff";
    }


    public setDeath(): void {
        this.isDeath = true;
        Laya.timer.clearAll(this);
        // this.bodyLoader.url = "ui://Game/death_" + this.type;
        // this.bodyLoader.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.dispose));

        // var p: Laya.Point = new Laya.Point();
        // p.x = this.scene.x + this.scene.width / 2;
        // p.y = this.scene.y + this.scene.height / 2;
        // ViewManager.instance.createGoods(1, p);
    }

    protected dispose(): void {
        EventManager.instance.offNotice(GameEvent.PLAYER_BOMB_HIT_ENEMY, this, this.beHit);
        EventManager.instance.offNotice(GameEvent.PLAYER_BULLET_HIT_ENEMY, this, this.beHit);
        Laya.timer.clearAll(this);
        this.scene.removeSelf();
        this.view.dispose();
        Laya.Pool.recover("enenmy", this);
    }


    public getRandomFire(): number {
        if (Math.random() > 0.5) return 1;
        return 2;
    }

    public getRandomDeath(): number {
        var r: number = Math.random();
        if (r > 0.75) return 4;
        if (r > 0.5) return 3;
        if (r > 0.25) return 2;
        return 1;
    }
}