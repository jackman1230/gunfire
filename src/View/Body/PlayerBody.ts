import { EventManager } from "../../Manager/EventManager";
import GameEvent from "../../Control/GameEvent";

export default class PlayerBody extends Laya.Script {

    private selfCollider: Laya.BoxCollider;//角色碰撞体
    private selfBody: Laya.RigidBody;//角色刚体
    private lastBox: Laya.BoxCollider;

    private isJump: boolean = false;
    private jumpEnd: boolean = false;

    constructor() { super(); }

    onEnable(): void {
        this.selfCollider = this.owner.getComponent(Laya.BoxCollider);
        this.selfBody = this.selfCollider.rigidBody;

        EventManager.instance.addNotice(GameEvent.PLAYER_JUMP, this, this.jump);
    }

    private jump(): void {
        this.isJump = true;
    }

    onDisable(): void {
    }

    onTriggerEnter(other: Laya.BoxCollider, self: Laya.BoxCollider, contact: any): void {
        this.lastBox = other;
        // console.log(this.lastBox.label);
        if (other.label == "ground" && this.jumpEnd) {
            console.log("jumpend");
            this.isJump = false;
            this.jumpEnd = false;
            EventManager.instance.dispatcherEvt(GameEvent.PLAYER_COLLISION_GROUND);
            this.setSpeedZero();
        }
    }
    onTriggerExit(): void {
        console.log("onTriggerExit--");
        if (this.lastBox.label == "ground" && this.isJump) {
            console.log("jumpstart");
            this.jumpEnd = true;
        }
    }

    onTriggerStay(other: Laya.BoxCollider, self: Laya.BoxCollider, contact: any): void {
        if (this.isJump == false) {
            // console.log("onTriggerStay---");
            this.setSpeedZero();
        }
    }

    onUpdate(): void {
        // this.setSpeedZero();
    }
    /**防止斜坡有加速度，将速度设置为0 */
    private setSpeedZero(): void {
        this.selfBody.linearVelocity = { x: 0, y: 0 };
        this.selfBody.angularVelocity = 0;
        this.selfBody.setVelocity({ x: 0, y: 0 });
        this.selfBody.linearDamping = 0;
        this.selfBody.angularDamping = 0;
        this.selfBody.setAngle({ x: 0, y: 0 });
        this.selfCollider.refresh();
    }
}