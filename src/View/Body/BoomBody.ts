import { EventManager } from "../../Manager/EventManager";
import GameEvent from "../../Control/GameEvent";


export default class BoomBody extends Laya.Script {

    private selfCollider: Laya.CircleCollider;//子弹碰撞体
    private selfBody: Laya.RigidBody;//子弹刚体

    private oriPosX: number;
    private self: Laya.Sprite;

    constructor() { super(); }

    onEnable(): void {
        this.selfCollider = this.owner.getComponent(Laya.CircleCollider);
        this.selfBody = this.selfCollider.rigidBody;
        this.self = this.owner as Laya.Sprite;
        this.oriPosX = this.self.x;
        console.log("oriPosX--" + this.oriPosX);

    }


    onDisable(): void {
    }

    onTriggerEnter(other: Laya.BoxCollider, self: Laya.BoxCollider, contact: any): void {
        // if (self.label == "PlayerBullet" && other.label == "enemy") {
        //     console.log("主角击中敌人-敌人ID=", other.id);
        //     this.owner.removeSelf();
        //     EventManager.instance.dispatcherEvt(GameEvent.BULLET_HIT_ENEMY, this.owner);
        //     return;
        // }
        // if (self.label == "enemyBullet" && other.label == "player") {
        //     console.log("敌人击中主角-主角ID=", other.id);
        //     this.owner.removeSelf();
        //     EventManager.instance.dispatcherEvt(GameEvent.BULLET_HIT_ROLE, this.owner);
        //     return;
        // }
    }
    onTriggerExit(): void {
    }

    onTriggerStay(other: Laya.BoxCollider, self: Laya.BoxCollider, contact: any): void {
        // this.setSpeedZero();
    }

    onUpdate(): void {
        // console.log("boomself-", this.self.x, this.self.y);

        // if (Math.abs(this.self.x) - Math.abs(this.oriPosX) > Laya.Browser.clientWidth / 2) {
        //     console.log("bulletremoveSelf");
        //     this.owner.removeSelf();
        //     EventManager.instance.dispatcherEvt(GameEvent.BULLET_DISPOSE, this.owner)
        // }
    }
}