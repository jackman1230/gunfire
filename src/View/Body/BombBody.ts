import { EventManager } from "../../Manager/EventManager";
import GameEvent from "../../Control/GameEvent";


export default class BombBody extends Laya.Script {

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
        console.log("oriPosX--" + this.oriPosX);

    }


    onDisable(): void {
    }

    onTriggerEnter(other: Laya.BoxCollider, self: Laya.BoxCollider, contact: any): void {
        if (self.label == "PlayerBomb" && other.label == "enemy") {
            console.log("主角扔雷击中敌人-敌人ID=", other.id);
            this.owner.removeSelf();
            EventManager.instance.dispatcherEvt(GameEvent.BOMB_HIT_ENEMY, this.owner);
            EventManager.instance.dispatcherEvt(GameEvent.BOMB_DISPOSE, this.owner);
            return;
        }
        if (self.label == "enemyBomb" && other.label == "player") {
            console.log("敌人扔雷击中主角-主角ID=", other.id);
            this.owner.removeSelf();
            EventManager.instance.dispatcherEvt(GameEvent.BOMB_HIT_ROLE, this.owner);
            EventManager.instance.dispatcherEvt(GameEvent.BOMB_DISPOSE, this.owner);
            return;
        }
        if (other.label == "ground") {
            console.log("雷撞墙了=", this.self.x, this.self.y);
            this.owner.removeSelf();
            EventManager.instance.dispatcherEvt(GameEvent.BOMB_DISPOSE, this.owner);
            return;
        }
    }
    onTriggerExit(): void {
    }

    onTriggerStay(other: Laya.BoxCollider, self: Laya.BoxCollider, contact: any): void {
        // this.setSpeedZero();
    }

    onUpdate(): void {
        // console.log("self-", this.self.x, this.self.y);
    }
}