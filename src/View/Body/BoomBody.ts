import { EventManager } from "../../Manager/EventManager";
import GameEvent from "../../Control/GameEvent";
import { ViewManager } from "../../Manager/ViewManager";
import { GameData } from "../../Data/GameData";


export default class BoomBody extends Laya.Script {

    private selfCollider: Laya.CircleCollider;//子弹碰撞体
    private selfBody: Laya.RigidBody;//子弹刚体

    private oriPosX: number;
    private self: Laya.Sprite;

    public isRemove: boolean = false;

    constructor() { super(); }

    onEnable(): void {
        this.selfCollider = this.owner.getComponent(Laya.CircleCollider);
        this.selfBody = this.selfCollider.rigidBody;
        this.self = this.owner as Laya.Sprite;
        this.oriPosX = this.self.x;
        // console.log("oriPosX--" + this.oriPosX);

    }


    onDisable(): void {
    }

    onTriggerEnter(other: Laya.BoxCollider, self: Laya.BoxCollider, contact: any): void {
        // if (this.isRemove) return;
        // if (self.label == "PlayerBomb") {
        //     if (other.label == "enemy") {
        //         // console.log("主角扔雷击中敌人-敌人ID=", other.id);
        //         EventManager.instance.dispatcherEvt(GameEvent.PLAYER_BOMB_HIT_ENEMY, { o: other.owner, s: self.owner, d: GameData.BOMB_DAMAGE });
        //         // EventManager.instance.dispatcherEvt(GameEvent.BOMB_DISPOSE, this.owner);
        //         this.owner.removeSelf();
        //         this.isRemove = true;
        //         ViewManager.instance.showShake(ViewManager.instance.warView.warView.displayObject, 30, 300, 6);
        //     } else if (other.label == "obstacle") {
        //         // console.log("主角扔雷击中障碍物", other.id);
        //         // EventManager.instance.dispatcherEvt(GameEvent.BOMB_DISPOSE, this.owner);
        //         EventManager.instance.dispatcherEvt(GameEvent.PLAYER_BOMB_HIT_OBSTACLE, { o: other.owner, s: self.owner, d: GameData.BOMB_DAMAGE });
        //         this.owner.removeSelf();
        //         this.isRemove = true;
        //         ViewManager.instance.showShake(ViewManager.instance.warView.warView.displayObject, 30, 300, 6);
        //     }
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