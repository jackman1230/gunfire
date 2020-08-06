import { EventManager } from "../../Manager/EventManager";
import GameEvent from "../../Control/GameEvent";
import { GameManager } from "../../Manager/GameManager";
import { GameData } from "../../Data/GameData";
import { ViewManager } from "../../Manager/ViewManager";


export default class BulletBody extends Laya.Script {

    private selfCollider: Laya.BoxCollider;//子弹碰撞体
    private selfBody: Laya.RigidBody;//子弹刚体

    private oriPosX: number;
    private self: Laya.Sprite;
    private damage: number;
    private bulletType: number = 0;
    private disposeLeft: number = 0;
    private disposeRight: number = 0;
    public isRemove: boolean = false;

    constructor() { super(); }

    onAwake(): void {
        this.selfCollider = this.owner.getComponent(Laya.BoxCollider);
        this.selfBody = this.selfCollider.rigidBody;
        this.self = this.owner as Laya.Sprite;
        this.oriPosX = this.self.x;
        this.isRemove = false;
        var moveX: number = Math.abs(ViewManager.instance.warView.warView.x);
        this.disposeRight = Laya.stage.width + moveX - 30;
        this.disposeLeft = moveX - 20;
        if (this.selfCollider.label.indexOf("PlayerBullet") > -1) {
            this.bulletType = Number(this.selfCollider.label.substr(("PlayerBullet").length, 1));
            this.damage = GameManager.instance.getPlayerBulletDamage(this.bulletType);
            if (ViewManager.instance.rolePlayer.sRun) {
                this.disposeRight += 220;
                this.disposeLeft -= 150;
            }
        }
    }


    onDisable(): void {
    }

    onTriggerEnter(other: Laya.BoxCollider, self: Laya.BoxCollider, contact: any): void {
        if (this.isRemove) return;
        if (self.label.indexOf("PlayerBullet") > -1) {
            if (other.label == "enemy") {
                // console.log("主角子弹击中敌人-敌人ID=", other.id);
                // this.owner.removeSelf();
                EventManager.instance.dispatcherEvt(GameEvent.PLAYER_BULLET_HIT_ENEMY, { o: other.owner, s: self.owner, d: this.damage });
            } else if (other.label == "obstacle") {
                // console.log("主角子弹击中障碍物", other.id);
                // this.owner.removeSelf();
                EventManager.instance.dispatcherEvt(GameEvent.PLAYER_BULLET_HIT_OBSTACLE, { o: other.owner, s: self.owner, d: this.damage });
            }
            return;
        }
        if (self.label == "enemyBullet") {
            if (other.label == "player") {
                // console.log("敌人子弹击中主角--ID=", other.id, self.id);
                this.selfCollider.destroy();
                EventManager.instance.dispatcherEvt(GameEvent.ENEMY_BULLET_HIT_PLAYER, { o: other.owner, s: self.owner });
            }
            return;
        }
    }
    onTriggerExit(): void {
    }

    onTriggerStay(other: Laya.BoxCollider, self: Laya.BoxCollider, contact: any): void {
        // this.setSpeedZero();
    }

    onUpdate(): void {
        if (this.isRemove) return;
        // if (this.bulletType == GameData.WEAPON_RIFLE) return;
        if (this.self.x > this.disposeRight || this.self.x < this.disposeLeft || this.self.y < -50 || this.self.y > Laya.stage.height + 50) {
            // console.log("BULLET_DISPOSE--", this.self.x);
            this.owner.removeSelf();
            this.isRemove = true;
            EventManager.instance.dispatcherEvt(GameEvent.BULLET_DISPOSE, this.owner);
        }
    }
}