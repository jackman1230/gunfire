import { EventManager } from "../../Manager/EventManager";
import GameEvent from "../../Control/GameEvent";


export default class BulletBody extends Laya.Script {

    private selfCollider: Laya.BoxCollider;//子弹碰撞体
    private selfBody: Laya.RigidBody;//子弹刚体

    private oriPosX: number;
    private self: Laya.Sprite;

    constructor() { super(); }

    onEnable(): void {
        this.selfCollider = this.owner.getComponent(Laya.BoxCollider);
        this.selfBody = this.selfCollider.rigidBody;
        this.self = this.owner as Laya.Sprite;
        this.oriPosX = this.self.x;
        // console.log("oriPosX--" + this.oriPosX);

    }


    onDisable(): void {
    }

    onTriggerEnter(other: Laya.BoxCollider, self: Laya.BoxCollider, contact: any): void {
        if (self.label == "PlayerBullet") {
            if (other.label == "enemy") {
                // console.log("主角子弹击中敌人-敌人ID=", other.id);
                // this.owner.removeSelf();
                EventManager.instance.dispatcherEvt(GameEvent.PLAYER_BULLET_HIT_ENEMY, { o: other.owner, s: self.owner });
            } else if (other.label == "obstacle") {
                // console.log("主角子弹击中障碍物", other.id);
                // this.owner.removeSelf();
                EventManager.instance.dispatcherEvt(GameEvent.PLAYER_BULLET_HIT_OBSTACLE, { o: other.owner, s: self.owner });
            }
            return;
        } else if (self.label == "enemyBullet") {
            if (other.label == "player") {
                // console.log("敌人子弹击中主角--ID=", other.id, self.id);
                this.selfCollider.destroy();
                EventManager.instance.dispatcherEvt(GameEvent.ENEMY_BULLET_HIT_PLAYER, { o: other.owner, s: self.owner });
            }
        }
    }
    onTriggerExit(): void {
    }

    onTriggerStay(other: Laya.BoxCollider, self: Laya.BoxCollider, contact: any): void {
        // this.setSpeedZero();
    }

    onUpdate(): void {
        // console.log("self-", this.self.x);

        // if (Math.abs(this.self.x) - Math.abs(this.oriPosX) > Laya.Browser.clientWidth / 2) {
        //     console.log("bulletremoveSelf");
        //     this.owner.removeSelf();
        //     EventManager.instance.dispatcherEvt(GameEvent.BULLET_DISPOSE, this.owner)
        // }
    }
}