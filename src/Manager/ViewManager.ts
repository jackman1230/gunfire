
import { WarView } from "../View/WarView";
import WXFUI_Player from "../fui/Game/WXFUI_Player";
import Player from "../View/Player";
import Enemy from "../View/Enemy";
import EnemyBullet from "../View/EnemyBullet";
import PlayerBullet from "../View/PlayerBullet";
import BombView from "../View/BombView";
import ObstacleView from "../View/ObstacleView";
import { BombData, ObstacleType } from "../Data/GameData";
import Chopper from "../View/Chopper";
import Tank from "../View/Tank";
import { EnemyInfo, ObstacleInfo } from "../Data/PlayerData";
import ChopperBomb from "../View/ChopperBomb";
import GoodsView from "../View/GoodsView";
import PlayerInfoView from "../View/PlayerInfoView";
import PlayerCtlView from "../View/PlayerCtlView";
import WXFUI_loadingView from "../fui/loading/WXFUI_loadingView";
import SuspendView from "../View/SuspendView";
import ChapterView from "../View/ChapterView";
import AfterWar from "../View/AfterWar";
import BeforeWar from "../View/BeforeWar";
import PopUpView from "../View/PopUpView";
import { GameManager } from "./GameManager";

export class ViewManager {

    private static _instance: ViewManager;
    public warView: WarView;
    public loadingView: WXFUI_loadingView;
    public player: Player;
    private enemy: Enemy;

    private bulletArr: PlayerBullet[] = [];
    private enemyArr: Enemy[] = [];

    private isChecking: boolean = false;

    public suspendView: SuspendView;
    public chapterView: ChapterView;
    public afterWar: AfterWar;
    public beforeWar: BeforeWar;

    public popUpView: PopUpView;
    public playerInfoView: PlayerInfoView;
    public playerCtlView: PlayerCtlView;

    constructor() {

    }
    public static get instance(): ViewManager {
        if (this._instance == null)
            this._instance = new ViewManager();
        return this._instance;
    }

    public createLoaningView(): void {
        this.loadingView = WXFUI_loadingView.createInstance();
        this.loadingView.m_bar.text = "0%";
        this.loadingView.m_bar.value = 0;
        Laya.stage.addChild(this.loadingView.displayObject);
    }

    public setLoadongProgress(p: number): void {
        console.log("progress--", p);
        this.loadingView.m_bar.m_title.text = Math.ceil(p * 100) + "%";
        this.loadingView.m_bar.value = p * 100;
    }

    public hideLoadingView(): void {
        Laya.stage.removeChild(this.loadingView.displayObject);
    }

    public createPlayer(): void {
        if (this.player) this.player.dispose();

        this.player = Laya.Pool.getItemByClass("player", Player);
        this.player.createView();
    }

    public createWarView(): void {
        if (this.warView) this.warView.dispose();

        this.warView = Laya.Pool.getItemByClass("warView", WarView);
        this.warView.createView();

        this.showPlayerCtlView();
        this.showPlayerInfoView();
    }
    /**创建步兵扔的雷 */
    public createBomb(type: number, dir: number, parentPos: Laya.Point, b: boolean): void {
        var bomb: BombView = Laya.Pool.getItemByClass("bombView", BombView);
        if (b)
            bomb.createView(BombData.BOMB_MY_GRE, dir, parentPos, b, this.getPlayerBulletOffSetPos(dir, type));
        else
            bomb.createView(type, dir, parentPos, b, this.getEnemyBulletOffSetPos(dir, type));
    }
    /**创建飞机的导弹 */
    public createChopperBomb(type: number, parentPos: Laya.Point, s: Laya.Point): void {
        var bomb: ChopperBomb = Laya.Pool.getItemByClass("ChopperBomb", ChopperBomb);
        bomb.createView(type, null, parentPos, null, s);
    }
    /**创建主角子弹 */
    public createBullet(): void {
        var b: PlayerBullet = Laya.Pool.getItemByClass("PlayerBullet", PlayerBullet);
        b.createView(this.rolePlayer.weaponType, this.rolePlayer.direction);
    }
    /**
     * 创建敌人子弹
     * @param type 子弹类型
     * @param dir 方向
     * @param s 父节点世界坐标
     */
    public createEnemyBullet(type: number, dir: number, s: Laya.Point): void {
        var b: EnemyBullet = Laya.Pool.getItemByClass("enemyBullet", EnemyBullet);
        b.createView(type, dir, s);
    }

    /**创建障碍物 */
    public createObstacle(d: ObstacleInfo): void {
        var b: ObstacleView = Laya.Pool.getItemByClass("obstacle", ObstacleView);
        b.createView(d);
    }

    /**创建步兵敌人 */
    public createEnemy(d: any): void {
        var b: Enemy = Laya.Pool.getItemByClass("enemy", Enemy);
        b.createView(d);
    }

    /**创建直升机 */
    public createChopper(d: EnemyInfo): void {
        var b: Chopper = Laya.Pool.getItemByClass("chopper", Chopper);
        b.createView(d);
    }
    /**创建坦克 */
    public createTank(d: EnemyInfo): void {
        var b: Tank = Laya.Pool.getItemByClass("tank", Tank);
        b.createView(d);
    }

    /**创建掉落物品 */
    public createGoods(type: number, s: Laya.Point): void {
        var b: GoodsView = Laya.Pool.getItemByClass("goods", GoodsView);
        b.createView(type, s);
    }

    /**创建人物信息界面 */
    public showPlayerInfoView(): void {
        if (!this.playerInfoView) this.playerInfoView = new PlayerInfoView();
        fairygui.GRoot.inst.addChild(this.playerInfoView.view);
    }

    /**创建人物操作界面 */
    public showPlayerCtlView(): void {
        if (!this.playerCtlView) this.playerCtlView = new PlayerCtlView();
        fairygui.GRoot.inst.addChild(this.playerCtlView.view);
    }
    /**
     * 显示关卡战斗之后界面
     * @param type 1胜利界面，2失败界面，3放弃界面
     */
    public showAfterWarView(type: number): void {
        this.afterWar.view.m_ctl.selectedIndex = type - 1;
        this.afterWar.updateCoin();
        this.showPopUpView(this.afterWar);
    }

    public showBeforeWarView(): void {
        this.showPopUpView(this.beforeWar);
    }

    public showSuspendView(): void {
        this.showPopUpView(this.suspendView);
    }

    public showChapterView(): void {
        this.chapterView.view.m_chapter.selectedIndex = GameManager.instance.curChapter - 1;
        this.chapterView.updateView();
        this.showPopUpView(this.chapterView, false, true);
    }

    public initPopUpView(): void {
        this.afterWar = new AfterWar();
        this.beforeWar = new BeforeWar()
        this.suspendView = new SuspendView();
        this.chapterView = new ChapterView();
        this.popUpView = new PopUpView();

        this.afterWar.createView();
        this.beforeWar.createView();
        this.suspendView.createView();
        this.chapterView.createView();

        Laya.stage.addChild(fairygui.GRoot.inst.displayObject);

    }
    public curPopView: PopUpView[] = [];
    /**显示弹窗 */
    public showPopUpView(p: PopUpView, showMask: boolean = true, hideOther: boolean = false): void {
        if (hideOther) {
            for (let i = 0; i < this.curPopView.length; i++) {
                var t: PopUpView = this.curPopView[i];
                t.hideAllView();
            }
            this.curPopView.length = 0;
        }
        p.showView(showMask);
        this.curPopView.push(p);
    }
    /**隐藏弹窗 */
    public hidePopUpView(p: PopUpView, all: boolean = false): void {
        if (all) {
            for (let i = 0; i < this.curPopView.length; i++) {
                var t: PopUpView = this.curPopView[i];
                t.hideAllView();
            }
            this.curPopView.length = 0;
        } else {
            if (p)
                p.hideAllView();
        }
    }

    public disposeWarView(): void {
        if (this.rolePlayer)
            this.rolePlayer.dispose();
        if (this.warView)
            this.warView.dispose();
    }

    public get rolePlayer(): Player {
        return this.player;
    }

    public getBodyCenterPos(s: Laya.Sprite): Laya.Point {
        return (s.getComponent(Laya.RigidBody) as Laya.RigidBody).getWorldCenter();
    }


    public updateViewPort(moveX: number): void {
        // this.bgView.updateViewPort(moveX);
        this.warView.updateViewPort(moveX);
    }
    /**根据导弹类型，获取导弹爆炸效果 */
    public getBoomAniTypeByBomb(type: number): number {
        if (type == BombData.BOMB_MY_GRE || type == BombData.BOMB_MY_GRE || type == BombData.BOMB_CHOPPER) {
            return 1;
        } else if (type == BombData.BOMB_MOR) {
            return 2;
        } else if (type == BombData.BOMB_TANK) {
            return 3;
        }
        return 1;
    }
    /**根据障碍物类型，获取导弹爆炸效果 */
    public getBoomAniTypeByObsType(type: number): number {
        if (type == ObstacleType.ObstacleType_SHABAO || type == ObstacleType.ObstacleType_YOUGUAN || type == ObstacleType.ObstacleType_9) {
            return 2;
        } else if (type == ObstacleType.ObstacleType_DACHE || type == ObstacleType.ObstacleType_11) {
            return 5;
        } else {
            return 3;
        }
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
        "111": [165, 15],//武器坦克，方向右
        "-11": [-100, 10],//武器手枪，方向左
        "-12": [0, -50],//武器手雷，方向左
        "-13": [-75, 15],//武器机枪，方向左
        "-14": [],//武器火箭筒，方向左
        "-15": [0, -20],//武器迫击炮，方向左
        "-111": [0, 15],//武器坦克，方向左
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