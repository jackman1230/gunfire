import { ViewManager } from "../Manager/ViewManager";
import { EventManager } from "../Manager/EventManager";
import GameEvent from "../Control/GameEvent";

export class PlayerSk {
    public role: Laya.Sprite;

    private weaponType: number = 1;
    public templet1: Laya.Templet;
    public weapon1: Laya.Templet;
    public weapon2: Laya.Templet;
    public weapon3: Laya.Templet;

    private body: Laya.Skeleton;
    private skin1: Laya.Skeleton;
    private skin2: Laya.Skeleton;
    private skin3: Laya.Skeleton;

    // private arm: Laya.Skeleton;

    private loadComplete1: boolean = false;
    private loadComplete2: boolean = false;
    private loadComplete3: boolean = false;
    private loadComplete4: boolean = false;

    private aniName: string = "";

    public static WEAPON_1: string = "weapons1";
    public static WEAPON_2: string = "weapons2";
    public static WEAPON_3: string = "weapons3";
    public static WEAPON_4: string = "weapons4";

    public static IDLE: string = "idle";
    public static RUN: string = "run";
    public static JUMP: string = "jump";
    public static CROUCH: string = "crouch";
    public static ATTACK_1: string = "attack1";
    public static ATTACK_2: string = "attack2";
    constructor() {
        this.role = new Laya.Sprite();
        this.role.x = 30;

        this.templet1 = new Laya.Templet();
        this.templet1.loadAni("res/zhujue_body.sk");
        this.templet1.on(Laya.Event.COMPLETE, this, this.parseComplete);

        this.weapon1 = new Laya.Templet();
        this.weapon1.loadAni("res/hero_arm.sk");
        this.weapon1.on(Laya.Event.COMPLETE, this, this.weaponComplete1);

        this.weapon2 = new Laya.Templet();
        this.weapon2.loadAni("res/hero_arm.sk");
        this.weapon2.on(Laya.Event.COMPLETE, this, this.weaponComplete2);

        this.weapon3 = new Laya.Templet();
        this.weapon3.loadAni("res/hero_arm.sk");
        this.weapon3.on(Laya.Event.COMPLETE, this, this.weaponComplete3);
    }

    public parseComplete(): void {
        this.loadComplete1 = true;
        this.body = this.templet1.buildArmature(0);
        // this.skin1.showSkinByName("weapons2");
        this.body.y = 110;
        this.body.play("idle", true);
        this.sendLoadComplete();
    }

    private weaponComplete1(): void {
        this.loadComplete2 = true;
        this.skin1 = this.weapon1.buildArmature(0);
        this.skin1.x = -7;
        this.skin1.y = 47;
        this.skin1.showSkinByName("weapons2");
        this.sendLoadComplete();
    }

    private weaponComplete2(): void {
        this.loadComplete3 = true;
        this.skin2 = this.weapon2.buildArmature(0);
        this.skin2.x = -7;
        this.skin2.y = 47;
        this.skin2.showSkinByName("weapons3");
        this.sendLoadComplete();
    }

    private weaponComplete3(): void {
        this.loadComplete4 = true;
        this.skin3 = this.weapon3.buildArmature(0);
        this.skin3.x = -7;
        this.skin3.y = 47;
        this.skin3.showSkinByName("weapons4");
        this.sendLoadComplete();
    }

    public setBodyIdle(): void {
        this.body.play("idle", true, false);
    }

    public setArmIdle(): void {
        this.arm.play("idle", true, false);
    }

    public setIdle(): void {
        this.setUp();
        this.setArmIdle();
        this.setBodyIdle();
    }

    public setRun(): void {
        this.body.play("run", true, false);
        this.setUp();
    }
    public setJump(): void {
        this.body.play("jump", true, false);
        this.setUp();
    }
    public setCrouch(): void {
        this.body.play("crouch", true, false);
        this.setDown();
    }
    public setAttack1(): void {
        this.arm.play("attack3", true, false);
        this.aniName = "attack3";
    }
    public setAttack2(): void {
        this.arm.play("attack2", true, false);
        this.aniName = "attack2";
    }

    public setFaceUp45(): void {
        this.arm.rotation = -45;
    }

    public setFaceUp90(): void {
        this.arm.rotation = -90;
    }
    public setWeapon(type: number): void {
        console.log("ssss--", type);
        this.weaponType = type;
        this.arm.stop();
        this.role.removeChildren();
        this.role.addChild(this.body);
        this.role.addChild(this.arm);
        this.arm.play(this.aniName, true, false);
        ViewManager.instance.rolePlayer.roleSprite.addChild(this.role);
    }

    private sendLoadComplete(): void {
        if (this.loadComplete1 && this.loadComplete2 && this.loadComplete3 && this.loadComplete4) {
            EventManager.instance.dispatcherEvt(GameEvent.ROLE_ANI_COMPLETE);
        }
    }

    public get arm(): Laya.Skeleton {
        if (this.weaponType == 1) {
            return this.skin1;
        } else if (this.weaponType == 2) {
            return this.skin2;
        } else if (this.weaponType == 3) {
            return this.skin3;
        }
        return this.skin1;
    }

    private setDown(): void {
        this.arm.rotation = 0;
        this.skin1.y = this.skin2.y = this.skin3.y = 62;
    }

    private setUp(): void {
        this.arm.rotation = 0;
        this.skin1.y = this.skin2.y = this.skin3.y = 47
    }


}