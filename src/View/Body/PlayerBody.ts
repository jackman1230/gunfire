import { EventManager } from "../../Manager/EventManager";
import GameEvent from "../../Control/GameEvent";

export default class PlayerBody extends Laya.Script {

    private selfCollider: Laya.BoxCollider;//角色碰撞体
    private selfBody: Laya.RigidBody;//角色刚体
    private lastBox: Laya.BoxCollider;

    public playerState: number = 0;
    public startJump: boolean = false;
    public keyJump: boolean = false;
    public keyJumpEnd: boolean = false;

    constructor() { super(); }

    onEnable(): void {
        this.selfCollider = this.owner.getComponent(Laya.BoxCollider);
        this.selfBody = this.selfCollider.rigidBody;

    }

    onDisable(): void {
    }

    onTriggerEnter(other: Laya.BoxCollider, self: Laya.BoxCollider, contact: any): void {
        this.setSpeedZero();
        if ((other.label == "ground" || other.label == "obstacle" || other.label == "board") && this.keyJumpEnd) {
            this.keyJump = false;
            this.keyJumpEnd = false;

            this.selfBody.linearVelocity = { x: 0, y: 0 };
            this.selfBody.angularVelocity = 0;
            this.selfBody.angularDamping = 0;
            this.selfBody.linearDamping = 0;
            this.selfBody.setVelocity({ x: 0, y: 0 });
            this.selfCollider.refresh();
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
        // console.log("player--", (this.owner as Laya.Sprite).y);
        if ((this.owner as Laya.Sprite).y > 800) {
            EventManager.instance.dispatcherEvt(GameEvent.GOTO_HOLE);
        }

    }
    /**防止斜坡有加速度，将速度设置为0 */
    private setSpeedZero(): void {
        if (Laya.Physics.I.world == null) return;
        if (this.keyJump) {
            return;
            // this.selfBody.setAngle({ x: 0, y: 0 });
            // this.selfBody.linearVelocity = { x: 0, y: 0 };
            // this.selfBody.angularVelocity = 0;
            // this.selfBody.angularDamping = 0;
            // this.selfBody.linearDamping = 0;
            // this.selfBody.setVelocity({ x: 0, y: 6 });
        } else {
            // console.log("setSpeedZerosetSpeedZero");
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