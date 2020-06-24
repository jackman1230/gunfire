import { EventManager } from "../../Manager/EventManager";
import GameEvent from "../../Control/GameEvent";
import { GameManager } from "../../Manager/GameManager";
import { GameData } from "../../Data/GameData";


export default class BulletBody extends Laya.Script {

    private selfCollider: Laya.BoxCollider;//子弹碰撞体
    private selfBody: Laya.RigidBody;//子弹刚体

    private oriPosX: number;
    private self: Laya.Sprite;
    private damage: number;
    private bulletType: number = 0;

    constructor() { super(); }

    onAwake(): void {
        this.selfCollider = this.owner.getComponent(Laya.BoxCollider);
        this.selfBody = this.selfCollider.rigidBody;
        this.self = this.owner as Laya.Sprite;
        this.oriPosX = this.self.x;
        if (this.selfCollider.label.indexOf("PlayerBullet") > -1) {
            this.bulletType = Number(this.selfCollider.label.substr(("PlayerBullet").length, 1));
            this.damage = GameManager.instance.getPlayerBulletDamage(this.bulletType);
        }
        // console.log("oriPosX--" + this.oriPosX);

    }


    onDisable(): void {
    }

    onTriggerEnter(other: Laya.BoxCollider, self: Laya.BoxCollider, contact: any): void {
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
        } else if (self.label == "enemyBullet") {
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
        if (this.bulletType == GameData.WEAPON_RIFLE) return;
        if (this.selfBody.label.indexOf("PlayerBullet") > -1) {
            if (this.oriPosX < this.self.x) {
                if (Math.abs(this.self.x - this.oriPosX) > Laya.stage.width * 0.6) {
                    this.owner.removeSelf();
                    EventManager.instance.dispatcherEvt(GameEvent.BULLET_DISPOSE, this.owner);
                }
            } else {
                if (Math.abs(this.oriPosX - this.self.x) > Laya.stage.width * 0.6) {
                    this.owner.removeSelf();
                    EventManager.instance.dispatcherEvt(GameEvent.BULLET_DISPOSE, this.owner);
                }
            }
        }
    }
}