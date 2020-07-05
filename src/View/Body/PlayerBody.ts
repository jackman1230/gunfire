import { EventManager } from "../../Manager/EventManager";
import GameEvent from "../../Control/GameEvent";

export default class PlayerBody extends Laya.Script {

    private selfCollider: Laya.BoxCollider;//角色碰撞体
    private selfBody: Laya.RigidBody;//角色刚体
    private lastBox: Laya.BoxCollider;

    public playerState: number = 0;
    public startJump: boolean = false;
    public keyJump: boolean = false;

    constructor() { super(); }

    onEnable(): void {
        this.selfCollider = this.owner.getComponent(Laya.BoxCollider);
        this.selfBody = this.selfCollider.rigidBody;

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

        this.setSpeedZero();
        if ((other.label == "ground" || other.label == "obstacle" || other.label == "board") && this.keyJump) {

            this.keyJump = false;
            EventManager.instance.dispatcherEvt(GameEvent.PLAYER_COLLISION_GROUND);
        }
        if (other.label == "goods") {
            EventManager.instance.dispatcherEvt(GameEvent.PLAYER_GET_GOODS, other.owner);
        }
    }
    onTriggerExit(): void {
    }

    onTriggerStay(other: Laya.BoxCollider, self: Laya.BoxCollider, contact: any): void {

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