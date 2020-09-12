
import { ViewManager } from "../Manager/ViewManager";
import PlayerBody from "./Body/PlayerBody";
import { EventManager } from "../Manager/EventManager";
import GameEvent from "../Control/GameEvent";
import { GameManager } from "../Manager/GameManager";
import { PlayerData } from "../Data/PlayerData";
import { SoundManager } from "../Manager/SoundManager";
import PlayerCtlView from "./PlayerCtlView";
import PlayerBullet from "./PlayerBullet";
import { ui } from "../ui/layaMaxUI";
import { GameData, BombData } from "../Data/GameData";
import PlayerDirView from "./PlayerDirView";
import { PlayerSk } from "./PlayerSk";

export class Player extends Laya.Script {

    public playerSk: PlayerSk;
    // private roleAni: Laya.Skeleton;
    // public rolePlayer: WXFUI_Player;
    // public body: fairygui.GLoader;

    public direction: number = 1;//方向1为右，-1为左

    public sRun: boolean = false;//人物是否在跑
    public sFire: boolean = false;//机枪，手枪连续射击
    private sBoom: boolean = false;
    private keyRight: boolean = false;
    private keyLeft: boolean = false;
    private keyJump: boolean = false;
    // private stillRifle: boolean = false;
    public isSquatDown: boolean = false;
    // private faceUp: boolean = false;

    private speed: number = 5;
    private jumpHigh: number = 200;
    public weaponType: number = 1;

    public roleSprite: Laya.Sprite;
    public roleBody: Laya.RigidBody;
    public roleBox: Laya.BoxCollider;
    public bodyScript: PlayerBody;

    //操作控制界面
    public playerCtlView: PlayerCtlView;
    //方向控制界面
    public playerDirView: PlayerDirView;
    public faceType: number = 1;//面朝向

    constructor() { super() }

    public createView() {
        // console.log("createViewPlayer");

        this.playerSk = new PlayerSk();
        this.roleSprite = new ui.PlayerBodyUI();
        if (!this.playerCtlView) this.playerCtlView = new PlayerCtlView();
        if (!this.playerDirView) this.playerDirView = new PlayerDirView();

        EventManager.instance.addNotice(GameEvent.ROLE_ANI_COMPLETE, this, this.loadComplete);

        // this.playerSk.templet.on(Laya.Event.COMPLETE, this, this.loadComplete);
        // this.loadComplete();
        // Laya.Scene.load("PlayerBody.scene", Laya.Handler.create(this, this.loadComplete));
    };

    public loadComplete(): void {
        // console.log("loadComplete");
        this.roleBody = this.roleSprite.getComponent(Laya.RigidBody);
        this.roleBox = this.roleSprite.getComponent(Laya.BoxCollider);

        // this.roleSprite.addChild(this.rolePlayer.displayObject);
        this.roleSprite.addComponent(PlayerBody);
        this.bodyScript = this.roleSprite.getComponent(PlayerBody);
        this.playerDirView.view.m_dirBtn.y = this.playerDirView.view.m_dirBtn.x = 0;
        // this.addEvent();

        this.resetData();
        // this.setStay();
    }

    private addEvent(): void {
        EventManager.instance.addNotice(GameEvent.PLAYER_COLLISION_GROUND, this, this.colliGround);
        EventManager.instance.addNotice(GameEvent.ENEMY_BULLET_HIT_PLAYER, this, this.beHit);
        EventManager.instance.addNotice(GameEvent.ENEMY_BOMB_HIT_PLAYER, this, this.beHit);
        EventManager.instance.addNotice(GameEvent.CHANGE_PLAYER_WEAPON, this, this.changeWeaponType);
        EventManager.instance.addNotice(GameEvent.GOTO_HOLE, this, this.gotoHole);

        Laya.stage.on(Laya.Event.KEY_DOWN, this, this.keyDowmEvent);
        Laya.stage.on(Laya.Event.KEY_UP, this, this.keyUpEvent);
        this.playerCtlView.view.m_fire.on(Laya.Event.MOUSE_DOWN, this, this.keyFireDown);
        this.playerCtlView.view.m_fire.on(Laya.Event.MOUSE_UP, this, this.keyFireUp);
        this.playerCtlView.view.m_fire.on(Laya.Event.MOUSE_OUT, this, this.keyFireUp);
        this.playerCtlView.view.m_bomb.on(Laya.Event.CLICK, this, this.onClickBomb);
        this.playerCtlView.view.m_jump.on(Laya.Event.CLICK, this, this.onClickJump);
        this.playerDirView.view.m_mask.on(Laya.Event.MOUSE_DOWN, this, this.addMouseDown);
        this.playerDirView.view.m_mask.on(Laya.Event.MOUSE_UP, this, this.addCtlViewMouseUp);
        this.playerDirView.view.m_mask.on(Laya.Event.MOUSE_OUT, this, this.addCtlViewMouseUp);
        // this.playerDirView.view.m_mask.on(Laya.Event.MOUSE_UP, this, this.addCtlViewMouseUp);

    }

    public resetData(): void {
        this.addEvent();
        ViewManager.instance.clearAddGold();
        if (GameManager.instance.buyWeaponType > 0) {
            GameManager.instance.roleInfo.weaponType = GameManager.instance.buyWeaponType;
            GameManager.instance.roleInfo.bulletNum = GameManager.instance.buyBullet;
        } else {
            GameManager.instance.roleInfo.weaponType = 1;
            GameManager.instance.roleInfo.bulletNum = 0;
        }
        ViewManager.instance.warView.scene.addChild(this.roleSprite);
        GameManager.instance.roleInfo.bombNum = GameManager.instance.buyGre;
        ViewManager.instance.playerInfoView.updateAllView();
        this.changeWeaponType(GameManager.instance.roleInfo.weaponType);
        this.playerDirView.view.m_dirBtn.y = this.playerDirView.view.m_dirBtn.x = 0;
        var d: any = GameManager.instance.curLvData;
        this.roleSprite.x = d.rolePos[0];
        this.roleSprite.y = d.rolePos[1];
        // console.log("ddd--");
        // console.log(this.roleSprite.x);

        // Laya.timer.frameOnce(1, this, () => {
        // })

        // GameManager.instance.roleInfo.bulletNum = 1000;
        this.sBoom = false;
        this.sRun = false;
        // this.stillRifle = false;
        this.playerSk.role.visible = true;
        this.setFireEnd();
        this.jumpEnd();
        this.faceType = 1;
        this.setFaceDirection();
        this.setStay();
        GameManager.instance.roleInfo.isInvincible = false;
        this.playerSk.hideWuDi();
        Laya.timer.clear(this, this.moveMap);
        this.acMove = false;
        GameManager.instance.buyBullet = 0;
        GameManager.instance.buyGre = 10;
        GameManager.instance.buyWeaponType = 0;

    }
    private acMove: boolean = false;
    private activeMove(): void {
        if (this.acMove) return;
        this.acMove = true;
        Laya.timer.loop(500, this, this.moveMap);
    }
    //原地复活加无敌
    public playerRes(): void {
        this.addCtlViewMouseUp(null);
        this.addEvent();
        this.sBoom = false;
        this.sRun = false;
        // this.stillRifle = false;
        this.playerSk.role.visible = true;
        this.keyJump = false;
        this.keyFireUp();
        this.playerDirView.view.m_dirBtn.y = this.playerDirView.view.m_dirBtn.x = 0;
        Laya.timer.clearAll(this);
        Laya.timer.loop(500, this, this.moveMap);
        this.setStay();
        // Laya.timer.once(3000, this, this.cancleInvincible);
        // this.bodyLeg.color = "#ffff00";
        // this.bodybody.color = "#ffff00";
        if (this.roleSprite.y > 800) {
            this.roleSprite.y = 580;
            this.roleSprite.x -= 200;
            // console.log("this.roleSprite.x222222", this.roleSprite.x);
        }
        this.playerSk.showWuDi();
    }

    //取消无敌
    // private cancleInvincible(): void {
    //     GameManager.instance.roleInfo.isInvincible = false;
    //     this.setColor();
    // }
    //掉到洞里面去了
    private gotoHole(): void {
        this.setDeath();
    }

    //取消方向控制
    private addCtlViewMouseUp(e: Laya.Event): void {
        this.playerDirView.view.m_mask.off(Laya.Event.MOUSE_MOVE, this, this.onMoveHandle);
        this.playerDirView.view.m_dirBtn.y = this.playerDirView.view.m_dirBtn.x = 0;
        this.setFaceDirection();
        this.setStandUp();
        this.stopMove();
    }

    private setFaceDirection(): void {
        if (this.faceType > 0) {
            this.faceType = this.direction = 1;
            this.setFaceRight();
        } else {
            this.faceType = this.direction = -1;
            this.setFaceLeft();
        }
    }

    private keyFire: boolean = false;
    private keyFireDown(): void {
        this.keyFire = true;
        this.setFire();
    }

    private keyFireUp(): void {
        this.keyFire = false;
        if (GameManager.instance.roleInfo.isDeath) return;
        this.setFireEnd();
    }


    private curTouchId: number = 0;
    private addMouseDown(e: Laya.Event): void {
        this.curTouchId = e.touchId;
        this.setDirection();
        this.playerDirView.view.m_mask.on(Laya.Event.MOUSE_MOVE, this, this.onMoveHandle);
    }

    private onMoveHandle(e: Laya.Event): void {
        if (e.touchId != this.curTouchId) return;
        this.setDirection();
    }

    private setDirection(): void {
        var pos: Laya.Point = this.playerDirView.view.globalToLocal(Laya.stage.mouseX, Laya.stage.mouseY)
        pos.x += 131;
        pos.y += 131;

        this.playerDirView.view.m_dirBtn.x = pos.x;
        this.playerDirView.view.m_dirBtn.y = pos.y;
        if (pos.x > 130)
            this.playerDirView.view.m_dirBtn.x = 130;
        if (pos.x < -130)
            this.playerDirView.view.m_dirBtn.x = -130;
        if (pos.y > 130)
            this.playerDirView.view.m_dirBtn.y = 130;
        if (pos.y < -130)
            this.playerDirView.view.m_dirBtn.y = -130;
        this.faceType = GameManager.instance.roleInfo.direction = ViewManager.instance.getPlayerDirection(pos);
        this.setFaceType();
    }

    private setFaceType(): void {
        if (this.faceType > 0) {
            this.setFaceRight();
            if (this.faceType == 1) {
                this.direction = 1;
                this.setStandUp();
                this.setRightRun();
            } else {
                this.sRun = false;
                Laya.timer.clear(this, this.stillRun);
                if (this.faceType == 5) {
                    this.setSquatDown();
                } else if (this.faceType == 4 || this.faceType == 3) {
                    this.setFaceUp();
                } else {
                    this.setStandUp();
                }
            }
        } else {
            this.setFaceLeft();
            if (this.faceType == -1) {
                this.direction = -1;
                this.setStandUp();
                this.setLeftRun();
            } else {
                this.sRun = false;
                Laya.timer.clear(this, this.stillRun);
                if (this.faceType == -5) {
                    this.setSquatDown();
                } else if (this.faceType == -4 || this.faceType == -3) {
                    this.setFaceUp();
                } else
                    this.setStandUp();
            }
        }
    }

    //蹲下
    private setSquatDown(): void {
        if (this.isSquatDown) return
        this.isSquatDown = true;
        // this.faceUp = false;
        // this.roleAni.y += 20;
        // this.roleBox.height = 70;
        this.playerSk.setCrouch();

    }
    private setStandUp(): void {
        if (!this.isSquatDown) return;
        this.isSquatDown = false;
        this.playerSk.setIdle();
    }
    private setFaceRight(): void {
        this.playerSk.role.skewY = 0;
        this.keyRight = true;
        this.keyLeft = false;
        // this.playerSk.setIdle();
        // this.setPlayerDir();
    }

    private setFaceUp(): void {
        if (Math.abs(this.faceType) == 3) {
            this.playerSk.setFaceUp45();
        } else if (Math.abs(this.faceType) == 4) {
            this.playerSk.setFaceUp90();
        }
        if (!this.keyJump)
            this.playerSk.setBodyIdle();
    }

    private setFaceLeft(): void {
        this.keyLeft = true;
        this.keyRight = false;
        this.playerSk.role.skewY = 180;
        // this.playerSk.setIdle();
        // this.setPlayerDir();
    }
    private onClickBomb(): void {
        if (this.sBoom) return;
        if (GameManager.instance.roleInfo.bombNum <= 0) return;
        this.setBoom();
    }

    private onClickJump(): void {
        if (this.keyJump) return;
        this.setJump();
    }

    public setLeftRun(): void {
        if (this.sRun) return;
        this.setRun();
        this.stillRun();
    }

    public setRightRun(): void {
        if (this.sRun) return;
        this.setRun();
        this.stillRun();
    }

    private colliGround(): void {
        this.jumpEnd();
    }

    private jummpTween: laya.utils.Tween;
    public setJump(): void {
        this.isSquatDown = false;
        // this.faceUp = false;
        this.keyJump = this.bodyScript.keyJump = true;
        this.setBoomComplete();
        // this.bodyLeg.url = "ui://Game/legJump";
        this.playerSk.setJump();
        this.roleBody.setVelocity({ x: 0, y: -11 });
        this.roleBox.refresh();
        Laya.timer.once(200, this, this.jumpHighHandle);
        // this.jummpTween = Laya.Tween.to(this.roleSprite, { y: this.roleSprite.y - this.jumpHigh }, 350, null, Laya.Handler.create(this, this.jumpHighHandle));
    }

    private jumpHighHandle(): void {
        this.bodyScript.keyJumpEnd = true;
        // EventManager.instance.dispatcherEvt(GameEvent.PLAYER_JUMP);
    }

    private jumpEnd(): void {
        this.keyJump = false;
        this.stopMove();
        if (GameManager.instance.roleInfo.isDeath) return;
        if (this.sBoom) {
            this.setBoomComplete();
        }
    }

    public setRun(): void {
        // this.faceUp = false;
        this.activeMove();
        if (!this.keyJump)
            this.playerSk.setRun();
        this.sRun = true;
        Laya.timer.clear(this, this.stillRun);
        Laya.timer.frameLoop(1, this, this.stillRun);
    }

    private moveMap(): void {
        if (Math.abs(ViewManager.instance.warView.warView.x) + Laya.stage.width > ViewManager.instance.warView.warView.width - 200)
            return;
        // console.log("ddd--22222");
        // console.log(this.roleSprite.x);
        if (this.roleSprite.x - Math.abs(ViewManager.instance.warView.warView.x) - this.roleSprite.width / 2 >= Laya.stage.width / 2) {
            var dis: number = this.roleSprite.x - Math.abs(ViewManager.instance.warView.warView.x) - Laya.stage.width / 2;
            ViewManager.instance.updateViewPort(dis);
        }
    }

    // public tweenRun: boolean = false;
    public stillRun(): void {
        if (this.direction == 1) {
            this.roleSprite.x += this.speed;
            if (this.roleSprite.x > ViewManager.instance.warView.warView.width - this.roleSprite.width - 200) {
                this.roleSprite.x = ViewManager.instance.warView.warView.width - this.roleSprite.width - 200;
                // return;
            }

            // console.log("this.roleSprite.x ", this.roleSprite.x);
            if (Math.abs(ViewManager.instance.warView.warView.x) + Laya.stage.width > ViewManager.instance.warView.warView.width - 200)
                return;
        } else if (this.direction == -1) {
            this.roleSprite.x -= this.speed;
            // console.log("this.roleSprite.x----", this.roleSprite.x);
            if (this.roleSprite.x < Math.abs(ViewManager.instance.warView.warView.x))
                this.roleSprite.x = Math.abs(ViewManager.instance.warView.warView.x);
        }
    }


    public setFire(): void {
        if (this.sFire) return;
        if (GameManager.instance.roleInfo.isDeath) return;
        this.playWeaponSound();
        Laya.timer.clear(this, this.stillFire);
        this.sFire = true;
        if (this.weaponType != PlayerData.WEAPON_PIS) {
            EventManager.instance.dispatcherEvt(GameEvent.USE_PLAYER_BULLET);
        }
        if (this.weaponType == PlayerData.WEAPON_RIFLE) {//如果是来福枪
            this.playerSk.setAttack2();
            // this.playerSk.setAttack1();
            ViewManager.instance.createSanBullet();
        } else {//如果是子弹枪
            this.playerSk.setAttack1();
            ViewManager.instance.createBullet();
        }
        Laya.timer.loop(150, this, this.stillFire);
    }

    private stillFire(): void {
        // if (this.sBoom) return;
        this.playWeaponSound();
        // ViewManager.instance.createBullet();
        if (this.weaponType != PlayerData.WEAPON_PIS) {
            EventManager.instance.dispatcherEvt(GameEvent.USE_PLAYER_BULLET);
        }
        if (this.weaponType == PlayerData.WEAPON_RIFLE) {//如果是来福枪
            ViewManager.instance.createSanBullet();
        } else {//如果是子弹枪
            ViewManager.instance.createBullet();
        }
    }

    private rilfeComplete(): void {
        // this.stillRifle = false;
        if (this.keyFire) {
            this.setFire();
        } else {
            this.setFireEnd();
        }
    }

    private setFireEnd(): void {
        Laya.timer.clear(this, this.stillFire);
        this.sFire = false;
        this.playerSk.setArmIdle();
        // if (this.sRun) {
        //     this.playerSk.setRun();
        // } else {
        // }
    }


    public setBoom(): void {
        this.sBoom = true;
        EventManager.instance.dispatcherEvt(GameEvent.USE_PLAYER_BOMB);

        Laya.timer.once(600, this, this.setBoomComplete);
        ViewManager.instance.createBomb(BombData.BOMB_MY_GRE, this.direction, ViewManager.instance.getBodyCenterPos(this.roleSprite), true);
    }

    private setBoomComplete(): void {
        this.sBoom = false;
    }


    public stopMove(): void {
        if (GameManager.instance.roleInfo.isDeath) return;
        Laya.timer.clear(this, this.stillRun);
        this.keyLeft = false;
        this.keyRight = false;
        this.sRun = false;
        this.playerSk.setBodyIdle();
        this.playerSk.setUp();
        // this.bodyLeg.url = "ui://Game/legStay";
    }

    public setStay(): void {
        if (this.faceType > 0) {
            this.direction = 1;
            this.playerSk.role.skewY = 0;
        } else {
            this.direction = -1;
            this.playerSk.role.skewY = 180;
        }
        Laya.timer.clear(this, this.stillFire);
        // this.body.url = "ui://Game/player_stay_" + this.weaponType + "_" + Math.abs(this.faceType);
        this.stopMove();
    }

    private changeWeaponType(type: number): void {
        this.weaponType = GameManager.instance.roleInfo.weaponType = type;
        if (this.sFire) {
            Laya.timer.clear(this, this.stillFire);
            this.sFire = false;
            this.setFire();
        }
        this.playerSk.setWeapon(type);

    }

    private setDeath(): void {
        if (GameManager.instance.roleInfo.isDeath) return;
        this.playerSk.role.visible = false;
        Laya.timer.clearAll(this);
        this.removeEvent();
        this.setFireEnd();
        this.stopMove();
        // this.rolePlayer.m_firePos1.visible = this.rolePlayer.m_firePos2.visible = false;
        GameManager.instance.roleInfo.isDeath = true;
        // this.body.url = "ui://Game/player_death";
        // this.bodybody.content.setPlaySettings(0, -1, 1, this.bodybody.content.frameCount - 1, Laya.Handler.create(this, this.deathComplete));
        this.playDeathSound();
        ViewManager.instance.showAfterWarView(3);
    }

    public victoryGame(): void {
        this.setStay();
        this.removeEvent();
        Laya.timer.clearAll(this);
        this.roleSprite.removeSelf();
        GameManager.instance.roleInfo.curlvCoin += GameData.VICTORY_LEVEL_COIN;
        GameManager.instance.roleInfo.totalCoin += GameData.VICTORY_LEVEL_COIN;
        ViewManager.instance.playerInfoView.updateCoin();
    }

    private playDeathSound(): void {
        var s: number = 1;
        var r: number = Math.random();
        if (r > 0.75) s = 4;
        if (r > 0.5) s = 3;
        if (r > 0.25) s = 2;
        s = 1;
        SoundManager.instance.playSound("die_" + s);
    }

    private playWeaponSound(): void {
        if (this.weaponType == 3) {
            SoundManager.instance.playSound("weapon_10");
        } else
            SoundManager.instance.playSound("weapon_" + this.weaponType);


    }

    private deathComplete(): void {
        // EventManager.instance.dispatcherEvt(GameEvent.PLAYER_DEATH)
    }

    private disposeEnemyBullet(s: any): void {

    }
    public beHit(s: any): void {
        this.disposeEnemyBullet(s);
        // console.log("playerBehit");
        if (GameManager.instance.roleInfo.isInvincible) return;
        if (GameManager.instance.roleInfo.isDeath) return;
        GameManager.instance.roleInfo.blood--;
        EventManager.instance.dispatcherEvt(GameEvent.DEC_PLAYER_BLOOD);
        ViewManager.instance.createDamageView(0.2, this.roleSprite);
        this.playerSk.beHit();
        if (GameManager.instance.roleInfo.blood <= 0) {
            GameManager.instance.roleInfo.blood = 0;
            this.setDeath();
            return;
        }
    }
    private setColor(): void {
        // if (GameManager.instance.roleInfo.isDeath) return;
        // this.roleAni.set = "#ffffff";
        // this.bodybody.color = "#ffffff";
    }

    public dispose(): void {
        this.removeEvent();

        Laya.timer.clearAll(this);
        this.roleSprite.removeChildren();
        this.roleSprite.removeSelf();
        // this.rolePlayer.dispose();
        this.roleSprite.destroy();
        this.roleSprite = null;
        this.recover();
    }

    private removeEvent(): void {
        this.playerCtlView.view.m_fire.off(Laya.Event.MOUSE_DOWN, this, this.setFire);
        this.playerCtlView.view.m_fire.off(Laya.Event.MOUSE_UP, this, this.setFireEnd);
        this.playerCtlView.view.m_fire.off(Laya.Event.MOUSE_OUT, this, this.setFireEnd);
        this.playerCtlView.view.m_bomb.off(Laya.Event.CLICK, this, this.onClickBomb);
        this.playerCtlView.view.m_jump.off(Laya.Event.CLICK, this, this.onClickJump);
        this.playerDirView.view.m_mask.off(Laya.Event.MOUSE_DOWN, this, this.addMouseDown);
        this.playerDirView.view.m_mask.off(Laya.Event.MOUSE_UP, this, this.addCtlViewMouseUp);
        this.playerDirView.view.m_mask.off(Laya.Event.MOUSE_OUT, this, this.addCtlViewMouseUp);

        Laya.stage.off(Laya.Event.KEY_DOWN, this, this.keyDowmEvent);
        Laya.stage.off(Laya.Event.KEY_UP, this, this.keyUpEvent);

        EventManager.instance.offNotice(GameEvent.PLAYER_COLLISION_GROUND, this, this.colliGround);
        EventManager.instance.offNotice(GameEvent.ENEMY_BULLET_HIT_PLAYER, this, this.beHit);
        EventManager.instance.offNotice(GameEvent.ENEMY_BOMB_HIT_PLAYER, this, this.beHit);
        EventManager.instance.offNotice(GameEvent.CHANGE_PLAYER_WEAPON, this, this.changeWeaponType);

    }

    protected recover(): void {
        Laya.Pool.recover("player", this);
    }


    private keyUpEvent(e: any): void {
        var keyCode: number = e["keyCode"];
        switch (keyCode) {
            case 87:
                this.setFireEnd();
                break;
            case 65:
                this.keyLeft = false;
                if (this.keyRight == false) {
                    this.sRun = false;
                    if (this.keyJump == false)
                        this.stopMove();
                }
                break;
            case 68:
                this.keyRight = false;
                if (this.keyLeft == false) {
                    this.sRun = false;
                    if (this.keyJump == false)
                        this.stopMove();
                }
                break;

        }
    }

    private keyDowmEvent(e: any): void {
        var keyCode: number = e["keyCode"];
        switch (keyCode) {
            case 87:
                // this.setFire();
                console.log("上");
                // this.setStandUp();
                // this.isSquatDown = false;
                // this.roleSprite.y -= 20;
                // this.roleBox.height = 90;
                // this.rolePlayer.y = 0;
                // this.faceType = 3;
                // this.setFaceType();
                // this.setBoom();
                this.faceType = 3;
                this.setFaceType();
                break;
            case 83:
                console.log("下");
                // this.isSquatDown = true;
                // this.roleSprite.y += 20;
                // this.roleBox.height = 70;
                // this.rolePlayer.y = -20;
                // this.setSquatDown();
                this.faceType = -3;
                this.setFaceType();
                break;
            case 65:
                this.keyLeft = true;
                this.playerSk.role.skewY = 180;
                if (this.sRun) return;
                this.setRun();
                this.stillRun();
                break;
            case 68:
                this.keyRight = true;
                this.playerSk.role.skewY = 0;
                if (this.sRun) return;
                this.setRun();
                this.stillRun();
                break;
            case 32:
                if (this.sFire) {
                    this.setFireEnd();
                    return;
                }
                this.setFire();
                break;
            case 81:
                break;
            case 69:
                break;
        }
    }

}