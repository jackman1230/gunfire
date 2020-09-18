import { ViewManager } from "./ViewManager";
import { PlayerInfo, EnemyInfo, ObstacleInfo, PlayerData } from "../Data/PlayerData";
import { GameData, GoodsType } from "../Data/GameData";
import { EventManager } from "./EventManager";
import GameEvent from "../Control/GameEvent";
import { SoundManager } from "./SoundManager";
import { SaveManager } from "./SaveManager";
import Enemy from "../View/Enemy";
import { MooSnowSDK } from "./MooSnowSDK";
import { VideoData, VideoType } from "../Data/VideoData";

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
    public buyWeaponType: number = 0;
    public buyBullet: number = 0;
    public buyGre: number = 10;

    public platform: number = 0;

    // public bossDeath: boolean = false;//当前关卡boss是否阵亡

    public isPauseGame: boolean = false;

    public oriBlood: number = 6;

    constructor() {
    }

    public static get instance(): GameManager {
        if (this._instance == null)
            this._instance = new GameManager();
        return this._instance;
    }

    public startGame(): void {
        this.levelData = Laya.loader.getRes("res/LevelData.json");
        var levelData2 = Laya.loader.getRes("res/LevelData2.json");
        this.levelData["chapter_4"] = levelData2["chapter_4"];
        this.levelData["chapter_5"] = levelData2["chapter_5"];
        this.platform = MooSnowSDK.getPlatform();
        // this.platform = moosnow.APP_PLATFORM.VIVO;
        console.log(this.levelData);
        this.initRoleData();
        this.initChapterConfig();
        SoundManager.instance.openSound();
        ViewManager.instance.initPopUpView();
        ViewManager.instance.showChapterView();
        // SoundManager.instance.addVisibleEvent();
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
        this.roleInfo.blood = this.oriBlood;
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
        // Laya.SoundManager.stopMusic();
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
    public goLevelGame(): void {
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
            this.roleInfo.blood = this.oriBlood;
            this.roleInfo.isDeath = false;
            ViewManager.instance.createWarView();
            SoundManager.instance.playBGM("bgm");
            MooSnowSDK.startGame(GameManager.instance.choiseLevel);
            MooSnowSDK.startRecord();
            // this.buyBullet = this.buyWeaponType = 0; this.buyGre = 10;
        } else {
            ViewManager.instance.showTipsView("您已通关！敬请期待后续章节");
        }
    }
    /**
     * 观看视频完成返回
     * @param d 免费获得道具数据
     * @param v 视频描述
     */
    public showVideoResp(d: any, v: VideoData, successFun?: Function): void {
        if (successFun) {
            successFun();
        }
        if (v.type == VideoType.VIDEOTYPE_ITEM && d) {
            GameManager.instance.buyShopItem(d, true);
            ViewManager.instance.beforeWar.updateView();
        } else if (v.type == VideoType.VIDEOTYPE_LIFE) {
            GameManager.instance.continueGameByVideo();
        } else if (v.type == VideoType.VIDEOTYPE_DOUBLE_COIN) {
            GameManager.instance.roleInfo.totalCoin += GameManager.instance.roleInfo.curlvCoin;
            ViewManager.instance.playerInfoView.updateCoin();
            GameManager.instance.goFirstPage();
            MooSnowSDK.endGame(GameManager.instance.choiseLevel, true);
            ViewManager.instance.showTipsView("额外获得金币：" + GameManager.instance.roleInfo.curlvCoin);
        } else if (v.type == VideoType.VIDEOTYPE_BOX) {
            ViewManager.instance.playerInfoView.showBoxGoods();
        }

    }

    private initRoleData(): void {
        if (!this.playerInfo) this.playerInfo = new PlayerInfo();

        this.playerInfo.bombNum = this.levelData.role.bombNum;
        this.playerInfo.weaponType = this.levelData.role.weaponType;
        this.oriBlood = this.playerInfo.blood = this.levelData.role.blood;
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

    public buyShopItem(d: any, showTip: boolean = false): void {
        if (d.type == GoodsType.GoodsType_MED) {
            GameManager.instance.roleInfo.blood += 2;
        } else if (d.type == GoodsType.GoodsType_MAC) {
            if (this.buyWeaponType != PlayerData.WEAPON_MAC)
                this.buyBullet = 0;
            this.buyWeaponType = PlayerData.WEAPON_MAC;
            this.buyBullet += d.num;
        } else if (d.type == GoodsType.GoodsType_GRE) {
            this.buyGre += d.num;
        } else if (d.type == GoodsType.GoodsType_RIF) {
            if (this.buyWeaponType != PlayerData.WEAPON_RIFLE)
                this.buyBullet = 0;
            this.buyWeaponType = PlayerData.WEAPON_RIFLE;
            this.buyBullet += d.num;
        }
        if (showTip) {
            ViewManager.instance.showTipsView("恭喜获得：" + d.name);
        }

        if (this.buyBullet > 999)
            this.buyBullet = 999;
        if (this.buyGre > 999)
            this.buyGre = 999;
    }

    public setADlist(): void {
        this.adOriList = this.adList.concat();//热门游戏需要用到的数组
        if (this.adList.length <= 5) {
            this.adList.push(...this.adList);
        }
        this.adTime = this.adList.length * 1200;
        this.adListRever = this.adList.concat().reverse();
        // Laya.timer.once(7000,this,()=>{

        EventManager.instance.dispatcherEvt(GameEvent.SHOW_AD_LIST);
        // })


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

    public createVideoData(t: number, info: string): VideoData {
        var v: VideoData = new VideoData();
        v.type = t;
        v.info = info;
        return v;
    }
}



