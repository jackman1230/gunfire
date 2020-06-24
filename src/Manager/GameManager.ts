import { ViewManager } from "./ViewManager";
import { PlayerInfo, EnemyInfo, ObstacleInfo } from "../Data/PlayerData";
import { GameData } from "../Data/GameData";
import Player from "../View/Player";
import { EventManager } from "./EventManager";
import GameEvent from "../Control/GameEvent";

export class GameManager {
    private static _instance: GameManager;
    private playerInfo: PlayerInfo;//角色数据
    public curLevel: number = 0;//当前正在战斗的关卡
    public curChapter: number = 1;//当前第几个章节
    public curLvData: any;//当前关卡数据
    public levelData: any;//levelData.json 中的所有数据
    public maxLevel: number = 10;//当前章节最大关卡数
    public maxChapter: number = 1;//章节最大数
    public gotoMaxLevel: number = 1;//当前章节所通过的最大关卡
    public choiseLevel: number = 1;//当前选择的关卡

    public bossDeath: boolean = false;//当前关卡boss是否阵亡

    public isPauseGame: boolean = false;

    constructor() {
    }

    public static get instance(): GameManager {
        if (this._instance == null)
            this._instance = new GameManager();
        return this._instance;
    }

    public startGame(): void {
        this.initChapterConfig();
        this.initRoleData();
        ViewManager.instance.initPopUpView();
        ViewManager.instance.showChapterView();
        // this.gotoNextLevel();
    }

    private initChapterConfig(): void {
        this.curChapter = 1;
        this.levelData = Laya.loader.getRes("res/LevelData.json");
        this.maxLevel = this.levelData["chapter_" + this.curChapter].maxLevelNum;
        this.maxChapter = this.levelData["maxChapter"];
    }
    /**跳到指定关卡 */
    public goPointToLevel(l: number): void {
        this.curLevel = --l;
        this.gotoNextLevel();
    }

    public enterGame(): void {
        this.curLevel = --this.choiseLevel;
        this.gotoNextLevel();
    }

    /**返回首页 */
    public goBack(): void {

    }

    /**返回首页 */
    public goFirstPage(): void {
        ViewManager.instance.hidePopUpView(null, true);
        ViewManager.instance.showChapterView();
    }

    /**暂停后继续游戏 */
    public goContinueGame(): void {

    }

    /**暂停游戏 */
    public suspendGame(): void {
        this.isPauseGame = this.isPauseGame == false ? true : false;
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
        this.bossDeath = false;
        if (this.gotoMaxLevel <= this.curLevel)
            this.gotoMaxLevel++;
        ViewManager.instance.showAfterWarView(1);

    }

    /**重新开始当前关卡 */
    public restartGame(): void {//
        ViewManager.instance.hidePopUpView(null, true);
        this.curLevel--;
        if (this.curLevel < 0) this.curLevel = 0;
        this.gotoNextLevel();
    }

    public gotoNextLevel(): void {
        // ViewManager.instance.warView.warView.x = 0;
        this.curLevel++;
        if (this.curLevel > this.maxLevel) {
            this.curChapter++;
        }
        if (this.levelData["chapter_" + this.curChapter]) {
            this.maxLevel = this.levelData["chapter_" + this.curChapter].maxLevelNum;
            this.curLevelData = this.levelData["chapter_" + this.curChapter]["level_" + this.curLevel];
            this.playerInfo.curlvCoin = 0;
            ViewManager.instance.createWarView();
        }

    }

    private initRoleData(): void {
        if (!this.playerInfo) this.playerInfo = new PlayerInfo();

        this.playerInfo.bombNum = this.levelData.role.bombNum;
        this.playerInfo.weaponType = this.levelData.role.weaponType;
        this.playerInfo.blood = this.levelData.role.blood;
        this.playerInfo.bulletNum = this.levelData.role.bulletNum;
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
                var d: EnemyInfo = new EnemyInfo();
                d.expRate = t.expRate.concat();
                d.pos = new Laya.Point(t.pos[0], t.pos[1]);
                d.activeDis = t.activeDis;
                d.damage = t.damage;
                d.blood = t.blood;
                d.direction = t.direction;
                d.isBoss = t.isBoss;
                d.type = t.type;
                if (d.type == GameData.ENEMY_TANK_1 || d.type == GameData.ENEMY_TANK_2) {
                    ViewManager.instance.createTank(d);
                } else if (d.type == GameData.ENEMY_CHOPPER) {
                    ViewManager.instance.createChopper(d);
                } else {
                    ViewManager.instance.createEnemy(d);
                }
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
                ViewManager.instance.createObstacle(d);
            }
        }
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
            return 5;
        } else if (type == GameData.WEAPON_MAC) {
            return 2;
        } else {
            return 1;
        }
    }
}



