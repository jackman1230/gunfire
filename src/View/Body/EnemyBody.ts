export default class EnemyBody extends Laya.Script {

    private selfCollider: Laya.BoxCollider;//角色碰撞体
    private selfBody: Laya.RigidBody;//角色刚体

    constructor() { super(); }

    onAwake(): void {
        this.selfCollider = this.owner.getComponent(Laya.BoxCollider);
        this.selfBody = this.selfCollider.rigidBody;

        this.selfCollider.label = "enemy";
        this.selfBody.label = "enemy";
    }

    onDisable(): void {
    }

    onTriggerEnter(other: Laya.BoxCollider, self: Laya.BoxCollider, contact: any): void {
        // if (other.label == "PlayerBullet") {
        //     console.log("behit--", this.selfBody.id);
        // }
    }
    onTriggerExit(): void {
    }

    onTriggerStay(other: Laya.BoxCollider, self: Laya.BoxCollider, contact: any): void {
        // this.setSpeedZero();
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