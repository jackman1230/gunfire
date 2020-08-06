import { EventManager } from "../../Manager/EventManager";
import GameEvent from "../../Control/GameEvent";
import { GameData } from "../../Data/GameData";
import { ViewManager } from "../../Manager/ViewManager";


export default class BombBody extends Laya.Script {

    private selfCollider: Laya.BoxCollider;//子弹碰撞体
    private selfBody: Laya.RigidBody;//子弹刚体

    private oriPosX: number;
    private self: Laya.Sprite;

    private isRemove: boolean = false;

    constructor() { super(); }

    onEnable(): void {
        this.selfCollider = this.owner.getComponent(Laya.BoxCollider);
        this.selfBody = this.selfCollider.rigidBody;
        this.self = this.owner as Laya.Sprite;
        this.oriPosX = this.self.x;
        this.isRemove = false;
        // console.log("oriPosX--" + this.oriPosX);

    }


    onDisable(): void {
    }

    onTriggerEnter(other: Laya.BoxCollider, self: Laya.BoxCollider, contact: any): void {
        if (this.isRemove) return;
        if (self.label == "PlayerBomb") {
            if (other.label == "enemy") {
                // console.log("主角扔雷击中敌人-敌人ID=", other.id);
                EventManager.instance.dispatcherEvt(GameEvent.PLAYER_BOMB_HIT_ENEMY, { o: other.owner, s: self.owner, d: GameData.BOMB_DAMAGE });
                // EventManager.instance.dispatcherEvt(GameEvent.BOMB_DISPOSE, this.owner);
                this.owner.removeSelf();
                this.isRemove = true;
                ViewManager.instance.showShake(ViewManager.instance.warView.warView.displayObject, 30, 300, 6);
            } else if (other.label == "obstacle") {
                // console.log("主角扔雷击中障碍物", other.id);
                // EventManager.instance.dispatcherEvt(GameEvent.BOMB_DISPOSE, this.owner);
                EventManager.instance.dispatcherEvt(GameEvent.PLAYER_BOMB_HIT_OBSTACLE, { o: other.owner, s: self.owner, d: GameData.BOMB_DAMAGE });
                this.owner.removeSelf();
                this.isRemove = true;
                ViewManager.instance.showShake(ViewManager.instance.warView.warView.displayObject, 30, 300, 6);
            }
        } else if (self.label == "enemyBomb" && other.label == "player") {
            // console.log("敌人扔雷击中主角-主角ID=", other.id);
            EventManager.instance.dispatcherEvt(GameEvent.ENEMY_BOMB_HIT_PLAYER, { o: other.owner, s: self.owner });
            this.owner.removeSelf();
            this.isRemove = true;
            // EventManager.instance.dispatcherEvt(GameEvent.BOMB_DISPOSE, this.owner);
            return;
        }
        if (other.label == "ground") {
            // console.log("雷撞墙了=", this.self.x, this.self.y);
            EventManager.instance.dispatcherEvt(GameEvent.BOMB_DISPOSE, { o: other.owner, s: self.owner });
            this.owner.removeSelf();
            this.isRemove = true;
            if (self.label == "PlayerBomb")
                ViewManager.instance.showShake(ViewManager.instance.warView.warView.displayObject, 30, 300, 6);
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