import { EventManager } from "../../Manager/EventManager";
import GameEvent from "../../Control/GameEvent";

export default class PlayerBody extends Laya.Script {

    private selfCollider: Laya.BoxCollider;//角色碰撞体
    private selfBody: Laya.RigidBody;//角色刚体
    private lastBox: Laya.BoxCollider;

    private playerState: number = 0;
    private startJump: boolean = false;
    private keyJump: boolean = false;

    constructor() { super(); }

    onEnable(): void {
        this.selfCollider = this.owner.getComponent(Laya.BoxCollider);
        this.selfBody = this.selfCollider.rigidBody;

        EventManager.instance.addNotice(GameEvent.PLAYER_JUMP, this, this.jump);
        EventManager.instance.addNotice(GameEvent.PLAYER_RUN, this, this.run);
        EventManager.instance.addNotice(GameEvent.PLAYER_STAY, this, this.stay);
        EventManager.instance.addNotice(GameEvent.PLAYER_DEATH, this, this.death);

    }

    private jump(): void {
        this.keyJump = true;
        this.playerState = 2;
        this.setSpeedZero();
        // this.jumpEnd = false;
    }
    private run(): void {
        this.playerState = 1;
        this.setSpeedZero();
    }
    private death(): void {
        // this.playerState = 5;
        // this.setSpeedZero();
    }
    private stay(): void {
        this.playerState = 0;
        this.setSpeedZero();
    }

    onDisable(): void {
    }

    onTriggerEnter(other: Laya.BoxCollider, self: Laya.BoxCollider, contact: any): void {
        // this.lastBox = other;
        // console.log("onTriggerEnter---");
        // if (!this.keyJump)
        this.setSpeedZero();
        if ((other.label == "ground" || other.label == "obstacle") && this.keyJump) {
            //     console.log("jumpend");
            this.keyJump = false;
            //     this.startJump = false;
            EventManager.instance.dispatcherEvt(GameEvent.PLAYER_COLLISION_GROUND);
        }
        if (other.label == "goods") {
            EventManager.instance.dispatcherEvt(GameEvent.PLAYER_GET_GOODS, other.owner);
        }
    }
    onTriggerExit(): void {
        // console.log("onTriggerExit--");
        // if (this.lastBox.label == "ground" || this.lastBox.label == "obstacle") {
        //     if (this.keyJump) {
        //         console.log("jumpstart");
        //         this.startJump = true;
        //     }
        // }
    }

    onTriggerStay(other: Laya.BoxCollider, self: Laya.BoxCollider, contact: any): void {
        // if (this.isJump == false) {
        // console.log("onTriggerStay---");
        // this.setSpeedZero();
        // }
    }

    onUpdate(): void {
        // this.setSpeedZero();
    }
    /**防止斜坡有加速度，将速度设置为0 */
    private setSpeedZero(): void {
        if (Laya.Physics.I.world == null) return;
        if (this.keyJump) {
            this.selfBody.linearVelocity = { x: 0, y: 0 };
            this.selfBody.angularVelocity = 0;
            this.selfBody.angularDamping = 0;
            // this.selfBody.setAngle({ x: 0, y: 0 });
            this.selfBody.linearDamping = 0;
            this.selfBody.setVelocity({ x: 0, y: 6 });
        } else {
            this.selfBody.linearVelocity = { x: 0, y: 0 };
            this.selfBody.angularVelocity = 0;
            this.selfBody.angularDamping = 0;
            // this.selfBody.setAngle({ x: 0, y: 0 });
            this.selfBody.linearDamping = 0;
            this.selfBody.setVelocity({ x: 0, y: 0 });
        }
        this.selfCollider.refresh();
    }
}