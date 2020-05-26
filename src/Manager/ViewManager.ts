
import { WarView } from "../View/WarView";
import WXFUI_Player from "../fui/Game/WXFUI_Player";
import Player from "../View/Player";
import Enemy from "../View/Enemy";
import EnemyBullet from "../View/EnemyBullet";
import PlayerBullet from "../View/PlayerBullet";
import BombView from "../View/BombView";
import { BombData } from "../Data/PlayerData";

export class ViewManager {

    private static _instance: ViewManager;
    public warView: WarView;
    private player: Player;
    private enemy: Enemy;

    private bulletArr: PlayerBullet[] = [];
    private enemyArr: Enemy[] = [];

    private isChecking: boolean = false;

    constructor() {

    }
    public static get instance(): ViewManager {
        if (this._instance == null)
            this._instance = new ViewManager();
        return this._instance;
    }

    public showStartView(): void {
        this.initView();
        console.log("开始初始化界面");
    }

    public createBomb(type: number, dir: number, parentPos: Laya.Point, b: boolean): void {
        var bomb: BombView = Laya.Pool.getItemByClass("bombView", BombView);
        if (b)
            bomb.initView(BombData.BOMB_1, dir, parentPos, b, this.getPlayerBulletOffSetPos(dir, type));
        else
            bomb.initView(type, dir, parentPos, b, this.getEnemyBulletOffSetPos(dir, type));
    }

    public createBullet(): void {
        var b: PlayerBullet = Laya.Pool.getItemByClass("PlayerBullet", PlayerBullet);
        b.initView(this.rolePlayer.weaponType, this.rolePlayer.direction);
    }

    public createEnemyBullet(type: number, dir: number, s: Laya.Point): void {
        var b: EnemyBullet = Laya.Pool.getItemByClass("enemyBullet", EnemyBullet);
        b.initView(type, dir, s);
    }

    public createEnemy(): void {
        var b: Enemy = Laya.Pool.getItemByClass("enemy", Enemy);
        b.initView();
    }

    public initView(): void {
        this.warView = new WarView();
        this.player = new Player();

        this.warView.initView();
        this.player.initView();
    }

    public get rolePlayer(): Player {
        return this.player;
    }

    public showEnemyDeathAfter(): void {

    }

    public getBodyCenterPos(s: Laya.Sprite): Laya.Point {
        return (s.getComponent(Laya.RigidBody) as Laya.RigidBody).getWorldCenter();
    }


    public updateViewPort(moveX: number): void {
        // this.bgView.updateViewPort(moveX);
        this.warView.updateViewPort(moveX);
    }

    public bulletRandomY(): number {
        return Math.floor(Math.random() * 10) + 10;
    }

    /**角色子弹坐标偏移 */
    private playerBulletPos: object = {
        "11": [135, -22],//武器手枪，方向右
        "12": [167, 0],//武器机枪，方向右
        "13": [],//武器来福枪，方向右
        "14": [20, -60],//武器手雷，方向右
        "-11": [-200, -22],//武器手枪，方向左
        "-12": [-220, 0],//武器机枪，方向左
        "-13": [],//武器来福枪，方向左
        "-14": [-20, -60],//武器手雷，方向左
        "21": [-150, -30],//武器手枪，方向右上
        "22": [],//武器机枪，方向右上
        "23": [],//武器来福枪，方向右上
        "-21": [],//武器手枪，方向左上
        "-22": [],//武器机枪，方向左上
        "-23": [],//武器来福枪，方向左上
    }
    /**角色子弹坐标偏移 */
    public getPlayerBulletOffSetPos(dir: number, weaponType: number): Laya.Point {
        var s: string = dir + "" + weaponType;
        if (this.playerBulletPos[s])
            return new Laya.Point(this.playerBulletPos[s][0], this.playerBulletPos[s][1]);
        else
            return new Laya.Point(0, 0);
    }
    /**敌人子弹坐标偏移 */
    private enemyBulletPos: object = {
        "11": [105, 10],//武器手枪，方向右
        "12": [10, -40],//武器手雷，方向右
        "13": [125, 15],//武器机枪，方向右
        "14": [],//武器火箭筒，方向右
        "15": [70, -20],//武器迫击炮，方向右
        "-11": [-100, 10],//武器手枪，方向左
        "-12": [0, -50],//武器手雷，方向左
        "-13": [-75, 15],//武器机枪，方向左
        "-14": [],//武器火箭筒，方向左
        "-15": [0, -20],//武器迫击炮，方向左
    }

    public getEnemyBulletOffSetPos(dir: number, weaponType: number): Laya.Point {
        var s: string = dir + "" + weaponType;
        console.log("getEnemyBulletOffSetPos--", s);
        if (this.enemyBulletPos[s])
            return new Laya.Point(this.enemyBulletPos[s][0], this.enemyBulletPos[s][1]);
        else
            return new Laya.Point(0, 0);
    }

}