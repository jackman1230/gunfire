
import { WarView } from "../View/WarView";
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
import TipsPopView from "../View/TipsPopView";
import { SoundManager } from "./SoundManager";
import { Player } from "../View/Player";
import { EventManager } from "./EventManager";
import GameEvent from "../Control/GameEvent";
import PlayerPan from "../View/PlayerPan";

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

    public tipsView: TipsPopView;
    public popUpView: PopUpView;
    public playerInfoView: PlayerInfoView;
    public playerPan: PlayerPan;
    // public playerCtlView: PlayerCtlView;

    public warAllView: any[] = [];

    constructor() {

    }
    public static get instance(): ViewManager {
        if (this._instance == null)
            this._instance = new ViewManager();
        return this._instance;
    }

    public addStageSizeChange(): void {
        Laya.stage.on(Laya.Event.RESIZE, this, this.changeSize);
    }

    private changeSize(): void {
        EventManager.instance.dispatcherEvt(GameEvent.CHANGE_SIZE);
    }


    public createLoaningView(): void {
        this.loadingView = WXFUI_loadingView.createInstance();
        this.loadingView.m_bar.text = "0%";
        this.loadingView.m_bar.value = 0;
        Laya.stage.addChild(fairygui.GRoot.inst.displayObject);
        this.loadingView.x = this.getLayoutWidth();
        fairygui.GRoot.inst.addChild(this.loadingView);
    }

    public setLoadongProgress(p: number): void {
        // console.log("progress--", p);
        this.loadingView.m_bar.m_title.text = Math.ceil(p * 100) + "%";
        this.loadingView.m_bar.value = p * 100;
    }

    public hideLoadingView(): void {
        fairygui.GRoot.inst.removeChild(this.loadingView);
    }

    public createPlayer(): void {
        if (!this.player) {
            this.player = new Player();
            this.player.createView();
        } else {
            this.player.resetData();
        }
        // this.player = Laya.Pool.getItemByClass("player", Player);
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
    public createBullet(): PlayerBullet {
        var b: PlayerBullet = Laya.Pool.getItemByClass("PlayerBullet", PlayerBullet);
        b.createView(this.rolePlayer.weaponType, this.rolePlayer.faceType);
        return b;
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
    public createEnemy(d: any): Enemy {
        var b: Enemy = Laya.Pool.getItemByClass("enemy", Enemy);
        b.createView(d);
        return b;
    }

    /**创建直升机 */
    public createChopper(d: EnemyInfo): Chopper {
        var b: Chopper = Laya.Pool.getItemByClass("chopper", Chopper);
        b.createView(d);
        return b;
    }
    /**创建坦克 */
    public createTank(d: EnemyInfo): Tank {
        var b: Tank = Laya.Pool.getItemByClass("tank", Tank);
        b.createView(d);
        return b;
    }

    /**创建掉落物品 */
    public createGoods(type: number, s: Laya.Point): void {
        var b: GoodsView = Laya.Pool.getItemByClass("goods", GoodsView);
        b.createView(type, s);
    }

    public showPlayerPanBody(): void {
        if (!this.playerPan) this.playerPan = new PlayerPan();
        if (this.player.direction > 0)
            this.playerPan.scene.x = 0;
        else {
            this.playerPan.scene.x = -this.playerPan.scene.width;
        }
        this.player.roleSprite.addChild(this.playerPan.scene);
    }

    public hidePlayerPanBody(): void {
        if (this.playerPan)
            this.player.roleSprite.removeChild(this.playerPan.scene);
    }

    /**创建人物信息界面 */
    public showPlayerInfoView(): void {
        if (!this.playerInfoView) this.playerInfoView = new PlayerInfoView();
        this.playerInfoView.updateAllView();
        fairygui.GRoot.inst.addChild(this.playerInfoView.view);
    }

    /**创建人物操作界面 */
    public showPlayerCtlView(): void {
        if (this.player.playerCtlView)
            fairygui.GRoot.inst.addChild(this.player.playerCtlView.view);
        if (this.player.playerDirView)
            fairygui.GRoot.inst.addChild(this.player.playerDirView.view);
    }
    /**
     * 显示关卡战斗之后界面
     * @param type 1胜利界面，2失败界面，3放弃界面
     */
    public showAfterWarView(type: number): void {
        this.afterWar.view.m_ctl.selectedIndex = type - 1;
        this.afterWar.updateView(type);
        this.showPopUpView(this.afterWar, true, true, false);
    }

    public showBeforeWarView(): void {
        this.showPopUpView(this.beforeWar);
    }

    public showSuspendView(): void {
        // this.showPopUpView(this.suspendView);
        this.suspendView.showViewNoTween();
    };
    public hideSuspendView(): void {
        // this.showPopUpView(this.suspendView);
        this.suspendView.hideAllView();
    }

    public showChapterView(): void {
        // SoundManager.instance.stopBGM();
        this.chapterView.view.m_chapter.selectedIndex = 0;
        this.chapterView.updateView();
        this.showPopUpView(this.chapterView, false, true);
    }

    public playerVicToryLevel(): void {
        this.player.victoryGame();
    }

    public initPopUpView(): void {
        this.afterWar = new AfterWar();
        this.beforeWar = new BeforeWar()
        this.suspendView = new SuspendView();
        this.chapterView = new ChapterView();
        this.popUpView = new PopUpView();
        this.tipsView = new TipsPopView();

        this.afterWar.createView();
        this.beforeWar.createView();
        this.suspendView.createView();
        this.chapterView.createView();

        Laya.stage.addChild(fairygui.GRoot.inst.displayObject);

    }

    /**显示弹窗 */
    public showTipsView(str: string): void {
        this.tipsView.showView(str);
    }

    public curPopView: PopUpView[] = [];
    /**显示弹窗 */
    public showPopUpView(p: PopUpView, showMask: boolean = true, hideOther: boolean = false, clickMaskHide: boolean = true): void {
        if (hideOther) {
            for (let i = 0; i < this.curPopView.length; i++) {
                var t: PopUpView = this.curPopView[i];
                t.hideAllView();
            }
            this.curPopView.length = 0;
        }
        p.showView(showMask, clickMaskHide);
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

    public removeWarView(): void {
        if (this.warView) {
            this.warView.removeView();
        }

    }

    public get rolePlayer(): Player {
        return this.player;
    }

    public getBodyCenterPos(s: Laya.Sprite): Laya.Point {
        return (s.getComponent(Laya.RigidBody) as Laya.RigidBody).getWorldCenter();
    }

    public updateViewPort(moveX: number): void {
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

    public getPlayerDirection(pos: Laya.Point): number {
        var rad = Math.atan2(pos.y, pos.x);// [-PI, PI]
        if ((rad >= -2 * Math.PI / 8 && rad < 0) || (rad >= 0 && rad < 2 * Math.PI / 8)) {
            return 1;// 右
        } else if (rad >= 2 * Math.PI / 8 && rad < 4 * Math.PI / 8) {
            return 5;// 右下
        } else if (rad >= 4 * Math.PI / 8 && rad < 6 * Math.PI / 8) {
            return -5;// 左下
        } else if ((rad >= 6 * Math.PI / 8 && rad < Math.PI) || (rad >= -Math.PI && rad < -6 * Math.PI / 8)) {
            return -1;// 左
        } else if (rad >= -6 * Math.PI / 8 && rad < -5 * Math.PI / 8) {
            // console.log("左斜上");
            return -3;// 左斜上
        } else if (rad >= -5 * Math.PI / 8 && rad < -4 * Math.PI / 8) {
            // console.log("左上");
            return -4;// 左上
        } else if (rad >= -4 * Math.PI / 8 && rad < -3 * Math.PI / 8) {
            // console.log("右上");
            return 4;// 右上
        } else {
            // console.log("右斜上");
            return 3;// 右斜上
        }

        // else if (rad >= -5 * Math.PI / 8 && rad < -3 * Math.PI / 8) {
        //     return cc.v2(0, -1);// 下
        // }
        // else if (rad >= 3 * Math.PI / 8 && rad < 5 * Math.PI / 8) {
        //     return cc.v2(0, 1);// 上
        // }
    }

    /**角色子弹坐标偏移 第一位是方向，第二位是武器类型*/
    private playerBulletPos: object = {
        "11": [135, -22],//武器手枪，方向 右
        "12": [150, 0],//武器机枪，方向 右
        "13": [50, 70],//武器来福枪，方向 右
        "21": [125, 25],//武器手枪，方向 右下
        "22": [115, 70],//武器机枪，方向 右下
        "23": [50, 5],//武器来福枪，方向 右下
        "31": [115, -95],//武器手枪，方向 右上
        "32": [120, -50],//武器机枪，方向 右上
        "33": [25, 130],//武器来福枪，方向 右上
        "41": [-30, -185],//武器手枪，方向 上
        "42": [-30, -185],//武器机枪，方向 上
        "43": [50, 200],//武器来福枪，方向 上
        "51": [135, -30],//武器手枪，方向 右蹲下
        "52": [150, -30],//武器机枪，方向 右蹲下
        "53": [50, 70],//武器来福枪，方向 右蹲下
        "14": [20, -60],//武器手雷，方向右
        "-11": [-200, -22],//武器手枪，方向 左
        "-12": [-210, 0],//武器机枪，方向 左
        "-13": [240, 80],//武器来福枪，方向 左
        "-14": [-20, -60],//武器手雷，方向 左
        "-21": [-190, 20],//武器手枪，方向 左下
        "-22": [-180, 15],//武器机枪，方向 左下
        "-23": [250, 20],//武器来福枪，方向 左下
        "-31": [-190, -90],//武器手枪，方向 左上
        "-32": [-180, -50],//武器机枪，方向 左上
        "-33": [255, 130],//武器来福枪，方向 左上
        "-41": [-30, -185],//武器手枪，方向 上
        "-42": [-30, -185],//武器机枪，方向 上
        "-43": [55, 200],//武器来福枪，方向 上
        "-51": [-200, -30],//武器手枪，方向 左蹲下
        "-52": [-235, -30],//武器机枪，方向 左蹲下
        "-53": [240, 80],//武器来福枪，方向 左蹲下
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
        "111": [-25, 15],//武器坦克11，方向右
        "112": [-5, 25],//武器坦克12，方向右
        "113": [-75, 15],//武器坦克13，方向右
        "114": [-35, 15],//武器坦克14，方向右
        "-11": [-100, 10],//武器手枪，方向左
        "-12": [0, -50],//武器手雷，方向左
        "-13": [-75, 15],//武器机枪，方向左
        "-14": [],//武器火箭筒，方向左
        "-15": [0, -20],//武器迫击炮，方向左
        "-111": [0, 15],//武器坦克11，方向左
        "-112": [-50, 30],//武器坦克12，方向左
        "-113": [20, 20],//武器坦克13，方向左
        "-114": [-20, 10],//武器坦克14，方向左
    }

    public getEnemyBulletOffSetPos(dir: number, weaponType: number): Laya.Point {
        var s: string = dir + "" + weaponType;
        // console.log("getEnemyBulletOffSetPos--", s);
        if (this.enemyBulletPos[s])
            return new Laya.Point(this.enemyBulletPos[s][0], this.enemyBulletPos[s][1]);
        else
            return new Laya.Point(0, 0);
    }

    /**获取设备高度 */
    // private getHeight(): number {
    //     if (Laya.Browser.onWeiXin) {
    //         let wxInfo = wx.getSystemInfoSync();
    //         console.log('wx height:', wxInfo.windowHeight, ', widht:', wxInfo.windowWidth);
    //         let h: number = 750 * wxInfo.windowHeight / wxInfo.windowWidth;
    //         console.log('h:', h);
    //         if (h > 1334) {
    //             return h;
    //         }
    //     } else {
    //         return Laya.Browser.clientHeight;
    //     }
    // }
    /**获取宽度(因为是横屏所以返回高度) */
    public getLayoutWidth(): number {
        let h: number = 0;
        let offX: number = 0;
        if (Laya.Browser.onWeiXin) {
            let wxInfo = wx.getSystemInfoSync();
            h = (wxInfo.windowHeight / 750) * 1334;//游戏所展示的宽度
            console.log('wx height:', wxInfo.windowHeight, ', width:', wxInfo.windowWidth);
            offX = (wxInfo.windowWidth - h) / (wxInfo.windowHeight / 750);
        } else {
            h = (Laya.Browser.height / 750) * 1334;//游戏所展示的宽度
            //按浏览器比例适配后，所需要偏移的X值
            offX = (Laya.Browser.width - h) / (Laya.Browser.height / 750);
        }
        return Math.floor(offX / 2);
    }

    public getProportion(): number {
        if (Laya.Browser.onWeiXin) {
            let wxInfo = wx.getSystemInfoSync();
            return wxInfo.windowHeight / 750;
        } else {
            return Laya.Browser.height / 750;
        }
    }

}