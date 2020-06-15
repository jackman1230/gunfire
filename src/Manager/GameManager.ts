import { ViewManager } from "./ViewManager";
import { PlayerInfo, EnemyInfo, ObstacleInfo } from "../Data/PlayerData";
import { GameData } from "../Data/GameData";
import Player from "../View/Player";

export class GameManager {
    private static _instance: GameManager;
    private playerInfo: PlayerInfo;
    public curLevel: number = 0;
    public curLvData: any;
    public levelData: any;

    constructor() {
    }

    public static get instance(): GameManager {
        if (this._instance == null)
            this._instance = new GameManager();
        return this._instance;
    }

    public startGame(): void {
        this.initRoleData();
        ViewManager.instance.initView();
        this.gotoNextLevel();
    }

    public gotoNextLevel(): void {
        this.curLevel++;
        this.curLevelData = this.levelData["level_" + this.curLevel];
        ViewManager.instance.createWarView();
    }

    private initRoleData(): void {
        this.playerInfo = new PlayerInfo();
        this.levelData = Laya.loader.getRes("res/LevelData.json");
        this.playerInfo.bombNum = this.levelData.role.bombNum;
        this.playerInfo.weaponType = this.levelData.role.weaponType;
        this.playerInfo.blood = this.levelData.role.blood;
        this.playerInfo.bulletNum = this.levelData.role.bulletNum;
        this.playerInfo.addBombNum = this.levelData.role.addBombNum;
        this.playerInfo.addMacNum = this.levelData.role.addMacNum;
        this.playerInfo.addRifNum = this.levelData.role.addRifNum;
    }

    public createPlayer(): void {
        if (!ViewManager.instance.rolePlayer) {
            ViewManager.instance.player = new Player();
            ViewManager.instance.player.createView();
        }
    }

    public createEnemyData(): void {
        var enemyArr: any = this.curLevelData.enemyArr;
        console.log("enemyArr--", enemyArr);

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
        var obstacle: any = GameManager.instance.curLevelData.enemyArr;
        console.log("obstacle--", obstacle);
        for (const key in obstacle) {
            if (obstacle.hasOwnProperty(key)) {
                var t = obstacle[key];
                var d: ObstacleInfo = new ObstacleInfo();
                d.pos = new Laya.Point(t.pos[0], t.pos[1]);
                d.blood = t.blood;
                d.type = t.type;
                ViewManager.instance.createEnemy(d);
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

}



