import { ViewManager } from "./ViewManager";

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
        this.playerInfo = new PlayerInfo();
        this.initConfig();
        ViewManager.instance.initView();
        this.gotoNextLevel();
    }

    public gotoNextLevel(): void {
        this.curLevel++;
        this.curLvData = this.levelData["level_" + this.curLevel];
        ViewManager.instance.createWarView();
    }

    private initConfig(): void {
        this.levelData = Laya.loader.getRes("res/LevelData.json");

        this.playerInfo.bombNum = this.levelData.role.bombNum;
        this.playerInfo.weaponType = this.levelData.role.weaponType;
        this.playerInfo.blood = this.levelData.role.blood;
        this.playerInfo.bulletNum = this.levelData.role.bulletNum;
    }

    public get roleInfo(): PlayerInfo {
        return this.playerInfo;
    }

    public getLevelData(l: number): void {

    }

}

export class PlayerInfo {
    public blood: number;
    public bulletNum: number;
    public bombNum: number;
    public levelNum: number;
    public weaponType: number;
    public rolePos: Laya.Point;
    public isDeath: boolean;

    constructor() {
    }

}

export class EnemyInfo {
    public type: number;
    public damage: number;
    public blood: number;
    public dir: number;
    public activeDis: number;
    public pos: Laya.Point;
    public expRate: number[] = [];
    public isBoss: boolean = false;

    constructor() {
    }

}

