import { ViewManager } from "./ViewManager";
import { PlayerInfo, EnemyInfo, ObstacleInfo, PlayerData } from "../Data/PlayerData";
import { GameData, GoodsType } from "../Data/GameData";
import { EventManager } from "./EventManager";
import GameEvent from "../Control/GameEvent";
import { SoundManager } from "./SoundManager";
import { SaveManager } from "./SaveManager";
import Enemy from "../View/Enemy";

export class GameManager {
    private static _instance: GameManager;
    private playerInfo: PlayerInfo;//角色数据
    public curLevel: number = 1;//当前正在战斗的关卡
    public curChapter: number = 1;//当前第几个章节
    public curLvData: any;//当前关卡数据
    public levelData: any;//levelData.json 中的所有数据
    public maxLevel: number = 8;//当前章节最大关卡数
    public maxChapter: number = 1;//章节最大数
    public gotoMaxLevel: number = 1;//所通过的最大关卡
    public gotoMaxChapter: number = 1;//所通过的最大章节
    public choiseLevel: number = 1;//当前选择的关卡

    public enemyArr: Enemy[] = [];

    public misTouchNum: number = 0;
    public adOriList: any[] = [];
    public adList: any[] = [];
    public adListRever: any[] = [];
    public adTime: number = 0;

    // public bossDeath: boolean = false;//当前关卡boss是否阵亡

    public isPauseGame: boolean = false;

    constructor() {
    }

    public static get instance(): GameManager {
        if (this._instance == null)
            this._instance = new GameManager();
        return this._instance;
    }

    public startGame(): void {
        this.levelData = Laya.loader.getRes("res/LevelData.json");
        this.initRoleData();
        this.initChapterConfig();
        ViewManager.instance.initPopUpView();
        ViewManager.instance.showChapterView();
        // this.gotoNextLevel();
    }

    private initChapterConfig(): void {
        this.maxChapter = this.levelData["maxChapter"];
        var l: string = SaveManager.instance.getGameData("level");
        var c: string = SaveManager.instance.getGameData("chapter");
        var coin: string = SaveManager.instance.getGameData("coin");
        if (coin && coin.length > 0)
            this.roleInfo.totalCoin = Number(coin);

        if (l && l.length > 0) {
            this.curLevel = this.gotoMaxLevel = Number(l);
            this.curChapter = this.gotoMaxChapter = Math.ceil(this.curLevel / this.maxLevel);
            if (this.curChapter > this.maxChapter)
                this.curChapter = this.gotoMaxChapter = this.maxChapter;
        } else {
            this.gotoMaxChapter = this.curChapter = 1;
            this.gotoMaxLevel = this.curLevel = 1;
        }
        this.maxLevel = this.levelData["chapter_" + this.curChapter].maxLevelNum;
    }

    public enterGame(): void {
        this.curLevel = this.choiseLevel;
        this.goLevelGame();
    }

    /**观看视频后。原地复活继续游戏 */
    public continueGameByVideo(): void {
        this.roleInfo.isDeath = false;
        this.roleInfo.blood = 3;
        this.roleInfo.isInvincible = true;
        ViewManager.instance.playerInfoView.updatePlayerBlood();
        ViewManager.instance.hidePopUpView(ViewManager.instance.afterWar);
        ViewManager.instance.player.playerRes();
    }

    /**返回首页 */
    public goBack(): void {
        this.goFirstPage();
    }

    /**返回首页 */
    public goFirstPage(): void {
        this.enemyArr.length = 0;
        EventManager.instance.dispatcherEvt(GameEvent.CLEAR_WAR_VIEW);
        ViewManager.instance.hidePopUpView(null, true);
        ViewManager.instance.removeWarView();
        ViewManager.instance.showChapterView();
        Laya.SoundManager.stopMusic();
    }

    /**暂停/继续游戏 */
    public suspendGame(): void {
        this.isPauseGame = !this.isPauseGame;
        if (GameManager.instance.isPauseGame) {
            Laya.updateTimer.pause();
            Laya.physicsTimer.pause();
            Laya.timer.pause();
        } else {
            Laya.updateTimer.resume();
            Laya.physicsTimer.resume();
            Laya.timer.resume();
        }
        EventManager.instance.dispatcherEvt(GameEvent.PAUSE_GAME);
    }

    public victoryGame(): void {
        ViewManager.instance.playerVicToryLevel();
        this.curLevel++;
        if (this.gotoMaxLevel < this.curLevel) {//通过了新的关卡
            this.gotoMaxLevel = this.curLevel;
            if (this.gotoMaxLevel % this.maxLevel == 1) {//通过了新的章节
                this.gotoMaxChapter++;
                if (this.gotoMaxChapter > this.maxChapter)
                    this.gotoMaxChapter = this.maxChapter;
                this.curChapter = this.gotoMaxChapter;
            }
        } else {
            this.curChapter = Math.ceil(this.curLevel / this.maxLevel);
        }
        ViewManager.instance.showAfterWarView(1);
        SaveManager.instance.saveGameData("level", this.gotoMaxLevel + "");
        SaveManager.instance.saveGameData("chapter", this.gotoMaxChapter + "");
        SaveManager.instance.saveGameData("coin", this.roleInfo.totalCoin + "");
        SoundManager.instance.playSound("gameOver");
    }

    /**重新开始当前关卡 */
    public restartGame(): void {//
        // EventManager.instance.dispatcherEvt(GameEvent.CLEAR_WAR_VIEW);
        ViewManager.instance.hidePopUpView(null, true);
        if (this.curLevel < 1) this.curLevel = 1;
        this.goLevelGame();
    }

    public gotoNextLevel(): void {
        ViewManager.instance.hidePopUpView(ViewManager.instance.afterWar);
        if (this.curLevel > this.maxLevel * this.maxChapter) {
            ViewManager.instance.showTipsView("您已通关！敬请期待后续章节");
            return;
        }
        this.goLevelGame();
    }
    private goLevelGame(): void {
        ViewManager.instance.hidePopUpView(null, true);
        if (this.curLevel > this.maxLevel * this.maxChapter) {
            ViewManager.instance.showTipsView("您已通关！敬请期待后续章节");
            return;
        }
        EventManager.instance.dispatcherEvt(GameEvent.CLEAR_WAR_VIEW);
        if (this.levelData["chapter_" + this.curChapter]) {
            var l: number = (this.curLevel % this.maxLevel);
            if (l == 0) l = 8;
            this.maxLevel = this.levelData["chapter_" + this.curChapter].maxLevelNum;
            this.curLevelData = this.levelData["chapter_" + this.curChapter]["level_" + l];
            this.playerInfo.curlvCoin = 0;
            this.roleInfo.blood = 3;
            this.roleInfo.isDeath = false;
            ViewManager.instance.createWarView();
            SoundManager.instance.playBGM("bgm");
        } else {
            ViewManager.instance.showTipsView("您已通关！敬请期待后续章节");
        }
    }

    private initRoleData(): void {
        if (!this.playerInfo) this.playerInfo = new PlayerInfo();

        this.playerInfo.bombNum = this.levelData.role.bombNum;
        this.playerInfo.weaponType = this.levelData.role.weaponType;
        this.playerInfo.blood = this.levelData.role.blood;
        // this.playerInfo.bulletNum = this.levelData.role.bulletNum;
        this.playerInfo.addBombNum = this.levelData.role.addBombNum;
        this.playerInfo.addMacNum = this.levelData.role.addMacNum;
        this.playerInfo.addRifNum = this.levelData.role.addRifNum;
        this.playerInfo.curLevel = this.playerInfo.curChapter = 1;
        this.playerInfo.curlvCoin = this.playerInfo.totalCoin = 0;

    }


    public createEnemyData(): void {
        var enemyArr: any = this.curLevelData.enemyArr;
        // console.log("enemyArr--", enemyArr);

        for (const key in enemyArr) {
            if (enemyArr.hasOwnProperty(key)) {
                var t = enemyArr[key];
                var e: Enemy;
                var d: EnemyInfo = new EnemyInfo();
                d.expRate = t.expRate.concat();
                d.pos = new Laya.Point(t.pos[0], t.pos[1]);
                d.activeDis = t.activeDis;
                d.damage = t.damage;
                d.blood = t.blood;
                d.direction = t.direction;
                d.isBoss = t.isBoss;
                d.type = t.type;
                d.name = key;
                if (d.type == GameData.ENEMY_TANK_1 || d.type == GameData.ENEMY_TANK_2 || d.type == GameData.ENEMY_TANK_3 || d.type == GameData.ENEMY_TANK_4) {
                    e = ViewManager.instance.createTank(d);
                } else if (d.type == GameData.ENEMY_CHOPPER) {
                    e = ViewManager.instance.createChopper(d);
                } else if (d.type == GameData.HOSTAGE) {
                    ViewManager.instance.createHostage(d);
                } else {
                    e = ViewManager.instance.createEnemy(d);
                }
                this.enemyArr.push(e);
            }
        }
    }


    public createObstacleData(): void {
        var obstacle: any = GameManager.instance.curLevelData.obstacle;
        // console.log("obstacle--", obstacle);
        for (const key in obstacle) {
            if (obstacle.hasOwnProperty(key)) {
                var t = obstacle[key];
                var d: ObstacleInfo = new ObstacleInfo();
                d.pos = new Laya.Point(t.pos[0], t.pos[1]);
                d.blood = t.blood;
                d.type = t.type;
                d.name = key;
                ViewManager.instance.createObstacle(d);
            }
        }
    }

    public buyShopItem(d: any): void {
        if (d.type == GoodsType.GoodsType_MED) {
            GameManager.instance.roleInfo.blood++;
        } else if (d.type == GoodsType.GoodsType_MAC) {
            GameManager.instance.roleInfo.weaponType = PlayerData.WEAPON_MAC;
            GameManager.instance.roleInfo.bulletNum += d.num;
        } else if (d.type == GoodsType.GoodsType_GRE) {
            GameManager.instance.roleInfo.bombNum += d.num;
        }
    }

    public setADlist(): void {
        this.adOriList = this.adList.concat();//热门游戏需要用到的数组
        if (this.adList.length <= 5) {
            this.adList.push(...this.adList);
        }
        this.adTime = this.adList.length * 500;
        this.adListRever = this.adList.concat().reverse();
    }

    public useWeaponPan(x: number, y: number, dir: number): boolean {
        if (dir > 0)
            x -= 50;
        else
            x += 50;
        for (let i = 0; i < this.enemyArr.length; i++) {
            var e: Enemy = this.enemyArr[i];
            if (e.isDeath) continue;
            if (e.isActive == false) continue;
            if (e.enemyType > GameData.ENEMY_CHOPPER) continue;
            if (dir > 0) {
                if (e.scene.x > x && e.scene.x - x < 150) {
                    if (Math.abs(y - e.scene.y) < 30)
                        return true;
                }
            } else {
                if (e.scene.x < x && x - e.scene.x < 150)
                    if (Math.abs(y - e.scene.y) < 30)
                        return true;
            }
        }
        return false;
    }

    public get roleInfo(): PlayerInfo {
        return this.playerInfo;
    }

    public set curLevelData(l: any) {
        this.curLvData = l;
    }

    public get curLevelData(): any {
        return this.curLvData;
    }

    public getPlayerBulletDamage(type: number): number {
        if (type == GameData.WEAPON_PIS) {
            return 1;
        } else if (type == GameData.WEAPON_RIFLE) {
            return 2;
        } else if (type == GameData.WEAPON_MAC) {
            return 2;
        } else {
            return 1;
        }
    }
}



