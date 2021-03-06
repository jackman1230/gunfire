import { EventManager } from "../../Manager/EventManager";
import GameEvent from "../../Control/GameEvent";


export default class GoodsBody extends Laya.Script {

    private selfCollider: Laya.BoxCollider;//子弹碰撞体
    private selfBody: Laya.RigidBody;//子弹刚体

    private oriPosX: number;
    private self: Laya.Sprite;
    public isRemove: boolean = false;

    constructor() { super(); }

    onEnable(): void {
        this.selfCollider = this.owner.getComponent(Laya.BoxCollider);
        this.selfBody = this.selfCollider.rigidBody;
        this.self = this.owner as Laya.Sprite;
        this.oriPosX = this.self.x;
        this.isRemove = false;
        // console.log("oriPosX--" + this.oriPosX);

        // this.selfBody.linearDamping = 9;
    }


    onDisable(): void {
    }

    onTriggerEnter(other: Laya.BoxCollider, self: Laya.BoxCollider, contact: any): void {
        if (this.isRemove) return;
        if ((other.label == "ground" || other.label == "board")) {
            this.selfBody.type = "static";
            // console.log("onTriggerEnter--");
        }
    }
    onTriggerExit(): void {
    }

    onTriggerStay(other: Laya.BoxCollider, self: Laya.BoxCollider, contact: any): void {
        // this.setSpeedZero();
    }

    onUpdate(): void {

    }
    private setSpeedZero(): void {
        // this.selfBody.linearVelocity = { x: 0 };
        // this.selfBody.setVelocity({ x: 0 });
        // this.selfBody.angularDamping = 0;
        // this.selfCollider.refresh();
    }
}