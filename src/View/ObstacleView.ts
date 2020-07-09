

import { ViewManager } from "../Manager/ViewManager";
import GameEvent from "../Control/GameEvent";
import { EventManager } from "../Manager/EventManager";
import { GameData, ObstacleType } from "../Data/GameData";
import { ObstacleInfo } from "../Data/PlayerData";
import { SoundManager } from "../Manager/SoundManager";
import { ui } from "../ui/layaMaxUI";
import BoomView from "./BoomView";
import ObstacleBoomBody from "./Body/ObstacleBoomBody";

export default class ObstacleView {
    public scene: Laya.Sprite;
    // public boomSp: Laya.Sprite;
    public view: fairygui.GComponent;
    public load: fairygui.GLoader;

    public type: number = 1;

    protected direction: number = 0;
    protected box: Laya.PolygonCollider;

    protected isDeath: boolean = false;

    protected blood: number = 1;

    protected pos: Laya.Point;

    constructor() { }

    public createView(d: ObstacleInfo) {
        this.type = d.type;
        this.blood = d.blood;
        this.pos = d.pos;
        if (this.type == ObstacleType.ObstacleType_SHABAO) {
            this.scene = new ui.ObstacleView_1UI();
        } else if (this.type == ObstacleType.ObstacleType_YOUGUAN) {
            this.scene = new ui.ObstacleView_2UI();
        } else if (this.type == ObstacleType.ObstacleType_MICHE) {
            this.scene = new ui.ObstacleView_3UI();
        } else if (this.type == ObstacleType.ObstacleType_DACHE) {
            this.scene = new ui.ObstacleView_4UI();
        } else if (this.type == ObstacleType.ObstacleType_CHE) {
            this.scene = new ui.ObstacleView_5UI();
        } else if (this.type == ObstacleType.ObstacleType_6) {
            this.scene = new ui.ObstacleView_6UI();
        } else if (this.type == ObstacleType.ObstacleType_7) {
            this.scene = new ui.ObstacleView_7UI();
        } else if (this.type == ObstacleType.ObstacleType_8) {
            this.scene = new ui.ObstacleView_8UI();
        } else if (this.type == ObstacleType.ObstacleType_9) {
            this.scene = new ui.ObstacleView_9UI();
        } else if (this.type == ObstacleType.ObstacleType_10) {
            this.scene = new ui.ObstacleView_10UI();
        } else if (this.type == ObstacleType.ObstacleType_11) {
            this.scene = new ui.ObstacleView_11UI();
        } else
            return;
        // this.scene = Laya.Pool.getItemByClass("ObstacleView_" + this.type + "UI");
        this.loadComplete();
        // Laya.Scene.load("ObstacleView_" + this.type + ".scene", Laya.Handler.create(this, this.loadComplete));
    };

    public loadComplete() {
        this.view = fairygui.UIPackage.createObject("Game", "obstacleView") as fairygui.GComponent;
        this.view.setPivot(0.5, 0.5);
        this.load = this.view.getChildAt(0) as fairygui.GLoader;
        // this.scene = s;
        this.initView();
    };

    public initView(): void {
        this.load.url = "ui://Game/obstacle_" + this.type;
        this.scene.addChild(this.view.displayObject);
        this.box = this.scene.getComponent(Laya.PolygonCollider);

        this.isDeath = false;

        this.scene.x = this.pos.x;
        this.scene.y = this.pos.y;
        ViewManager.instance.warView.scene.addChild(this.scene);

        EventManager.instance.addNotice(GameEvent.CLEAR_WAR_VIEW, this, this.dispose);
        EventManager.instance.addNotice(GameEvent.PLAYER_BOMB_HIT_OBSTACLE, this, this.beHit);
        EventManager.instance.addNotice(GameEvent.PLAYER_BULLET_HIT_OBSTACLE, this, this.beHit);

    }

    public beHit(s: any): void {
        if (this.isDeath) return;
        if (s.o == this.box.owner) {
            this.blood -= s.d;
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
        this.load.url = "";
        var boomAniType: number = ViewManager.instance.getBoomAniTypeByObsType(this.type);
        var boomAni: fairygui.GMovieClip = fairygui.UIPackage.createObject("Game", "boom_" + boomAniType).asMovieClip;
        var p: Laya.Point = this.getBoomAniPos(this.type);
        boomAni.x = p.x;
        boomAni.y = p.y;
        this.load.displayObject.addChild(boomAni.displayObject);
        boomAni.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.dispose));
        EventManager.instance.dispatcherEvt(GameEvent.OBSTACLE_BOOM, this.box.owner);
        // this.boomSp = new ui.ObstacleBoomBodyUI();
        // this.load.displayObject.addChild(this.boomSp);
        // this.boomSp.addComponent(ObstacleBoomBody);
        // this.boomSp.x = (this.load.width - this.boomSp.width) / 2;
        // this.boomSp.y = (this.load.height - this.boomSp.height) / 2;
    }


    public dispose(): void {
        EventManager.instance.offNotice(GameEvent.CLEAR_WAR_VIEW, this, this.dispose);
        EventManager.instance.offNotice(GameEvent.PLAYER_BOMB_HIT_OBSTACLE, this, this.beHit);
        EventManager.instance.offNotice(GameEvent.PLAYER_BULLET_HIT_OBSTACLE, this, this.beHit);
        Laya.timer.clearAll(this);
        if (this.scene)
            this.scene.removeSelf();
        if (this.view)
            this.view.dispose();
        // if (this.boomSp)
        //     this.boomSp.removeSelf();
        Laya.Pool.recover("obstacle", this);
    }

    private getBoomAniPos(type: number): Laya.Point {
        var p: Laya.Point = new Laya.Point();
        if (type == ObstacleType.ObstacleType_SHABAO) {
            p.x = 10;
            p.y = -10;
        } else if (type == ObstacleType.ObstacleType_YOUGUAN) {
            p.x = -10;
            p.y = -10;
        } else if (type == ObstacleType.ObstacleType_MICHE) {
            p.x = -20;
            p.y = -180;
        } else if (type == ObstacleType.ObstacleType_DACHE) {
            p.x = 250;
            p.y = -40;
        } else if (type == ObstacleType.ObstacleType_CHE) {
            p.x = 50;
            p.y = -100;
        } else if (type == ObstacleType.ObstacleType_6) {
            p.x = -50;
            p.y = -100;
        } else if (type == ObstacleType.ObstacleType_7) {
            p.x = -40;
            p.y = -200;
        } else if (type == ObstacleType.ObstacleType_8) {
            p.x = -60;
            p.y = -220;
        } else if (type == ObstacleType.ObstacleType_9) {
            p.x = -10;
            p.y = -10;
        } else if (type == ObstacleType.ObstacleType_10) {
            p.x = 20;
            p.y = -120;
        } else if (type == ObstacleType.ObstacleType_11) {
            p.x = -30;
            p.y = -150;
        }
        return p;
    }
}