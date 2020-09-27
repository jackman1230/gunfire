(function () {
    'use strict';

    class GameConfig {
        constructor() {
        }
        static init() {
            var reg = Laya.ClassUtils.regClass;
        }
    }
    GameConfig.width = 640;
    GameConfig.height = 1136;
    GameConfig.scaleMode = "fixedwidth";
    GameConfig.screenMode = "none";
    GameConfig.alignV = "top";
    GameConfig.alignH = "left";
    GameConfig.startScene = "BoardBody.scene";
    GameConfig.sceneRoot = "";
    GameConfig.debug = false;
    GameConfig.stat = false;
    GameConfig.physicsDebug = false;
    GameConfig.exportSceneToJson = true;
    GameConfig.init();

    var Scene = Laya.Scene;
    var REG = Laya.ClassUtils.regClass;
    var ui;
    (function (ui) {
        class BoardBodyUI extends Laya.View {
            constructor() {
                super();
            }
            createChildren() {
                super.createChildren();
                this.createView(BoardBodyUI.uiView);
            }
        }
        BoardBodyUI.uiView = { "type": "View", "props": { "width": 350, "height": 25 }, "compId": 2, "child": [{ "type": "Sprite", "props": { "y": 0, "x": 0, "texture": "2460.png" }, "compId": 5 }, { "type": "Script", "props": { "y": 0, "x": 0, "width": 350, "label": "board", "isSensor": false, "height": 25, "friction": 0, "density": 0, "runtime": "laya.physics.BoxCollider" }, "compId": 3 }, { "type": "Script", "props": { "type": "static", "label": "board", "gravityScale": 0, "allowRotation": false, "runtime": "laya.physics.RigidBody" }, "compId": 4 }], "loadList": ["2460.png"], "loadList3D": [] };
        ui.BoardBodyUI = BoardBodyUI;
        REG("ui.BoardBodyUI", BoardBodyUI);
        class BombBodyUI extends Laya.View {
            constructor() {
                super();
            }
            createChildren() {
                super.createChildren();
                this.createView(BombBodyUI.uiView);
            }
        }
        BombBodyUI.uiView = { "type": "View", "props": { "width": 25, "height": 25 }, "compId": 2, "child": [{ "type": "Script", "props": { "y": 0, "x": 0, "width": 25, "isSensor": true, "height": 25, "friction": 0, "runtime": "laya.physics.BoxCollider" }, "compId": 3 }, { "type": "Script", "props": { "gravityScale": 1.5, "allowRotation": false, "runtime": "laya.physics.RigidBody" }, "compId": 4 }], "loadList": [], "loadList3D": [] };
        ui.BombBodyUI = BombBodyUI;
        REG("ui.BombBodyUI", BombBodyUI);
        class BoomBodyUI extends Laya.View {
            constructor() {
                super();
            }
            createChildren() {
                super.createChildren();
                this.createView(BoomBodyUI.uiView);
            }
        }
        BoomBodyUI.uiView = { "type": "View", "props": { "width": 90, "mouseEnabled": false, "height": 90 }, "compId": 2, "child": [{ "type": "Script", "props": { "y": 0, "x": 0, "radius": 45, "isSensor": true, "friction": 0, "density": 0, "runtime": "laya.physics.CircleCollider" }, "compId": 5 }, { "type": "Script", "props": { "type": "dynamic", "gravityScale": 0, "runtime": "laya.physics.RigidBody" }, "compId": 6 }], "loadList": [], "loadList3D": [] };
        ui.BoomBodyUI = BoomBodyUI;
        REG("ui.BoomBodyUI", BoomBodyUI);
        class BulletUI extends Laya.View {
            constructor() {
                super();
            }
            createChildren() {
                super.createChildren();
                this.createView(BulletUI.uiView);
            }
        }
        BulletUI.uiView = { "type": "View", "props": { "width": 30, "height": 15 }, "compId": 2, "child": [{ "type": "Script", "props": { "y": 0, "x": 0, "width": 30, "isSensor": true, "height": 15, "friction": 0, "runtime": "laya.physics.BoxCollider" }, "compId": 3 }, { "type": "Script", "props": { "gravityScale": 0, "allowRotation": false, "runtime": "laya.physics.RigidBody" }, "compId": 4 }], "loadList": [], "loadList3D": [] };
        ui.BulletUI = BulletUI;
        REG("ui.BulletUI", BulletUI);
        class BulletPanUI extends Laya.View {
            constructor() {
                super();
            }
            createChildren() {
                super.createChildren();
                this.createView(BulletPanUI.uiView);
            }
        }
        BulletPanUI.uiView = { "type": "View", "props": { "width": 180, "height": 80 }, "compId": 2, "child": [{ "type": "Script", "props": { "y": 0, "x": 0, "width": 180, "isSensor": true, "height": 80, "friction": 0, "runtime": "laya.physics.BoxCollider" }, "compId": 3 }, { "type": "Script", "props": { "gravityScale": 0, "allowRotation": false, "runtime": "laya.physics.RigidBody" }, "compId": 4 }], "loadList": [], "loadList3D": [] };
        ui.BulletPanUI = BulletPanUI;
        REG("ui.BulletPanUI", BulletPanUI);
        class BulletRifleUI extends Laya.View {
            constructor() {
                super();
            }
            createChildren() {
                super.createChildren();
                this.createView(BulletRifleUI.uiView);
            }
        }
        BulletRifleUI.uiView = { "type": "View", "props": { "width": 347, "height": 197 }, "compId": 2, "child": [{ "type": "Script", "props": { "y": 0, "x": 0, "width": 347, "isSensor": true, "height": 197, "friction": 0, "density": 0, "runtime": "laya.physics.BoxCollider" }, "compId": 3 }, { "type": "Script", "props": { "gravityScale": 0, "allowRotation": false, "runtime": "laya.physics.RigidBody" }, "compId": 4 }], "loadList": [], "loadList3D": [] };
        ui.BulletRifleUI = BulletRifleUI;
        REG("ui.BulletRifleUI", BulletRifleUI);
        class BulletRifleUpUI extends Laya.View {
            constructor() {
                super();
            }
            createChildren() {
                super.createChildren();
                this.createView(BulletRifleUpUI.uiView);
            }
        }
        BulletRifleUpUI.uiView = { "type": "View", "props": { "width": 197, "height": 347 }, "compId": 2, "child": [{ "type": "Script", "props": { "y": 0, "x": 0, "width": 197, "isSensor": true, "height": 347, "friction": 0, "density": 0, "runtime": "laya.physics.BoxCollider" }, "compId": 3 }, { "type": "Script", "props": { "gravityScale": 0, "allowRotation": false, "runtime": "laya.physics.RigidBody" }, "compId": 4 }], "loadList": [], "loadList3D": [] };
        ui.BulletRifleUpUI = BulletRifleUpUI;
        REG("ui.BulletRifleUpUI", BulletRifleUpUI);
        class BulletSanUI extends Laya.View {
            constructor() {
                super();
            }
            createChildren() {
                super.createChildren();
                this.createView(BulletSanUI.uiView);
            }
        }
        BulletSanUI.uiView = { "type": "View", "props": { "width": 28, "height": 28 }, "compId": 2, "child": [{ "type": "Script", "props": { "y": 0, "x": 0, "width": 28, "isSensor": true, "height": 28, "friction": 0, "runtime": "laya.physics.BoxCollider" }, "compId": 3 }, { "type": "Script", "props": { "gravityScale": 0, "allowRotation": false, "runtime": "laya.physics.RigidBody" }, "compId": 4 }], "loadList": [], "loadList3D": [] };
        ui.BulletSanUI = BulletSanUI;
        REG("ui.BulletSanUI", BulletSanUI);
        class BulletUpUI extends Laya.View {
            constructor() {
                super();
            }
            createChildren() {
                super.createChildren();
                this.createView(BulletUpUI.uiView);
            }
        }
        BulletUpUI.uiView = { "type": "View", "props": { "width": 15, "height": 30 }, "compId": 2, "child": [{ "type": "Script", "props": { "y": 0, "x": 0, "width": 15, "isSensor": true, "height": 30, "friction": 0, "runtime": "laya.physics.BoxCollider" }, "compId": 3 }, { "type": "Script", "props": { "gravityScale": 0, "allowRotation": false, "runtime": "laya.physics.RigidBody" }, "compId": 4 }], "loadList": [], "loadList3D": [] };
        ui.BulletUpUI = BulletUpUI;
        REG("ui.BulletUpUI", BulletUpUI);
        class ChopperBodyUI extends Laya.View {
            constructor() {
                super();
            }
            createChildren() {
                super.createChildren();
                this.createView(ChopperBodyUI.uiView);
            }
        }
        ChopperBodyUI.uiView = { "type": "View", "props": { "width": 332, "height": 172 }, "compId": 2, "child": [{ "type": "Script", "props": { "y": 0, "x": 0, "width": 332, "label": "enemy", "isSensor": true, "height": 172, "friction": 0, "density": 0, "runtime": "laya.physics.BoxCollider" }, "compId": 3 }, { "type": "Script", "props": { "label": "enemy", "gravityScale": 0, "allowRotation": false, "runtime": "laya.physics.RigidBody" }, "compId": 4 }], "loadList": [], "loadList3D": [] };
        ui.ChopperBodyUI = ChopperBodyUI;
        REG("ui.ChopperBodyUI", ChopperBodyUI);
        class ChopperBombUI extends Laya.View {
            constructor() {
                super();
            }
            createChildren() {
                super.createChildren();
                this.createView(ChopperBombUI.uiView);
            }
        }
        ChopperBombUI.uiView = { "type": "View", "props": { "width": 32, "height": 67 }, "compId": 2, "child": [{ "type": "Script", "props": { "y": 0, "x": 0, "width": 32, "label": "enemyBomb", "isSensor": true, "height": 67, "friction": 0, "runtime": "laya.physics.BoxCollider" }, "compId": 3 }, { "type": "Script", "props": { "label": "enemyBomb", "gravityScale": 1.5, "allowRotation": false, "runtime": "laya.physics.RigidBody" }, "compId": 4 }, { "type": "Sprite", "props": { "y": 0, "x": 0, "texture": "zhadan_3.png" }, "compId": 6 }], "loadList": ["zhadan_3.png"], "loadList3D": [] };
        ui.ChopperBombUI = ChopperBombUI;
        REG("ui.ChopperBombUI", ChopperBombUI);
        class EnemyBodyUI extends Laya.View {
            constructor() {
                super();
            }
            createChildren() {
                super.createChildren();
                this.createView(EnemyBodyUI.uiView);
            }
        }
        EnemyBodyUI.uiView = { "type": "View", "props": { "width": 91, "height": 91 }, "compId": 2, "child": [{ "type": "Script", "props": { "width": 91, "label": "enemy", "isSensor": true, "height": 91, "friction": 0, "density": 0, "runtime": "laya.physics.BoxCollider" }, "compId": 3 }, { "type": "Script", "props": { "label": "enemy", "group": 0, "gravityScale": 0, "allowRotation": false, "runtime": "laya.physics.RigidBody" }, "compId": 4 }], "loadList": [], "loadList3D": [] };
        ui.EnemyBodyUI = EnemyBodyUI;
        REG("ui.EnemyBodyUI", EnemyBodyUI);
        class GoodsBodyUI extends Laya.View {
            constructor() {
                super();
            }
            createChildren() {
                super.createChildren();
                this.createView(GoodsBodyUI.uiView);
            }
        }
        GoodsBodyUI.uiView = { "type": "View", "props": { "width": 47, "height": 47 }, "compId": 2, "child": [{ "type": "Script", "props": { "y": 0, "x": 0, "width": 47, "label": "goods", "isSensor": false, "height": 47, "friction": 0, "density": 10, "runtime": "laya.physics.BoxCollider" }, "compId": 3 }, { "type": "Script", "props": { "type": "dynamic", "linearDamping": 1, "label": "goods", "gravityScale": 1, "allowRotation": false, "runtime": "laya.physics.RigidBody" }, "compId": 4 }], "loadList": [], "loadList3D": [] };
        ui.GoodsBodyUI = GoodsBodyUI;
        REG("ui.GoodsBodyUI", GoodsBodyUI);
        class HostageBodyUI extends Laya.View {
            constructor() {
                super();
            }
            createChildren() {
                super.createChildren();
                this.createView(HostageBodyUI.uiView);
            }
        }
        HostageBodyUI.uiView = { "type": "View", "props": { "width": 76, "height": 130 }, "compId": 2, "child": [{ "type": "Script", "props": { "y": 0, "x": 0, "width": 76, "label": "hostage", "isSensor": true, "height": 130, "friction": 0, "density": 0, "runtime": "laya.physics.BoxCollider" }, "compId": 3 }, { "type": "Script", "props": { "label": "hostage", "group": 0, "gravityScale": 0, "allowRotation": false, "runtime": "laya.physics.RigidBody" }, "compId": 4 }], "loadList": [], "loadList3D": [] };
        ui.HostageBodyUI = HostageBodyUI;
        REG("ui.HostageBodyUI", HostageBodyUI);
        class map_1UI extends Laya.Scene {
            constructor() {
                super();
            }
            createChildren() {
                super.createChildren();
                this.createView(map_1UI.uiView);
            }
        }
        map_1UI.uiView = { "type": "Scene", "props": { "width": 50, "height": 50 }, "compId": 2, "child": [{ "type": "Script", "props": { "y": 579, "x": 1872, "points": "-825,-335,-825,-16,-4,-16,138,-42,262,-89,555,-89,615,-102,676,-138,923,-138,1348,30,1560,69,1561,-30,1600,5,1960,7,2197,96,3133,96", "label": "ground", "friction": 0, "runtime": "laya.physics.ChainCollider" }, "compId": 12 }, { "type": "Script", "props": { "y": 0, "x": -800, "type": "static", "label": "ground", "group": 0, "runtime": "laya.physics.RigidBody" }, "compId": 13 }], "loadList": [], "loadList3D": [] };
        ui.map_1UI = map_1UI;
        REG("ui.map_1UI", map_1UI);
        class map_2UI extends Laya.Scene {
            constructor() {
                super();
            }
            createChildren() {
                super.createChildren();
                this.createView(map_2UI.uiView);
            }
        }
        map_2UI.uiView = { "type": "Scene", "props": { "width": 50, "height": 50 }, "compId": 2, "child": [{ "type": "Script", "props": { "y": 338.75, "x": 828, "points": "-828,-340,-827,-52,-385,-29,21,58,825,112,3030,112,4199,-191", "label": "ground", "friction": 0, "runtime": "laya.physics.ChainCollider" }, "compId": 12 }, { "type": "Script", "props": { "y": -178, "x": -1848, "type": "static", "label": "ground", "group": 0, "runtime": "laya.physics.RigidBody" }, "compId": 13 }], "loadList": [], "loadList3D": [] };
        ui.map_2UI = map_2UI;
        REG("ui.map_2UI", map_2UI);
        class map_3UI extends Laya.Scene {
            constructor() {
                super();
            }
            createChildren() {
                super.createChildren();
                this.createView(map_3UI.uiView);
            }
        }
        map_3UI.uiView = { "type": "Scene", "props": { "width": 50, "height": 50 }, "compId": 2, "child": [{ "type": "Script", "props": { "y": 343, "x": 832, "points": "0,-340,0,250,4199,250", "label": "ground", "friction": 0, "runtime": "laya.physics.ChainCollider" }, "compId": 12 }, { "type": "Script", "props": { "y": -167, "x": -1848, "type": "static", "label": "ground", "group": 0, "runtime": "laya.physics.RigidBody" }, "compId": 13 }], "loadList": [], "loadList3D": [] };
        ui.map_3UI = map_3UI;
        REG("ui.map_3UI", map_3UI);
        class map_4UI extends Laya.Scene {
            constructor() {
                super();
            }
            createChildren() {
                super.createChildren();
                this.createView(map_4UI.uiView);
            }
        }
        map_4UI.uiView = { "type": "Scene", "props": { "width": 50, "height": 50 }, "compId": 2, "child": [{ "type": "Script", "props": { "y": 342.75, "x": 829, "points": "-800,-340,-800,250,-141,250,-146,186,-66,186,441,75,850,180,1156,180,1384,119,1651,180,2163,57,2705,182,2707,59,2782,57,3099,107,3301,163,3674,163,4199,250", "label": "ground", "friction": 0, "runtime": "laya.physics.ChainCollider" }, "compId": 12 }, { "type": "Script", "props": { "y": -167, "x": -1848, "type": "static", "label": "ground", "group": 0, "runtime": "laya.physics.RigidBody" }, "compId": 13 }], "loadList": [], "loadList3D": [] };
        ui.map_4UI = map_4UI;
        REG("ui.map_4UI", map_4UI);
        class map_5UI extends Laya.Scene {
            constructor() {
                super();
            }
            createChildren() {
                super.createChildren();
                this.createView(map_5UI.uiView);
            }
        }
        map_5UI.uiView = { "type": "Scene", "props": { "width": 50, "height": 50 }, "compId": 2, "child": [{ "type": "Script", "props": { "y": 414, "x": 608, "points": "0,-340,0,250,4500,250", "label": "ground", "friction": 0, "runtime": "laya.physics.ChainCollider" }, "compId": 12 }, { "type": "Script", "props": { "y": -167, "x": -1848, "type": "static", "label": "ground", "group": 0, "runtime": "laya.physics.RigidBody" }, "compId": 13 }], "loadList": [], "loadList3D": [] };
        ui.map_5UI = map_5UI;
        REG("ui.map_5UI", map_5UI);
        class map_6UI extends Laya.Scene {
            constructor() {
                super();
            }
            createChildren() {
                super.createChildren();
                this.createView(map_6UI.uiView);
            }
        }
        map_6UI.uiView = { "type": "Scene", "props": { "width": 50, "height": 50 }, "compId": 2, "child": [{ "type": "Script", "props": { "y": 424, "x": 0, "points": "0,-340,0,250,5100,250", "label": "ground", "friction": 0, "runtime": "laya.physics.ChainCollider" }, "compId": 12 }, { "type": "Script", "props": { "y": -167, "x": -1848, "type": "static", "label": "ground", "group": 0, "runtime": "laya.physics.RigidBody" }, "compId": 13 }], "loadList": [], "loadList3D": [] };
        ui.map_6UI = map_6UI;
        REG("ui.map_6UI", map_6UI);
        class map_7UI extends Laya.Scene {
            constructor() {
                super();
            }
            createChildren() {
                super.createChildren();
                this.createView(map_7UI.uiView);
            }
        }
        map_7UI.uiView = { "type": "Scene", "props": { "width": 50, "height": 50 }, "compId": 2, "child": [{ "type": "Script", "props": { "y": 428, "x": 0, "points": "0,-340,0,250,5200,250", "label": "ground", "friction": 0, "runtime": "laya.physics.ChainCollider" }, "compId": 12 }, { "type": "Script", "props": { "y": -167, "x": -1848, "type": "static", "label": "ground", "group": 0, "runtime": "laya.physics.RigidBody" }, "compId": 13 }], "loadList": [], "loadList3D": [] };
        ui.map_7UI = map_7UI;
        REG("ui.map_7UI", map_7UI);
        class map_8UI extends Scene {
            constructor() {
                super();
            }
            createChildren() {
                super.createChildren();
                this.createView(map_8UI.uiView);
            }
        }
        map_8UI.uiView = { "type": "Scene", "props": { "width": 50, "height": 50 }, "compId": 2, "child": [{ "type": "BoardBody", "props": { "y": 674, "x": 854, "name": "board_1", "runtime": "ui.BoardBodyUI" }, "compId": 67 }, { "type": "BoardBody", "props": { "y": 674, "x": 1306, "name": "board_2", "runtime": "ui.BoardBodyUI" }, "compId": 68 }, { "type": "BoardBody", "props": { "y": 674, "x": 1768, "name": "board_3", "runtime": "ui.BoardBodyUI" }, "compId": 69 }, { "type": "Script", "props": { "y": 425, "x": 29, "points": "0,-340,0,250,780,250", "label": "ground", "friction": 0, "runtime": "laya.physics.ChainCollider" }, "compId": 12 }, { "type": "Script", "props": { "y": -167, "x": -1848, "type": "static", "label": "ground", "group": 0, "runtime": "laya.physics.RigidBody" }, "compId": 13 }, { "type": "Script", "props": { "y": 280, "x": 2221, "points": "50,540,50,400,2429,400,2429,-300", "label": "ground", "friction": 0, "runtime": "laya.physics.ChainCollider" }, "compId": 73 }], "loadList": [], "loadList3D": [] };
        ui.map_8UI = map_8UI;
        REG("ui.map_8UI", map_8UI);
        class ObstacleBoomBodyUI extends Laya.View {
            constructor() {
                super();
            }
            createChildren() {
                super.createChildren();
                this.createView(ObstacleBoomBodyUI.uiView);
            }
        }
        ObstacleBoomBodyUI.uiView = { "type": "View", "props": { "width": 150, "mouseEnabled": false, "height": 150 }, "compId": 2, "child": [{ "type": "Script", "props": { "y": 0, "x": 0, "radius": 75, "isSensor": true, "friction": 0, "density": 0, "runtime": "laya.physics.CircleCollider" }, "compId": 5 }, { "type": "Script", "props": { "type": "dynamic", "gravityScale": 0, "runtime": "laya.physics.RigidBody" }, "compId": 6 }], "loadList": [], "loadList3D": [] };
        ui.ObstacleBoomBodyUI = ObstacleBoomBodyUI;
        REG("ui.ObstacleBoomBodyUI", ObstacleBoomBodyUI);
        class ObstacleView_1UI extends Laya.Scene {
            constructor() {
                super();
            }
            createChildren() {
                super.createChildren();
                this.createView(ObstacleView_1UI.uiView);
            }
        }
        ObstacleView_1UI.uiView = { "type": "Scene", "props": { "width": 182, "height": 96 }, "compId": 2, "child": [{ "type": "Script", "props": { "y": 0, "x": 0, "points": "55,17,116,17,185,97,-1,97", "label": "obstacle", "isSensor": false, "friction": 0, "runtime": "laya.physics.PolygonCollider" }, "compId": 4 }, { "type": "Script", "props": { "y": 0, "x": 0, "type": "static", "label": "obstacle", "gravityScale": 1, "runtime": "laya.physics.RigidBody" }, "compId": 5 }], "loadList": [], "loadList3D": [] };
        ui.ObstacleView_1UI = ObstacleView_1UI;
        REG("ui.ObstacleView_1UI", ObstacleView_1UI);
        class ObstacleView_10UI extends Laya.Scene {
            constructor() {
                super();
            }
            createChildren() {
                super.createChildren();
                this.createView(ObstacleView_10UI.uiView);
            }
        }
        ObstacleView_10UI.uiView = { "type": "Scene", "props": { "width": 394, "height": 241 }, "compId": 2, "child": [{ "type": "Script", "props": { "y": 0, "x": 0, "points": "0,165,41,165,44,27,355,28,353,174,394,174,394,240,0,239", "label": "obstacle", "friction": 0, "runtime": "laya.physics.PolygonCollider" }, "compId": 4 }, { "type": "Script", "props": { "y": 0, "x": 0, "type": "static", "label": "obstacle", "runtime": "laya.physics.RigidBody" }, "compId": 5 }], "loadList": [], "loadList3D": [] };
        ui.ObstacleView_10UI = ObstacleView_10UI;
        REG("ui.ObstacleView_10UI", ObstacleView_10UI);
        class ObstacleView_11UI extends Laya.Scene {
            constructor() {
                super();
            }
            createChildren() {
                super.createChildren();
                this.createView(ObstacleView_11UI.uiView);
            }
        }
        ObstacleView_11UI.uiView = { "type": "Scene", "props": { "width": 131, "height": 70 }, "compId": 2, "child": [{ "type": "Script", "props": { "y": -3, "x": 0, "points": "1,3,130,3,130,73,0,74", "label": "obstacle", "friction": 0, "runtime": "laya.physics.PolygonCollider" }, "compId": 4 }, { "type": "Script", "props": { "y": 0, "x": 0, "type": "static", "label": "obstacle", "runtime": "laya.physics.RigidBody" }, "compId": 5 }], "loadList": [], "loadList3D": [] };
        ui.ObstacleView_11UI = ObstacleView_11UI;
        REG("ui.ObstacleView_11UI", ObstacleView_11UI);
        class ObstacleView_2UI extends Laya.Scene {
            constructor() {
                super();
            }
            createChildren() {
                super.createChildren();
                this.createView(ObstacleView_2UI.uiView);
            }
        }
        ObstacleView_2UI.uiView = { "type": "Scene", "props": { "width": 92, "height": 119 }, "compId": 2, "child": [{ "type": "Script", "props": { "y": 0, "x": 0, "points": "1,3,91,3,90,120,0,119", "label": "obstacle", "friction": 0, "runtime": "laya.physics.PolygonCollider" }, "compId": 4 }, { "type": "Script", "props": { "y": 0, "x": 0, "type": "static", "label": "obstacle", "runtime": "laya.physics.RigidBody" }, "compId": 5 }], "loadList": [], "loadList3D": [] };
        ui.ObstacleView_2UI = ObstacleView_2UI;
        REG("ui.ObstacleView_2UI", ObstacleView_2UI);
        class ObstacleView_3UI extends Laya.Scene {
            constructor() {
                super();
            }
            createChildren() {
                super.createChildren();
                this.createView(ObstacleView_3UI.uiView);
            }
        }
        ObstacleView_3UI.uiView = { "type": "Scene", "props": { "width": 292, "height": 145 }, "compId": 2, "child": [{ "type": "Script", "props": { "y": -94, "x": 0, "points": "0,165,41,165,43,121,260,121,260,170,291,170,290,239,0,239", "label": "obstacle", "friction": 0, "runtime": "laya.physics.PolygonCollider" }, "compId": 4 }, { "type": "Script", "props": { "y": 0, "x": 0, "type": "static", "label": "obstacle", "runtime": "laya.physics.RigidBody" }, "compId": 5 }], "loadList": [], "loadList3D": [] };
        ui.ObstacleView_3UI = ObstacleView_3UI;
        REG("ui.ObstacleView_3UI", ObstacleView_3UI);
        class ObstacleView_4UI extends Laya.Scene {
            constructor() {
                super();
            }
            createChildren() {
                super.createChildren();
                this.createView(ObstacleView_4UI.uiView);
            }
        }
        ObstacleView_4UI.uiView = { "type": "Scene", "props": { "width": 781, "height": 236 }, "compId": 2, "child": [{ "type": "Script", "props": { "y": -94, "x": 0, "points": "32,246,65,246,65,132,707,131,704,252,740,253,740,329,32,329", "label": "obstacle", "friction": 0, "runtime": "laya.physics.PolygonCollider" }, "compId": 4 }, { "type": "Script", "props": { "y": 0, "x": 0, "type": "static", "label": "obstacle", "runtime": "laya.physics.RigidBody" }, "compId": 5 }], "loadList": [], "loadList3D": [] };
        ui.ObstacleView_4UI = ObstacleView_4UI;
        REG("ui.ObstacleView_4UI", ObstacleView_4UI);
        class ObstacleView_5UI extends Laya.Scene {
            constructor() {
                super();
            }
            createChildren() {
                super.createChildren();
                this.createView(ObstacleView_5UI.uiView);
            }
        }
        ObstacleView_5UI.uiView = { "type": "Scene", "props": { "width": 452, "height": 236 }, "compId": 2, "child": [{ "type": "Script", "props": { "y": 0, "x": 0, "points": "0,165,41,165,43,50,405,50,404,174,445,174,445,239,0,239", "label": "obstacle", "friction": 0, "runtime": "laya.physics.PolygonCollider" }, "compId": 4 }, { "type": "Script", "props": { "y": 0, "x": 0, "type": "static", "label": "obstacle", "runtime": "laya.physics.RigidBody" }, "compId": 5 }], "loadList": [], "loadList3D": [] };
        ui.ObstacleView_5UI = ObstacleView_5UI;
        REG("ui.ObstacleView_5UI", ObstacleView_5UI);
        class ObstacleView_6UI extends Laya.Scene {
            constructor() {
                super();
            }
            createChildren() {
                super.createChildren();
                this.createView(ObstacleView_6UI.uiView);
            }
        }
        ObstacleView_6UI.uiView = { "type": "Scene", "props": { "width": 181, "height": 230 }, "compId": 2, "child": [{ "type": "Script", "props": { "y": -94, "x": 0, "points": "0,91,180,93,178,324,50,324", "label": "obstacle", "friction": 0, "runtime": "laya.physics.PolygonCollider" }, "compId": 4 }, { "type": "Script", "props": { "y": 0, "x": 0, "type": "static", "label": "obstacle", "runtime": "laya.physics.RigidBody" }, "compId": 5 }], "loadList": [], "loadList3D": [] };
        ui.ObstacleView_6UI = ObstacleView_6UI;
        REG("ui.ObstacleView_6UI", ObstacleView_6UI);
        class ObstacleView_7UI extends Laya.Scene {
            constructor() {
                super();
            }
            createChildren() {
                super.createChildren();
                this.createView(ObstacleView_7UI.uiView);
            }
        }
        ObstacleView_7UI.uiView = { "type": "Scene", "props": { "width": 295, "height": 98 }, "compId": 2, "child": [{ "type": "Script", "props": { "y": -140, "x": 0, "points": "0,165,290,165,290,239,0,239", "label": "obstacle", "friction": 0, "runtime": "laya.physics.PolygonCollider" }, "compId": 4 }, { "type": "Script", "props": { "y": 0, "x": 0, "type": "static", "label": "obstacle", "runtime": "laya.physics.RigidBody" }, "compId": 5 }], "loadList": [], "loadList3D": [] };
        ui.ObstacleView_7UI = ObstacleView_7UI;
        REG("ui.ObstacleView_7UI", ObstacleView_7UI);
        class ObstacleView_8UI extends Laya.Scene {
            constructor() {
                super();
            }
            createChildren() {
                super.createChildren();
                this.createView(ObstacleView_8UI.uiView);
            }
        }
        ObstacleView_8UI.uiView = { "type": "Scene", "props": { "width": 197, "height": 73 }, "compId": 2, "child": [{ "type": "Script", "props": { "y": -165, "x": 0, "points": "0,183,14,222,182,222,196,181,196,238,0,238", "label": "obstacle", "friction": 0, "runtime": "laya.physics.PolygonCollider" }, "compId": 4 }, { "type": "Script", "props": { "y": 0, "x": 0, "type": "static", "label": "obstacle", "runtime": "laya.physics.RigidBody" }, "compId": 5 }], "loadList": [], "loadList3D": [] };
        ui.ObstacleView_8UI = ObstacleView_8UI;
        REG("ui.ObstacleView_8UI", ObstacleView_8UI);
        class ObstacleView_9UI extends Laya.Scene {
            constructor() {
                super();
            }
            createChildren() {
                super.createChildren();
                this.createView(ObstacleView_9UI.uiView);
            }
        }
        ObstacleView_9UI.uiView = { "type": "Scene", "props": { "width": 92, "height": 119 }, "compId": 2, "child": [{ "type": "Script", "props": { "y": 0, "x": 0, "points": "1,3,87,3,87,120,0,119", "label": "obstacle", "friction": 0, "runtime": "laya.physics.PolygonCollider" }, "compId": 4 }, { "type": "Script", "props": { "y": 0, "x": 0, "type": "static", "label": "obstacle", "runtime": "laya.physics.RigidBody" }, "compId": 5 }], "loadList": [], "loadList3D": [] };
        ui.ObstacleView_9UI = ObstacleView_9UI;
        REG("ui.ObstacleView_9UI", ObstacleView_9UI);
        class PlayerBodyUI extends Laya.View {
            constructor() {
                super();
            }
            createChildren() {
                super.createChildren();
                this.createView(PlayerBodyUI.uiView);
            }
        }
        PlayerBodyUI.uiView = { "type": "View", "props": { "width": 55, "height": 105 }, "compId": 2, "child": [{ "type": "Script", "props": { "y": 0, "x": 0, "width": 55, "label": "player", "isSensor": false, "height": 105, "friction": 0, "density": 20, "runtime": "laya.physics.BoxCollider" }, "compId": 3 }, { "type": "Script", "props": { "type": "dynamic", "label": "player", "group": 0, "gravityScale": 2.5, "allowRotation": false, "runtime": "laya.physics.RigidBody" }, "compId": 4 }], "loadList": [], "loadList3D": [] };
        ui.PlayerBodyUI = PlayerBodyUI;
        REG("ui.PlayerBodyUI", PlayerBodyUI);
        class TankBody11UI extends Laya.View {
            constructor() {
                super();
            }
            createChildren() {
                super.createChildren();
                this.createView(TankBody11UI.uiView);
            }
        }
        TankBody11UI.uiView = { "type": "View", "props": { "width": 227, "height": 110 }, "compId": 2, "child": [{ "type": "Script", "props": { "y": 0, "x": 0, "width": 227, "label": "enemy", "isSensor": true, "height": 110, "friction": 0, "density": 0, "runtime": "laya.physics.BoxCollider" }, "compId": 3 }, { "type": "Script", "props": { "label": "enemy", "gravityScale": 0, "allowRotation": false, "runtime": "laya.physics.RigidBody" }, "compId": 4 }], "loadList": [], "loadList3D": [] };
        ui.TankBody11UI = TankBody11UI;
        REG("ui.TankBody11UI", TankBody11UI);
        class TankBody12UI extends Laya.View {
            constructor() {
                super();
            }
            createChildren() {
                super.createChildren();
                this.createView(TankBody12UI.uiView);
            }
        }
        TankBody12UI.uiView = { "type": "View", "props": { "width": 256, "height": 130 }, "compId": 2, "child": [{ "type": "Script", "props": { "y": 0, "x": 0, "width": 256, "label": "enemy", "isSensor": true, "height": 130, "friction": 0, "density": 0, "runtime": "laya.physics.BoxCollider" }, "compId": 3 }, { "type": "Script", "props": { "label": "enemy", "gravityScale": 0, "allowRotation": false, "runtime": "laya.physics.RigidBody" }, "compId": 4 }], "loadList": [], "loadList3D": [] };
        ui.TankBody12UI = TankBody12UI;
        REG("ui.TankBody12UI", TankBody12UI);
        class TankBody13UI extends Laya.View {
            constructor() {
                super();
            }
            createChildren() {
                super.createChildren();
                this.createView(TankBody13UI.uiView);
            }
        }
        TankBody13UI.uiView = { "type": "View", "props": { "width": 298, "height": 119 }, "compId": 2, "child": [{ "type": "Script", "props": { "y": 0, "x": 0, "width": 298, "label": "enemy", "isSensor": true, "height": 119, "friction": 0, "density": 0, "runtime": "laya.physics.BoxCollider" }, "compId": 3 }, { "type": "Script", "props": { "label": "enemy", "gravityScale": 0, "allowRotation": false, "runtime": "laya.physics.RigidBody" }, "compId": 4 }], "loadList": [], "loadList3D": [] };
        ui.TankBody13UI = TankBody13UI;
        REG("ui.TankBody13UI", TankBody13UI);
        class TankBody14UI extends Laya.View {
            constructor() {
                super();
            }
            createChildren() {
                super.createChildren();
                this.createView(TankBody14UI.uiView);
            }
        }
        TankBody14UI.uiView = { "type": "View", "props": { "width": 253, "height": 106 }, "compId": 2, "child": [{ "type": "Script", "props": { "y": 0, "x": 0, "width": 253, "label": "enemy", "isSensor": true, "height": 106, "friction": 0, "density": 0, "runtime": "laya.physics.BoxCollider" }, "compId": 3 }, { "type": "Script", "props": { "label": "enemy", "gravityScale": 0, "allowRotation": false, "runtime": "laya.physics.RigidBody" }, "compId": 4 }], "loadList": [], "loadList3D": [] };
        ui.TankBody14UI = TankBody14UI;
        REG("ui.TankBody14UI", TankBody14UI);
    })(ui || (ui = {}));

    class GameData {
    }
    GameData.WEAPON_PIS = 1;
    GameData.WEAPON_MAC = 2;
    GameData.WEAPON_RIFLE = 3;
    GameData.WEAPON_GRE = 4;
    GameData.ENEMY_PIS = 1;
    GameData.ENEMY_GRE = 2;
    GameData.ENEMY_MAC = 3;
    GameData.ENEMY_FIRE = 4;
    GameData.ENEMY_MOR = 5;
    GameData.ENEMY_JUNGUAN = 6;
    GameData.ENEMY_CHOPPER = 10;
    GameData.ENEMY_TANK_1 = 11;
    GameData.ENEMY_TANK_2 = 12;
    GameData.ENEMY_TANK_3 = 13;
    GameData.ENEMY_TANK_4 = 14;
    GameData.HOSTAGE = 30;
    GameData.RANDOM_COIN = 200;
    GameData.BOMB_DAMAGE = 5;
    GameData.OBSTACLE_DAMAGE = 10;
    GameData.SOUND_FONT = "sound/";
    GameData.VICTORY_LEVEL_COIN = 1000;
    GameData.PAN_DAMAGE = 5;
    GameData.SHOW_ENEMY_NAME = false;
    class BombData {
    }
    BombData.BOMB_MY_GRE = 1;
    BombData.BOMB_ENEMY_GRE = 2;
    BombData.BOMB_CHOPPER = 3;
    BombData.BOMB_TANK = 4;
    BombData.BOMB_MOR = 5;
    BombData.BOMB_FIRE = 6;
    class ShotDirectionData {
    }
    ShotDirectionData.LEFT = -1;
    ShotDirectionData.RIGHT = 1;
    ShotDirectionData.RIGHT_UP = 2;
    ShotDirectionData.LEFT_UP = -2;
    class ObstacleType {
    }
    ObstacleType.ObstacleType_SHABAO = 1;
    ObstacleType.ObstacleType_YOUGUAN = 2;
    ObstacleType.ObstacleType_MICHE = 3;
    ObstacleType.ObstacleType_DACHE = 4;
    ObstacleType.ObstacleType_CHE = 5;
    ObstacleType.ObstacleType_6 = 6;
    ObstacleType.ObstacleType_7 = 7;
    ObstacleType.ObstacleType_8 = 8;
    ObstacleType.ObstacleType_9 = 9;
    ObstacleType.ObstacleType_10 = 10;
    ObstacleType.ObstacleType_11 = 11;
    class GoodsType {
    }
    GoodsType.GoodsType_MED = 1;
    GoodsType.GoodsType_MAC = 2;
    GoodsType.GoodsType_RIF = 3;
    GoodsType.GoodsType_GRE = 4;
    GoodsType.GoodsType_COIN = 5;
    GoodsType.GoodsType_BOX = 6;
    GoodsType.GoodsType_OPEN_BOX = 7;

    class SoundManager {
        constructor() {
            this.isOpenSound = true;
            this.bgmName = "";
        }
        static get instance() {
            if (this._instance == null) {
                this._instance = new SoundManager();
                Laya.SoundManager.useAudioMusic = false;
            }
            return this._instance;
        }
        playLastBgm() {
            if (Laya.stage.isFocused) {
                if (this.bgmName) {
                    if (this.isOpenSound) {
                        Laya.SoundManager.soundMuted = false;
                        Laya.SoundManager.musicMuted = false;
                        this.bgm = Laya.SoundManager.playMusic(this.bgmName);
                    }
                }
            }
            else {
                console.log("Laya.stage.isFocused", Laya.stage.isFocused);
            }
        }
        playSound(n) {
            if (!this.isOpenSound)
                return;
            var s = GameData.SOUND_FONT + n + ".mp3";
            Laya.SoundManager.playSound(s);
        }
        playBGM(name) {
            var s = "sound/" + name + ".mp3";
            this.bgmName = name;
            Laya.SoundManager.playMusic(s);
        }
        stopBGM() {
            Laya.SoundManager.stopMusic();
        }
        offSound() {
            this.isOpenSound = false;
            Laya.SoundManager.soundMuted = true;
            Laya.SoundManager.musicMuted = true;
        }
        openSound() {
            this.isOpenSound = true;
            Laya.SoundManager.soundMuted = false;
            Laya.SoundManager.musicMuted = false;
        }
    }

    class WarView {
        constructor() { }
        createView() {
            var index = GameManager.instance.curLevelData.mapIndex;
            if (index == 1) {
                this.scene = new ui.map_1UI();
            }
            else if (index == 2) {
                this.scene = new ui.map_2UI();
            }
            else if (index == 3) {
                this.scene = new ui.map_3UI();
            }
            else if (index == 4) {
                this.scene = new ui.map_4UI();
            }
            else if (index == 5) {
                this.scene = new ui.map_5UI();
            }
            else if (index == 6) {
                this.scene = new ui.map_6UI();
            }
            else if (index == 7) {
                this.scene = new ui.map_7UI();
            }
            else if (index == 8) {
                this.scene = new ui.map_8UI();
            }
            else {
                return;
            }
            this.loadComplete();
        }
        ;
        loadComplete() {
            this.warView = fairygui.UIPackage.createObject("Game", "WarView");
            this.warView.m_bg.url = "res/map_" + GameManager.instance.curLevelData.mapIndex + ".jpg";
            this.warView.m_bg2.url = "res/map_" + GameManager.instance.curLevelData.mapIndex + "_2.jpg";
            Laya.Physics.I.worldRoot = this.scene;
            ViewManager.instance.createPlayer();
            GameManager.instance.createEnemyData();
            GameManager.instance.createObstacleData();
            this.warView.x = GameManager.instance.curLvData.warViewPos[0];
            this.warView.y = GameManager.instance.curLvData.warViewPos[1];
            this.warView.displayObject.addChild(this.scene);
            Laya.stage.addChildAt(this.warView.displayObject, 0);
        }
        showReMenAd() {
            SoundManager.instance.playSound("btn_click");
            ViewManager.instance.showADListView();
        }
        updateViewPort(moveX) {
            Laya.Tween.to(this.warView, { x: this.warView.x - moveX }, 500, Laya.Ease.linearIn);
        }
        dispose() {
            if (this.scene) {
                this.scene.removeChildren();
                this.scene.removeSelf();
            }
            if (this.warView) {
                this.warView.displayObject.removeChildren();
                this.warView.dispose();
            }
            this.recover();
        }
        recover() {
            Laya.Pool.recover("warView", this);
        }
        removeView() {
            this.warView.displayObject.removeChild(this.scene);
            Laya.stage.removeChild(this.warView.displayObject);
        }
    }

    class EventManager extends Laya.EventDispatcher {
        constructor() {
            super();
        }
        static get instance() {
            if (this._instance == null)
                this._instance = new EventManager();
            return this._instance;
        }
        dispatcherEvt(InName, agv) {
            EventManager.eventDispatcher.event(InName, agv);
        }
        addNotice(InName, caller, listener, arg) {
            EventManager.eventDispatcher.on(InName, caller, listener, (arg == null) ? null : ([arg]));
        }
        offNotice(InName, caller, listener) {
            EventManager.eventDispatcher.off(InName, caller, listener);
        }
    }
    EventManager.eventDispatcher = new Laya.EventDispatcher();

    class GameEvent {
        constructor() {
        }
    }
    GameEvent.PLAYER_DEATH = "PLAYER_DEATH";
    GameEvent.PLAYER_JUMP = "PLAYER_JUMP";
    GameEvent.PLAYER_RUN = "PLAYER_RUN";
    GameEvent.PLAYER_STAY = "PLAYER_STAY";
    GameEvent.PLAYER_COLLISION_GROUND = "PLAYER_COLLISION_GROUND";
    GameEvent.BULLET_DISPOSE = "BULLET_DISPOSE";
    GameEvent.PLAYER_BULLET_HIT_ENEMY = "PLAYER_BULLET_HIT_ENEMY";
    GameEvent.PLAYER_BULLET_HIT_OBSTACLE = "PLAYER_BULLET_HIT_OBSTACLE";
    GameEvent.PLAYER_PAN_HIT_ENEMY = "PLAYER_PAN_HIT_ENEMY";
    GameEvent.ENEMY_BULLET_HIT_PLAYER = "ENEMY_BULLET_HIT_PLAYER";
    GameEvent.ACTIVE_ENEMY = "ACTIVE_ENEMY";
    GameEvent.ACTIVE_HOSTAGE = "ACTIVE_HOSTAGE";
    GameEvent.BOMB_DISPOSE = "BOMB_DISPOSE";
    GameEvent.PLAYER_BOMB_HIT_ENEMY = "PLAYER_BOMB_HIT_ENEMY";
    GameEvent.PLAYER_BOMB_HIT_OBSTACLE = "PLAYER_BOMB_HIT_OBSTACLE";
    GameEvent.ENEMY_BOMB_HIT_PLAYER = "ENEMY_BOMB_HIT_PLAYER";
    GameEvent.PLAYER_GET_GOODS = "PLAYER_GET_GOODS";
    GameEvent.CHANGE_PLAYER_GOODS = "CHANGE_PLAYER_GOODS";
    GameEvent.CHANGE_PLAYER_WEAPON = "CHANGE_PLAYER_WEAPON";
    GameEvent.ADD_PLAYER_BOMB = "ADD_PLAYER_BOMB";
    GameEvent.ADD_PLAYER_BLOOD = "ADD_PLAYER_BLOOD";
    GameEvent.DEC_PLAYER_BLOOD = "DEC_PLAYER_BLOOD";
    GameEvent.USE_PLAYER_BOMB = "USE_PLAYER_BOMB";
    GameEvent.USE_PLAYER_BULLET = "USE_PLAYER_BULLET";
    GameEvent.PAUSE_GAME = "PAUSE_GAME";
    GameEvent.VICITORY_LEVEL = "VICITORY_LEVEL";
    GameEvent.BUY_SHOP_ITEM = "BUY_SHOP_ITEM";
    GameEvent.BUY_SHOP_ITEM_FREE = "BUY_SHOP_ITEM_FREE";
    GameEvent.CLEAR_WAR_VIEW = "CLEAR_WAR_VIEW";
    GameEvent.GOTO_HOLE = "GOTO_HOLE";
    GameEvent.OBSTACLE_BOOM = "OBSTACLE_BOOM";
    GameEvent.CHANGE_SIZE = "CHANGE_SIZE";
    GameEvent.ROLE_ANI_COMPLETE = "ROLE_ANI_COMPLETE";
    GameEvent.SHOW_AD_LIST = "SHOW_AD_LIST";
    GameEvent.CLOSE_APP_AD_BOX = "CLOSE_APP_AD_BOX";

    class EnemyBody extends Laya.Script {
        constructor() {
            super();
            this.activeDis = 650;
            this.isActive = false;
            this.isDrop = false;
            this.isRemove = false;
        }
        onAwake() {
            this.selfCollider = this.owner.getComponent(Laya.BoxCollider);
            this.selfBody = this.selfCollider.rigidBody;
            this.oriPosX = this.selfBody.getWorldCenter().x;
            this.isRemove = false;
        }
        onDisable() {
        }
        onTriggerEnter(other, self, contact) {
            if (this.isRemove)
                return;
            if (other.label == "obstacle") {
                this.obstacleBox = other;
            }
            if ((other.label == "ground" || other.label == "board" || other.label == "obstacle")) {
                this.selfBody.gravityScale = 0;
                this.selfCollider.density = 0;
                this.selfBody.setVelocity({ x: 0, y: 0 });
                this.selfCollider.refresh();
                if (this.isDrop)
                    (this.selfBody.owner).y -= 8;
            }
        }
        onTriggerExit() {
        }
        onTriggerStay(other, self, contact) {
        }
        onUpdate() {
            if (this.isActive)
                return;
            if (Math.abs(ViewManager.instance.rolePlayer.roleSprite.x - this.oriPosX) < this.activeDis) {
                this.isActive = true;
                EventManager.instance.dispatcherEvt(GameEvent.ACTIVE_ENEMY, this.owner);
            }
        }
        setSpeedZero() {
            this.selfBody.linearVelocity = { x: 0, y: 0 };
            this.selfBody.angularVelocity = 0;
            this.selfBody.setVelocity({ x: 0, y: 0 });
            this.selfBody.angularDamping = 0;
            this.selfBody.setAngle({ x: 0, y: 0 });
            this.selfBody.linearDamping = 0;
            this.selfCollider.refresh();
        }
    }

    class VideoData {
        constructor() {
            this.type = 0;
            this.info = "";
        }
    }
    class VideoInfo {
    }
    VideoInfo.VIDEOINFO_ITEM = "看视频获得物资";
    VideoInfo.VIDEOINFO_LIFE = "看视频原地复活";
    VideoInfo.VIDEOINFO_DOUBLE_COIN = "看视频获得双倍金币";
    VideoInfo.VIDEOINFO_BOX = "看视频获得宝箱奖励";
    VideoInfo.VIDEOINFO_GOODS = "金币不够,看视频获得道具";
    VideoInfo.VIDEOTYPE_TREBLE_COIN = "看视频获得三倍金币";
    class VideoType {
    }
    VideoType.VIDEOTYPE_ITEM = 1;
    VideoType.VIDEOTYPE_LIFE = 2;
    VideoType.VIDEOTYPE_DOUBLE_COIN = 3;
    VideoType.VIDEOTYPE_BOX = 4;
    VideoType.VIDEOTYPE_GOODS = 5;
    VideoType.VIDEOTYPE_TREBLE_COIN = 6;

    class MooSnowSDK {
        static login() {
            moosnow.platform.login(() => {
                console.log('登录成功 ');
            });
            if (MooSnowSDK.getPlatform() == moosnow.APP_PLATFORM.WX)
                MooSnowSDK.showAutoBanner();
        }
        static finishLoading() {
            moosnow.http.finishLoading();
        }
        static startGame(lv) {
            moosnow.http.startGame(lv + "");
        }
        static endGame(lv, isWin) {
            moosnow.http.endGame(lv + "", isWin);
        }
        static videoPoint(type, lv, str) {
            moosnow.http.videoPoint(type + "", str, lv + "");
        }
        static getAD() {
            moosnow.ad.getAd((r) => {
                console.log('广告数据 ', r);
                GameManager.instance.adList = r.indexLeft.concat();
                GameManager.instance.setADlist();
            });
        }
        static showBanner(isWuChu = false) {
            moosnow.platform.showBanner(isWuChu, (isOpend) => {
                console.log('用户是否点击了banner ', isOpend);
                if (isOpend) {
                    if (isWuChu) {
                        MooSnowSDK.hideBanner();
                    }
                }
            });
        }
        static hideBanner() {
            moosnow.platform.hideBanner();
        }
        static showAutoBanner() {
            moosnow.platform.showAutoBanner();
        }
        static showVideo(data, videoData, successFun, errorFun, noFinishFun, closeFun) {
            if (GameManager.instance.platform == moosnow.APP_PLATFORM.VIVO) {
                if (!MooSnowSDK.showVIVOTimer) {
                    ViewManager.instance.showTipsView("视频还未准备好，请稍后再试");
                    return;
                }
            }
            if (SoundManager.instance.isOpenSound) {
                Laya.SoundManager.soundMuted = true;
                Laya.SoundManager.musicMuted = true;
            }
            if (videoData.type == VideoType.VIDEOTYPE_ITEM) {
                MooSnowSDK.videoPoint(0, GameManager.instance.choiseLevel, VideoInfo.VIDEOINFO_ITEM);
            }
            else if (videoData.type == VideoType.VIDEOTYPE_LIFE) {
                MooSnowSDK.videoPoint(0, GameManager.instance.choiseLevel, VideoInfo.VIDEOINFO_LIFE);
            }
            else if (videoData.type == VideoType.VIDEOTYPE_DOUBLE_COIN) {
                MooSnowSDK.videoPoint(0, GameManager.instance.choiseLevel, VideoInfo.VIDEOINFO_DOUBLE_COIN);
            }
            else if (videoData.type == VideoType.VIDEOTYPE_BOX) {
                MooSnowSDK.videoPoint(0, GameManager.instance.choiseLevel, VideoInfo.VIDEOINFO_BOX);
            }
            moosnow.platform.showVideo(res => {
                switch (res) {
                    case moosnow.VIDEO_STATUS.NOTEND:
                        console.log('视频未观看完成 ');
                        if (noFinishFun) {
                            noFinishFun();
                        }
                        if (GameManager.instance.platform == moosnow.APP_PLATFORM.BYTEDANCE) {
                            ViewManager.instance.showNoVideoView(videoData, data, successFun, closeFun);
                        }
                        else
                            ViewManager.instance.showTipsView("未看完视频无法获得奖励哦");
                        break;
                    case moosnow.VIDEO_STATUS.ERR:
                        console.log('获取视频错误 ');
                        if (errorFun) {
                            errorFun();
                        }
                        ViewManager.instance.showTipsView("视频获取失败，请稍后再试");
                        break;
                    case moosnow.VIDEO_STATUS.END:
                        console.log('观看视频结束 ');
                        if (GameManager.instance.platform == moosnow.APP_PLATFORM.BYTEDANCE)
                            ViewManager.instance.hidePopUpView(null, true);
                        GameManager.instance.showVideoResp(data, videoData, successFun);
                        MooSnowSDK.videoPoint(1, GameManager.instance.choiseLevel, videoData.info);
                        break;
                }
                if (SoundManager.instance.isOpenSound) {
                    Laya.SoundManager.soundMuted = false;
                    Laya.SoundManager.musicMuted = false;
                    SoundManager.instance.playBGM(SoundManager.instance.bgmName);
                }
                if (GameManager.instance.platform == moosnow.APP_PLATFORM.VIVO) {
                    Laya.timer.clear(this, this.showVIVOVideo);
                    this.showVIVOTimer = false;
                    Laya.timer.once(10000, this, this.showVIVOVideo);
                }
            });
        }
        static showVIVOVideo() {
            this.showVIVOTimer = true;
        }
        static getMistouchPosNum() {
            var misTouchPosNum = 0;
            moosnow.http.getMistouchPosNum((res) => {
                MooSnowSDK.mistouchPos = misTouchPosNum = res;
                console.log("误点位移次数间隔", res);
            });
        }
        static getMisTouchNum() {
            var misTouchNum = 0;
            moosnow.http.getMisTouchNum((res) => {
                MooSnowSDK.misTouchNum = misTouchNum = res;
                console.log("误点次数间隔", res);
            });
        }
        static setPoint(str) {
            moosnow.http.point(str);
        }
        static getAllConfig() {
            var data;
            moosnow.http.getAllConfig(res => {
                data = res;
                console.log("游戏的所有配置数据", res);
            });
            return data;
        }
        static getPlatform() {
            let curPlatform = moosnow.getAppPlatform();
            return curPlatform;
        }
        static showQQADBox(isWuChu = false, closeShowBannerr = false) {
            moosnow.platform.showAppBox((res) => {
                if (res <= 0) {
                    moosnow.platform.hideAppBox();
                    EventManager.instance.dispatcherEvt(GameEvent.CLOSE_APP_AD_BOX);
                }
                if (isWuChu && res == 0) {
                    MooSnowSDK.hideQQADBox();
                }
            }, false);
        }
        static hideQQADBox() {
            moosnow.platform.hideAppBox(() => {
                ViewManager.instance.showResultView();
            });
        }
        static startRecord() {
            if (GameManager.instance.platform != moosnow.APP_PLATFORM.BYTEDANCE)
                return;
            moosnow.platform.startRecord(300, (e) => {
                console.log('是否是抖音', e);
            });
        }
        static clipRecord(call) {
            if (GameManager.instance.platform != moosnow.APP_PLATFORM.BYTEDANCE)
                return;
            console.log('视频精彩剪切');
            moosnow.platform.clipRecord([15, 2], (res) => {
                console.log('剪切视频完成');
                MooSnowSDK.stopRecord();
            });
        }
        static stopRecord() {
            if (GameManager.instance.platform != moosnow.APP_PLATFORM.BYTEDANCE)
                return;
            moosnow.platform.stopRecord((res) => {
                if (res.videoPath) {
                    let videoPath = res.videoPath;
                    console.log('录制的视频路径', videoPath);
                }
            });
        }
        static shareRecord() {
            if (GameManager.instance.platform != moosnow.APP_PLATFORM.BYTEDANCE)
                return;
            moosnow.platform.share({
                channel: moosnow.SHARE_CHANNEL.VIDEO
            }, (res) => {
                console.log('分享结束', res);
            }, (res) => {
                console.log('录屏时间太短', res);
            });
            ViewManager.instance.showResultView();
        }
        static installShortcut() {
            moosnow.platform.hasShortcutInstalled(function (has) {
                if (!has)
                    moosnow.platform.installShortcut(null);
            });
        }
        static clickNative(callback) {
            moosnow.platform.clickNative(callback);
        }
    }
    MooSnowSDK.misTouchNum = 0;
    MooSnowSDK.mistouchPos = 0;
    MooSnowSDK.showVIVOTimer = true;

    class Enemy {
        constructor() {
            this.enemyType = 5;
            this.direction = 0;
            this.sRun = false;
            this.keyRight = false;
            this.keyLeft = false;
            this.keyJump = false;
            this.speed = 10;
            this.jumpHigh = 200;
            this.isDeath = false;
            this.blood = 1;
            this.expRate = [];
            this.isBoss = false;
            this.isActive = false;
            this.name = "";
        }
        createView(d) {
            this.initData(d);
            this.scene = new ui.EnemyBodyUI();
            this.loadComplete();
        }
        ;
        initData(d) {
            this.enemyData = d;
            this.direction = d.direction;
            this.enemyType = d.type;
            this.blood = d.blood;
            this.damage = d.damage;
            this.activeDis = d.activeDis;
            this.pos = d.pos;
            this.expRate = d.expRate.concat();
            this.isBoss = d.isBoss;
            this.isActive = false;
            this.isDeath = false;
            this.name = d.name;
            Laya.timer.clear(this, this.setFire);
        }
        loadComplete() {
            this.view = fairygui.UIPackage.createObject("Game", "enemy");
            this.view.setPivot(0.5, 0.5);
            this.enemy = this.view.getChildAt(0);
            this.initView();
        }
        ;
        initView() {
            this.enemy.url = "ui://Game/enemy" + this.enemyType;
            this.scene.addChild(this.enemy.displayObject);
            this.scene.addComponent(EnemyBody);
            this.box = this.scene.getComponent(Laya.BoxCollider);
            this.body = this.scene.getComponent(Laya.RigidBody);
            this.scene.x = this.pos.x;
            this.scene.y = this.pos.y;
            ViewManager.instance.warView.scene.addChild(this.scene);
            this.enemyScript = this.scene.getComponent(EnemyBody);
            if (this.enemyType == GameData.ENEMY_JUNGUAN) {
                this.enemyScript.activeDis = 900;
            }
            EventManager.instance.addNotice(GameEvent.PLAYER_BULLET_HIT_ENEMY, this, this.beHit);
            EventManager.instance.addNotice(GameEvent.PLAYER_BOMB_HIT_ENEMY, this, this.beHit);
            EventManager.instance.addNotice(GameEvent.PAUSE_GAME, this, this.pauseGame);
            EventManager.instance.addNotice(GameEvent.ACTIVE_ENEMY, this, this.activeEnemy);
            EventManager.instance.addNotice(GameEvent.CLEAR_WAR_VIEW, this, this.clearWarView);
            EventManager.instance.addNotice(GameEvent.OBSTACLE_BOOM, this, this.obstacleBoom);
            EventManager.instance.addNotice(GameEvent.PLAYER_PAN_HIT_ENEMY, this, this.beHit);
            this.setDirection();
            this.setStay();
            this.showEnemyName();
        }
        activeEnemy(s) {
            if (this.isActive)
                return;
            if (this.isDeath)
                return;
            if (this.box.owner == s) {
                this.isActive = true;
                this.setFire();
                Laya.timer.loop(3000, this, this.setFire);
            }
        }
        pauseGame() {
            if (this.isDeath)
                return;
            this.bodyLoader.playing = !GameManager.instance.isPauseGame;
            if (this.enemyType == GameData.ENEMY_MOR) {
                this.bodyLoader.component.getChildAt(0).asLoader.playing = !GameManager.instance.isPauseGame;
                this.bodyLoader.component.getChildAt(1).asMovieClip.playing = !GameManager.instance.isPauseGame;
            }
        }
        obstacleBoom(s) {
            if (this.enemyScript.obstacleBox && this.enemyScript.obstacleBox.owner && s == this.enemyScript.obstacleBox.owner) {
                this.body.gravityScale = 2;
                this.box.density = 5;
                this.body.setVelocity({ x: 0, y: 1 });
                this.box.refresh();
                this.enemyScript.isDrop = true;
                console.log("obstacleBoom--");
            }
        }
        beHit(s) {
            if (this.isDeath)
                return;
            if (s.o == this.box.owner) {
                this.blood -= s.d;
                Laya.timer.clear(this, this.setColor);
                if (this.blood <= 0) {
                    this.setDeath();
                }
                else {
                    if (this.enemyType == GameData.ENEMY_MOR) {
                        this.bodyLoader.component.getChildAt(0).asLoader.content.color = "#ff0000";
                        this.bodyLoader.component.getChildAt(1).asMovieClip.color = "#ff0000";
                    }
                    else
                        this.bodyLoader.color = "#ff0000";
                    Laya.timer.once(200, this, this.setColor);
                    ViewManager.instance.createDamageView(s.d, this.scene);
                }
            }
        }
        setColor() {
            if (this.enemyType == GameData.ENEMY_MOR) {
                this.bodyLoader.component.getChildAt(0).asLoader.content.color = "#ffffff";
                this.bodyLoader.component.getChildAt(1).asMovieClip.color = "#ffffff";
            }
            else
                this.bodyLoader.color = "#ffffff";
        }
        setDirection() {
            if (this.direction == ShotDirectionData.LEFT) {
                this.bodyLoader.skewY = 0;
            }
            else {
                this.bodyLoader.skewY = 180;
            }
        }
        setIdle() {
            if (this.isDeath)
                return;
            if (this.enemyType == GameData.ENEMY_PIS || this.enemyType == GameData.ENEMY_GRE) {
                this.bodyLoader.url = "ui://Game/enemyIdle_1";
            }
            else if (this.enemyType == GameData.ENEMY_MAC) {
                this.bodyLoader.url = "ui://Game/enemyIdle_2";
            }
            else if (this.enemyType == GameData.ENEMY_FIRE) {
                this.bodyLoader.url = "ui://Game/enemyStay_4";
            }
            else if (this.enemyType == GameData.ENEMY_MOR) {
                this.bodyLoader.url = "ui://Game/enemyStay_5";
            }
            else if (this.enemyType == GameData.ENEMY_JUNGUAN) {
                this.bodyLoader.url = "ui://Game/enemyStay_6";
            }
            else if (this.enemyType == GameData.ENEMY_TANK_1) {
                this.bodyLoader.url = "ui://Game/enemy11";
            }
            else if (this.enemyType == GameData.ENEMY_TANK_2) {
                this.bodyLoader.url = "ui://Game/enemy12";
            }
            else if (this.enemyType == GameData.ENEMY_TANK_3) {
                this.bodyLoader.url = "ui://Game/enemy13";
            }
            else if (this.enemyType == GameData.ENEMY_TANK_4) {
                this.bodyLoader.url = "ui://Game/enemy14";
            }
            this.bodyLoader.content.setPlaySettings(0, -1, 0, 0);
        }
        setRun() {
            if (this.isDeath)
                return;
            if (this.sRun)
                return;
            this.bodyLoader.url = "ui://Game/enemy_run_" + this.enemyType;
        }
        stillRun() {
            if (this.isDeath)
                return;
            if (this.direction == 1) {
                this.scene.x += this.speed;
                if (this.scene.x >= Laya.Browser.clientWidth / 2) {
                    this.scene.x = Laya.Browser.clientWidth / 2;
                }
            }
            else {
                this.scene.x -= this.speed;
                if (this.scene.x < 1)
                    this.scene.x = 1;
            }
        }
        setFire() {
            if (this.isDeath)
                return;
            if (this.enemyType == GameData.ENEMY_PIS || this.enemyType == GameData.ENEMY_GRE) {
                if (this.getRandomFire() == 1) {
                    SoundManager.instance.playSound("enemy_fire");
                    this.bodyLoader.url = "ui://Game/enemy_fire_1";
                    this.bodyLoader.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.shotComplete));
                }
                else {
                    this.bodyLoader.url = "ui://Game/enemy_fire_2";
                    this.bodyLoader.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.bombComplete));
                }
            }
            else if (this.enemyType == GameData.ENEMY_MAC) {
                SoundManager.instance.playSound("enemy_fire");
                this.bodyLoader.url = "ui://Game/enemy_fire_3";
                this.bodyLoader.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.shot2Complete));
            }
            else if (this.enemyType == GameData.ENEMY_FIRE) {
                SoundManager.instance.playSound("BombDrop");
                this.bodyLoader.url = "ui://Game/enemy_fire_4";
                this.bodyLoader.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.shot4Complete));
            }
            else if (this.enemyType == GameData.ENEMY_MOR) {
                SoundManager.instance.playSound("BombDrop");
                this.bodyLoader.url = "ui://Game/enemy_fire_5";
                this.bodyLoader.component.getChildAt(0).asLoader.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.morComplete));
                this.bodyLoader.component.getChildAt(1).asMovieClip.setPlaySettings(0, -1, 1, 0);
            }
            else if (this.enemyType == GameData.ENEMY_JUNGUAN) {
                SoundManager.instance.playSound("enemy_fire");
                this.bodyLoader.url = "ui://Game/enemy_fire_6";
                this.bodyLoader.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.shot2Complete));
            }
            else {
                console.log("没有对应的敌人攻击效果");
            }
        }
        setDeath() {
            if (this.isDeath)
                return;
            this.isDeath = true;
            Laya.timer.clear(this, this.setFire);
            var s = this.getRandomDeath();
            SoundManager.instance.playSound("die_" + s);
            if (this.enemyType == GameData.ENEMY_JUNGUAN) {
                this.enemy.url = "ui://Game/death_" + this.enemyType;
            }
            else
                this.enemy.url = "ui://Game/death_" + s;
            this.enemy.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.dispose));
            Laya.timer.once(500, this, this.dispose);
            this.createGoods();
            if (this.isBoss) {
                MooSnowSDK.clipRecord();
                GameManager.instance.victoryGame();
            }
        }
        morComplete() {
            ViewManager.instance.createBomb(BombData.BOMB_MOR, this.direction, ViewManager.instance.getBodyCenterPos(this.scene), false);
            this.setIdle();
        }
        shotComplete() {
            ViewManager.instance.createEnemyBullet(GameData.ENEMY_PIS, this.direction, ViewManager.instance.getBodyCenterPos(this.scene));
            this.setIdle();
        }
        shot2Complete() {
            ViewManager.instance.createEnemyBullet(GameData.ENEMY_MAC, this.direction, ViewManager.instance.getBodyCenterPos(this.scene));
            this.setIdle();
        }
        shot4Complete() {
            ViewManager.instance.createBomb(BombData.BOMB_FIRE, this.direction, ViewManager.instance.getBodyCenterPos(this.scene), false);
            this.setIdle();
        }
        bombComplete() {
            ViewManager.instance.createBomb(BombData.BOMB_ENEMY_GRE, this.direction, ViewManager.instance.getBodyCenterPos(this.scene), false);
            this.setIdle();
        }
        tankeComplete() {
        }
        setStay() {
            this.setIdle();
        }
        setBoomComplete() {
            this.setStay();
        }
        createGoods() {
            if (this.expRate.length > 0) {
                var r = Math.random();
                var rate = 0;
                var type = 0;
                for (let i = 0; i < this.expRate.length; i += 2) {
                    rate += this.expRate[i + 1];
                    if (rate >= r) {
                        type = this.expRate[i];
                        if (type > 0) {
                            var p = new Laya.Point();
                            p.x = this.scene.x + this.scene.width / 2;
                            p.y = this.scene.y + this.scene.height / 2;
                            ViewManager.instance.createGoods(type, p);
                        }
                        break;
                    }
                }
            }
        }
        clearWarView() {
            this.dispose();
        }
        dispose() {
            EventManager.instance.offNotice(GameEvent.CLEAR_WAR_VIEW, this, this.clearWarView);
            EventManager.instance.offNotice(GameEvent.ACTIVE_ENEMY, this, this.activeEnemy);
            EventManager.instance.offNotice(GameEvent.PAUSE_GAME, this, this.pauseGame);
            EventManager.instance.offNotice(GameEvent.PLAYER_BULLET_HIT_ENEMY, this, this.beHit);
            EventManager.instance.offNotice(GameEvent.OBSTACLE_BOOM, this, this.obstacleBoom);
            EventManager.instance.offNotice(GameEvent.PLAYER_PAN_HIT_ENEMY, this, this.beHit);
            Laya.timer.clearAll(this);
            if (this.scene) {
                this.enemyScript.isRemove = true;
                this.scene.removeSelf();
            }
            if (this.view)
                this.view.dispose();
            this.recover();
        }
        recover() {
            Laya.Pool.recover("enenmy", this);
        }
        get component() {
            return this.enemy.component;
        }
        get bodyLoader() {
            return this.enemy.component.getChildAt(0).asLoader;
        }
        getRandomFire() {
            if (Math.random() > 0.5)
                return 1;
            return 2;
        }
        getRandomDeath() {
            var r = Math.random();
            if (r > 0.75)
                return 4;
            if (r > 0.5)
                return 3;
            if (r > 0.25)
                return 2;
            return 1;
        }
        showEnemyName() {
            if (!GameData.SHOW_ENEMY_NAME)
                return;
            var txt = new Laya.Text();
            txt.width = 50;
            txt.height = 30;
            txt.fontSize = 20;
            txt.color = "#ffff00";
            txt.text = this.name;
            this.enemy.displayObject.addChild(txt);
        }
    }

    class BulletBody extends Laya.Script {
        constructor() {
            super();
            this.bulletType = 0;
            this.disposeLeft = 0;
            this.disposeRight = 0;
            this.isRemove = false;
        }
        onAwake() {
            this.selfCollider = this.owner.getComponent(Laya.BoxCollider);
            this.selfBody = this.selfCollider.rigidBody;
            this.self = this.owner;
            this.oriPosX = this.self.x;
            this.isRemove = false;
            var moveX = Math.abs(ViewManager.instance.warView.warView.x);
            this.disposeRight = Laya.stage.width + moveX - 30;
            this.disposeLeft = moveX - 20;
            if (this.selfCollider.label.indexOf("PlayerBullet") > -1) {
                this.bulletType = Number(this.selfCollider.label.substr(("PlayerBullet").length, 1));
                this.damage = GameManager.instance.getPlayerBulletDamage(this.bulletType);
                if (ViewManager.instance.rolePlayer.sRun) {
                    this.disposeRight += 220;
                    this.disposeLeft -= 150;
                }
            }
        }
        onDisable() {
        }
        onTriggerEnter(other, self, contact) {
            if (this.isRemove)
                return;
            if (self.label.indexOf("PlayerBullet") > -1) {
                if (other.label == "enemy") {
                    EventManager.instance.dispatcherEvt(GameEvent.PLAYER_BULLET_HIT_ENEMY, { o: other.owner, s: self.owner, d: this.damage });
                }
                else if (other.label == "obstacle") {
                    EventManager.instance.dispatcherEvt(GameEvent.PLAYER_BULLET_HIT_OBSTACLE, { o: other.owner, s: self.owner, d: this.damage });
                }
                return;
            }
            if (self.label == "enemyBullet") {
                if (other.label == "player") {
                    this.selfCollider.destroy();
                    EventManager.instance.dispatcherEvt(GameEvent.ENEMY_BULLET_HIT_PLAYER, { o: other.owner, s: self.owner });
                }
                return;
            }
        }
        onTriggerExit() {
        }
        onTriggerStay(other, self, contact) {
        }
        onUpdate() {
            if (this.isRemove)
                return;
            if (this.self.x > this.disposeRight || this.self.x < this.disposeLeft || this.self.y < -50 || this.self.y > Laya.stage.height + 50) {
                this.owner.removeSelf();
                this.isRemove = true;
                EventManager.instance.dispatcherEvt(GameEvent.BULLET_DISPOSE, this.owner);
            }
        }
    }

    class EnemyBullet {
        constructor() {
            this.bulletType = 1;
            this.direction = 1;
        }
        createView(type, dir, s) {
            this.bulletType = type;
            this.direction = dir;
            this.parentPos = s;
            this.scene = new ui.BulletUI();
            this.loadComplete();
        }
        loadComplete() {
            this.view = fairygui.UIPackage.createObject("Game", "zidan");
            if (this.bulletType == GameData.ENEMY_TANK_1 || this.bulletType == GameData.ENEMY_TANK_2 || this.bulletType == GameData.ENEMY_TANK_3 || this.bulletType == GameData.ENEMY_TANK_4) {
                this.view.m_zidan.url = "ui://Game/zhadan_4";
            }
            else
                this.view.m_zidan.url = "ui://Game/zidan3";
            this.scene.addChild(this.view.displayObject);
            ViewManager.instance.warView.scene.addChild(this.scene);
            this.setBulletPos();
            EventManager.instance.addNotice(GameEvent.CLEAR_WAR_VIEW, this, this.disposeAll);
            EventManager.instance.addNotice(GameEvent.BULLET_DISPOSE, this, this.dispose);
            EventManager.instance.addNotice(GameEvent.ENEMY_BULLET_HIT_PLAYER, this, this.bulletHitPlayer);
            EventManager.instance.addNotice(GameEvent.ENEMY_BOMB_HIT_PLAYER, this, this.dispose);
        }
        setBulletPos() {
            var p = ViewManager.instance.getEnemyBulletOffSetPos(this.direction, this.bulletType);
            this.scene.x = this.parentPos.x + p.x;
            this.scene.y = this.parentPos.y + p.y;
            this.scene.addComponent(BulletBody);
            this.script = this.scene.getComponent(BulletBody);
            this.body = this.scene.getComponent(Laya.RigidBody);
            this.box = this.scene.getComponent(Laya.BoxCollider);
            this.box.label = this.body.label = "enemyBullet";
            if (this.direction == 1) {
                this.view.setSkew(0, 0);
                this.body.setVelocity({ x: 10, y: 0 });
            }
            else {
                this.view.setSkew(180, 180);
                this.body.setVelocity({ x: -10, y: 0 });
            }
        }
        bulletHitPlayer(s) {
            if (s.s == this.box.owner) {
                this.body.setVelocity({ x: 0, y: 0 });
                this.view.m_zidan.url = "ui://Game/bulletDisAni";
                this.view.m_zidan.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.disposeAll));
            }
        }
        disposeAll() {
            EventManager.instance.offNotice(GameEvent.CLEAR_WAR_VIEW, this, this.disposeAll);
            EventManager.instance.offNotice(GameEvent.BULLET_DISPOSE, this, this.dispose);
            EventManager.instance.offNotice(GameEvent.ENEMY_BULLET_HIT_PLAYER, this, this.bulletHitPlayer);
            EventManager.instance.offNotice(GameEvent.ENEMY_BOMB_HIT_PLAYER, this, this.dispose);
            if (this.scene) {
                this.script.isRemove = true;
                this.scene.removeSelf();
            }
            this.view.dispose();
            Laya.Pool.recover("enemyBullet", this);
        }
        dispose(s) {
            if (s == this.box.owner) {
                this.disposeAll();
            }
        }
    }

    class PlayerBullet {
        constructor() {
            this.bulletType = 1;
            this.direction = 1;
            this.speed = 35;
        }
        createView(type, dir) {
            this.bulletType = type;
            this.direction = dir;
            this.view = fairygui.UIPackage.createObject("Game", "zidan");
            this.view.m_zidan.url = "ui://Game/playerzidan" + this.bulletType;
            if (this.bulletType == GameData.WEAPON_RIFLE) {
                if (this.direction == 4 || this.direction == -4) {
                    this.scene = new ui.BulletRifleUpUI();
                }
                else
                    this.scene = new ui.BulletRifleUI();
            }
            else {
                if (this.direction == 4 || this.direction == -4) {
                    this.scene = new ui.BulletUpUI();
                }
                else
                    this.scene = new ui.BulletUI();
            }
            this.loadComplete();
        }
        loadComplete() {
            ViewManager.instance.warView.scene.addChild(this.scene);
            this.scene.addComponent(BulletBody);
            this.script = this.scene.getComponent(BulletBody);
            this.body = this.scene.getComponent(Laya.RigidBody);
            this.box = this.scene.getComponent(Laya.BoxCollider);
            this.box.label = this.body.label = "PlayerBullet" + this.bulletType;
            this.setBulletPos();
            EventManager.instance.addNotice(GameEvent.CLEAR_WAR_VIEW, this, this.disposeAll);
            EventManager.instance.addNotice(GameEvent.BULLET_DISPOSE, this, this.disposeBullet);
            EventManager.instance.addNotice(GameEvent.PLAYER_BULLET_HIT_ENEMY, this, this.hitEnemy);
            EventManager.instance.addNotice(GameEvent.PLAYER_BULLET_HIT_OBSTACLE, this, this.hitEnemy);
        }
        hitEnemy(s) {
            if (this.bulletType == GameData.WEAPON_RIFLE)
                return;
            if (s.s == this.box.owner) {
                this.body.setVelocity({ x: 0, y: 0 });
                this.view.m_zidan.url = "ui://Game/bulletDisAni";
                this.view.m_zidan.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.disposeAll));
            }
        }
        disposeAll() {
            EventManager.instance.offNotice(GameEvent.CLEAR_WAR_VIEW, this, this.disposeAll);
            EventManager.instance.offNotice(GameEvent.BULLET_DISPOSE, this, this.disposeBullet);
            EventManager.instance.offNotice(GameEvent.PLAYER_BULLET_HIT_ENEMY, this, this.hitEnemy);
            EventManager.instance.offNotice(GameEvent.PLAYER_BULLET_HIT_OBSTACLE, this, this.hitEnemy);
            if (this.scene) {
                this.script.isRemove = true;
                this.scene.removeSelf();
            }
            this.view.dispose();
            Laya.Pool.recover("PlayerBullet", this);
        }
        disposeBullet(s) {
            if (s == this.body.owner) {
                this.disposeAll();
            }
        }
        setBulletPos() {
            var p = ViewManager.instance.getPlayerBulletOffSetPos(this.direction, this.bulletType);
            var c = ViewManager.instance.rolePlayer.roleBody.getWorldCenter();
            if (this.bulletType == GameData.WEAPON_RIFLE) {
                this.view.x = p.x;
                this.view.y = p.y;
                this.scene.addChild(this.view.displayObject);
                var b = this.scene.getComponent(BulletBody);
                b.onAwake();
                if (this.direction > 0) {
                    this.scene.x = c.x + 45;
                    if (this.direction == 2) {
                        this.scene.y = c.y;
                        this.view.setSkew(15, 15);
                    }
                    else if (this.direction == 3) {
                        this.scene.y = c.y - this.scene.height;
                        this.view.setSkew(-15, -15);
                    }
                    else if (this.direction == 4) {
                        this.scene.y = c.y - this.scene.height;
                        this.scene.x = c.x - this.scene.width / 2;
                        this.view.setSkew(-90, -90);
                    }
                    else {
                        this.scene.y = c.y - this.scene.height / 2;
                        this.view.setSkew(0, 0);
                    }
                }
                else {
                    this.scene.x = c.x - this.scene.width - 45;
                    if (this.direction == -2) {
                        this.scene.y = c.y;
                        this.view.setSkew(165, 165);
                    }
                    else if (this.direction == -3) {
                        this.scene.y = c.y - this.scene.height;
                        this.view.setSkew(195, 195);
                    }
                    else if (this.direction == -4) {
                        this.scene.y = c.y - this.scene.height;
                        this.scene.x = c.x - this.scene.width / 2;
                        this.view.setSkew(270, 270);
                    }
                    else {
                        this.scene.y = c.y - this.scene.height / 2;
                        this.view.setSkew(180, 180);
                    }
                }
                this.view.m_zidan.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.disposeAll));
            }
            else {
                if (this.direction == 1 || this.direction == -1 || this.direction == 5 || this.direction == -5) {
                    var y = ViewManager.instance.bulletRandomY();
                    this.scene.x = c.x + p.x;
                    this.scene.y = c.y - y + p.y;
                }
                else {
                    this.scene.x = c.x + p.x;
                    this.scene.y = c.y + p.y;
                }
                this.scene.addChild(this.view.displayObject);
                var b = this.scene.getComponent(BulletBody);
                b.onAwake();
                if (this.direction > 0) {
                    if (this.direction == 2) {
                        this.view.setSkew(25, 25);
                        this.body.setVelocity({ x: 11, y: 8 });
                    }
                    else if (this.direction == 3) {
                        this.view.setSkew(-35, -35);
                        this.body.setVelocity({ x: 11, y: -9 });
                    }
                    else if (this.direction == 4) {
                        this.view.setSkew(-90, -90);
                        this.body.setVelocity({ x: 0, y: -10 });
                    }
                    else {
                        this.view.setSkew(0, 0);
                        this.body.setVelocity({ x: 12, y: 0 });
                    }
                }
                else {
                    if (this.direction == -2) {
                        this.view.setSkew(155, 155);
                        this.body.setVelocity({ x: -11, y: 8 });
                    }
                    else if (this.direction == -3) {
                        this.view.setSkew(215, 215);
                        this.body.setVelocity({ x: -11, y: -9 });
                    }
                    else if (this.direction == -4) {
                        this.view.setSkew(270, 270);
                        this.body.setVelocity({ x: 0, y: -10 });
                    }
                    else {
                        this.view.setSkew(180, 180);
                        this.body.setVelocity({ x: -12, y: 0 });
                    }
                }
            }
        }
    }

    class BombBody extends Laya.Script {
        constructor() {
            super();
            this.isRemove = false;
        }
        onEnable() {
            this.selfCollider = this.owner.getComponent(Laya.BoxCollider);
            this.selfBody = this.selfCollider.rigidBody;
            this.self = this.owner;
            this.oriPosX = this.self.x;
            this.isRemove = false;
        }
        onDisable() {
        }
        onTriggerEnter(other, self, contact) {
            if (this.isRemove)
                return;
            if (self.label == "PlayerBomb") {
                if (other.label == "enemy") {
                    EventManager.instance.dispatcherEvt(GameEvent.PLAYER_BOMB_HIT_ENEMY, { o: other.owner, s: self.owner, d: GameData.BOMB_DAMAGE });
                    this.owner.removeSelf();
                    this.isRemove = true;
                    ViewManager.instance.showShake(ViewManager.instance.warView.warView.displayObject, 30, 300, 6);
                }
                else if (other.label == "obstacle") {
                    EventManager.instance.dispatcherEvt(GameEvent.PLAYER_BOMB_HIT_OBSTACLE, { o: other.owner, s: self.owner, d: GameData.BOMB_DAMAGE });
                    this.owner.removeSelf();
                    this.isRemove = true;
                    ViewManager.instance.showShake(ViewManager.instance.warView.warView.displayObject, 30, 300, 6);
                }
            }
            else if (self.label == "enemyBomb" && other.label == "player") {
                EventManager.instance.dispatcherEvt(GameEvent.ENEMY_BOMB_HIT_PLAYER, { o: other.owner, s: self.owner });
                this.owner.removeSelf();
                this.isRemove = true;
                return;
            }
            if (other.label == "ground") {
                EventManager.instance.dispatcherEvt(GameEvent.BOMB_DISPOSE, { o: other.owner, s: self.owner });
                this.owner.removeSelf();
                this.isRemove = true;
                if (self.label == "PlayerBomb")
                    ViewManager.instance.showShake(ViewManager.instance.warView.warView.displayObject, 30, 300, 6);
                return;
            }
        }
        onTriggerExit() {
        }
        onTriggerStay(other, self, contact) {
        }
        onUpdate() {
        }
    }

    class BoomBody extends Laya.Script {
        constructor() {
            super();
            this.isRemove = false;
        }
        onEnable() {
            this.selfCollider = this.owner.getComponent(Laya.CircleCollider);
            this.selfBody = this.selfCollider.rigidBody;
            this.self = this.owner;
            this.oriPosX = this.self.x;
        }
        onDisable() {
        }
        onTriggerEnter(other, self, contact) {
        }
        onTriggerExit() {
        }
        onTriggerStay(other, self, contact) {
        }
        onUpdate() {
        }
    }

    class BoomView {
        constructor() {
            this.boomType = 1;
            this.direction = 1;
            this.speed = 35;
        }
        createView(type, s, b) {
            this.boomType = type;
            this.isPlayer = b;
            this.pos = s;
            this.scene = new ui.BoomBodyUI();
            this.loadComplete();
        }
        loadComplete() {
            this.view = fairygui.UIPackage.createObject("Game", "BoomView");
            this.scene.addComponent(BoomBody);
            this.body = this.scene.getComponent(Laya.RigidBody);
            this.box = this.scene.getComponent(Laya.CircleCollider);
            if (this.isPlayer) {
                this.box.label = this.body.label = "PlayerBoom";
            }
            else {
                this.box.label = this.body.label = "enemyBoom";
            }
            this.scene.addChild(this.view.displayObject);
            ViewManager.instance.warView.scene.addChild(this.scene);
            this.view.m_boom.url = "ui://Game/boom_" + this.boomType;
            this.view.m_boom.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.showComplete));
            this.setBoomViewPos();
            EventManager.instance.addNotice(GameEvent.CLEAR_WAR_VIEW, this, this.dispose);
        }
        setBoomViewPos() {
            this.scene.x = this.pos.x - this.scene.width / 2;
            this.scene.y = this.pos.y - this.scene.height / 2;
        }
        showComplete() {
            this.calDamage();
            this.dispose();
        }
        calDamage() {
        }
        dispose() {
            EventManager.instance.offNotice(GameEvent.CLEAR_WAR_VIEW, this, this.dispose);
            Laya.Pool.recover("boomView", this);
            if (this.view)
                this.view.dispose();
            this.scene.removeSelf();
        }
    }

    class BombView {
        constructor() {
            this.bombType = 1;
            this.direction = 1;
            this.isPlayer = false;
        }
        createView(type, dir, s, p, offPos) {
            this.bombType = type;
            this.direction = dir;
            this.parentPos = s;
            this.isPlayer = p;
            this.offPos = offPos;
            this.scene = new ui.BombBodyUI();
            this.loadComplete();
        }
        loadComplete() {
            this.view = fairygui.UIPackage.createObject("Game", "Bomb");
            this.view.m_boom3.visible = this.view.m_boom.visible = this.view.m_boom2.visible = false;
            if (this.bombType == BombData.BOMB_MOR) {
                this.view.m_boom.visible = true;
                this.trans = this.view.getTransitionAt(0);
            }
            else if (this.bombType == BombData.BOMB_ENEMY_GRE || this.bombType == BombData.BOMB_MY_GRE) {
                this.view.m_boom2.visible = true;
                this.trans = this.view.getTransitionAt(1);
            }
            else if (this.bombType == BombData.BOMB_FIRE) {
                this.view.m_boom3.visible = true;
                this.trans = this.view.getTransitionAt(2);
            }
            this.scene.addComponent(BombBody);
            this.body = this.scene.getComponent(Laya.RigidBody);
            this.box = this.scene.getComponent(Laya.BoxCollider);
            if (this.isPlayer) {
                this.box.label = this.body.label = "PlayerBomb";
            }
            else {
                this.box.label = this.body.label = "enemyBomb";
            }
            this.view.m_boom3.url = this.view.m_boom.url = this.view.m_boom2.url = "ui://Game/zhadan_" + this.bombType;
            if (this.bombType == BombData.BOMB_ENEMY_GRE)
                this.view.m_boom2.content.setPlaySettings(0, -1, 0, 0);
            if (this.bombType == BombData.BOMB_MY_GRE || this.bombType == BombData.BOMB_ENEMY_GRE)
                this.trans.play(null, 1);
            this.scene.addChild(this.view.displayObject);
            ViewManager.instance.warView.scene.addChild(this.scene);
            this.setBombPos();
            EventManager.instance.addNotice(GameEvent.CLEAR_WAR_VIEW, this, this.disposeAll);
            EventManager.instance.addNotice(GameEvent.PLAYER_BOMB_HIT_ENEMY, this, this.dispose);
            EventManager.instance.addNotice(GameEvent.ENEMY_BOMB_HIT_PLAYER, this, this.dispose);
            EventManager.instance.addNotice(GameEvent.BOMB_DISPOSE, this, this.dispose);
            EventManager.instance.addNotice(GameEvent.PLAYER_BOMB_HIT_OBSTACLE, this, this.dispose);
        }
        setBombPos() {
            if (this.direction == 1) {
                if (this.bombType == BombData.BOMB_MOR) {
                    this.body.setVelocity({ x: 7, y: -6 });
                    this.trans.play(null, 1, 0, 0, 1.25);
                }
                else if (this.bombType == BombData.BOMB_FIRE) {
                    this.body.setVelocity({ x: 12, y: 0 });
                    this.trans.play(null, 1, 0, 0, 1.25);
                }
                else if (this.bombType == BombData.BOMB_MY_GRE) {
                    this.body.setVelocity({ x: 10, y: -7 });
                }
                else if (this.bombType == BombData.BOMB_ENEMY_GRE) {
                    this.body.setVelocity({ x: 7, y: -6 });
                }
            }
            else {
                if (this.bombType == BombData.BOMB_MOR) {
                    this.body.setVelocity({ x: -7, y: -6 });
                    this.trans.play(null, 1, 0, 1.5, 2.75);
                }
                else if (this.bombType == BombData.BOMB_FIRE) {
                    this.body.setVelocity({ x: -12, y: 0 });
                    this.trans.play(null, 1, 0, 1.5, 2.75);
                }
                else if (this.bombType == BombData.BOMB_MY_GRE) {
                    this.body.setVelocity({ x: -10, y: -7 });
                }
                else if (this.bombType == BombData.BOMB_ENEMY_GRE) {
                    this.body.setVelocity({ x: -7, y: -6 });
                }
            }
            this.scene.x = this.parentPos.x + this.offPos.x;
            this.scene.y = this.parentPos.y + this.offPos.y;
        }
        showBoomView() {
            SoundManager.instance.playSound("boom");
            var bomb = Laya.Pool.getItemByClass("boomView", BoomView);
            var p = ViewManager.instance.getBodyCenterPos(this.scene);
            bomb.createView(ViewManager.instance.getBoomAniTypeByBomb(this.bombType), p, this.isPlayer);
        }
        dispose(s) {
            if (s.s == this.box.owner) {
                this.showBoomView();
                this.disposeAll();
            }
        }
        disposeAll() {
            EventManager.instance.offNotice(GameEvent.CLEAR_WAR_VIEW, this, this.disposeAll);
            EventManager.instance.offNotice(GameEvent.PLAYER_BOMB_HIT_ENEMY, this, this.dispose);
            EventManager.instance.offNotice(GameEvent.ENEMY_BOMB_HIT_PLAYER, this, this.dispose);
            EventManager.instance.offNotice(GameEvent.BOMB_DISPOSE, this, this.dispose);
            Laya.Pool.recover("bombView", this);
            if (this.view)
                this.view.dispose();
            this.scene.removeSelf();
        }
    }

    class ObstacleView {
        constructor() {
            this.type = 1;
            this.direction = 0;
            this.isDeath = false;
            this.blood = 1;
            this.name = "";
        }
        createView(d) {
            this.type = d.type;
            this.blood = d.blood;
            this.pos = d.pos;
            this.name = d.name;
            if (this.type == ObstacleType.ObstacleType_SHABAO) {
                this.scene = new ui.ObstacleView_1UI();
            }
            else if (this.type == ObstacleType.ObstacleType_YOUGUAN) {
                this.scene = new ui.ObstacleView_2UI();
            }
            else if (this.type == ObstacleType.ObstacleType_MICHE) {
                this.scene = new ui.ObstacleView_3UI();
            }
            else if (this.type == ObstacleType.ObstacleType_DACHE) {
                this.scene = new ui.ObstacleView_4UI();
            }
            else if (this.type == ObstacleType.ObstacleType_CHE) {
                this.scene = new ui.ObstacleView_5UI();
            }
            else if (this.type == ObstacleType.ObstacleType_6) {
                this.scene = new ui.ObstacleView_6UI();
            }
            else if (this.type == ObstacleType.ObstacleType_7) {
                this.scene = new ui.ObstacleView_7UI();
            }
            else if (this.type == ObstacleType.ObstacleType_8) {
                this.scene = new ui.ObstacleView_8UI();
            }
            else if (this.type == ObstacleType.ObstacleType_9) {
                this.scene = new ui.ObstacleView_9UI();
            }
            else if (this.type == ObstacleType.ObstacleType_10) {
                this.scene = new ui.ObstacleView_10UI();
            }
            else if (this.type == ObstacleType.ObstacleType_11) {
                this.scene = new ui.ObstacleView_11UI();
            }
            else
                return;
            this.loadComplete();
        }
        ;
        loadComplete() {
            this.view = fairygui.UIPackage.createObject("Game", "obstacleView");
            this.view.setPivot(0.5, 0.5);
            this.load = this.view.getChildAt(0);
            this.initView();
        }
        ;
        initView() {
            this.load.url = "ui://Game/obstacle_" + this.type;
            this.scene.addChild(this.view.displayObject);
            this.box = this.scene.getComponent(Laya.PolygonCollider);
            this.isDeath = false;
            this.scene.x = this.pos.x;
            this.scene.y = this.pos.y;
            ViewManager.instance.warView.scene.addChild(this.scene);
            EventManager.instance.addNotice(GameEvent.CLEAR_WAR_VIEW, this, this.dispose);
            EventManager.instance.addNotice(GameEvent.PLAYER_BOMB_HIT_OBSTACLE, this, this.beHit);
            EventManager.instance.addNotice(GameEvent.PLAYER_BULLET_HIT_OBSTACLE, this, this.beHit);
            this.showEnemyName();
        }
        beHit(s) {
            if (this.isDeath)
                return;
            if (s.o == this.box.owner) {
                this.blood -= s.d;
                Laya.timer.clear(this, this.setColor);
                if (this.blood <= 0) {
                    this.setDeath();
                }
                else {
                    this.load.color = "#ff0000";
                    Laya.timer.once(200, this, this.setColor);
                }
            }
        }
        setColor() {
            this.load.color = "#ffffff";
        }
        setDeath() {
            this.isDeath = true;
            Laya.timer.clearAll(this);
            this.load.url = "";
            var boomAniType = ViewManager.instance.getBoomAniTypeByObsType(this.type);
            var boomAni = fairygui.UIPackage.createObject("Game", "boom_" + boomAniType).asMovieClip;
            var p = this.getBoomAniPos(this.type);
            boomAni.x = p.x;
            boomAni.y = p.y;
            this.load.displayObject.addChild(boomAni.displayObject);
            boomAni.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.dispose));
        }
        dispose() {
            EventManager.instance.offNotice(GameEvent.CLEAR_WAR_VIEW, this, this.dispose);
            EventManager.instance.offNotice(GameEvent.PLAYER_BOMB_HIT_OBSTACLE, this, this.beHit);
            EventManager.instance.offNotice(GameEvent.PLAYER_BULLET_HIT_OBSTACLE, this, this.beHit);
            Laya.timer.clearAll(this);
            if (this.scene)
                this.scene.removeSelf();
            if (this.view)
                this.view.dispose();
            Laya.Pool.recover("obstacle", this);
            EventManager.instance.dispatcherEvt(GameEvent.OBSTACLE_BOOM, this.box.owner);
        }
        getBoomAniPos(type) {
            var p = new Laya.Point();
            if (type == ObstacleType.ObstacleType_SHABAO) {
                p.x = 10;
                p.y = -10;
            }
            else if (type == ObstacleType.ObstacleType_YOUGUAN) {
                p.x = -10;
                p.y = -10;
            }
            else if (type == ObstacleType.ObstacleType_MICHE) {
                p.x = -20;
                p.y = -180;
            }
            else if (type == ObstacleType.ObstacleType_DACHE) {
                p.x = 250;
                p.y = -40;
            }
            else if (type == ObstacleType.ObstacleType_CHE) {
                p.x = 50;
                p.y = -100;
            }
            else if (type == ObstacleType.ObstacleType_6) {
                p.x = -50;
                p.y = -100;
            }
            else if (type == ObstacleType.ObstacleType_7) {
                p.x = -40;
                p.y = -200;
            }
            else if (type == ObstacleType.ObstacleType_8) {
                p.x = -60;
                p.y = -220;
            }
            else if (type == ObstacleType.ObstacleType_9) {
                p.x = -10;
                p.y = -10;
            }
            else if (type == ObstacleType.ObstacleType_10) {
                p.x = 20;
                p.y = -120;
            }
            else if (type == ObstacleType.ObstacleType_11) {
                p.x = -30;
                p.y = -150;
            }
            return p;
        }
        showEnemyName() {
            if (!GameData.SHOW_ENEMY_NAME)
                return;
            var txt = new Laya.Text();
            txt.width = 50;
            txt.height = 30;
            txt.fontSize = 20;
            txt.color = "#ffff00";
            txt.text = this.name;
            this.load.displayObject.addChild(txt);
        }
    }

    class Chopper extends Enemy {
        constructor() {
            super();
            this.stillFire = 0;
            this.randomY = false;
        }
        createView(d) {
            super.initData(d);
            this.scene = new ui.ChopperBodyUI();
            this.loadComplete();
        }
        ;
        initView() {
            super.initView();
            var b = this.scene.getComponent(EnemyBody);
            b.activeDis = 800;
        }
        activeEnemy(s) {
            if (this.isActive)
                return;
            if (this.isDeath)
                return;
            if (this.box.owner == s) {
                this.isActive = true;
                this.setRun();
                this.setStillFire();
                Laya.timer.loop(4000, this, this.setStillFire);
                Laya.timer.loop(5000, this, this.setRun);
            }
        }
        setRun() {
            var roleX = ViewManager.instance.rolePlayer.roleSprite.x;
            if (this.scene.x > roleX) {
                Laya.Tween.to(this.scene, { x: roleX - this.getDis(), y: this.scene.y + this.getRandomY() }, 2000);
            }
            else {
                Laya.Tween.to(this.scene, { x: roleX + this.getDis(), y: this.scene.y + this.getRandomY() }, 2000);
            }
        }
        setStillFire() {
            this.setFire();
            Laya.timer.loop(300, this, this.setFire);
        }
        setFire() {
            this.stillFire++;
            var p = new Laya.Point(this.view.width / 2, this.view.height);
            ViewManager.instance.createChopperBomb(BombData.BOMB_CHOPPER, ViewManager.instance.getBodyCenterPos(this.scene), p);
            SoundManager.instance.playSound("bombDrop");
            if (this.stillFire >= 5) {
                this.stillFire = 0;
                Laya.timer.clear(this, this.setFire);
            }
        }
        setDeath() {
            if (this.isDeath)
                return;
            this.isDeath = true;
            Laya.timer.clearAll(this);
            Laya.Tween.clearAll(this.scene);
            this.enemy.url = "ui://Game/boom_5";
            this.enemy.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.dispose));
            if (this.isBoss) {
                MooSnowSDK.clipRecord();
                GameManager.instance.victoryGame();
            }
            SoundManager.instance.playSound("boom");
        }
        clearWarView() {
            this.dispose();
            Laya.timer.clearAll(this);
        }
        recover() {
            Laya.Pool.recover("chopper", this);
        }
        getDis() {
            return (Math.random() * 200 + 100);
        }
        getRandomY() {
            this.randomY = !this.randomY;
            var r = Math.random();
            if (this.randomY) {
                return (r * 20 + 30);
            }
            else {
                return (r * -20 - 30);
            }
        }
    }

    class Tank extends Enemy {
        constructor() {
            super();
            this.randomX = false;
        }
        createView(d) {
            super.initData(d);
            if (this.enemyType == 11) {
                this.scene = new ui.TankBody11UI();
            }
            else if (this.enemyType == 12) {
                this.scene = new ui.TankBody12UI();
            }
            else if (this.enemyType == 13) {
                this.scene = new ui.TankBody13UI();
            }
            else if (this.enemyType == 14) {
                this.scene = new ui.TankBody14UI();
            }
            this.loadComplete();
        }
        ;
        activeEnemy(s) {
            if (this.isActive)
                return;
            if (this.isDeath)
                return;
            if (this.box.owner == s) {
                this.isActive = true;
                this.doActive();
                Laya.timer.loop(2000, this, this.doActive);
            }
        }
        doActive() {
            this.setFire();
            this.setRun();
        }
        initView() {
            super.initView();
            var b = this.scene.getComponent(EnemyBody);
            b.activeDis = 800;
        }
        setRun() {
            var roleDir = ViewManager.instance.rolePlayer.direction;
            var roleX = ViewManager.instance.rolePlayer.roleSprite.x;
            if (roleX > this.scene.x) {
                this.direction = 1;
                this.setDirection();
            }
            else {
                this.direction = -1;
                this.setDirection();
            }
            Laya.Tween.to(this.scene, { x: this.scene.x + this.getRandomX() }, 2000);
        }
        beHit(s) {
            if (this.isDeath)
                return;
            if (s.o == this.box.owner) {
                this.blood -= s.d;
                Laya.timer.clear(this, this.setColor);
                if (this.blood <= 0) {
                    this.setDeath();
                }
                else {
                    this.bodyLoader.component.getChildAt(0).asLoader.content.color = "#ff0000";
                    Laya.timer.once(200, this, this.setColor);
                    ViewManager.instance.createDamageView(s.d, this.scene);
                }
            }
        }
        setColor() {
            this.bodyLoader.component.getChildAt(0).asLoader.content.color = "#ffffff";
        }
        setFire() {
            this.bodyLoader.url = "ui://Game/enemy_fire_" + this.enemyType;
            if (this.enemyType == GameData.ENEMY_TANK_1 || this.enemyType == GameData.ENEMY_TANK_2) {
                this.bodyLoader.component.getChildAt(0).asLoader.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.tankShotComplete));
            }
            SoundManager.instance.playSound("tank_fire");
            ViewManager.instance.createEnemyBullet(this.enemyType, this.direction, ViewManager.instance.getBodyCenterPos(this.scene));
        }
        tankShotComplete() {
            this.setIdle();
        }
        setDeath() {
            if (this.isDeath)
                return;
            this.isDeath = true;
            Laya.timer.clearAll(this);
            Laya.Tween.clearAll(this.scene);
            this.bodyLoader.url = "";
            var ani = fairygui.UIPackage.createObject("Game", "boom_5").asMovieClip;
            ani.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.dispose));
            ani.x = 20;
            ani.y = -100;
            this.bodyLoader.displayObject.addChild(ani.displayObject);
            if (this.isBoss) {
                MooSnowSDK.clipRecord();
                GameManager.instance.victoryGame();
            }
            SoundManager.instance.playSound("boom");
        }
        clearWarView() {
            this.dispose();
            Laya.timer.clearAll(this);
        }
        recover() {
            Laya.Pool.recover("tank", this);
        }
        getRandomX() {
            this.randomX = !this.randomX;
            var r = Math.random();
            if (this.randomX) {
                return (r * 20 + 50);
            }
            else {
                return (r * -20 - 50);
            }
        }
    }

    class ChopperBomb extends BombView {
        constructor() { super(); }
        createView(type, dir, s, p, offPos) {
            this.bombType = type;
            this.parentPos = s;
            this.offPos = offPos;
            this.scene = new ui.ChopperBombUI();
            this.loadComplete();
        }
        setBombPos() {
            this.body.setVelocity({ x: 0, y: 5 });
            this.scene.x = this.parentPos.x + 165;
            this.scene.y = this.parentPos.y + 85;
        }
        dispose(s) {
            if (s.s == this.box.owner) {
                this.showBoomView();
                this.disposeAll();
            }
        }
        disposeAll() {
            EventManager.instance.offNotice(GameEvent.CLEAR_WAR_VIEW, this, this.disposeAll);
            EventManager.instance.offNotice(GameEvent.PLAYER_BOMB_HIT_ENEMY, this, this.dispose);
            EventManager.instance.offNotice(GameEvent.ENEMY_BOMB_HIT_PLAYER, this, this.dispose);
            EventManager.instance.offNotice(GameEvent.BOMB_DISPOSE, this, this.dispose);
            if (this.scene) {
                this.scene.removeSelf();
            }
            if (this.view)
                this.view.dispose();
            Laya.Pool.recover("ChopperBomb", this);
        }
    }

    class GoodsBody extends Laya.Script {
        constructor() {
            super();
            this.isRemove = false;
        }
        onEnable() {
            this.selfCollider = this.owner.getComponent(Laya.BoxCollider);
            this.selfBody = this.selfCollider.rigidBody;
            this.self = this.owner;
            this.oriPosX = this.self.x;
            this.isRemove = false;
        }
        onDisable() {
        }
        onTriggerEnter(other, self, contact) {
            if (this.isRemove)
                return;
            if ((other.label == "ground" || other.label == "board")) {
                this.selfBody.type = "static";
            }
        }
        onTriggerExit() {
        }
        onTriggerStay(other, self, contact) {
        }
        onUpdate() {
        }
        setSpeedZero() {
        }
    }

    class GoodsView {
        constructor() {
            this.type = 1;
        }
        createView(type, s) {
            this.type = type;
            this.pos = s;
            this.scene = new ui.GoodsBodyUI();
            this.loadComplete();
        }
        loadComplete() {
            this.body = this.scene.getComponent(Laya.RigidBody);
            this.box = this.scene.getComponent(Laya.BoxCollider);
            this.scene.addComponent(GoodsBody);
            this.script = this.scene.getComponent(GoodsBody);
            this.view = fairygui.UIPackage.createObject("Game", "goodsView");
            this.mc = fairygui.UIPackage.createObject("Game", "createGoodsAni").asMovieClip;
            this.mc.x = -this.mc.width / 2 + 20;
            this.mc.y = -this.mc.height / 2;
            this.mc.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.createAniComplete));
            this.view.addChild(this.mc);
            this.scene.addChild(this.view.displayObject);
            ViewManager.instance.warView.scene.addChild(this.scene);
            this.setBombPos();
            EventManager.instance.addNotice(GameEvent.CLEAR_WAR_VIEW, this, this.clearView);
            EventManager.instance.addNotice(GameEvent.PLAYER_GET_GOODS, this, this.dispose);
        }
        createAniComplete() {
            this.view.removeChild(this.mc);
            this.view.m_load.url = "ui://Game/goods_" + this.type;
            if (this.type != GoodsType.GoodsType_COIN && this.type != GoodsType.GoodsType_GRE) {
                this.view.m_load.content.setPlaySettings(0, -1, 0, 0);
            }
        }
        dispose(s) {
            if (s == this.box.owner) {
                SoundManager.instance.playSound("get_goods");
                this.clearView();
                this.dispatcherEvt();
            }
        }
        clearView() {
            EventManager.instance.offNotice(GameEvent.CLEAR_WAR_VIEW, this, this.clearView);
            EventManager.instance.offNotice(GameEvent.PLAYER_GET_GOODS, this, this.dispose);
            this.view.removeChildren();
            if (this.view)
                this.view.dispose();
            if (this.scene) {
                this.script.isRemove = true;
                this.scene.removeSelf();
            }
            Laya.Pool.recover("goods", this);
        }
        dispatcherEvt() {
            EventManager.instance.dispatcherEvt(GameEvent.CHANGE_PLAYER_GOODS, this.type);
        }
        setBombPos() {
            this.scene.x = this.pos.x + 20;
            this.scene.y = this.pos.y;
        }
    }

    class PlayerData {
    }
    PlayerData.WEAPON_TYPE = 1;
    PlayerData.WEAPON_PIS = 1;
    PlayerData.WEAPON_MAC = 2;
    PlayerData.WEAPON_RIFLE = 3;
    PlayerData.WEAPON_GRE = 4;
    class PlayerInfo {
        constructor() {
            this.blood = 0;
            this.bulletNum = 0;
            this.bombNum = 0;
            this.weaponType = 0;
            this.isDeath = false;
            this.addMacNum = 0;
            this.addBombNum = 0;
            this.addRifNum = 0;
            this.curChapter = 0;
            this.curLevel = 0;
            this.totalCoin = 0;
            this.curlvCoin = 0;
            this.direction = 0;
            this.isInvincible = false;
        }
    }
    class EnemyInfo {
        constructor() {
            this.expRate = [];
            this.isBoss = false;
            this.name = "";
        }
    }
    class ObstacleInfo {
        constructor() {
            this.name = "";
        }
    }

    class PlayerInfoView {
        constructor() { this.createView(); }
        createView() {
            this.view = fairygui.UIPackage.createObject("Game", "PlayerInfoView");
            EventManager.instance.addNotice(GameEvent.CHANGE_PLAYER_GOODS, this, this.changePlayerGoods);
            EventManager.instance.addNotice(GameEvent.USE_PLAYER_BULLET, this, this.usePlyerBullet);
            EventManager.instance.addNotice(GameEvent.USE_PLAYER_BOMB, this, this.decBombNum);
            EventManager.instance.addNotice(GameEvent.DEC_PLAYER_BLOOD, this, this.updatePlayerBlood);
            this.view.m_item_1.visible = this.view.m_item_2.visible = this.view.m_item_3.visible = false;
            if (GameManager.instance.platform == moosnow.APP_PLATFORM.BYTEDANCE) {
                this.view.m_item_1.visible = this.view.m_item_2.visible = this.view.m_item_3.visible = true;
                this.initBuyItem();
            }
            this.updateAllView();
            this.view.m_pause.onClick(this, this.pauseGame);
            this.layout();
        }
        layout() {
            if (Laya.Browser.onWeiXin) {
                let wxInfo = wx.getSystemInfoSync();
                var h = (wxInfo.windowHeight / 750) * 1334;
                this.view.x = 80 * (Laya.stage.width / 1334);
                if ((wxInfo.windowWidth / wxInfo.windowHeight) > 2) {
                    this.view.m_pause.x = 1050;
                }
                else
                    this.view.m_pause.x = 950;
            }
            else {
                var h = (Laya.Browser.height / 750) * 1334;
                this.view.x = 100 * (Laya.Browser.width / h);
            }
            this.view.y = 0;
        }
        updateAllView() {
            this.updateBulletNum();
            this.updatePlayerBlood();
            this.updateGreNum();
            this.updateCoin();
            this.updateLevel();
        }
        updateLevel() {
            this.view.m_level.text = " 第" + GameManager.instance.curLevel + "关 ";
        }
        pauseGame() {
            SoundManager.instance.playSound("btn_press");
            ViewManager.instance.showSuspendView();
            GameManager.instance.suspendGame();
        }
        changePlayerGoods(t) {
            if (t == GoodsType.GoodsType_MED) {
                GameManager.instance.roleInfo.blood += 2;
                if (GameManager.instance.roleInfo.blood > GameManager.instance.oriBlood)
                    GameManager.instance.roleInfo.blood = GameManager.instance.oriBlood;
                this.updatePlayerBlood();
                ViewManager.instance.createAddGold(t, 1, true);
            }
            else if (t == GoodsType.GoodsType_MAC) {
                if (GameManager.instance.roleInfo.weaponType == PlayerData.WEAPON_MAC) {
                    GameManager.instance.roleInfo.bulletNum += GameManager.instance.roleInfo.addMacNum;
                }
                else {
                    GameManager.instance.roleInfo.bulletNum = GameManager.instance.roleInfo.addMacNum;
                    GameManager.instance.roleInfo.weaponType = PlayerData.WEAPON_MAC;
                }
                EventManager.instance.dispatcherEvt(GameEvent.CHANGE_PLAYER_WEAPON, GameManager.instance.roleInfo.weaponType);
                this.updateBulletNum();
                ViewManager.instance.createAddGold(t, GameManager.instance.roleInfo.addMacNum, true);
            }
            else if (t == GoodsType.GoodsType_RIF) {
                if (GameManager.instance.roleInfo.weaponType == PlayerData.WEAPON_RIFLE) {
                    GameManager.instance.roleInfo.bulletNum += GameManager.instance.roleInfo.addRifNum;
                }
                else {
                    GameManager.instance.roleInfo.bulletNum = GameManager.instance.roleInfo.addRifNum;
                    GameManager.instance.roleInfo.weaponType = PlayerData.WEAPON_RIFLE;
                }
                this.updateBulletNum();
                EventManager.instance.dispatcherEvt(GameEvent.CHANGE_PLAYER_WEAPON, GameManager.instance.roleInfo.weaponType);
                ViewManager.instance.createAddGold(t, GameManager.instance.roleInfo.addRifNum, true);
            }
            else if (t == GoodsType.GoodsType_GRE) {
                GameManager.instance.roleInfo.bombNum += GameManager.instance.roleInfo.addBombNum;
                this.updateGreNum();
                ViewManager.instance.createAddGold(t, GameManager.instance.roleInfo.addBombNum, true);
            }
            else if (t == GoodsType.GoodsType_COIN) {
                var coin = this.getRandomCoin();
                GameManager.instance.roleInfo.curlvCoin += coin;
                GameManager.instance.roleInfo.totalCoin += coin;
                this.updateCoin();
                ViewManager.instance.createAddGold(t, coin, true);
            }
            else if (t == GoodsType.GoodsType_BOX) {
                if (GameManager.instance.platform == moosnow.APP_PLATFORM.VIVO || GameManager.instance.platform == moosnow.APP_PLATFORM.OPPO) {
                    this.showBoxGoods();
                    return;
                }
                if (MooSnowSDK.misTouchNum == 0) {
                    this.showBoxGoods();
                }
                else if (MooSnowSDK.misTouchNum > 0) {
                    GameManager.instance.misTouchNum++;
                    if (GameManager.instance.misTouchNum >= MooSnowSDK.misTouchNum) {
                        GameManager.instance.misTouchNum = 0;
                        ViewManager.instance.showClickChestView();
                    }
                    else {
                        this.showBoxGoods();
                    }
                }
            }
            else if (t == GoodsType.GoodsType_OPEN_BOX) {
                this.showBoxGoods();
            }
        }
        showBoxGoods() {
            this.changePlayerGoods(GoodsType.GoodsType_MED);
            Laya.timer.once(500, this, this.changePlayerGoods, [GoodsType.GoodsType_RIF]);
            Laya.timer.once(1000, this, this.showGetGoods, [GoodsType.GoodsType_GRE]);
        }
        showGetGoods(t) {
            this.changePlayerGoods(t);
        }
        decPlayerBlood() {
            this.updatePlayerBlood();
        }
        usePlyerBullet() {
            if (GameManager.instance.roleInfo.weaponType == PlayerData.WEAPON_PIS)
                return;
            GameManager.instance.roleInfo.bulletNum--;
            if (GameManager.instance.roleInfo.bulletNum <= 0) {
                GameManager.instance.roleInfo.weaponType = PlayerData.WEAPON_PIS;
                EventManager.instance.dispatcherEvt(GameEvent.CHANGE_PLAYER_WEAPON, PlayerData.WEAPON_PIS);
            }
            this.updateBulletNum();
        }
        decBombNum() {
            GameManager.instance.roleInfo.bombNum--;
            this.updateGreNum();
        }
        updateBulletNum() {
            this.view.m_bullet.text = GameManager.instance.roleInfo.bulletNum + "";
        }
        updateGreNum() {
            this.view.m_gre.text = GameManager.instance.roleInfo.bombNum + "";
        }
        updateCoin() {
            this.view.m_coin.text = GameManager.instance.roleInfo.totalCoin + "";
            this.updateBuyItem();
        }
        updatePlayerBlood() {
            if (GameManager.instance.roleInfo.blood == 6) {
                this.view.m_blood_3.m_ctl.selectedIndex = this.view.m_blood_2.m_ctl.selectedIndex = this.view.m_blood_1.m_ctl.selectedIndex = 0;
            }
            else if (GameManager.instance.roleInfo.blood == 5) {
                this.view.m_blood_2.m_ctl.selectedIndex = this.view.m_blood_1.m_ctl.selectedIndex = 0;
                this.view.m_blood_3.m_ctl.selectedIndex = 1;
            }
            else if (GameManager.instance.roleInfo.blood == 4) {
                this.view.m_blood_2.m_ctl.selectedIndex = this.view.m_blood_1.m_ctl.selectedIndex = 0;
                this.view.m_blood_3.m_ctl.selectedIndex = 2;
            }
            else if (GameManager.instance.roleInfo.blood == 3) {
                this.view.m_blood_1.m_ctl.selectedIndex = 0;
                this.view.m_blood_2.m_ctl.selectedIndex = 1;
                this.view.m_blood_3.m_ctl.selectedIndex = 2;
            }
            else if (GameManager.instance.roleInfo.blood == 2) {
                this.view.m_blood_1.m_ctl.selectedIndex = 0;
                this.view.m_blood_2.m_ctl.selectedIndex = 2;
                this.view.m_blood_3.m_ctl.selectedIndex = 2;
            }
            else if (GameManager.instance.roleInfo.blood == 1) {
                this.view.m_blood_1.m_ctl.selectedIndex = 1;
                this.view.m_blood_2.m_ctl.selectedIndex = 2;
                this.view.m_blood_3.m_ctl.selectedIndex = 2;
            }
            else {
                this.view.m_blood_1.m_ctl.selectedIndex = 2;
                this.view.m_blood_2.m_ctl.selectedIndex = 2;
                this.view.m_blood_3.m_ctl.selectedIndex = 2;
            }
        }
        initBuyItem() {
            this.shopData = GameManager.instance.levelData.shop;
            var index = 0;
            for (const key in this.shopData) {
                if (this.shopData.hasOwnProperty(key)) {
                    index++;
                    var d = this.shopData[key];
                    this.view["m_item_" + index].m_coin.text = d.coin + "";
                    this.view["m_item_" + index].m_info.text = "x" + d.num;
                    this.view["m_item_" + index].m_icon.url = "ui://Game/goods_" + d.type;
                    this.view["m_item_" + index].data = d;
                    this.view["m_item_" + index].onClick(this, this.buyItem, [d]);
                }
            }
        }
        updateBuyItem() {
            if (GameManager.instance.platform != moosnow.APP_PLATFORM.BYTEDANCE)
                return;
            for (let i = 1; i <= 3; i++) {
                var d = this.view["m_item_" + i].data;
                if (!d)
                    continue;
                if (d.coin > GameManager.instance.roleInfo.totalCoin) {
                    this.view["m_item_" + i].m_ctl.selectedIndex = 1;
                }
                else {
                    this.view["m_item_" + i].m_ctl.selectedIndex = 0;
                }
            }
        }
        buyItem(d) {
            if (d.coin > GameManager.instance.roleInfo.totalCoin) {
                this.watchVideo(d);
            }
            else {
                this.buyItemSuccess(d);
            }
        }
        buyItemSuccess(d) {
            GameManager.instance.roleInfo.totalCoin -= d.coin;
            this.changePlayerGoods(d.type);
            this.updateCoin();
            ViewManager.instance.showTipsView("恭喜获得：" + d.name);
        }
        watchVideo(d) {
            var v = GameManager.instance.createVideoData(VideoType.VIDEOTYPE_GOODS, VideoInfo.VIDEOINFO_GOODS);
            MooSnowSDK.showVideo(d, v, this.changePlayerGoods.bind(this, [d.type]));
        }
        getRandomCoin() {
            return Math.floor((Math.random() * 100) * GameData.RANDOM_COIN / 100);
        }
        getRandomGoodsType() {
            return Math.ceil(Math.random() * 5);
        }
    }

    class WXFUI_loadingView extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("loading", "loadingView"));
        }
        onConstruct() {
            this.m_n7 = (this.getChild("n7"));
            this.m_n6 = (this.getChild("n6"));
            this.m_bar = (this.getChild("bar"));
            this.m_txt = (this.getChild("txt"));
        }
    }
    WXFUI_loadingView.URL = "ui://nr80du74n8quil";

    class WXFUI_PopUpView extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "PopUpView"));
        }
        onConstruct() {
            this.m_mask = (this.getChild("mask"));
            this.m_load = (this.getChild("load"));
            this.m_t0 = this.getTransition("t0");
        }
    }
    WXFUI_PopUpView.URL = "ui://bq3h5insmtpio6";

    class PopUpView {
        constructor() {
            this.isShow = false;
            this.v = WXFUI_PopUpView.createInstance();
        }
        showView(showMask = true, clickMaskHide = true) {
            this.isShow = true;
            this.layout();
            this.layoutMask();
            Laya.Tween.clearTween(this.tween);
            this.v.addChild(this.view);
            fairygui.GRoot.inst.addChild(this.v);
            this.view.setPivot(0.5, 0.5);
            this.view.setScale(0.4, 0.4);
            this.tween = Laya.Tween.to(this.view, { scaleX: 1, scaleY: 1 }, 250, null, Laya.Handler.create(this, this.showComplete, [showMask, clickMaskHide]));
        }
        showViewNoTween() {
            this.isShow = true;
            this.layout();
            this.layoutMask();
            this.view.setScale(1, 1);
            this.v.addChild(this.view);
            fairygui.GRoot.inst.addChild(this.v);
        }
        layout() {
            var w = ViewManager.instance.getLayoutWidth();
            this.v.x = w;
        }
        layoutMask() {
            var pro = ViewManager.instance.getProportion();
            if (pro > 0)
                this.v.m_mask.setScale(1 + pro, 1 + pro);
        }
        showComplete(s, c) {
            if (s) {
                this.v.m_mask.visible = true;
                if (c)
                    this.v.m_mask.on(Laya.Event.CLICK, this, this.hideAllView);
            }
            this.view.setScale(1, 1);
        }
        hideAllView() {
            this.isShow = false;
            this.v.m_mask.off(Laya.Event.CLICK, this, this.hideAllView);
            fairygui.GRoot.inst.removeChild(this.v);
        }
    }

    class WXFUI_TipsPopView extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "TipsPopView"));
        }
        onConstruct() {
            this.m_tips = (this.getChild("tips"));
            this.m_play = this.getTransition("play");
        }
    }
    WXFUI_TipsPopView.URL = "ui://bq3h5insugvixpf";

    class TipsPopView {
        constructor() {
            this.isShow = false;
            this.v = WXFUI_TipsPopView.createInstance();
        }
        showView(str) {
            if (this.isShow)
                return;
            this.isShow = true;
            this.v.x = (Laya.stage.width - this.v.width) / 2;
            this.v.y = (Laya.stage.height - this.v.height) / 2;
            this.v.m_tips.text = str;
            Laya.stage.addChild(this.v.displayObject);
            this.v.displayObject.zOrder = 10;
            this.v.m_play.play(Laya.Handler.create(this, this.hideView), 1, 0, 0);
        }
        hideView() {
            Laya.stage.removeChild(this.v.displayObject);
            this.isShow = false;
        }
    }

    class PlayerBody extends Laya.Script {
        constructor() {
            super();
            this.playerState = 0;
            this.startJump = false;
            this.keyJump = false;
            this.keyJumpEnd = false;
        }
        onAwake() {
            this.selfCollider = this.owner.getComponent(Laya.BoxCollider);
            this.selfBody = this.selfCollider.rigidBody;
        }
        onDisable() {
        }
        onTriggerEnter(other, self, contact) {
            this.setSpeedZero();
            if ((other.label == "ground" || other.label == "obstacle" || other.label == "board") && this.keyJumpEnd) {
                this.keyJump = false;
                this.keyJumpEnd = false;
                this.selfBody.linearVelocity = { x: 0, y: 0 };
                this.selfBody.angularVelocity = 0;
                this.selfBody.angularDamping = 0;
                this.selfBody.linearDamping = 0;
                this.selfBody.setVelocity({ x: 0, y: 0 });
                this.selfCollider.refresh();
                EventManager.instance.dispatcherEvt(GameEvent.PLAYER_COLLISION_GROUND);
            }
            if (other.label == "goods") {
                EventManager.instance.dispatcherEvt(GameEvent.PLAYER_GET_GOODS, other.owner);
            }
        }
        onTriggerExit() {
        }
        onTriggerStay(other, self, contact) {
        }
        onUpdate() {
            if (this.owner.y > 800) {
                EventManager.instance.dispatcherEvt(GameEvent.GOTO_HOLE);
            }
        }
        setSpeedZero() {
            if (Laya.Physics.I.world == null)
                return;
            if (this.keyJump) {
                return;
            }
            else {
                this.selfBody.linearVelocity = { x: 0, y: 0 };
                this.selfBody.angularVelocity = 0;
                this.selfBody.angularDamping = 0;
                this.selfBody.linearDamping = 0;
                this.selfBody.setVelocity({ x: 0, y: 0 });
            }
            this.selfCollider.refresh();
        }
    }

    class PlayerCtlView {
        constructor() { this.createView(); }
        createView() {
            this.view = fairygui.UIPackage.createObject("Game", "PlayerCtlView");
            this.layout();
        }
        layout() {
            if (Laya.Browser.onWeiXin) {
                let wxInfo = wx.getSystemInfoSync();
                this.view.x = Laya.stage.width - this.view.width - 50 * (Laya.stage.width / 1334);
                this.view.y = 385;
                console.log("this.view--", this.view.x);
            }
            else {
                var h = (Laya.Browser.height / 750) * 1334;
                this.view.x = 930 * (Laya.Browser.width / h);
                this.view.y = 385;
            }
        }
    }

    class PlayerDirView {
        constructor() { this.createView(); }
        createView() {
            this.view = fairygui.UIPackage.createObject("Game", "PlayerDirView");
            this.layout();
        }
        layout() {
            if (Laya.Browser.onWeiXin) {
                let wxInfo = wx.getSystemInfoSync();
                this.view.x = 300 * (Laya.stage.width / 1334);
                this.view.y = 720;
            }
            else {
                var h = (Laya.Browser.height / 750) * 1334;
                this.view.x = 320 * (Laya.Browser.width / h);
                this.view.y = 720;
            }
        }
    }

    class PlayerSk {
        constructor() {
            this.isWuDi = false;
            this.weaponType = 1;
            this.loadComplete1 = false;
            this.loadComplete2 = false;
            this.loadComplete3 = false;
            this.loadComplete4 = false;
            this.aniName = "";
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
            this.wudiImg = fairygui.UIPackage.createObject("Game", "wudi").asImage;
        }
        showWuDi() {
            this.isWuDi = true;
            this.role.addChild(this.wudiImg.displayObject);
            this.wudiImg.x = (this.role.width - this.wudiImg.width) / 2;
            this.wudiImg.y = -30;
        }
        hideWuDi() {
            this.isWuDi = false;
            this.role.removeChild(this.wudiImg.displayObject);
        }
        parseComplete() {
            this.loadComplete1 = true;
            this.body = this.templet1.buildArmature(0);
            this.body.y = 110;
            this.body.play("idle", true);
            this.sendLoadComplete();
        }
        weaponComplete1() {
            this.loadComplete2 = true;
            this.skin1 = this.weapon1.buildArmature(0);
            this.skin1.x = -7;
            this.skin1.y = 47;
            this.skin1.showSkinByName("weapons2");
            this.sendLoadComplete();
        }
        weaponComplete2() {
            this.loadComplete3 = true;
            this.skin2 = this.weapon2.buildArmature(0);
            this.skin2.x = -7;
            this.skin2.y = 47;
            this.skin2.showSkinByName("weapons3");
            this.sendLoadComplete();
        }
        weaponComplete3() {
            this.loadComplete4 = true;
            this.skin3 = this.weapon3.buildArmature(0);
            this.skin3.x = -7;
            this.skin3.y = 47;
            this.skin3.showSkinByName("weapons4");
            this.sendLoadComplete();
        }
        setBodyIdle() {
            this.body.play("idle", true, false);
        }
        setArmIdle() {
            this.arm.play("idle", true, false);
        }
        setIdle() {
            this.setUp();
            this.setArmIdle();
            this.setBodyIdle();
        }
        setRun() {
            this.body.play("run", true, false);
            this.setUp();
        }
        setJump() {
            this.body.play("jump", true, false);
            this.setUp();
        }
        setCrouch() {
            this.body.play("crouch", true, false);
            this.setDown();
        }
        setAttack1() {
            this.arm.play("attack3", true, false);
            this.aniName = "attack3";
        }
        setAttack2() {
            this.arm.play("attack2", true, false);
            this.aniName = "attack2";
        }
        setFaceUp45() {
            this.arm.rotation = -45;
        }
        setFaceUp90() {
            this.arm.rotation = -90;
        }
        setWeapon(type) {
            this.weaponType = type;
            this.arm.stop();
            this.role.removeChildren();
            this.role.addChild(this.body);
            this.role.addChild(this.arm);
            if (this.isWuDi)
                this.showWuDi();
            if (ViewManager.instance.player.sFire) {
                if (GameManager.instance.roleInfo.weaponType == GameData.WEAPON_RIFLE) {
                    this.setAttack2();
                }
                else {
                    this.setAttack1();
                }
            }
            else {
                this.setArmIdle();
            }
            ViewManager.instance.rolePlayer.roleSprite.addChild(this.role);
        }
        sendLoadComplete() {
            if (this.loadComplete1 && this.loadComplete2 && this.loadComplete3 && this.loadComplete4) {
                EventManager.instance.dispatcherEvt(GameEvent.ROLE_ANI_COMPLETE);
            }
        }
        get arm() {
            if (this.weaponType == 1) {
                return this.skin1;
            }
            else if (this.weaponType == 2) {
                return this.skin2;
            }
            else if (this.weaponType == 3) {
                return this.skin3;
            }
            return this.skin1;
        }
        setDown() {
            this.arm.rotation = 0;
            this.skin1.y = this.skin2.y = this.skin3.y = 62;
        }
        setUp() {
            this.arm.rotation = 0;
            this.skin1.y = this.skin2.y = this.skin3.y = 47;
        }
        beHit() {
        }
        clearBeHit() {
            this.role.x = 30;
            Laya.Tween.clearTween(this.role);
        }
    }
    PlayerSk.WEAPON_1 = "weapons1";
    PlayerSk.WEAPON_2 = "weapons2";
    PlayerSk.WEAPON_3 = "weapons3";
    PlayerSk.WEAPON_4 = "weapons4";
    PlayerSk.IDLE = "idle";
    PlayerSk.RUN = "run";
    PlayerSk.JUMP = "jump";
    PlayerSk.CROUCH = "crouch";
    PlayerSk.ATTACK_1 = "attack1";
    PlayerSk.ATTACK_2 = "attack2";

    class Player extends Laya.Script {
        constructor() {
            super();
            this.direction = 1;
            this.sRun = false;
            this.sFire = false;
            this.sBoom = false;
            this.keyRight = false;
            this.keyLeft = false;
            this.keyJump = false;
            this.isSquatDown = false;
            this.speed = 5;
            this.jumpHigh = 200;
            this.weaponType = 1;
            this.faceType = 1;
            this.acMove = false;
            this.keyFire = false;
            this.curTouchId = 0;
        }
        createView() {
            this.playerSk = new PlayerSk();
            this.roleSprite = new ui.PlayerBodyUI();
            if (!this.playerCtlView)
                this.playerCtlView = new PlayerCtlView();
            if (!this.playerDirView)
                this.playerDirView = new PlayerDirView();
            EventManager.instance.addNotice(GameEvent.ROLE_ANI_COMPLETE, this, this.loadComplete);
        }
        ;
        loadComplete() {
            this.roleBody = this.roleSprite.getComponent(Laya.RigidBody);
            this.roleBox = this.roleSprite.getComponent(Laya.BoxCollider);
            this.roleSprite.addComponent(PlayerBody);
            this.bodyScript = this.roleSprite.getComponent(PlayerBody);
            this.playerDirView.view.m_dirBtn.y = this.playerDirView.view.m_dirBtn.x = 0;
            this.resetData();
        }
        addEvent() {
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
        }
        resetData() {
            this.addEvent();
            ViewManager.instance.clearAddGold();
            if (GameManager.instance.buyWeaponType > 0) {
                GameManager.instance.roleInfo.weaponType = GameManager.instance.buyWeaponType;
                GameManager.instance.roleInfo.bulletNum = GameManager.instance.buyBullet;
            }
            else {
                GameManager.instance.roleInfo.weaponType = 1;
                GameManager.instance.roleInfo.bulletNum = 0;
            }
            ViewManager.instance.warView.scene.addChild(this.roleSprite);
            GameManager.instance.roleInfo.bombNum = GameManager.instance.buyGre;
            ViewManager.instance.playerInfoView.updateAllView();
            this.changeWeaponType(GameManager.instance.roleInfo.weaponType);
            this.playerDirView.view.m_dirBtn.y = this.playerDirView.view.m_dirBtn.x = 0;
            var d = GameManager.instance.curLvData;
            this.roleSprite.x = d.rolePos[0];
            this.roleSprite.y = d.rolePos[1];
            this.sBoom = false;
            this.sRun = false;
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
        activeMove() {
            if (this.acMove)
                return;
            this.acMove = true;
            Laya.timer.loop(500, this, this.moveMap);
        }
        playerRes() {
            this.addCtlViewMouseUp(null);
            this.addEvent();
            this.sBoom = false;
            this.sRun = false;
            this.playerSk.role.visible = true;
            this.keyJump = false;
            this.keyFireUp();
            this.playerDirView.view.m_dirBtn.y = this.playerDirView.view.m_dirBtn.x = 0;
            Laya.timer.clearAll(this);
            Laya.timer.loop(500, this, this.moveMap);
            this.setStay();
            if (this.roleSprite.y > 800) {
                this.roleSprite.y = 580;
                this.roleSprite.x -= 200;
            }
            this.playerSk.showWuDi();
        }
        gotoHole() {
            this.setDeath();
        }
        addCtlViewMouseUp(e) {
            this.playerDirView.view.m_mask.off(Laya.Event.MOUSE_MOVE, this, this.onMoveHandle);
            this.playerDirView.view.m_dirBtn.y = this.playerDirView.view.m_dirBtn.x = 0;
            this.setFaceDirection();
            this.setStandUp();
            this.stopMove();
        }
        setFaceDirection() {
            if (this.faceType > 0) {
                this.faceType = this.direction = 1;
                this.setFaceRight();
            }
            else {
                this.faceType = this.direction = -1;
                this.setFaceLeft();
            }
        }
        keyFireDown() {
            this.keyFire = true;
            this.setFire();
        }
        keyFireUp() {
            this.keyFire = false;
            if (GameManager.instance.roleInfo.isDeath)
                return;
            this.setFireEnd();
        }
        addMouseDown(e) {
            this.curTouchId = e.touchId;
            this.setDirection();
            this.playerDirView.view.m_mask.on(Laya.Event.MOUSE_MOVE, this, this.onMoveHandle);
        }
        onMoveHandle(e) {
            if (e.touchId != this.curTouchId)
                return;
            this.setDirection();
        }
        setDirection() {
            var pos = this.playerDirView.view.globalToLocal(Laya.stage.mouseX, Laya.stage.mouseY);
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
        setFaceType() {
            if (this.faceType > 0) {
                this.setFaceRight();
                if (this.faceType == 1) {
                    this.direction = 1;
                    this.setStandUp();
                    this.setRightRun();
                }
                else {
                    this.sRun = false;
                    Laya.timer.clear(this, this.stillRun);
                    if (this.faceType == 5) {
                        this.setSquatDown();
                    }
                    else if (this.faceType == 4 || this.faceType == 3) {
                        this.setFaceUp();
                    }
                    else {
                        this.setStandUp();
                    }
                }
            }
            else {
                this.setFaceLeft();
                if (this.faceType == -1) {
                    this.direction = -1;
                    this.setStandUp();
                    this.setLeftRun();
                }
                else {
                    this.sRun = false;
                    Laya.timer.clear(this, this.stillRun);
                    if (this.faceType == -5) {
                        this.setSquatDown();
                    }
                    else if (this.faceType == -4 || this.faceType == -3) {
                        this.setFaceUp();
                    }
                    else
                        this.setStandUp();
                }
            }
        }
        setSquatDown() {
            if (this.isSquatDown)
                return;
            this.isSquatDown = true;
            this.playerSk.setCrouch();
        }
        setStandUp() {
            if (!this.isSquatDown)
                return;
            this.isSquatDown = false;
            this.playerSk.setIdle();
        }
        setFaceRight() {
            this.playerSk.role.skewY = 0;
            this.keyRight = true;
            this.keyLeft = false;
        }
        setFaceUp() {
            if (Math.abs(this.faceType) == 3) {
                this.playerSk.setFaceUp45();
            }
            else if (Math.abs(this.faceType) == 4) {
                this.playerSk.setFaceUp90();
            }
            if (!this.keyJump)
                this.playerSk.setBodyIdle();
        }
        setFaceLeft() {
            this.keyLeft = true;
            this.keyRight = false;
            this.playerSk.role.skewY = 180;
        }
        onClickBomb() {
            if (this.sBoom)
                return;
            if (GameManager.instance.roleInfo.bombNum <= 0)
                return;
            this.setBoom();
        }
        onClickJump() {
            if (this.keyJump)
                return;
            this.setJump();
        }
        setLeftRun() {
            if (this.sRun)
                return;
            this.setRun();
            this.stillRun();
        }
        setRightRun() {
            if (this.sRun)
                return;
            this.setRun();
            this.stillRun();
        }
        colliGround() {
            this.jumpEnd();
        }
        setJump() {
            this.isSquatDown = false;
            this.keyJump = this.bodyScript.keyJump = true;
            this.setBoomComplete();
            this.playerSk.setJump();
            this.roleBody.setVelocity({ x: 0, y: -11 });
            this.roleBox.refresh();
            Laya.timer.once(200, this, this.jumpHighHandle);
        }
        jumpHighHandle() {
            this.bodyScript.keyJumpEnd = true;
        }
        jumpEnd() {
            this.keyJump = false;
            this.stopMove();
            if (GameManager.instance.roleInfo.isDeath)
                return;
            if (this.sBoom) {
                this.setBoomComplete();
            }
        }
        setRun() {
            this.activeMove();
            if (!this.keyJump)
                this.playerSk.setRun();
            this.sRun = true;
            Laya.timer.clear(this, this.stillRun);
            Laya.timer.frameLoop(1, this, this.stillRun);
        }
        moveMap() {
            if (Math.abs(ViewManager.instance.warView.warView.x) + Laya.stage.width > ViewManager.instance.warView.warView.width - 200)
                return;
            if (this.roleSprite.x - Math.abs(ViewManager.instance.warView.warView.x) - this.roleSprite.width / 2 >= Laya.stage.width / 2) {
                var dis = this.roleSprite.x - Math.abs(ViewManager.instance.warView.warView.x) - Laya.stage.width / 2;
                ViewManager.instance.updateViewPort(dis);
            }
        }
        stillRun() {
            if (this.direction == 1) {
                this.roleSprite.x += this.speed;
                if (this.roleSprite.x > ViewManager.instance.warView.warView.width - this.roleSprite.width - 200) {
                    this.roleSprite.x = ViewManager.instance.warView.warView.width - this.roleSprite.width - 200;
                }
                if (Math.abs(ViewManager.instance.warView.warView.x) + Laya.stage.width > ViewManager.instance.warView.warView.width - 200)
                    return;
            }
            else if (this.direction == -1) {
                this.roleSprite.x -= this.speed;
                if (this.roleSprite.x < Math.abs(ViewManager.instance.warView.warView.x))
                    this.roleSprite.x = Math.abs(ViewManager.instance.warView.warView.x);
            }
        }
        setFire() {
            if (this.sFire)
                return;
            if (GameManager.instance.roleInfo.isDeath)
                return;
            this.playWeaponSound();
            Laya.timer.clear(this, this.stillFire);
            this.sFire = true;
            if (this.weaponType != PlayerData.WEAPON_PIS) {
                EventManager.instance.dispatcherEvt(GameEvent.USE_PLAYER_BULLET);
            }
            if (this.weaponType == PlayerData.WEAPON_RIFLE) {
                this.playerSk.setAttack2();
                ViewManager.instance.createSanBullet();
            }
            else {
                this.playerSk.setAttack1();
                ViewManager.instance.createBullet();
            }
            Laya.timer.loop(150, this, this.stillFire);
        }
        stillFire() {
            this.playWeaponSound();
            if (this.weaponType != PlayerData.WEAPON_PIS) {
                EventManager.instance.dispatcherEvt(GameEvent.USE_PLAYER_BULLET);
            }
            if (this.weaponType == PlayerData.WEAPON_RIFLE) {
                ViewManager.instance.createSanBullet();
            }
            else {
                ViewManager.instance.createBullet();
            }
        }
        rilfeComplete() {
            if (this.keyFire) {
                this.setFire();
            }
            else {
                this.setFireEnd();
            }
        }
        setFireEnd() {
            Laya.timer.clear(this, this.stillFire);
            this.sFire = false;
            this.playerSk.setArmIdle();
        }
        setBoom() {
            this.sBoom = true;
            EventManager.instance.dispatcherEvt(GameEvent.USE_PLAYER_BOMB);
            Laya.timer.once(600, this, this.setBoomComplete);
            ViewManager.instance.createBomb(BombData.BOMB_MY_GRE, this.direction, ViewManager.instance.getBodyCenterPos(this.roleSprite), true);
        }
        setBoomComplete() {
            this.sBoom = false;
        }
        stopMove() {
            if (GameManager.instance.roleInfo.isDeath)
                return;
            Laya.timer.clear(this, this.stillRun);
            this.keyLeft = false;
            this.keyRight = false;
            this.sRun = false;
            this.playerSk.setBodyIdle();
            this.playerSk.setUp();
        }
        setStay() {
            if (this.faceType > 0) {
                this.direction = 1;
                this.playerSk.role.skewY = 0;
            }
            else {
                this.direction = -1;
                this.playerSk.role.skewY = 180;
            }
            Laya.timer.clear(this, this.stillFire);
            this.stopMove();
        }
        changeWeaponType(type) {
            this.weaponType = GameManager.instance.roleInfo.weaponType = type;
            if (this.sFire) {
                Laya.timer.clear(this, this.stillFire);
                this.sFire = false;
                this.setFire();
            }
            this.playerSk.setWeapon(type);
        }
        setDeath() {
            if (GameManager.instance.roleInfo.isDeath)
                return;
            this.playerSk.role.visible = false;
            Laya.timer.clearAll(this);
            this.removeEvent();
            this.setFireEnd();
            this.stopMove();
            GameManager.instance.roleInfo.isDeath = true;
            this.playDeathSound();
            ViewManager.instance.showAfterWarView(3);
            MooSnowSDK.clipRecord();
        }
        victoryGame() {
            this.setStay();
            this.removeEvent();
            Laya.timer.clearAll(this);
            this.roleSprite.removeSelf();
            GameManager.instance.roleInfo.curlvCoin += GameData.VICTORY_LEVEL_COIN;
            GameManager.instance.roleInfo.totalCoin += GameData.VICTORY_LEVEL_COIN;
            ViewManager.instance.playerInfoView.updateCoin();
        }
        playDeathSound() {
            var s = 1;
            var r = Math.random();
            if (r > 0.75)
                s = 4;
            if (r > 0.5)
                s = 3;
            if (r > 0.25)
                s = 2;
            s = 1;
            SoundManager.instance.playSound("die_" + s);
        }
        playWeaponSound() {
            if (this.weaponType == 3) {
                SoundManager.instance.playSound("weapon_10");
            }
            else
                SoundManager.instance.playSound("weapon_" + this.weaponType);
        }
        deathComplete() {
        }
        disposeEnemyBullet(s) {
        }
        beHit(s) {
            this.disposeEnemyBullet(s);
            if (GameManager.instance.roleInfo.isInvincible)
                return;
            if (GameManager.instance.roleInfo.isDeath)
                return;
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
        setColor() {
        }
        dispose() {
            this.removeEvent();
            Laya.timer.clearAll(this);
            this.roleSprite.removeChildren();
            this.roleSprite.removeSelf();
            this.roleSprite.destroy();
            this.roleSprite = null;
            this.recover();
        }
        removeEvent() {
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
        recover() {
            Laya.Pool.recover("player", this);
        }
        keyUpEvent(e) {
            var keyCode = e["keyCode"];
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
        keyDowmEvent(e) {
            var keyCode = e["keyCode"];
            switch (keyCode) {
                case 87:
                    console.log("上");
                    this.faceType = 3;
                    this.setFaceType();
                    break;
                case 83:
                    console.log("下");
                    this.faceType = -3;
                    this.setFaceType();
                    break;
                case 65:
                    this.keyLeft = true;
                    this.playerSk.role.skewY = 180;
                    if (this.sRun)
                        return;
                    this.setRun();
                    this.stillRun();
                    break;
                case 68:
                    this.keyRight = true;
                    this.playerSk.role.skewY = 0;
                    if (this.sRun)
                        return;
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

    class DamageView {
        constructor() { }
        createView(damage, s) {
            this.view = fairygui.UIPackage.createObject("Game", "damageView");
            this.view.m_num.text = " - " + damage * 5;
            this.view.m_ani.play(Laya.Handler.create(this, this.dispose));
            s.addChild(this.view.displayObject);
        }
        dispose() {
            if (this.view.parent) {
                this.view.parent.removeChild(this.view);
            }
            Laya.Pool.recover("damageView", this);
        }
    }

    class AddGold {
        constructor() { }
        createView(goodsType, num, s, isBox = false) {
            this.view = fairygui.UIPackage.createObject("Game", "addGold");
            this.view.m_icon.url = "";
            var n = num;
            if (isBox) {
                this.view.m_icon.url = "ui://Game/goods_" + goodsType;
                if (goodsType == GoodsType.GoodsType_MED) {
                    n = 1;
                }
                else if (goodsType == GoodsType.GoodsType_MAC) {
                    n = GameManager.instance.roleInfo.addMacNum;
                }
                else if (goodsType == GoodsType.GoodsType_RIF) {
                    n = GameManager.instance.roleInfo.addRifNum;
                }
                else if (goodsType == GoodsType.GoodsType_GRE) {
                    n = GameManager.instance.roleInfo.addBombNum;
                }
            }
            this.view.m_num.text = " + " + n;
            this.view.m_ani.play(Laya.Handler.create(this, this.dispose));
            s.addChild(this.view.displayObject);
        }
        dispose() {
            if (this.view.parent) {
                this.view.parent.removeChild(this.view);
            }
            Laya.Pool.recover("addGold", this);
        }
    }

    class HostageBody extends Laya.Script {
        constructor() {
            super();
            this.activeDis = 150;
            this.isActive = false;
        }
        onEnable() {
            this.selfCollider = this.owner.getComponent(Laya.BoxCollider);
            this.selfBody = this.selfCollider.rigidBody;
            this.self = this.owner;
            this.oriPosX = this.selfBody.getWorldCenter().x;
        }
        onDisable() {
        }
        onTriggerEnter(other, self, contact) {
        }
        onTriggerExit() {
        }
        onTriggerStay(other, self, contact) {
        }
        onUpdate() {
            if (this.isActive)
                return;
            if (Math.abs(ViewManager.instance.rolePlayer.roleSprite.x - this.oriPosX) < this.activeDis) {
                this.isActive = true;
                EventManager.instance.dispatcherEvt(GameEvent.ACTIVE_HOSTAGE, this.owner);
            }
        }
    }

    class HostageView {
        constructor() {
            this.isActive = false;
        }
        createView(d) {
            this.scene = new ui.HostageBodyUI();
            this.pos = d.pos;
            this.isActive = false;
            this.loadComplete();
        }
        loadComplete() {
            this.body = this.scene.getComponent(Laya.RigidBody);
            this.box = this.scene.getComponent(Laya.BoxCollider);
            this.scene.addComponent(HostageBody);
            this.script = this.scene.getComponent(HostageBody);
            this.scene.x = this.pos.x;
            this.scene.y = this.pos.y;
            this.view = fairygui.UIPackage.createObject("Game", "hostage");
            this.scene.addChild(this.view.displayObject);
            ViewManager.instance.warView.scene.addChild(this.scene);
            EventManager.instance.addNotice(GameEvent.ACTIVE_HOSTAGE, this, this.activeHostage);
        }
        activeHostage(s) {
            if (this.isActive)
                return;
            if (this.box.owner == s) {
                this.isActive = true;
                this.view.m_en.url = "ui://Game/hostageAni";
                this.view.m_en.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.dispose));
            }
        }
        dispose(s) {
            var p = new Laya.Point();
            p.x = this.scene.x + this.scene.width / 2;
            p.y = this.scene.y + this.scene.height / 2;
            ViewManager.instance.createGoods(GoodsType.GoodsType_BOX, p);
            EventManager.instance.offNotice(GameEvent.ACTIVE_HOSTAGE, this, this.activeHostage);
            this.view.removeChildren();
            if (this.view)
                this.view.dispose();
            if (this.scene) {
                this.scene.removeSelf();
            }
            Laya.Pool.recover("hostage", this);
        }
    }

    class WXFUI_SuspendView extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "SuspendView"));
        }
        onConstruct() {
            this.m_bg = (this.getChild("bg"));
            this.m_back = (this.getChild("back"));
            this.m_continue = (this.getChild("continue"));
            this.m_restart = (this.getChild("restart"));
            this.m_n10 = (this.getChild("n10"));
        }
    }
    WXFUI_SuspendView.URL = "ui://bq3h5insn8qul6";

    class SuspendView extends PopUpView {
        constructor() { super(); }
        createView() {
            this.view = WXFUI_SuspendView.createInstance();
            this.view.m_back.onClick(this, this.goFirstPage);
            this.view.m_continue.onClick(this, this.continueGame);
            this.view.m_restart.onClick(this, this.restartGame);
        }
        showViewNoTween() {
            super.showViewNoTween();
            if (GameManager.instance.platform != moosnow.APP_PLATFORM.BYTEDANCE)
                MooSnowSDK.showBanner(false);
        }
        goFirstPage() {
            SoundManager.instance.playSound("btn_click");
            GameManager.instance.suspendGame();
            MooSnowSDK.endGame(GameManager.instance.choiseLevel, true);
            Laya.timer.frameOnce(1, this, () => {
                ViewManager.instance.hideSuspendView();
                GameManager.instance.goFirstPage();
            });
        }
        continueGame() {
            SoundManager.instance.playSound("btn_click");
            GameManager.instance.suspendGame();
            Laya.timer.frameOnce(1, this, () => {
                ViewManager.instance.hideSuspendView();
            });
        }
        restartGame() {
            SoundManager.instance.playSound("btn_click");
            GameManager.instance.suspendGame();
            MooSnowSDK.endGame(GameManager.instance.choiseLevel, true);
            Laya.timer.frameOnce(1, this, () => {
                ViewManager.instance.hideSuspendView();
                GameManager.instance.restartGame();
            });
        }
        hideAllView() {
            super.hideAllView();
            MooSnowSDK.hideBanner();
        }
    }

    class WXFUI_ChapterView extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "ChapterView"));
        }
        onConstruct() {
            this.m_ctl = this.getController("ctl");
            this.m_bg = (this.getChild("bg"));
            this.m_n14 = (this.getChild("n14"));
            this.m_map = (this.getChild("map"));
            this.m_level_1 = (this.getChild("level_1"));
            this.m_level_2 = (this.getChild("level_2"));
            this.m_level_3 = (this.getChild("level_3"));
            this.m_level_4 = (this.getChild("level_4"));
            this.m_level_5 = (this.getChild("level_5"));
            this.m_level_6 = (this.getChild("level_6"));
            this.m_level_7 = (this.getChild("level_7"));
            this.m_level_8 = (this.getChild("level_8"));
            this.m_title = (this.getChild("title"));
            this.m_setView = (this.getChild("setView"));
            this.m_ad_1 = (this.getChild("ad_1"));
            this.m_ad_2 = (this.getChild("ad_2"));
            this.m_ad_3 = (this.getChild("ad_3"));
            this.m_n41 = (this.getChild("n41"));
            this.m_ad_remen = (this.getChild("ad_remen"));
            this.m_ad = (this.getChild("ad"));
            this.m_last = (this.getChild("last"));
            this.m_next = (this.getChild("next"));
            this.m_ad_remen2 = (this.getChild("ad_remen2"));
        }
    }
    WXFUI_ChapterView.URL = "ui://bq3h5insdr1tnw";

    class ChapterView extends PopUpView {
        constructor() {
            super();
            this.showSet = true;
            this.showVolume = true;
        }
        createView() {
            this.view = WXFUI_ChapterView.createInstance();
            this.view.m_title.url = "ui://Game/chapter_1";
            for (let t = 1; t <= GameManager.instance.maxLevel; t++) {
                this.view["m_level_" + t].on(Laya.Event.CLICK, this, this.chooseLevel, [t]);
            }
            this.view.m_setView.onClick(this, this.setVolume);
            this.view.m_last.onClick(this, this.lastHandle);
            this.view.m_next.onClick(this, this.nextHandle);
            this.updateView();
            EventManager.instance.addNotice(GameEvent.PAUSE_GAME, this, this.pauseGame);
            if (GameManager.instance.platform == moosnow.APP_PLATFORM.QQ) {
                this.view.m_ctl.selectedIndex = 1;
                this.view.m_ad_remen2.onClick(this, this.showReMenAD2);
                this.view.m_ad_remen2.m_ani_2.play(null, -1);
                MooSnowSDK.showBanner(false);
            }
            else if (GameManager.instance.platform == moosnow.APP_PLATFORM.WX) {
                this.view.m_ctl.selectedIndex = 0;
                this.view.m_ad_1.onClick(this, this.onClickADItem, [1]);
                this.view.m_ad_2.onClick(this, this.onClickADItem, [2]);
                this.view.m_ad_3.onClick(this, this.onClickADItem, [3]);
                this.view.m_ad_remen.onClick(this, this.showReMenAD);
                this.view.m_ad.m_list.itemRenderer = Laya.Handler.create(this, this.setADItem, null, false);
                this.view.m_ad.m_list.width = 240 * GameManager.instance.adList.length;
                this.view.m_ad.m_list.on(fairygui.Events.CLICK_ITEM, this, this.onClickItem);
                EventManager.instance.addNotice(GameEvent.SHOW_AD_LIST, this, this.showADList);
                this.view.m_ad.m_n4.width = 1310;
            }
            else if (GameManager.instance.platform == moosnow.APP_PLATFORM.BYTEDANCE) {
                this.view.m_ctl.selectedIndex = 1;
                this.view.m_ad_remen2.visible = false;
                MooSnowSDK.hideBanner();
            }
            else if (GameManager.instance.platform == moosnow.APP_PLATFORM.VIVO || GameManager.instance.platform == moosnow.APP_PLATFORM.OPPO) {
                this.view.m_ctl.selectedIndex = 1;
                this.view.m_ad_remen2.visible = false;
                MooSnowSDK.showBanner(false);
            }
        }
        showView(s, c) {
            super.showView(s, c);
            this.view.m_ad.m_list.x = 0;
            this.showADList();
            if (GameManager.instance.platform == moosnow.APP_PLATFORM.QQ) {
                MooSnowSDK.showBanner(false);
            }
        }
        updateView() {
            var c = GameManager.instance.curChapter;
            this.view.m_title.url = "ui://Game/chapter_" + c;
            for (let i = 1; i <= GameManager.instance.maxLevel; i++) {
                var index = i + (c - 1) * GameManager.instance.maxLevel;
                this.view["m_level_" + i].m_star.m_ctl.selectedIndex = 0;
                this.view["m_level_" + i].m_numF.text = (i + (GameManager.instance.curChapter - 1) * GameManager.instance.maxLevel) + "";
                if (index < GameManager.instance.gotoMaxLevel) {
                    this.view["m_level_" + i].m_ctl.selectedIndex = 1;
                    this.view["m_level_" + i].m_star.m_ctl.selectedIndex = 3;
                }
                else if (index == GameManager.instance.gotoMaxLevel) {
                    this.view["m_level_" + i].m_ctl.selectedIndex = 2;
                    this.view["m_level_" + i].m_star.m_ctl.selectedIndex = 1;
                }
                else {
                    this.view["m_level_" + i].m_ctl.selectedIndex = 0;
                    this.view["m_level_" + i].m_star.m_ctl.selectedIndex = 0;
                }
            }
            if (GameManager.instance.platform == moosnow.APP_PLATFORM.QQ) {
                this.view.m_ad_remen2.m_ani_2.play(null, -1);
            }
        }
        chooseLevel(l) {
            SoundManager.instance.playSound("btn_click");
            console.log("选择第" + GameManager.instance.curChapter + "章，" + "第" + l + "关");
            if (l + (GameManager.instance.curChapter - 1) * GameManager.instance.maxLevel > GameManager.instance.gotoMaxLevel)
                return;
            GameManager.instance.choiseLevel = l + (GameManager.instance.curChapter - 1) * GameManager.instance.maxLevel;
            console.log("选择第" + GameManager.instance.choiseLevel + "关");
            ViewManager.instance.showBeforeWarView();
        }
        setVolume() {
            SoundManager.instance.playSound("btn_click");
            this.showVolume = !this.showVolume;
            if (this.showVolume) {
                this.view.m_setView.m_ctl.selectedIndex = 0;
                SoundManager.instance.openSound();
            }
            else {
                this.view.m_setView.m_ctl.selectedIndex = 1;
                SoundManager.instance.offSound();
            }
        }
        lastHandle() {
            SoundManager.instance.playSound("btn_click");
            GameManager.instance.curChapter--;
            if (GameManager.instance.curChapter < 1) {
                GameManager.instance.curChapter = GameManager.instance.maxChapter;
            }
            this.updateView();
        }
        nextHandle() {
            SoundManager.instance.playSound("btn_click");
            GameManager.instance.curChapter++;
            if (GameManager.instance.curChapter > GameManager.instance.maxChapter) {
                GameManager.instance.curChapter = 1;
            }
            this.updateView();
        }
        showReMenAD() {
            SoundManager.instance.playSound("btn_click");
            ViewManager.instance.showADListView();
        }
        showReMenAD2() {
            SoundManager.instance.playSound("btn_click");
            console.log("showReMenAD2");
            MooSnowSDK.showQQADBox();
        }
        showADList() {
            if (GameManager.instance.adList.length < 1)
                return;
            if (GameManager.instance.platform != moosnow.APP_PLATFORM.WX)
                return;
            EventManager.instance.offNotice(GameEvent.SHOW_AD_LIST, this, this.showADList);
            this.view.m_ad.m_list.width = 240 * GameManager.instance.adList.length;
            this.view.m_ad.m_list.numItems = GameManager.instance.adList.length;
            Laya.Tween.clearTween(this.view.m_ad.m_list);
            Laya.timer.clear(this, this.changeAD);
            this.adMoveLeft();
            this.view.m_ad_1.m_ani_1.play(null, -1);
            this.view.m_ad_2.m_ani_1.play(null, -1);
            this.view.m_ad_3.m_ani_1.play(null, -1);
            this.view.m_ad_remen.m_ani.play(null, -1);
            this.changeAD();
            Laya.timer.loop(3000, this, this.changeAD);
        }
        changeAD() {
            this.view.m_ad_1.data = this.getRandomAdData();
            this.view.m_ad_2.data = this.getRandomAdData();
            this.view.m_ad_3.data = this.getRandomAdData();
            this.view.m_ad_3.m_ad.m_icon.url = this.view.m_ad_3.data["img"];
            this.view.m_ad_3.m_ad.m_name.text = this.view.m_ad_3.data["title"];
            this.view.m_ad_2.m_ad.m_icon.url = this.view.m_ad_2.data["img"];
            this.view.m_ad_2.m_ad.m_name.text = this.view.m_ad_2.data["title"];
            this.view.m_ad_1.m_ad.m_icon.url = this.view.m_ad_1.data["img"];
            this.view.m_ad_1.m_ad.m_name.text = this.view.m_ad_1.data["title"];
        }
        setADItem(index, item) {
            var d = GameManager.instance.adList[index];
            if (!d)
                return;
            item.data = d;
            item.m_icon.url = d.img;
            item.m_name.text = d.title;
        }
        onClickADItem(index) {
            var m = this.view["m_ad_" + index].data;
            if (!m)
                return;
            console.log("onClickADItem--", m);
            moosnow.platform.navigate2Mini(m, (res) => {
                console.log('跳转成功 ', res);
            }, (res) => {
                console.log('跳转失败 ', res);
                ViewManager.instance.showADListView();
            });
        }
        onClickItem(e) {
            var m = e.data;
            console.log("ad--", m);
            if (!m)
                return;
            moosnow.platform.navigate2Mini(m, (res) => {
                console.log('跳转成功 ', res);
            }, (res) => {
                console.log('跳转失败 ', res);
                ViewManager.instance.showADListView();
            });
        }
        adMoveLeft() {
            Laya.Tween.to(this.view.m_ad.m_list, { x: this.view.m_ad.width - 240 * GameManager.instance.adList.length }, GameManager.instance.adTime, null, Laya.Handler.create(this, this.adMoveRight));
        }
        adMoveRight() {
            Laya.Tween.to(this.view.m_ad.m_list, { x: 0 }, GameManager.instance.adTime, null, Laya.Handler.create(this, this.adMoveLeft));
        }
        pauseGame() {
            if (GameManager.instance.isPauseGame) {
                this.hideADList();
            }
            else {
                this.showADList();
            }
        }
        hideADList() {
            this.view.m_ad_1.m_ani_1.stop(null);
            this.view.m_ad_2.m_ani_1.stop(null);
            this.view.m_ad_3.m_ani_1.stop(null);
            this.view.m_ad_remen.m_ani.stop(null);
            Laya.Tween.clearTween(this.view.m_ad.m_list);
            Laya.timer.clear(this, this.changeAD);
        }
        hideAllView() {
            super.hideAllView();
            this.hideADList();
        }
        getRandomAdData() {
            var r = Math.floor(Math.random() * GameManager.instance.adList.length);
            return GameManager.instance.adList[r];
        }
    }

    class WXFUI_AfterWar extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "AfterWar"));
        }
        onConstruct() {
            this.m_ctl = this.getController("ctl");
            this.m_n20 = (this.getChild("n20"));
            this.m_coin = (this.getChild("coin"));
            this.m_n24 = (this.getChild("n24"));
            this.m_n26 = (this.getChild("n26"));
            this.m_abandon = (this.getChild("abandon"));
            this.m_continue_1 = (this.getChild("continue_1"));
            this.m_continue_2 = (this.getChild("continue_2"));
            this.m_continue_3 = (this.getChild("continue_3"));
            this.m_return = (this.getChild("return"));
            this.m_ad_1 = (this.getChild("ad_1"));
            this.m_ad_2 = (this.getChild("ad_2"));
            this.m_adHot = (this.getChild("adHot"));
            this.m_n37 = (this.getChild("n37"));
            this.m_nextBtn = (this.getChild("nextBtn"));
            this.m_gou = (this.getChild("gou"));
            this.m_n42 = (this.getChild("n42"));
            this.m_nativeAD = (this.getChild("nativeAD"));
            this.m_oppoNative = (this.getChild("oppoNative"));
            this.m_sanbei = (this.getChild("sanbei"));
            this.m_nextBtn2 = (this.getChild("nextBtn2"));
        }
    }
    WXFUI_AfterWar.URL = "ui://bq3h5insdr1tnq";

    class AfterWar extends PopUpView {
        constructor() {
            super();
            this.adList = [];
            this._checkBoxMistouch = false;
            this._clickCount = 0;
            this._randomList = [];
        }
        createView() {
            this.view = WXFUI_AfterWar.createInstance();
            this.view.m_coin.text = " 0";
            this.view.m_ad_1.m_list.itemRenderer = Laya.Handler.create(this, this.setADItem1, null, false);
            this.view.m_ad_2.m_list.itemRenderer = Laya.Handler.create(this, this.setADItem2, null, false);
            EventManager.instance.addNotice(GameEvent.SHOW_AD_LIST, this, this.showADList);
            this.view.m_adHot.m_jixu.onClick(this, this.hideADHot);
            this._sdkData = MooSnowSDK.getAllConfig();
            if (this._sdkData && this._sdkData.checkBoxMistouch != "0") {
                this._checkBoxMistouch = true;
                this._randomList = MooSnowSDK.getAllConfig().checkBoxProbabilitys;
            }
        }
        clickHotAdItem(n) {
            var m = this.view.m_adHot["m_ad_" + n].data;
            if (!m)
                return;
            console.log("ad--", m);
            moosnow.platform.navigate2Mini(m, (res) => {
                console.log('跳转成功 ', res);
            }, (res) => {
                console.log('跳转失败 ', res);
                this.changeAdItem(n);
            });
        }
        changeAdItem(n) {
            var d = this.getRandomAdItem();
            if (!d)
                return;
            this.view.m_adHot["m_ad_" + n].data = d;
            this.view.m_adHot["m_ad_" + n].m_icon.url = d.img;
            this.view.m_adHot["m_ad_" + n].m_name.text = d.title;
        }
        hideADHot() {
            MooSnowSDK.hideBanner();
            ViewManager.instance.showADListView(1);
        }
        showView(s, c) {
            super.showView(s, c);
            this.view.m_continue_1.onClick(this, this.continueGame);
            this.view.m_continue_2.onClick(this, this.restartGame);
            this.view.m_continue_3.onClick(this, this.continueGameByVideo);
            this.view.m_return.onClick(this, this.returnHandle);
            this.view.m_abandon.onClick(this, this.abandonHandle);
            this.view.m_nextBtn.onClick(this, this.onNextHandle);
            this.view.m_gou.onClick(this, this.gouHandle);
            this.view.m_ad_1.m_list.on(fairygui.Events.CLICK_ITEM, this, this.onClickItem);
            this.view.m_ad_2.m_list.on(fairygui.Events.CLICK_ITEM, this, this.onClickItem);
            this.view.m_ad_1.m_list.y = 0;
            this.view.m_adHot.visible = false;
            if (GameManager.instance.platform == moosnow.APP_PLATFORM.WX) {
                this.showADList();
                MooSnowSDK.showBanner(false);
                this.view.m_ad_1.visible = this.view.m_ad_2.visible = true;
            }
            if (GameManager.instance.platform == moosnow.APP_PLATFORM.QQ) {
                MooSnowSDK.hideBanner();
                this.view.m_ad_1.visible = this.view.m_ad_2.visible = false;
                EventManager.instance.addNotice(GameEvent.CLOSE_APP_AD_BOX, this, this.closeAppBox);
            }
            if (GameManager.instance.platform == moosnow.APP_PLATFORM.BYTEDANCE) {
                MooSnowSDK.hideBanner();
                this.view.m_ad_1.visible = this.view.m_ad_2.visible = false;
                this.view.m_gou.selected = true;
            }
            if (GameManager.instance.platform == moosnow.APP_PLATFORM.VIVO || GameManager.instance.platform == moosnow.APP_PLATFORM.OPPO) {
                MooSnowSDK.hideBanner();
                this.view.m_ad_1.visible = this.view.m_ad_2.visible = false;
            }
        }
        closeAppBox() {
            MooSnowSDK.showBanner(false);
        }
        showHotAdList() {
            for (let i = 1; i <= 6; i++) {
                var d = this.getRandomAdItem();
                if (!d)
                    continue;
                this.view.m_adHot["m_ad_" + i].data = d;
                this.view.m_adHot["m_ad_" + i].m_icon.url = d.img;
                this.view.m_adHot["m_ad_" + i].m_name.text = d.title;
                this.view.m_adHot["m_ad_" + i].onClick(this, this.clickHotAdItem, [i]);
            }
        }
        updateView(type) {
            this.updateCoin();
            this.view.m_nativeAD.visible = false;
            this.view.m_oppoNative.visible = false;
            this.view.m_sanbei.visible = false;
            this.view.m_nextBtn2.visible = false;
            if (type == 3) {
                this.view.m_abandon.visible = false;
                Laya.timer.once(2000, this, this.showAbondon);
                if (GameManager.instance.platform == moosnow.APP_PLATFORM.WX)
                    ViewManager.instance.showADListView();
            }
            else if (type == 1) {
                if (GameManager.instance.platform == moosnow.APP_PLATFORM.WX) {
                    this.view.m_adHot.visible = true;
                    this.adList = GameManager.instance.adList.concat();
                    this.showHotAdList();
                }
                if (GameManager.instance.platform == moosnow.APP_PLATFORM.BYTEDANCE) {
                    this.view.m_ctl.selectedIndex = 3;
                    this._clickCount = 0;
                    if (this._checkBoxMistouch)
                        this.getRandomMisTouchIndex();
                }
            }
            if (GameManager.instance.platform == moosnow.APP_PLATFORM.VIVO || GameManager.instance.platform == moosnow.APP_PLATFORM.OPPO) {
                if (type == 3) {
                    this.view.m_nativeAD.m_ctl.selectedIndex = 1;
                    this.view.m_oppoNative.m_ctl.selectedIndex = 1;
                }
                else {
                    this.view.m_nativeAD.m_ctl.selectedIndex = 0;
                    this.view.m_oppoNative.m_ctl.selectedIndex = 0;
                    if (GameManager.instance.platform == moosnow.APP_PLATFORM.OPPO) {
                        this.view.m_continue_1.visible = false;
                        this.view.m_sanbei.visible = true;
                        this.view.m_sanbei.onClick(this, this.onSanBeiHandle);
                        Laya.timer.once(3000, this, () => {
                            this.view.m_nextBtn2.visible = true;
                            this.view.m_nextBtn2.onClick(this, this.continueGame);
                        });
                    }
                }
                var self = this;
                moosnow.platform.checkVersion("", (open) => {
                    if (open) {
                        moosnow.platform.showNativeAd((row) => {
                            if (row && row.imgUrlList && row.imgUrlList.length > 0) {
                                if (GameManager.instance.platform == moosnow.APP_PLATFORM.VIVO)
                                    self.showNativeAD(row);
                                else {
                                    self.showOppoNativeAD(row);
                                }
                            }
                        });
                    }
                });
            }
        }
        showNativeAD(row) {
            Laya.timer.once(500, this, () => {
                this.view.m_nativeAD.visible = true;
                this.view.m_nativeAD.m_close.onClick(this, this.onCloseHandle);
                this.view.m_nativeAD.m_see.onClick(this, this.onSeeHandle);
                this.view.m_nativeAD.m_pass.onClick(this, this.onSeeHandle);
                this.view.m_nativeAD.m_load.onClick(this, this.onSeeHandle);
                if (this._sdkData && this._sdkData.mx_native_click_switch && this._sdkData.mx_native_click_switch == 1) {
                    this.view.m_nativeAD.m_see.visible = false;
                    this.view.m_nativeAD.m_pass.visible = true;
                }
                else {
                    this.view.m_nativeAD.m_see.visible = true;
                    this.view.m_nativeAD.m_pass.visible = false;
                }
                Laya.loader.create(row.imgUrlList[0], Laya.Handler.create(this, (res) => {
                    if (res == null)
                        return;
                    this.view.m_nativeAD.m_load.url = row.imgUrlList[0];
                }));
            });
        }
        showOppoNativeAD(row) {
            Laya.timer.once(500, this, () => {
                this.view.m_oppoNative.visible = true;
                this.view.m_oppoNative.m_close.onClick(this, this.onCloseHandle);
                this.view.m_oppoNative.m_see.onClick(this, this.onSeeHandle);
                this.view.m_oppoNative.m_pass.onClick(this, this.onSeeHandle);
                this.view.m_oppoNative.m_load.onClick(this, this.onSeeHandle);
                if (this._sdkData && this._sdkData.mx_native_click_switch && this._sdkData.mx_native_click_switch == 1) {
                    this.view.m_oppoNative.m_see.visible = false;
                    this.view.m_oppoNative.m_pass.visible = true;
                }
                else {
                    this.view.m_oppoNative.m_see.visible = true;
                    this.view.m_oppoNative.m_pass.visible = false;
                }
                Laya.loader.create(row.imgUrlList[0], Laya.Handler.create(this, (res) => {
                    if (res == null)
                        return;
                    this.view.m_oppoNative.m_load.url = row.imgUrlList[0];
                }));
            });
        }
        onCloseHandle() {
            var r = Math.random() * 100;
            if (r <= this._sdkData.nativeAdCloseOpenV)
                MooSnowSDK.clickNative(this.hideNativeAD.bind(this));
            else
                this.hideNativeAD();
        }
        hideNativeAD() {
            this.view.m_nativeAD.visible = false;
            this.view.m_oppoNative.visible = false;
        }
        onSeeHandle() {
            MooSnowSDK.clickNative(this.hideNativeAD.bind(this));
        }
        showAbondon() {
            this.view.m_abandon.visible = true;
        }
        updateCoin() {
            this.view.m_coin.text = " " + GameManager.instance.roleInfo.curlvCoin + " ";
        }
        continueGame() {
            SoundManager.instance.playSound("btn_click");
            GameManager.instance.goFirstPage(true);
            MooSnowSDK.endGame(GameManager.instance.choiseLevel, true);
        }
        restartGame() {
            SoundManager.instance.playSound("btn_click");
            GameManager.instance.restartGame();
        }
        continueGameByVideo() {
            SoundManager.instance.playSound("btn_click");
            var v = GameManager.instance.createVideoData(VideoType.VIDEOTYPE_LIFE, VideoInfo.VIDEOINFO_LIFE);
            MooSnowSDK.showVideo(null, v);
        }
        abandonHandle() {
            SoundManager.instance.playSound("btn_click");
            GameManager.instance.goFirstPage(true);
            MooSnowSDK.endGame(GameManager.instance.choiseLevel, false);
        }
        onNextHandle() {
            if (this.view.m_gou.selected) {
                this.watchVideo();
            }
            else {
                this.continueGame();
            }
        }
        onSanBeiHandle() {
            var v = GameManager.instance.createVideoData(VideoType.VIDEOTYPE_TREBLE_COIN, VideoInfo.VIDEOTYPE_TREBLE_COIN);
            MooSnowSDK.showVideo(null, v, this.getTrebleCoin.bind(this));
        }
        getTrebleCoin() {
        }
        gouHandle() {
            if (this._checkBoxMistouch) {
                if (this._clickCount == this._misTouchIndex) {
                    this.watchVideo();
                }
                this._clickCount++;
            }
        }
        watchVideo() {
            var v = GameManager.instance.createVideoData(VideoType.VIDEOTYPE_DOUBLE_COIN, VideoInfo.VIDEOINFO_DOUBLE_COIN);
            MooSnowSDK.showVideo(null, v);
        }
        returnHandle() {
            SoundManager.instance.playSound("btn_click");
            GameManager.instance.goFirstPage(true);
        }
        showADList() {
            if (GameManager.instance.adList.length < 1)
                return;
            if (GameManager.instance.platform != moosnow.APP_PLATFORM.WX)
                return;
            EventManager.instance.offNotice(GameEvent.SHOW_AD_LIST, this, this.showADList);
            Laya.Tween.clearTween(this.view.m_ad_1.m_list);
            this.view.m_ad_1.m_list.numItems = GameManager.instance.adList.length;
            this.view.m_ad_2.m_list.numItems = GameManager.instance.adListRever.length;
            this.view.m_ad_1.m_list.height = this.view.m_ad_2.m_list.height = 311 * GameManager.instance.adList.length + 2;
            this.adMoveUp();
        }
        onClickItem(e) {
            var m = e.data;
            console.log("ad--", m);
            moosnow.platform.navigate2Mini(m, (res) => {
                console.log('跳转成功 ', res);
            }, (res) => {
                console.log('跳转失败 ', res);
                ViewManager.instance.showADListView();
            });
        }
        setADItem1(index, item) {
            var d = GameManager.instance.adList[index];
            if (!d)
                return;
            item.data = d;
            item.m_icon.url = d.img;
            item.m_name.text = d.title;
        }
        setADItem2(index, item) {
            var d = GameManager.instance.adListRever[index];
            if (!d)
                return;
            item.data = d;
            item.m_icon.url = d.img;
            item.m_name.text = d.title;
        }
        adMoveDown() {
            this._tweenNum = Laya.Tween.to(this.view.m_ad_1.m_list, { y: 0 }, GameManager.instance.adTime, null, Laya.Handler.create(this, this.adMoveUp));
            this._tweenNum.update = Laya.Handler.create(this, this.updateTween, null, false);
        }
        adMoveUp() {
            this._tweenNum = Laya.Tween.to(this.view.m_ad_1.m_list, { y: this.view.m_ad_1.height - 311 * GameManager.instance.adList.length }, GameManager.instance.adTime, null, Laya.Handler.create(this, this.adMoveDown));
            this._tweenNum.update = Laya.Handler.create(this, this.updateTween, null, false);
        }
        updateTween() {
            this.view.m_ad_2.m_list.y = this.view.m_ad_1.m_list.y;
        }
        hideAllView() {
            super.hideAllView();
            this.view.m_continue_1.offClick(this, this.continueGame);
            this.view.m_continue_2.offClick(this, this.restartGame);
            this.view.m_continue_3.offClick(this, this.continueGameByVideo);
            this.view.m_return.offClick(this, this.returnHandle);
            this.view.m_abandon.offClick(this, this.abandonHandle);
            this.view.m_nextBtn.offClick(this, this.onNextHandle);
            this.view.m_gou.offClick(this, this.gouHandle);
            this.view.m_nativeAD.m_close.offClick(this, this.onCloseHandle);
            this.view.m_nativeAD.m_see.offClick(this, this.onSeeHandle);
            this.view.m_nativeAD.m_pass.offClick(this, this.onSeeHandle);
            this.view.m_nativeAD.m_load.offClick(this, this.onSeeHandle);
            this.view.m_oppoNative.m_close.offClick(this, this.onCloseHandle);
            this.view.m_oppoNative.m_see.offClick(this, this.onSeeHandle);
            this.view.m_oppoNative.m_pass.offClick(this, this.onSeeHandle);
            this.view.m_oppoNative.m_load.offClick(this, this.onSeeHandle);
            this.view.m_sanbei.offClick(this, this.onSanBeiHandle);
            this.view.m_nextBtn2.offClick(this, this.continueGame);
            this.view.m_ad_1.m_list.off(fairygui.Events.CLICK_ITEM, this, this.onClickItem);
            this.view.m_ad_2.m_list.off(fairygui.Events.CLICK_ITEM, this, this.onClickItem);
            Laya.Tween.clearTween(this.view.m_ad_1.m_list);
            if (GameManager.instance.platform == moosnow.APP_PLATFORM.WX) {
                MooSnowSDK.hideBanner();
            }
            for (let i = 1; i <= 6; i++) {
                this.view.m_adHot["m_ad_" + i].offClick(this, this.clickHotAdItem, [i]);
            }
            EventManager.instance.offNotice(GameEvent.CLOSE_APP_AD_BOX, this, this.closeAppBox);
        }
        getRandomAdItem() {
            if (this.adList.length > 0) {
            }
            else {
                this.adList = GameManager.instance.adList.concat();
            }
            var n = Math.floor(Math.random() * this.adList.length);
            var d = this.adList.splice(n, 1)[0];
            console.log("d---", d);
            return d;
        }
        getRandomMisTouchIndex() {
            var arr = [];
            var idx = 0;
            for (var i = 0; i < this._randomList.length; i++) {
                var num = this._randomList[i];
                for (var j = 0; j < num; j++)
                    arr.push(idx);
                idx++;
            }
            if (arr.length > 0)
                this._misTouchIndex = arr[Math.floor(Math.random() * arr.length)];
            else
                this._misTouchIndex = 1000000;
        }
    }

    class WXFUI_BeforeWar extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "BeforeWar"));
        }
        onConstruct() {
            this.m_bg = (this.getChild("bg"));
            this.m_item_1 = (this.getChild("item_1"));
            this.m_item_2 = (this.getChild("item_2"));
            this.m_item_3 = (this.getChild("item_3"));
            this.m_item_4 = (this.getChild("item_4"));
            this.m_enter = (this.getChild("enter"));
            this.m_n17 = (this.getChild("n17"));
            this.m_ad = (this.getChild("ad"));
            this.m_n19 = (this.getChild("n19"));
            this.m_n20 = (this.getChild("n20"));
            this.m_n21 = (this.getChild("n21"));
            this.m_coin = (this.getChild("coin"));
            this.m_bulletNum = (this.getChild("bulletNum"));
            this.m_bombNum = (this.getChild("bombNum"));
        }
    }
    WXFUI_BeforeWar.URL = "ui://bq3h5insdr1tnl";

    class BeforeWar extends PopUpView {
        constructor() { super(); }
        createView() {
            this.view = WXFUI_BeforeWar.createInstance();
            this.view.m_enter.onClick(this, this.enterGame);
            this.shopData = GameManager.instance.levelData.shop;
            this.view.m_item_1.visible = this.view.m_item_2.visible = this.view.m_item_3.visible = this.view.m_item_4.visible = false;
            var index = 0;
            for (const key in this.shopData) {
                if (this.shopData.hasOwnProperty(key)) {
                    index++;
                    var d = this.shopData[key];
                    this.view["m_item_" + index].m_ani.setAutoPlay(true, -1);
                    this.view["m_item_" + index].visible = true;
                    this.view["m_item_" + index].m_coin.text = d.coin + "";
                    this.view["m_item_" + index].m_info.text = d.name;
                    this.view["m_item_" + index].m_icon.url = "ui://Game/goods_" + d.type;
                    this.view["m_item_" + index].m_buy.onClick(this, this.buyItem, [d]);
                    this.view["m_item_" + index].m_free.onClick(this, this.buyItemByFree, [d]);
                }
            }
            if (GameManager.instance.platform == moosnow.APP_PLATFORM.QQ) {
                this.view.m_ad.m_list.visible = false;
            }
            else if (GameManager.instance.platform == moosnow.APP_PLATFORM.WX) {
                this.view.m_ad.m_list.visible = true;
                this.view.m_ad.m_list.itemRenderer = Laya.Handler.create(this, this.setADItem, null, false);
                this.view.m_ad.m_list.on(fairygui.Events.CLICK_ITEM, this, this.onClickItem);
                EventManager.instance.addNotice(GameEvent.SHOW_AD_LIST, this, this.showADList);
            }
            else if (GameManager.instance.platform == moosnow.APP_PLATFORM.BYTEDANCE) {
                this.view.m_ad.m_list.visible = false;
            }
            else if (GameManager.instance.platform == moosnow.APP_PLATFORM.VIVO || GameManager.instance.platform == moosnow.APP_PLATFORM.OPPO) {
                this.view.m_ad.m_list.visible = false;
            }
        }
        showView(s, c) {
            super.showView(s, c);
            this.view.m_ad.m_list.x = 0;
            this.showADList();
            this.updateView();
        }
        buyItem(d) {
            SoundManager.instance.playSound("btn_press");
            if (GameManager.instance.roleInfo.totalCoin < d.coin) {
                ViewManager.instance.showTipsView("金币不足！");
                return;
            }
            else {
                ViewManager.instance.showTipsView("金币-" + d.coin);
                GameManager.instance.roleInfo.totalCoin -= d.coin;
                GameManager.instance.buyShopItem(d);
                this.updateView();
            }
        }
        updateView() {
            this.view.m_coin.text = GameManager.instance.roleInfo.totalCoin + "";
            this.view.m_bulletNum.text = GameManager.instance.buyBullet + "";
            this.view.m_bombNum.text = GameManager.instance.buyGre + "";
        }
        buyItemByFree(d) {
            SoundManager.instance.playSound("btn_press");
            var v = GameManager.instance.createVideoData(VideoType.VIDEOTYPE_ITEM, VideoInfo.VIDEOINFO_ITEM);
            MooSnowSDK.showVideo(d, v);
        }
        enterGame() {
            SoundManager.instance.playSound("btn_click");
            ViewManager.instance.hidePopUpView(this, true);
            if (GameManager.instance.platform == moosnow.APP_PLATFORM.QQ) {
                if (MooSnowSDK.misTouchNum == 0) {
                    GameManager.instance.enterGame();
                }
                else if (MooSnowSDK.misTouchNum > 0) {
                    GameManager.instance.misTouchNum++;
                    if (GameManager.instance.misTouchNum >= MooSnowSDK.misTouchNum) {
                        GameManager.instance.misTouchNum = 0;
                        ViewManager.instance.showQQWuChuView(1);
                    }
                    else {
                        GameManager.instance.enterGame();
                    }
                }
            }
            else if (GameManager.instance.platform == moosnow.APP_PLATFORM.WX) {
                GameManager.instance.enterGame();
            }
            else if (GameManager.instance.platform == moosnow.APP_PLATFORM.BYTEDANCE) {
                GameManager.instance.enterGame();
            }
            else {
                GameManager.instance.enterGame();
            }
        }
        showADList() {
            if (GameManager.instance.adList.length < 1)
                return;
            if (GameManager.instance.platform != moosnow.APP_PLATFORM.WX)
                return;
            EventManager.instance.offNotice(GameEvent.SHOW_AD_LIST, this, this.showADList);
            this.view.m_ad.m_list.width = 136 * GameManager.instance.adList.length;
            this.view.m_ad.m_list.numItems = GameManager.instance.adList.length;
            Laya.Tween.clearTween(this.view.m_ad.m_list);
            this.adMoveLeft();
        }
        setADItem(index, item) {
            var d = GameManager.instance.adList[index];
            if (!d)
                return;
            item.data = d;
            item.m_icon.url = d.img;
            item.m_name.text = d.title;
        }
        onClickItem(e) {
            var m = e.data;
            console.log("ad--", m);
            moosnow.platform.navigate2Mini(m, (res) => {
                console.log('跳转成功 ', res);
            }, (res) => {
                console.log('跳转失败 ', res);
                ViewManager.instance.showADListView();
            });
        }
        adMoveLeft() {
            Laya.Tween.to(this.view.m_ad.m_list, { x: this.view.m_ad.width - 136 * GameManager.instance.adList.length }, GameManager.instance.adTime, null, Laya.Handler.create(this, this.adMoveRight));
        }
        adMoveRight() {
            Laya.Tween.to(this.view.m_ad.m_list, { x: 0 }, GameManager.instance.adTime, null, Laya.Handler.create(this, this.adMoveLeft));
        }
        hideAllView() {
            super.hideAllView();
            Laya.Tween.clearTween(this.view.m_ad.m_list);
        }
    }

    class WXFUI_ADListView extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "ADListView"));
        }
        onConstruct() {
            this.m_ctl = this.getController("ctl");
            this.m_n6 = (this.getChild("n6"));
            this.m_ad_1 = (this.getChild("ad_1"));
            this.m_ad_2 = (this.getChild("ad_2"));
            this.m_jixu = (this.getChild("jixu"));
            this.m_n12 = (this.getChild("n12"));
            this.m_time = (this.getChild("time"));
        }
    }
    WXFUI_ADListView.URL = "ui://bq3h5insvmpqxua";

    class ADListView extends PopUpView {
        constructor() {
            super();
            this.floor = 0;
            this.ceil = 0;
            this.type = 0;
            this.timer = 4;
        }
        createView() {
            this.view = WXFUI_ADListView.createInstance();
            this.view.m_jixu.onClick(this, this.continueGame);
            this.view.m_time.text = " 0";
            this.view.m_ad_1.m_list.itemRenderer = Laya.Handler.create(this, this.setADItem1, null, false);
            this.view.m_ad_2.m_list.itemRenderer = Laya.Handler.create(this, this.setADItem2, null, false);
            this.view.m_ad_1.m_list.on(fairygui.Events.CLICK_ITEM, this, this.onClickItem);
            this.view.m_ad_2.m_list.on(fairygui.Events.CLICK_ITEM, this, this.onClickItem);
            EventManager.instance.addNotice(GameEvent.SHOW_AD_LIST, this, this.showADList);
        }
        showView(s, c) {
            super.showView(s, c);
            var pro = ViewManager.instance.getProportion();
            if (pro > 0)
                this.view.m_n6.setScale(1 + pro, 1 + pro);
            this.view.m_ad_1.m_list.x = this.view.m_ad_2.m_list.x = 0;
            this.showADList();
            this.view.m_ctl.selectedIndex = 0;
            this.timer = 4;
            this.showTxt();
            this.showTimer();
            this.adMoveLeft();
            var d = MooSnowSDK.getAllConfig();
            if (d && d.exportAutoNavigate && d.exportAutoNavigate != 0) {
                this.gotoRandomGame();
            }
        }
        showTimer() {
            Laya.timer.loop(1000, this, this.showTxt);
        }
        showTxt() {
            this.timer--;
            if (this.timer <= 0) {
                this.view.m_ctl.selectedIndex = 1;
                Laya.timer.clear(this, this.showTxt);
            }
            this.view.m_time.text = this.timer + "";
        }
        continueGame() {
            SoundManager.instance.playSound("btn_click");
            ViewManager.instance.adListView.hideAllView();
            if (this.type == 1) {
                GameManager.instance.goFirstPage();
            }
        }
        showADList() {
            if (GameManager.instance.adList.length < 1)
                return;
            EventManager.instance.offNotice(GameEvent.SHOW_AD_LIST, this, this.showADList);
            this.view.m_ad_1.m_list.width = 240 * GameManager.instance.adList.length;
            this.view.m_ad_2.m_list.width = 240 * GameManager.instance.adList.length;
            this.view.m_ad_1.m_list.numItems = GameManager.instance.adList.length;
            this.view.m_ad_2.m_list.numItems = GameManager.instance.adList.length;
            this.view.m_ad_2.m_list.x = this.view.m_ad_1.m_list.x = 0;
        }
        onClickItem(e) {
            var m = e.data;
            console.log("ad--", m);
            if (!m)
                return;
            moosnow.platform.navigate2Mini(m, (res) => {
                console.log('跳转成功 ', res);
            }, (res) => {
                console.log('跳转失败 ', res);
            });
        }
        setADItem1(index, item) {
            var d = GameManager.instance.adOriList[index];
            if (!d)
                return;
            item.data = d;
            item.m_icon.url = d.img;
            item.m_name.text = d.title;
        }
        setADItem2(index, item) {
            var d = GameManager.instance.adListRever[index];
            if (!d)
                return;
            item.data = d;
            item.m_icon.url = d.img;
            item.m_name.text = d.title;
        }
        adMoveLeft() {
            this._tweenNum = Laya.Tween.to(this.view.m_ad_1.m_list, { x: this.view.m_ad_1.width - 240 * GameManager.instance.adOriList.length }, GameManager.instance.adTime, null, Laya.Handler.create(this, this.adMoveRight));
            this._tweenNum.update = Laya.Handler.create(this, this.updateTween, null, false);
        }
        adMoveRight() {
            this._tweenNum = Laya.Tween.to(this.view.m_ad_1.m_list, { x: 0 }, GameManager.instance.adTime, null, Laya.Handler.create(this, this.adMoveLeft));
            this._tweenNum.update = Laya.Handler.create(this, this.updateTween, null, false);
        }
        updateTween() {
            this.view.m_ad_2.m_list.x = this.view.m_ad_1.m_list.x;
        }
        hideAllView() {
            super.hideAllView();
            Laya.Tween.clearTween(this.view.m_ad_1.m_list);
            Laya.timer.clearAll(this);
        }
        gotoRandomGame() {
            var n = Math.floor(Math.random() * GameManager.instance.adList.length);
            var d = GameManager.instance.adList[n];
            if (!d)
                return;
            moosnow.platform.navigate2Mini(d, (res) => {
                console.log('跳转成功 ', res);
            }, (res) => {
                console.log('跳转失败 ', res);
            });
        }
    }

    class PlayerSanBullet {
        constructor() {
            this.bulletType = 1;
            this.direction = 1;
            this.bulletIndex = 0;
        }
        createView(type, dir, index) {
            this.bulletType = type;
            this.direction = dir;
            this.bulletIndex = index;
            this.view = fairygui.UIPackage.createObject("Game", "sandan");
            this.view.m_zidan.url = "ui://Game/playerzidan" + this.bulletType;
            this.scene = new ui.BulletSanUI();
            this.loadComplete();
        }
        loadComplete() {
            ViewManager.instance.warView.scene.addChild(this.scene);
            this.scene.addComponent(BulletBody);
            this.body = this.scene.getComponent(Laya.RigidBody);
            this.box = this.scene.getComponent(Laya.BoxCollider);
            this.box.label = this.body.label = "PlayerBullet" + this.bulletType;
            this.setBulletPos();
            EventManager.instance.addNotice(GameEvent.CLEAR_WAR_VIEW, this, this.disposeAll);
            EventManager.instance.addNotice(GameEvent.BULLET_DISPOSE, this, this.disposeBullet);
            EventManager.instance.addNotice(GameEvent.PLAYER_BULLET_HIT_ENEMY, this, this.hitEnemy);
            EventManager.instance.addNotice(GameEvent.PLAYER_BULLET_HIT_OBSTACLE, this, this.hitEnemy);
        }
        hitEnemy(s) {
            if (s.s == this.box.owner) {
                this.body.setVelocity({ x: 0, y: 0 });
                this.view.m_zidan.url = "ui://Game/bulletDisAni";
                this.view.m_zidan.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.disposeAll));
            }
        }
        disposeAll() {
            EventManager.instance.offNotice(GameEvent.CLEAR_WAR_VIEW, this, this.disposeAll);
            EventManager.instance.offNotice(GameEvent.BULLET_DISPOSE, this, this.disposeBullet);
            EventManager.instance.offNotice(GameEvent.PLAYER_BULLET_HIT_ENEMY, this, this.hitEnemy);
            EventManager.instance.offNotice(GameEvent.PLAYER_BULLET_HIT_OBSTACLE, this, this.hitEnemy);
            if (this.scene) {
                this.scene.removeSelf();
            }
            this.view.dispose();
            Laya.Pool.recover("PlayerSanBullet", this);
        }
        disposeBullet(s) {
            if (s == this.body.owner) {
                this.disposeAll();
            }
        }
        setBulletPos() {
            var p = this.getBulletOffSetPos(this.direction);
            var c = ViewManager.instance.rolePlayer.roleBody.getWorldCenter();
            this.scene.addChild(this.view.displayObject);
            var b = this.scene.getComponent(BulletBody);
            b.onAwake();
            this.scene.x = c.x + p.x;
            this.scene.y = c.y + p.y;
            if (this.direction > 0) {
                if (this.direction == 4) {
                    if (this.bulletIndex == 0) {
                        this.body.setVelocity({ x: -2, y: -10 });
                    }
                    else if (this.bulletIndex == 1) {
                        this.body.setVelocity({ x: 0, y: -10 });
                    }
                    else if (this.bulletIndex == 2) {
                        this.body.setVelocity({ x: 2, y: -10 });
                    }
                }
                else if (this.direction == 3) {
                    if (this.bulletIndex == 0) {
                        this.body.setVelocity({ x: 11, y: -11 });
                    }
                    else if (this.bulletIndex == 1) {
                        this.body.setVelocity({ x: 11, y: -9 });
                    }
                    else if (this.bulletIndex == 2) {
                        this.body.setVelocity({ x: 11, y: -7 });
                    }
                }
                else {
                    if (this.bulletIndex == 0) {
                        this.body.setVelocity({ x: 12, y: -2 });
                    }
                    else if (this.bulletIndex == 1) {
                        this.body.setVelocity({ x: 12, y: 0 });
                    }
                    else if (this.bulletIndex == 2) {
                        this.body.setVelocity({ x: 12, y: 2 });
                    }
                }
            }
            else {
                if (this.direction == -4) {
                    if (this.bulletIndex == 0) {
                        this.body.setVelocity({ x: -2, y: -10 });
                    }
                    else if (this.bulletIndex == 1) {
                        this.body.setVelocity({ x: 0, y: -10 });
                    }
                    else if (this.bulletIndex == 2) {
                        this.body.setVelocity({ x: 2, y: -10 });
                    }
                }
                else if (this.direction == -3) {
                    if (this.bulletIndex == 0) {
                        this.body.setVelocity({ x: -11, y: -11 });
                    }
                    else if (this.bulletIndex == 1) {
                        this.body.setVelocity({ x: -11, y: -9 });
                    }
                    else if (this.bulletIndex == 2) {
                        this.body.setVelocity({ x: -11, y: -7 });
                    }
                }
                else {
                    if (this.bulletIndex == 0) {
                        this.body.setVelocity({ x: -12, y: -2 });
                    }
                    else if (this.bulletIndex == 1) {
                        this.body.setVelocity({ x: -12, y: 0 });
                    }
                    else if (this.bulletIndex == 2) {
                        this.body.setVelocity({ x: -12, y: 2 });
                    }
                }
            }
        }
        getBulletOffSetPos(d) {
            var p = new Laya.Point();
            if (d == 1) {
                p.x = 75;
                p.y = -20;
            }
            else if (d == -1) {
                p.x = -100;
                p.y = -20;
            }
            else if (d == 4) {
                p.x = -20;
                p.y = -120;
            }
            else if (d == -4) {
                p.x = 0;
                p.y = -120;
            }
            else if (d == 3) {
                p.x = 50;
                p.y = -100;
            }
            else if (d == -3) {
                p.x = -65;
                p.y = -100;
            }
            else if (d == 5) {
                p.x = 75;
                p.y = -3;
            }
            else if (d == -5) {
                p.x = -105;
                p.y = -3;
            }
            return p;
        }
    }

    class Shake {
        constructor() {
            this._isShaking = false;
            this._startTime = 0;
            this._offsetPos = [0, 0];
            this.shank_I = 0;
            this._orgX = 0;
            this._orgY = 0;
        }
        exe(target, intensity, duration, radius) {
            if (this._isShaking) {
                return;
            }
            this._isShaking = true;
            this._startTime = Laya.timer.currTimer;
            this._offsetPos = [0, 0];
            this.shank_I = 0;
            this._target = target;
            this._orgX = target.x;
            this._orgY = target.y;
            Laya.timer.loop(intensity, this, this._pos, [duration, radius]);
        }
        _pos(duration, radius) {
            this._offsetPos[this.shank_I % 2] = (this._offsetPos[this.shank_I % 2] > 0) ? -radius : radius;
            this.shank_I++;
            this._target.x += this._offsetPos[0];
            this._target.y += this._offsetPos[1];
            if (Laya.timer.currTimer - this._startTime >= duration) {
                Laya.timer.clear(this, this._pos);
                this.shank_I = 0;
                this._isShaking = false;
                this._target.x = this._orgX;
                this._target.y = this._orgY;
                this._target = null;
            }
        }
    }

    class WXFUI_freeView extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "freeView"));
        }
        onConstruct() {
            this.m_ctl = this.getController("ctl");
            this.m_n25 = (this.getChild("n25"));
            this.m_n27 = (this.getChild("n27"));
            this.m_n28 = (this.getChild("n28"));
            this.m_gou = (this.getChild("gou"));
            this.m_n30 = (this.getChild("n30"));
            this.m_lingqu = (this.getChild("lingqu"));
            this.m_fangqi = (this.getChild("fangqi"));
            this.m_cha = (this.getChild("cha"));
        }
    }
    WXFUI_freeView.URL = "ui://bq3h5insk6saxwm";

    class FreeView extends PopUpView {
        constructor() {
            super();
            this._checkBoxMistouch = false;
            this._clickCount = 0;
            this._randomList = [];
        }
        createView() {
            this.view = WXFUI_freeView.createInstance();
            var sdkData = MooSnowSDK.getAllConfig();
            if (sdkData && sdkData.checkBoxMistouch != "0") {
                this._checkBoxMistouch = true;
                this._randomList = MooSnowSDK.getAllConfig().checkBoxProbabilitys;
            }
        }
        showView(s, c) {
            super.showView(s, c);
            this.updateView();
        }
        updateView() {
            this.view.m_ctl.selectedIndex = 0;
            this._clickCount = 0;
            if (this._checkBoxMistouch)
                this.getRandomMisTouchIndex();
            this.view.m_gou.selected = true;
            this.view.m_cha.visible = false;
            this.view.m_lingqu.onClick(this, this.lingquHandle);
            this.view.m_gou.onClick(this, this.gouHandle);
            this.view.m_fangqi.onClick(this, this.fangqiHandle);
            this.view.m_cha.onClick(this, this.closeHandle);
        }
        showFangQiBtn() {
            Laya.timer.clear(this, this.showCloseBtn);
            this.view.m_ctl.selectedIndex = 1;
            Laya.timer.once(3000, this, this.showCloseBtn);
        }
        showLingQuBtn() {
            this.view.m_ctl.selectedIndex = 0;
            Laya.timer.clear(this, this.showCloseBtn);
        }
        showCloseBtn() {
            this.view.m_cha.visible = true;
        }
        gouHandle() {
            if (this._checkBoxMistouch) {
                if (this._clickCount == this._misTouchIndex) {
                    this.watchVideo();
                }
                else {
                    if (!this.view.m_gou.selected) {
                        this.showFangQiBtn();
                    }
                    else {
                        this.showLingQuBtn();
                    }
                }
                this._clickCount++;
            }
            else {
                if (!this.view.m_gou.selected) {
                    this.showFangQiBtn();
                }
                else {
                    this.showLingQuBtn();
                }
            }
        }
        lingquHandle() {
            this.watchVideo();
        }
        closeHandle() {
            this.enterGame();
        }
        fangqiHandle() {
            if (MooSnowSDK.misTouchNum == 0) {
                this.enterGame();
            }
            else if (MooSnowSDK.misTouchNum > 0) {
                GameManager.instance.misTouchNum++;
                if (GameManager.instance.misTouchNum >= MooSnowSDK.misTouchNum) {
                    GameManager.instance.misTouchNum = 0;
                    this.watchVideo();
                }
                else {
                }
            }
        }
        enterGame() {
            Laya.timer.clear(this, this.showCloseBtn);
            SoundManager.instance.playSound("btn_click");
            ViewManager.instance.hidePopUpView(this, true);
            GameManager.instance.enterGame();
        }
        watchVideo() {
            if (!this.view.m_gou.selected) {
                this.showFangQiBtn();
            }
            else {
                this.showLingQuBtn();
            }
            Laya.timer.clear(this, this.showCloseBtn);
            var d = GameManager.instance.levelData.shop["item_4"];
            var v = GameManager.instance.createVideoData(VideoType.VIDEOTYPE_ITEM, VideoInfo.VIDEOINFO_ITEM);
            MooSnowSDK.showVideo(d, v, this.enterGame.bind(this), null, null, this.timeShowCloseBtn.bind(this));
        }
        timeShowCloseBtn() {
            console.log("timeShowCloseBtn-");
            Laya.timer.clear(this, this.showCloseBtn);
            if (!this.view.m_gou.selected)
                Laya.timer.once(3000, this, this.showCloseBtn);
        }
        hideAllView() {
            super.hideAllView();
            Laya.timer.clear(this, this.showCloseBtn);
            this.view.m_lingqu.offClick(this, this.lingquHandle);
            this.view.m_gou.offClick(this, this.gouHandle);
            this.view.m_fangqi.offClick(this, this.fangqiHandle);
            this.view.m_cha.offClick(this, this.closeHandle);
        }
        getRandomMisTouchIndex() {
            var arr = [];
            var idx = 0;
            for (var i = 0; i < this._randomList.length; i++) {
                var num = this._randomList[i];
                for (var j = 0; j < num; j++)
                    arr.push(idx);
                idx++;
            }
            if (arr.length > 0)
                this._misTouchIndex = arr[Math.floor(Math.random() * arr.length)];
            else
                this._misTouchIndex = 1000000;
        }
    }

    class ViewManager {
        constructor() {
            this.bulletArr = [];
            this.enemyArr = [];
            this.isChecking = false;
            this.warAllView = [];
            this.addDamageArr = [];
            this.addGoodsArr = [];
            this.curPopView = [];
            this.playerBulletPos = {
                "11": [65, -5],
                "12": [70, -10],
                "13": [30, 80],
                "21": [125, 25],
                "22": [115, 70],
                "23": [50, 5],
                "31": [55, -95],
                "32": [50, -110],
                "33": [25, 130],
                "41": [-35, -135],
                "42": [-35, -135],
                "43": [50, 200],
                "51": [65, 15],
                "52": [65, 15],
                "53": [30, 95],
                "14": [40, -30],
                "-11": [-145, -5],
                "-12": [-145, -10],
                "-13": [235, 85],
                "-14": [-60, -30],
                "-21": [-190, 20],
                "-22": [-180, 15],
                "-23": [250, 20],
                "-31": [-105, -90],
                "-32": [-100, -90],
                "-33": [255, 130],
                "-41": [-20, -135],
                "-42": [-20, -135],
                "-43": [70, 200],
                "-51": [-170, 17],
                "-52": [-175, 15],
                "-53": [245, 100],
            };
            this.enemyBulletPos = {
                "11": [105, 10],
                "12": [10, -40],
                "13": [125, 15],
                "15": [70, -20],
                "16": [130, 0],
                "111": [-25, 15],
                "112": [-5, 25],
                "113": [-75, 15],
                "114": [-35, 15],
                "-11": [-100, 10],
                "-12": [0, -50],
                "-13": [-75, 15],
                "-15": [0, -20],
                "-16": [-20, 0],
                "-111": [0, 15],
                "-112": [-50, 30],
                "-113": [20, 20],
                "-114": [-20, 10],
            };
        }
        static get instance() {
            if (this._instance == null)
                this._instance = new ViewManager();
            return this._instance;
        }
        addStageSizeChange() {
            Laya.stage.on(Laya.Event.RESIZE, this, this.changeSize);
        }
        changeSize() {
            EventManager.instance.dispatcherEvt(GameEvent.CHANGE_SIZE);
        }
        createLoaningView() {
            this.loadingView = WXFUI_loadingView.createInstance();
            this.loadingView.m_bar.text = "0%";
            this.loadingView.m_bar.value = 0;
            Laya.stage.addChild(fairygui.GRoot.inst.displayObject);
            this.loadingView.x = this.getLayoutWidth();
            fairygui.GRoot.inst.addChild(this.loadingView);
        }
        setLoadongProgress(p) {
            this.loadingView.m_bar.m_title.text = Math.ceil(p * 100) + "%";
            this.loadingView.m_bar.value = p * 100;
        }
        hideLoadingView() {
            fairygui.GRoot.inst.removeChild(this.loadingView);
        }
        createPlayer() {
            if (!this.player) {
                this.player = new Player();
                this.player.createView();
            }
            else {
                this.player.resetData();
            }
        }
        createWarView() {
            if (this.warView)
                this.warView.dispose();
            this.warView = Laya.Pool.getItemByClass("warView", WarView);
            this.warView.createView();
            this.showPlayerCtlView();
            this.showPlayerInfoView();
            this.showADBtn();
        }
        showADBtn() {
            if (GameManager.instance.platform == moosnow.APP_PLATFORM.QQ) {
                Laya.timer.clear(this, this.clearBanner);
                if (!this.adBtn2)
                    this.adBtn2 = fairygui.UIPackage.createObject("Game", "ADremen");
                this.adBtn2.x = 80;
                this.adBtn2.y = 250;
                fairygui.GRoot.inst.addChild(this.adBtn2);
                this.adBtn2.onClick(this, this.showADListView);
                this.adBtn2.m_ani_2.play(null, -1);
                if (GameManager.instance.platform == moosnow.APP_PLATFORM.QQ) {
                    MooSnowSDK.showBanner(false);
                    Laya.timer.once(2500, this, this.clearBanner);
                }
            }
            else if (GameManager.instance.platform == moosnow.APP_PLATFORM.WX) {
                if (!this.adBtn)
                    this.adBtn = fairygui.UIPackage.createObject("Game", "ADremen2");
                this.adBtn.x = 80;
                this.adBtn.y = 250;
                fairygui.GRoot.inst.addChild(this.adBtn);
                this.adBtn.onClick(this, this.showADListView);
                this.adBtn.m_ani.play(null, -1);
            }
        }
        clearBanner() {
            MooSnowSDK.hideBanner();
        }
        createBomb(type, dir, parentPos, b) {
            var bomb = Laya.Pool.getItemByClass("bombView", BombView);
            if (b)
                bomb.createView(BombData.BOMB_MY_GRE, dir, parentPos, b, this.getPlayerBulletOffSetPos(dir, 4));
            else
                bomb.createView(type, dir, parentPos, false, this.getEnemyBulletOffSetPos(dir, type));
        }
        createChopperBomb(type, parentPos, s) {
            var bomb = Laya.Pool.getItemByClass("ChopperBomb", ChopperBomb);
            bomb.createView(type, null, parentPos, null, s);
        }
        createBullet() {
            var b = Laya.Pool.getItemByClass("PlayerBullet", PlayerBullet);
            b.createView(this.rolePlayer.weaponType, this.rolePlayer.faceType);
            return b;
        }
        createSanBullet() {
            for (let i = 0; i < 3; i++) {
                var b = Laya.Pool.getItemByClass("PlayerSanBullet", PlayerSanBullet);
                b.createView(this.rolePlayer.weaponType, this.rolePlayer.faceType, i);
            }
        }
        createEnemyBullet(type, dir, s) {
            var b = Laya.Pool.getItemByClass("enemyBullet", EnemyBullet);
            b.createView(type, dir, s);
        }
        createObstacle(d) {
            var b = Laya.Pool.getItemByClass("obstacle", ObstacleView);
            b.createView(d);
        }
        createEnemy(d) {
            var b = Laya.Pool.getItemByClass("enemy", Enemy);
            b.createView(d);
            return b;
        }
        createChopper(d) {
            var b = Laya.Pool.getItemByClass("chopper", Chopper);
            b.createView(d);
            return b;
        }
        createTank(d) {
            var b = Laya.Pool.getItemByClass("tank", Tank);
            b.createView(d);
            return b;
        }
        createHostage(d) {
            var b = Laya.Pool.getItemByClass("hostage", HostageView);
            b.createView(d);
            return b;
        }
        createGoods(type, s) {
            var b = Laya.Pool.getItemByClass("goods", GoodsView);
            b.createView(type, s);
        }
        createDamageView(d, s) {
            var b = Laya.Pool.getItemByClass("damageView", DamageView);
            b.createView(d, s);
            this.addDamageArr.push(b);
        }
        createAddGold(goodsType, d, isBox = false) {
            var b = Laya.Pool.getItemByClass("addGold", AddGold);
            b.createView(goodsType, d, this.rolePlayer.roleSprite, isBox);
            this.addGoodsArr.push(b);
        }
        clearAddGold() {
            for (let i = 0; i < this.addGoodsArr.length; i++) {
                var e = this.addGoodsArr[i];
                if (e && e.view && e.view.displayObject.parent) {
                    e.view.displayObject.parent.removeChild(e.view.displayObject);
                }
            }
            for (let j = 0; j < this.addDamageArr.length; j++) {
                var k = this.addDamageArr[j];
                if (k && k.view && k.view.parent) {
                    k.view.displayObject.parent.removeChild(k.view.displayObject);
                }
            }
        }
        showPlayerPanBody() {
        }
        hidePlayerPanBody() {
            if (this.playerPan)
                this.player.roleSprite.removeChild(this.playerPan.scene);
        }
        showPlayerInfoView() {
            if (!this.playerInfoView)
                this.playerInfoView = new PlayerInfoView();
            this.playerInfoView.updateAllView();
            fairygui.GRoot.inst.addChild(this.playerInfoView.view);
        }
        showPlayerCtlView() {
            if (this.player.playerCtlView)
                fairygui.GRoot.inst.addChild(this.player.playerCtlView.view);
            if (this.player.playerDirView)
                fairygui.GRoot.inst.addChild(this.player.playerDirView.view);
        }
        showAfterWarView(type) {
            this.afterWar.view.m_ctl.selectedIndex = type - 1;
            this.afterWar.updateView(type);
            if (GameManager.instance.platform == moosnow.APP_PLATFORM.WX) {
                this.showPopUpView(this.afterWar, true, true, false);
            }
            else if (GameManager.instance.platform == moosnow.APP_PLATFORM.QQ) {
                if (MooSnowSDK.misTouchNum == 0) {
                    this.showPopUpView(this.afterWar, true, true, false);
                }
                else if (MooSnowSDK.misTouchNum > 0) {
                    GameManager.instance.misTouchNum++;
                    if (GameManager.instance.misTouchNum >= MooSnowSDK.misTouchNum) {
                        GameManager.instance.misTouchNum = 0;
                        this.showQQWuChuView(2);
                    }
                    else {
                        this.showPopUpView(this.afterWar, true, true, false);
                    }
                }
            }
            else if (GameManager.instance.platform == moosnow.APP_PLATFORM.BYTEDANCE) {
            }
            else {
                this.showPopUpView(this.afterWar, true, true, false);
            }
        }
        showResultView() {
            if (GameManager.instance.platform == moosnow.APP_PLATFORM.QQ) {
                MooSnowSDK.showQQADBox();
            }
            this.showPopUpView(this.afterWar, true, true, false);
        }
        showBeforeWarView() {
            if (GameManager.instance.platform == moosnow.APP_PLATFORM.BYTEDANCE) {
                this.showPopUpView(this.freeView, true, false, false);
            }
            else {
                this.showPopUpView(this.beforeWar);
            }
        }
        showSuspendView() {
            this.suspendView.showViewNoTween();
        }
        ;
        showClickChestView() {
        }
        ;
        showADListView(type = 0) {
            if (GameManager.instance.platform == moosnow.APP_PLATFORM.QQ) {
                MooSnowSDK.showQQADBox();
                this.hidePopUpView(null, true);
            }
            else if (GameManager.instance.platform == moosnow.APP_PLATFORM.WX) {
                this.showPopUpView(this.adListView, false, false, false);
                this.adListView.type = type;
            }
        }
        ;
        showQQADBoxView() {
        }
        ;
        showQQWuChuView(type = 1) {
        }
        ;
        hideSuspendView() {
            this.suspendView.hideAllView();
        }
        showChapterView() {
            this.chapterView.updateView();
            this.showPopUpView(this.chapterView, false, true);
            SoundManager.instance.playBGM("chapterBgm");
        }
        playerVicToryLevel() {
            this.player.victoryGame();
        }
        initPopUpView() {
            MooSnowSDK.getAD();
            this.afterWar = new AfterWar();
            this.beforeWar = new BeforeWar();
            this.suspendView = new SuspendView();
            this.chapterView = new ChapterView();
            this.adListView = new ADListView();
            this.popUpView = new PopUpView();
            this.tipsView = new TipsPopView();
            this.freeView = new FreeView();
            this.afterWar.createView();
            this.beforeWar.createView();
            this.suspendView.createView();
            this.chapterView.createView();
            this.adListView.createView();
            this.freeView.createView();
            Laya.stage.addChildAt(fairygui.GRoot.inst.displayObject, 0);
        }
        showTipsView(str) {
            this.tipsView.showView(str);
        }
        showNoVideoView(v, d, f, c) {
        }
        showPopUpView(p, showMask = true, hideOther = false, clickMaskHide = true) {
            if (hideOther) {
                for (let i = 0; i < this.curPopView.length; i++) {
                    var t = this.curPopView[i];
                    t.hideAllView();
                }
                this.curPopView.length = 0;
            }
            p.showView(showMask, clickMaskHide);
            this.curPopView.push(p);
        }
        hidePopUpView(p, all = false) {
            if (all) {
                for (let i = 0; i < this.curPopView.length; i++) {
                    var t = this.curPopView[i];
                    t.hideAllView();
                }
                this.curPopView.length = 0;
            }
            else {
                if (p)
                    p.hideAllView();
            }
        }
        removeWarView() {
            if (this.warView) {
                this.warView.removeView();
                if (this.adBtn) {
                    this.adBtn.offClick(this, this.showADListView);
                    this.adBtn.m_ani.stop();
                }
                if (this.adBtn2) {
                    this.adBtn2.offClick(this, this.showADListView);
                    this.adBtn2.m_ani_2.stop();
                }
            }
        }
        get rolePlayer() {
            return this.player;
        }
        getBodyCenterPos(s) {
            return s.getComponent(Laya.RigidBody).getWorldCenter();
        }
        updateViewPort(moveX) {
            this.warView.updateViewPort(moveX);
        }
        getBoomAniTypeByBomb(type) {
            if (type == BombData.BOMB_MY_GRE || type == BombData.BOMB_MY_GRE || type == BombData.BOMB_CHOPPER) {
                return 1;
            }
            else if (type == BombData.BOMB_MOR) {
                return 2;
            }
            else if (type == BombData.BOMB_TANK) {
                return 3;
            }
            return 1;
        }
        getBoomAniTypeByObsType(type) {
            if (type == ObstacleType.ObstacleType_SHABAO || type == ObstacleType.ObstacleType_YOUGUAN || type == ObstacleType.ObstacleType_9) {
                return 2;
            }
            else if (type == ObstacleType.ObstacleType_DACHE || type == ObstacleType.ObstacleType_11) {
                return 5;
            }
            else {
                return 3;
            }
        }
        bulletRandomY() {
            return Math.floor(Math.random() * 10) + 10;
        }
        getPlayerDirection(pos) {
            var rad = Math.atan2(pos.y, pos.x);
            if ((rad >= -2 * Math.PI / 8 && rad < 0) || (rad >= 0 && rad < 2 * Math.PI / 8)) {
                return 1;
            }
            else if (rad >= 2 * Math.PI / 8 && rad < 4 * Math.PI / 8) {
                return 5;
            }
            else if (rad >= 4 * Math.PI / 8 && rad < 6 * Math.PI / 8) {
                return -5;
            }
            else if ((rad >= 6 * Math.PI / 8 && rad < Math.PI) || (rad >= -Math.PI && rad < -6 * Math.PI / 8)) {
                return -1;
            }
            else if (rad >= -6 * Math.PI / 8 && rad < -5 * Math.PI / 8) {
                return -3;
            }
            else if (rad >= -5 * Math.PI / 8 && rad < -4 * Math.PI / 8) {
                return -4;
            }
            else if (rad >= -4 * Math.PI / 8 && rad < -3 * Math.PI / 8) {
                return 4;
            }
            else {
                return 3;
            }
        }
        getPlayerBulletOffSetPos(dir, weaponType) {
            var s = dir + "" + weaponType;
            if (this.playerBulletPos[s])
                return new Laya.Point(this.playerBulletPos[s][0], this.playerBulletPos[s][1]);
            else
                return new Laya.Point(0, 0);
        }
        getEnemyBulletOffSetPos(dir, weaponType) {
            var s = dir + "" + weaponType;
            if (this.enemyBulletPos[s])
                return new Laya.Point(this.enemyBulletPos[s][0], this.enemyBulletPos[s][1]);
            else
                return new Laya.Point(0, 0);
        }
        getLayoutWidth() {
            let h = 0;
            let offX = 0;
            if (Laya.Browser.onWeiXin) {
                let wxInfo = wx.getSystemInfoSync();
                h = (wxInfo.windowHeight / 750) * 1334;
                console.log('wx height:', wxInfo.windowHeight, ', width:', wxInfo.windowWidth);
                offX = (wxInfo.windowWidth - h) / (wxInfo.windowHeight / 750);
            }
            else {
                h = (Laya.Browser.height / 750) * 1334;
                offX = (Laya.Browser.width - h) / (Laya.Browser.height / 750);
            }
            return Math.floor(offX / 2);
        }
        getProportion() {
            if (Laya.Browser.onWeiXin) {
                let wxInfo = wx.getSystemInfoSync();
                return wxInfo.windowHeight / 750;
            }
            else {
                return Laya.Browser.height / 750;
            }
        }
        showShake(s, intensity, duration, radius) {
            if (!this.shake)
                this.shake = new Shake();
            this.shake.exe(s, intensity, duration, radius);
        }
    }

    class SaveManager {
        constructor() {
        }
        static get instance() {
            if (this._instance == null)
                this._instance = new SaveManager();
            return this._instance;
        }
        saveGameData(key, value) {
            localStorage.setItem(key, value);
        }
        getGameData(key) {
            return localStorage.getItem(key);
        }
    }

    class GameManager {
        constructor() {
            this.curLevel = 1;
            this.curChapter = 1;
            this.maxLevel = 8;
            this.maxChapter = 1;
            this.gotoMaxLevel = 1;
            this.gotoMaxChapter = 1;
            this.choiseLevel = 1;
            this.enemyArr = [];
            this.misTouchNum = 0;
            this.adOriList = [];
            this.adList = [];
            this.adListRever = [];
            this.adTime = 0;
            this.buyWeaponType = 0;
            this.buyBullet = 0;
            this.buyGre = 10;
            this.platform = 0;
            this.isPauseGame = false;
            this.oriBlood = 6;
        }
        static get instance() {
            if (this._instance == null)
                this._instance = new GameManager();
            return this._instance;
        }
        startGame() {
            this.levelData = Laya.loader.getRes("res/LevelData.json");
            var levelData2 = Laya.loader.getRes("res/LevelData2.json");
            this.levelData["chapter_4"] = levelData2["chapter_4"];
            this.levelData["chapter_5"] = levelData2["chapter_5"];
            this.platform = MooSnowSDK.getPlatform();
            console.log(this.levelData);
            this.initRoleData();
            this.initChapterConfig();
            SoundManager.instance.openSound();
            ViewManager.instance.initPopUpView();
            ViewManager.instance.showChapterView();
        }
        initChapterConfig() {
            this.maxChapter = this.levelData["maxChapter"];
            var l = SaveManager.instance.getGameData("level");
            var c = SaveManager.instance.getGameData("chapter");
            var coin = SaveManager.instance.getGameData("coin");
            if (coin && coin.length > 0)
                this.roleInfo.totalCoin = Number(coin);
            if (l && l.length > 0) {
                this.curLevel = this.gotoMaxLevel = Number(l);
                this.curChapter = this.gotoMaxChapter = Math.ceil(this.curLevel / this.maxLevel);
                if (this.curChapter > this.maxChapter)
                    this.curChapter = this.gotoMaxChapter = this.maxChapter;
            }
            else {
                this.gotoMaxChapter = this.curChapter = 1;
                this.gotoMaxLevel = this.curLevel = 1;
            }
            this.maxLevel = this.levelData["chapter_" + this.curChapter].maxLevelNum;
        }
        enterGame() {
            this.curLevel = this.choiseLevel;
            this.goLevelGame();
        }
        continueGameByVideo() {
            this.roleInfo.isDeath = false;
            this.roleInfo.blood = this.oriBlood;
            this.roleInfo.isInvincible = true;
            ViewManager.instance.playerInfoView.updatePlayerBlood();
            ViewManager.instance.hidePopUpView(ViewManager.instance.afterWar);
            ViewManager.instance.player.playerRes();
        }
        goBack() {
            this.goFirstPage();
        }
        goFirstPage(end = false) {
            this.enemyArr.length = 0;
            EventManager.instance.dispatcherEvt(GameEvent.CLEAR_WAR_VIEW);
            ViewManager.instance.hidePopUpView(null, true);
            ViewManager.instance.removeWarView();
            ViewManager.instance.showChapterView();
            if (end && GameManager.instance.platform == moosnow.APP_PLATFORM.VIVO) {
                MooSnowSDK.installShortcut();
            }
            if (end && GameManager.instance.platform == moosnow.APP_PLATFORM.OPPO) {
                MooSnowSDK.installShortcut();
            }
        }
        suspendGame() {
            this.isPauseGame = !this.isPauseGame;
            if (GameManager.instance.isPauseGame) {
                Laya.updateTimer.pause();
                Laya.physicsTimer.pause();
                Laya.timer.pause();
            }
            else {
                Laya.updateTimer.resume();
                Laya.physicsTimer.resume();
                Laya.timer.resume();
            }
            EventManager.instance.dispatcherEvt(GameEvent.PAUSE_GAME);
        }
        victoryGame() {
            ViewManager.instance.playerVicToryLevel();
            this.curLevel++;
            if (this.gotoMaxLevel < this.curLevel) {
                this.gotoMaxLevel = this.curLevel;
                if (this.gotoMaxLevel % this.maxLevel == 1) {
                    this.gotoMaxChapter++;
                    if (this.gotoMaxChapter > this.maxChapter)
                        this.gotoMaxChapter = this.maxChapter;
                    this.curChapter = this.gotoMaxChapter;
                }
            }
            else {
                this.curChapter = Math.ceil(this.curLevel / this.maxLevel);
            }
            ViewManager.instance.showAfterWarView(1);
            SaveManager.instance.saveGameData("level", this.gotoMaxLevel + "");
            SaveManager.instance.saveGameData("chapter", this.gotoMaxChapter + "");
            SaveManager.instance.saveGameData("coin", this.roleInfo.totalCoin + "");
            SoundManager.instance.playSound("gameOver");
        }
        restartGame() {
            ViewManager.instance.hidePopUpView(null, true);
            if (this.curLevel < 1)
                this.curLevel = 1;
            this.goLevelGame();
        }
        gotoNextLevel() {
            ViewManager.instance.hidePopUpView(ViewManager.instance.afterWar);
            if (this.curLevel > this.maxLevel * this.maxChapter) {
                ViewManager.instance.showTipsView("您已通关！敬请期待后续章节");
                return;
            }
            this.goLevelGame();
        }
        goLevelGame() {
            ViewManager.instance.hidePopUpView(null, true);
            if (this.curLevel > this.maxLevel * this.maxChapter) {
                ViewManager.instance.showTipsView("您已通关！敬请期待后续章节");
                return;
            }
            EventManager.instance.dispatcherEvt(GameEvent.CLEAR_WAR_VIEW);
            if (this.levelData["chapter_" + this.curChapter]) {
                var l = (this.curLevel % this.maxLevel);
                if (l == 0)
                    l = 8;
                this.maxLevel = this.levelData["chapter_" + this.curChapter].maxLevelNum;
                this.curLevelData = this.levelData["chapter_" + this.curChapter]["level_" + l];
                this.playerInfo.curlvCoin = 0;
                this.roleInfo.blood = this.oriBlood;
                this.roleInfo.isDeath = false;
                ViewManager.instance.createWarView();
                SoundManager.instance.playBGM("bgm");
                MooSnowSDK.startGame(GameManager.instance.choiseLevel);
                MooSnowSDK.startRecord();
            }
            else {
                ViewManager.instance.showTipsView("您已通关！敬请期待后续章节");
            }
        }
        showVideoResp(d, v, successFun) {
            if (v.type == VideoType.VIDEOTYPE_ITEM && d) {
                GameManager.instance.buyShopItem(d, true);
                ViewManager.instance.beforeWar.updateView();
            }
            else if (v.type == VideoType.VIDEOTYPE_LIFE) {
                GameManager.instance.continueGameByVideo();
            }
            else if (v.type == VideoType.VIDEOTYPE_DOUBLE_COIN) {
                GameManager.instance.roleInfo.totalCoin += GameManager.instance.roleInfo.curlvCoin;
                ViewManager.instance.playerInfoView.updateCoin();
                GameManager.instance.goFirstPage();
                MooSnowSDK.endGame(GameManager.instance.choiseLevel, true);
                ViewManager.instance.showTipsView("额外获得金币：" + GameManager.instance.roleInfo.curlvCoin);
            }
            else if (v.type == VideoType.VIDEOTYPE_TREBLE_COIN) {
                GameManager.instance.roleInfo.totalCoin += GameManager.instance.roleInfo.curlvCoin * 2;
                ViewManager.instance.playerInfoView.updateCoin();
                GameManager.instance.goFirstPage();
                MooSnowSDK.endGame(GameManager.instance.choiseLevel, true);
                ViewManager.instance.showTipsView("额外获得金币：" + GameManager.instance.roleInfo.curlvCoin * 2);
            }
            else if (v.type == VideoType.VIDEOTYPE_BOX) {
                ViewManager.instance.playerInfoView.showBoxGoods();
            }
            if (successFun) {
                successFun();
            }
        }
        initRoleData() {
            if (!this.playerInfo)
                this.playerInfo = new PlayerInfo();
            this.playerInfo.bombNum = this.levelData.role.bombNum;
            this.playerInfo.weaponType = this.levelData.role.weaponType;
            this.oriBlood = this.playerInfo.blood = this.levelData.role.blood;
            this.playerInfo.addBombNum = this.levelData.role.addBombNum;
            this.playerInfo.addMacNum = this.levelData.role.addMacNum;
            this.playerInfo.addRifNum = this.levelData.role.addRifNum;
            this.playerInfo.curLevel = this.playerInfo.curChapter = 1;
            this.playerInfo.curlvCoin = this.playerInfo.totalCoin = 0;
        }
        createEnemyData() {
            var enemyArr = this.curLevelData.enemyArr;
            for (const key in enemyArr) {
                if (enemyArr.hasOwnProperty(key)) {
                    var t = enemyArr[key];
                    var e;
                    var d = new EnemyInfo();
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
                    }
                    else if (d.type == GameData.ENEMY_CHOPPER) {
                        e = ViewManager.instance.createChopper(d);
                    }
                    else if (d.type == GameData.HOSTAGE) {
                        ViewManager.instance.createHostage(d);
                    }
                    else {
                        e = ViewManager.instance.createEnemy(d);
                    }
                    this.enemyArr.push(e);
                }
            }
        }
        createObstacleData() {
            var obstacle = GameManager.instance.curLevelData.obstacle;
            for (const key in obstacle) {
                if (obstacle.hasOwnProperty(key)) {
                    var t = obstacle[key];
                    var d = new ObstacleInfo();
                    d.pos = new Laya.Point(t.pos[0], t.pos[1]);
                    d.blood = t.blood;
                    d.type = t.type;
                    d.name = key;
                    ViewManager.instance.createObstacle(d);
                }
            }
        }
        buyShopItem(d, showTip = false) {
            if (d.type == GoodsType.GoodsType_MED) {
                GameManager.instance.roleInfo.blood += 2;
            }
            else if (d.type == GoodsType.GoodsType_MAC) {
                if (this.buyWeaponType != PlayerData.WEAPON_MAC)
                    this.buyBullet = 0;
                this.buyWeaponType = PlayerData.WEAPON_MAC;
                this.buyBullet += d.num;
            }
            else if (d.type == GoodsType.GoodsType_GRE) {
                this.buyGre += d.num;
            }
            else if (d.type == GoodsType.GoodsType_RIF) {
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
        setADlist() {
            this.adOriList = this.adList.concat();
            if (this.adList.length <= 5) {
                this.adList.push(...this.adList);
            }
            this.adTime = this.adList.length * 1200;
            this.adListRever = this.adList.concat().reverse();
            EventManager.instance.dispatcherEvt(GameEvent.SHOW_AD_LIST);
        }
        useWeaponPan(x, y, dir) {
            if (dir > 0)
                x -= 50;
            else
                x += 50;
            for (let i = 0; i < this.enemyArr.length; i++) {
                var e = this.enemyArr[i];
                if (e.isDeath)
                    continue;
                if (e.isActive == false)
                    continue;
                if (e.enemyType > GameData.ENEMY_CHOPPER)
                    continue;
                if (dir > 0) {
                    if (e.scene.x > x && e.scene.x - x < 150) {
                        if (Math.abs(y - e.scene.y) < 30)
                            return true;
                    }
                }
                else {
                    if (e.scene.x < x && x - e.scene.x < 150)
                        if (Math.abs(y - e.scene.y) < 30)
                            return true;
                }
            }
            return false;
        }
        get roleInfo() {
            return this.playerInfo;
        }
        set curLevelData(l) {
            this.curLvData = l;
        }
        get curLevelData() {
            return this.curLvData;
        }
        getPlayerBulletDamage(type) {
            if (type == GameData.WEAPON_PIS) {
                return 1;
            }
            else if (type == GameData.WEAPON_RIFLE) {
                return 2;
            }
            else if (type == GameData.WEAPON_MAC) {
                return 2;
            }
            else {
                return 1;
            }
        }
        createVideoData(t, info) {
            var v = new VideoData();
            v.type = t;
            v.info = info;
            return v;
        }
    }

    class AssetsManager {
        constructor() {
        }
        static get instance() {
            if (this._instance == null)
                this._instance = new AssetsManager();
            return this._instance;
        }
        loadLoadingAssetsData() {
            AssetsManager.loadingAssetsData.push({ url: "loading/loading_atlas0.png", type: Laya.Loader.IMAGE }, { url: "loading/loading_atlas_n8quey.jpg", type: Laya.Loader.IMAGE }, { url: "loading/loading.proto", type: Laya.Loader.BUFFER });
            if (Laya.Browser.onPC) {
                Laya.loader.create(AssetsManager.loadingAssetsData, Laya.Handler.create(this, this.loadingAssetsComplete));
                return;
            }
            if (moosnow.getAppPlatform() == moosnow.APP_PLATFORM.WX) {
                console.log("onWeiXin");
                Laya.loader.create(AssetsManager.loadingAssetsData, Laya.Handler.create(this, this.onWXLoaded));
            }
            else if (moosnow.getAppPlatform() == moosnow.APP_PLATFORM.QQ) {
                console.log("loadQQ");
                Laya.loader.create(AssetsManager.loadingAssetsData, Laya.Handler.create(this, this.onQQLoaded));
            }
            else if (moosnow.getAppPlatform() == moosnow.APP_PLATFORM.VIVO) {
                console.log("loadVIVO ");
                Laya.loader.create(AssetsManager.loadingAssetsData, Laya.Handler.create(this, this.onVIVOLoaded));
            }
            else {
                Laya.loader.create(AssetsManager.loadingAssetsData, Laya.Handler.create(this, this.loadingAssetsComplete));
            }
        }
        onWXLoaded() {
            if (moosnow.getAppPlatform() == moosnow.APP_PLATFORM.QQ) {
                console.log("loadQQ");
                Laya.loader.create(AssetsManager.loadingAssetsData, Laya.Handler.create(this, this.onQQLoaded));
                return;
            }
            let wxLoad = Laya.Browser.window.wx;
            const wxloadTask = wxLoad["loadSubpackage"]({
                name: 'res',
                success: function (res) {
                    AssetsManager.instance.loadingAssetsComplete();
                },
                fail: function (res) {
                    console.log("分包加载wx失败");
                }
            });
        }
        onQQLoaded() {
            let qqLoad = Laya.Browser.window.qq;
            const qqloadTask = qqLoad["loadSubpackage"]({
                name: 'res',
                success: function (res) {
                    AssetsManager.instance.loadingAssetsComplete();
                },
                fail: function (res) {
                    console.log("分包加载qq失败");
                }
            });
        }
        onVIVOLoaded() {
            let qgLoad = Laya.Browser.window.qg;
            const qgloadTask = qgLoad["loadSubpackage"]({
                name: 'res',
                success: function (res) {
                    AssetsManager.instance.loadingAssetsComplete();
                },
                fail: function (res) {
                    console.log("分包加载vivo失败");
                }
            });
        }
        loadingAssetsComplete() {
            fairygui.UIPackage.addPackage("loading/loading");
            console.log("loading界面资源加载完成--显示loading界面，并开始加载游戏资源");
            MooSnowSDK.getMistouchPosNum();
            MooSnowSDK.getMisTouchNum();
            MooSnowSDK.getAllConfig();
            ViewManager.instance.createLoaningView();
            this.loadAssetsData();
        }
        loadAssetsData() {
            AssetsManager.assetsData.push({ url: "res/Game_atlas0.png", type: Laya.Loader.IMAGE }, { url: "res/Game_atlas0_1.png", type: Laya.Loader.IMAGE }, { url: "res/Game_atlas0_2.png", type: Laya.Loader.IMAGE }, { url: "res/Game_atlas0_3.png", type: Laya.Loader.IMAGE }, { url: "res/Game_atlas0_4.png", type: Laya.Loader.IMAGE }, { url: "res/Game_atlas0_5.png", type: Laya.Loader.IMAGE }, { url: "res/Game_atlas0_6.png", type: Laya.Loader.IMAGE }, { url: "res/Game_atlas0_7.png", type: Laya.Loader.IMAGE }, { url: "res/Game_atlas_n8qun1.jpg", type: Laya.Loader.IMAGE }, { url: "res/Game_atlas_n8qun7.png", type: Laya.Loader.IMAGE }, { url: "res/LevelData.json", type: Laya.Loader.JSON }, { url: "res/LevelData2.json", type: Laya.Loader.JSON }, { url: "res/map_1.jpg", type: Laya.Loader.IMAGE }, { url: "res/map_2.jpg", type: Laya.Loader.IMAGE }, { url: "res/map_3.jpg", type: Laya.Loader.IMAGE }, { url: "res/map_4.jpg", type: Laya.Loader.IMAGE }, { url: "res/map_5.jpg", type: Laya.Loader.IMAGE }, { url: "res/map_6.jpg", type: Laya.Loader.IMAGE }, { url: "res/map_7.jpg", type: Laya.Loader.IMAGE }, { url: "res/map_8.jpg", type: Laya.Loader.IMAGE }, { url: "res/map_1_2.jpg", type: Laya.Loader.IMAGE }, { url: "res/map_2_2.jpg", type: Laya.Loader.IMAGE }, { url: "res/map_3_2.jpg", type: Laya.Loader.IMAGE }, { url: "res/map_4_2.jpg", type: Laya.Loader.IMAGE }, { url: "res/map_5_2.jpg", type: Laya.Loader.IMAGE }, { url: "res/map_6_2.jpg", type: Laya.Loader.IMAGE }, { url: "res/map_7_2.jpg", type: Laya.Loader.IMAGE }, { url: "res/map_8_2.jpg", type: Laya.Loader.IMAGE }, { url: "res/Game.proto", type: Laya.Loader.BUFFER }, { url: "res/zhujue_body.png", type: Laya.Loader.IMAGE }, { url: "res/zhujue_body.sk", type: Laya.Loader.BUFFER }, { url: "res/hero_arm.png", type: Laya.Loader.IMAGE }, { url: "res/hero_arm.sk", type: Laya.Loader.BUFFER }, { url: "sound/bgm.mp3", type: Laya.Loader.SOUND }, { url: "sound/BombDrop.mp3", type: Laya.Loader.SOUND }, { url: "sound/boom.mp3", type: Laya.Loader.SOUND }, { url: "sound/btn_click.mp3", type: Laya.Loader.SOUND }, { url: "sound/btn_press.mp3", type: Laya.Loader.SOUND }, { url: "sound/die_1.mp3", type: Laya.Loader.SOUND }, { url: "sound/die_2.mp3", type: Laya.Loader.SOUND }, { url: "sound/die_3.mp3", type: Laya.Loader.SOUND }, { url: "sound/die_4.mp3", type: Laya.Loader.SOUND }, { url: "sound/enemy_fire.mp3", type: Laya.Loader.SOUND }, { url: "sound/gameOver.mp3", type: Laya.Loader.SOUND }, { url: "sound/get_goods.mp3", type: Laya.Loader.SOUND }, { url: "sound/obstacleBoom.mp3", type: Laya.Loader.SOUND }, { url: "sound/obstacleBoom2.mp3", type: Laya.Loader.SOUND }, { url: "sound/tank_fire.mp3", type: Laya.Loader.SOUND }, { url: "sound/weapon_1.mp3", type: Laya.Loader.SOUND }, { url: "sound/weapon_2.mp3", type: Laya.Loader.SOUND }, { url: "sound/weapon_3.mp3", type: Laya.Loader.SOUND }, { url: "sound/weapon_10.mp3", type: Laya.Loader.SOUND }, { url: "sound/chapterBgm.mp3", type: Laya.Loader.SOUND });
            Laya.loader.create(AssetsManager.assetsData, Laya.Handler.create(this, this.loadComplete), Laya.Handler.create(this, this.onloadingProgress));
        }
        onloadingProgress(progress) {
            ViewManager.instance.setLoadongProgress(progress);
        }
        loadComplete() {
            fairygui.UIPackage.addPackage("res/Game");
            ViewManager.instance.hideLoadingView();
            moosnow.http.finishLoading();
            GameManager.instance.startGame();
        }
        setVersionUrl(arr) {
            for (let i = 0; i < arr.length; i++) {
                var t = arr[i];
                t.url = this.getVersionUrl(t.url);
            }
        }
        getVersionUrl(s) {
            var v = Laya.loader.getRes("version.json");
            if (v[s]) {
                return v[s];
            }
            return s;
        }
    }
    AssetsManager.assetsData = [];
    AssetsManager.loadingAssetsData = [];

    class WXFUI_damageView extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "damageView"));
        }
        onConstruct() {
            this.m_num = (this.getChild("num"));
            this.m_ani = this.getTransition("ani");
        }
    }
    WXFUI_damageView.URL = "ui://bq3h5ins8mn4xsm";

    class WXFUI_addGold extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "addGold"));
        }
        onConstruct() {
            this.m_num = (this.getChild("num"));
            this.m_icon = (this.getChild("icon"));
            this.m_com = (this.getChild("com"));
            this.m_ani = this.getTransition("ani");
        }
    }
    WXFUI_addGold.URL = "ui://bq3h5ins8mn4xsz";

    class WXFUI_enemy_fire_14 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "enemy_fire_14"));
        }
        onConstruct() {
            this.m_n1 = (this.getChild("n1"));
        }
    }
    WXFUI_enemy_fire_14.URL = "ui://bq3h5inscdcoxpj";

    class WXFUI_star extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "star"));
        }
        onConstruct() {
            this.m_ctl = this.getController("ctl");
            this.m_n18 = (this.getChild("n18"));
            this.m_n19 = (this.getChild("n19"));
            this.m_n16 = (this.getChild("n16"));
            this.m_n17 = (this.getChild("n17"));
            this.m_n20 = (this.getChild("n20"));
            this.m_n21 = (this.getChild("n21"));
        }
    }
    WXFUI_star.URL = "ui://bq3h5inscde5xqp";

    class WXFUI_jumpBtn extends fairygui.GButton {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "jumpBtn"));
        }
        onConstruct() {
            this.m_button = this.getController("button");
            this.m_n3 = (this.getChild("n3"));
            this.m_n4 = (this.getChild("n4"));
        }
    }
    WXFUI_jumpBtn.URL = "ui://bq3h5inscqp93n";

    class WXFUI_fireBtn extends fairygui.GButton {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "fireBtn"));
        }
        onConstruct() {
            this.m_button = this.getController("button");
            this.m_n3 = (this.getChild("n3"));
            this.m_n4 = (this.getChild("n4"));
            this.m_n5 = (this.getChild("n5"));
        }
    }
    WXFUI_fireBtn.URL = "ui://bq3h5inscqp93o";

    class WXFUI_throwBtn extends fairygui.GButton {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "throwBtn"));
        }
        onConstruct() {
            this.m_button = this.getController("button");
            this.m_n3 = (this.getChild("n3"));
            this.m_n4 = (this.getChild("n4"));
        }
    }
    WXFUI_throwBtn.URL = "ui://bq3h5inscqp93p";

    class WXFUI_enemyStay_5 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "enemyStay_5"));
        }
        onConstruct() {
            this.m_en = (this.getChild("en"));
            this.m_people = (this.getChild("people"));
        }
    }
    WXFUI_enemyStay_5.URL = "ui://bq3h5insdhktei";

    class WXFUI_enemy_fire_5 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "enemy_fire_5"));
        }
        onConstruct() {
            this.m_mor = (this.getChild("mor"));
            this.m_people = (this.getChild("people"));
        }
    }
    WXFUI_enemy_fire_5.URL = "ui://bq3h5insdhktej";

    class WXFUI_enemy5 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "enemy5"));
        }
        onConstruct() {
            this.m_en = (this.getChild("en"));
        }
    }
    WXFUI_enemy5.URL = "ui://bq3h5insdhktem";

    class WXFUI_backHomeBtn extends fairygui.GButton {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "backHomeBtn"));
        }
        onConstruct() {
            this.m_button = this.getController("button");
            this.m_n5 = (this.getChild("n5"));
            this.m_n4 = (this.getChild("n4"));
        }
    }
    WXFUI_backHomeBtn.URL = "ui://bq3h5insdr1tni";

    class WXFUI_restartBtn extends fairygui.GButton {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "restartBtn"));
        }
        onConstruct() {
            this.m_button = this.getController("button");
            this.m_n5 = (this.getChild("n5"));
            this.m_n4 = (this.getChild("n4"));
        }
    }
    WXFUI_restartBtn.URL = "ui://bq3h5insdr1tnj";

    class WXFUI_continueBtn extends fairygui.GButton {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "continueBtn"));
        }
        onConstruct() {
            this.m_button = this.getController("button");
            this.m_n4 = (this.getChild("n4"));
        }
    }
    WXFUI_continueBtn.URL = "ui://bq3h5insdr1tnk";

    class WXFUI_buyItem extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "buyItem"));
        }
        onConstruct() {
            this.m_n2 = (this.getChild("n2"));
            this.m_n4 = (this.getChild("n4"));
            this.m_n5 = (this.getChild("n5"));
            this.m_buy = (this.getChild("buy"));
            this.m_coin = (this.getChild("coin"));
            this.m_free = (this.getChild("free"));
            this.m_icon = (this.getChild("icon"));
            this.m_info = (this.getChild("info"));
            this.m_ani = this.getTransition("ani");
        }
    }
    WXFUI_buyItem.URL = "ui://bq3h5insdr1tnm";

    class WXFUI_enterBtn extends fairygui.GButton {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "enterBtn"));
        }
        onConstruct() {
            this.m_button = this.getController("button");
            this.m_n5 = (this.getChild("n5"));
        }
    }
    WXFUI_enterBtn.URL = "ui://bq3h5insdr1tnn";

    class WXFUI_buyBtn extends fairygui.GButton {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "buyBtn"));
        }
        onConstruct() {
            this.m_button = this.getController("button");
            this.m_n5 = (this.getChild("n5"));
        }
    }
    WXFUI_buyBtn.URL = "ui://bq3h5insdr1tno";

    class WXFUI_freeBtn extends fairygui.GButton {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "freeBtn"));
        }
        onConstruct() {
            this.m_button = this.getController("button");
            this.m_n6 = (this.getChild("n6"));
            this.m_t0 = this.getTransition("t0");
        }
    }
    WXFUI_freeBtn.URL = "ui://bq3h5insdr1tnp";

    class WXFUI_backBtn extends fairygui.GButton {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "backBtn"));
        }
        onConstruct() {
            this.m_button = this.getController("button");
            this.m_n6 = (this.getChild("n6"));
        }
    }
    WXFUI_backBtn.URL = "ui://bq3h5insdr1tnr";

    class WXFUI_continueBtn2 extends fairygui.GButton {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "continueBtn2"));
        }
        onConstruct() {
            this.m_button = this.getController("button");
            this.m_n5 = (this.getChild("n5"));
        }
    }
    WXFUI_continueBtn2.URL = "ui://bq3h5insdr1tns";

    class WXFUI_continueBtn3 extends fairygui.GButton {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "continueBtn3"));
        }
        onConstruct() {
            this.m_button = this.getController("button");
            this.m_n6 = (this.getChild("n6"));
        }
    }
    WXFUI_continueBtn3.URL = "ui://bq3h5insdr1tnt";

    class WXFUI_continueBtn4 extends fairygui.GButton {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "continueBtn4"));
        }
        onConstruct() {
            this.m_button = this.getController("button");
            this.m_n7 = (this.getChild("n7"));
        }
    }
    WXFUI_continueBtn4.URL = "ui://bq3h5insdr1tnu";

    class WXFUI_LevelItem extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "LevelItem"));
        }
        onConstruct() {
            this.m_ctl = this.getController("ctl");
            this.m_n12 = (this.getChild("n12"));
            this.m_n13 = (this.getChild("n13"));
            this.m_n14 = (this.getChild("n14"));
            this.m_n15 = (this.getChild("n15"));
            this.m_star = (this.getChild("star"));
            this.m_numF = (this.getChild("numF"));
        }
    }
    WXFUI_LevelItem.URL = "ui://bq3h5insdr1tnx";

    class WXFUI_lastChapter extends fairygui.GButton {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "lastChapter"));
        }
        onConstruct() {
            this.m_button = this.getController("button");
            this.m_n7 = (this.getChild("n7"));
        }
    }
    WXFUI_lastChapter.URL = "ui://bq3h5insdr1tnz";

    class WXFUI_nextChapter extends fairygui.GButton {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "nextChapter"));
        }
        onConstruct() {
            this.m_button = this.getController("button");
            this.m_n7 = (this.getChild("n7"));
        }
    }
    WXFUI_nextChapter.URL = "ui://bq3h5insdr1to0";

    class WXFUI_share extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "share"));
        }
        onConstruct() {
            this.m_n2 = (this.getChild("n2"));
            this.m_share1 = (this.getChild("share1"));
            this.m_share2 = (this.getChild("share2"));
        }
    }
    WXFUI_share.URL = "ui://bq3h5insdr1to2";

    class WXFUI_shareBtn1 extends fairygui.GButton {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "shareBtn1"));
        }
        onConstruct() {
            this.m_button = this.getController("button");
            this.m_n6 = (this.getChild("n6"));
        }
    }
    WXFUI_shareBtn1.URL = "ui://bq3h5insdr1to3";

    class WXFUI_shareBtn2 extends fairygui.GButton {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "shareBtn2"));
        }
        onConstruct() {
            this.m_button = this.getController("button");
            this.m_n6 = (this.getChild("n6"));
        }
    }
    WXFUI_shareBtn2.URL = "ui://bq3h5insdr1to4";

    class WXFUI_enemy11 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "enemy11"));
        }
        onConstruct() {
            this.m_load = (this.getChild("load"));
        }
    }
    WXFUI_enemy11.URL = "ui://bq3h5insdx35l4";

    class WXFUI_enemy12 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "enemy12"));
        }
        onConstruct() {
            this.m_load = (this.getChild("load"));
        }
    }
    WXFUI_enemy12.URL = "ui://bq3h5insdx35l5";

    class WXFUI_Bomb extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "Bomb"));
        }
        onConstruct() {
            this.m_boom = (this.getChild("boom"));
            this.m_boom2 = (this.getChild("boom2"));
            this.m_boom3 = (this.getChild("boom3"));
            this.m_z2 = this.getTransition("z2");
            this.m_t3 = this.getTransition("t3");
            this.m_t4 = this.getTransition("t4");
        }
    }
    WXFUI_Bomb.URL = "ui://bq3h5insgww20";

    class WXFUI_PlayerInfoView extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "PlayerInfoView"));
        }
        onConstruct() {
            this.m_blood_1 = (this.getChild("blood_1"));
            this.m_blood_2 = (this.getChild("blood_2"));
            this.m_blood_3 = (this.getChild("blood_3"));
            this.m_n7 = (this.getChild("n7"));
            this.m_pause = (this.getChild("pause"));
            this.m_coin = (this.getChild("coin"));
            this.m_bullet = (this.getChild("bullet"));
            this.m_gre = (this.getChild("gre"));
            this.m_level = (this.getChild("level"));
            this.m_n13 = (this.getChild("n13"));
            this.m_n14 = (this.getChild("n14"));
            this.m_item_1 = (this.getChild("item_1"));
            this.m_item_2 = (this.getChild("item_2"));
            this.m_item_3 = (this.getChild("item_3"));
        }
    }
    WXFUI_PlayerInfoView.URL = "ui://bq3h5insiasdkz";

    class WXFUI_PlayerCtlView extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "PlayerCtlView"));
        }
        onConstruct() {
            this.m_fire = (this.getChild("fire"));
            this.m_jump = (this.getChild("jump"));
            this.m_bomb = (this.getChild("bomb"));
        }
    }
    WXFUI_PlayerCtlView.URL = "ui://bq3h5insiasdl0";

    class WXFUI_PlayerDirView extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "PlayerDirView"));
        }
        onConstruct() {
            this.m_bg = (this.getChild("bg"));
            this.m_dirBtn = (this.getChild("dirBtn"));
            this.m_mask = (this.getChild("mask"));
        }
    }
    WXFUI_PlayerDirView.URL = "ui://bq3h5insiasdl1";

    class WXFUI_dirBtn extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "dirBtn"));
        }
        onConstruct() {
            this.m_n1 = (this.getChild("n1"));
        }
    }
    WXFUI_dirBtn.URL = "ui://bq3h5insiasdl2";

    class WXFUI_susBtn extends fairygui.GButton {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "susBtn"));
        }
        onConstruct() {
            this.m_button = this.getController("button");
            this.m_n3 = (this.getChild("n3"));
        }
    }
    WXFUI_susBtn.URL = "ui://bq3h5insiasdl3";

    class WXFUI_ADListHorBig2 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "ADListHorBig2"));
        }
        onConstruct() {
            this.m_list = (this.getChild("list"));
            this.m_n4 = (this.getChild("n4"));
        }
    }
    WXFUI_ADListHorBig2.URL = "ui://bq3h5insihitxur";

    class WXFUI_ADItemBig2 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "ADItemBig2"));
        }
        onConstruct() {
            this.m_n0 = (this.getChild("n0"));
            this.m_icon = (this.getChild("icon"));
            this.m_name = (this.getChild("name"));
        }
    }
    WXFUI_ADItemBig2.URL = "ui://bq3h5insihitxus";

    class WXFUI_videoBtn extends fairygui.GButton {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "videoBtn"));
        }
        onConstruct() {
            this.m_button = this.getController("button");
            this.m_n0 = (this.getChild("n0"));
            this.m_n1 = (this.getChild("n1"));
        }
    }
    WXFUI_videoBtn.URL = "ui://bq3h5insk6saxwn";

    class WXFUI_lingquBtn extends fairygui.GButton {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "lingquBtn"));
        }
        onConstruct() {
            this.m_button = this.getController("button");
            this.m_n0 = (this.getChild("n0"));
            this.m_n1 = (this.getChild("n1"));
        }
    }
    WXFUI_lingquBtn.URL = "ui://bq3h5insk6saxwo";

    class WXFUI_fangqiBtn extends fairygui.GButton {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "fangqiBtn"));
        }
        onConstruct() {
            this.m_button = this.getController("button");
            this.m_ctl = this.getController("ctl");
            this.m_n0 = (this.getChild("n0"));
            this.m_n1 = (this.getChild("n1"));
            this.m_guanbi = (this.getChild("guanbi"));
        }
    }
    WXFUI_fangqiBtn.URL = "ui://bq3h5insk6saxwp";

    class WXFUI_guanbiBtn extends fairygui.GButton {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "guanbiBtn"));
        }
        onConstruct() {
            this.m_button = this.getController("button");
            this.m_n0 = (this.getChild("n0"));
        }
    }
    WXFUI_guanbiBtn.URL = "ui://bq3h5insk6saxwq";

    class WXFUI_nextBtn extends fairygui.GButton {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "nextBtn"));
        }
        onConstruct() {
            this.m_button = this.getController("button");
            this.m_n0 = (this.getChild("n0"));
        }
    }
    WXFUI_nextBtn.URL = "ui://bq3h5insk6saxwy";

    class WXFUI_chaBtn extends fairygui.GButton {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "chaBtn"));
        }
        onConstruct() {
            this.m_button = this.getController("button");
            this.m_n0 = (this.getChild("n0"));
        }
    }
    WXFUI_chaBtn.URL = "ui://bq3h5insk6saxwz";

    class WXFUI_BoomView extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "BoomView"));
        }
        onConstruct() {
            this.m_boom = (this.getChild("boom"));
        }
    }
    WXFUI_BoomView.URL = "ui://bq3h5inske5wdt";

    class WXFUI_ADReMenList extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "ADReMenList"));
        }
        onConstruct() {
            this.m_n6 = (this.getChild("n6"));
            this.m_ad_3 = (this.getChild("ad_3"));
            this.m_ad_2 = (this.getChild("ad_2"));
            this.m_ad_1 = (this.getChild("ad_1"));
            this.m_ad_6 = (this.getChild("ad_6"));
            this.m_ad_5 = (this.getChild("ad_5"));
            this.m_ad_4 = (this.getChild("ad_4"));
            this.m_n21 = (this.getChild("n21"));
            this.m_jixu = (this.getChild("jixu"));
        }
    }
    WXFUI_ADReMenList.URL = "ui://bq3h5insko37xui";

    class WXFUI_ADremen2 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "ADremen2"));
        }
        onConstruct() {
            this.m_n3 = (this.getChild("n3"));
            this.m_n4 = (this.getChild("n4"));
            this.m_ani = this.getTransition("ani");
        }
    }
    WXFUI_ADremen2.URL = "ui://bq3h5insko37xuk";

    class WXFUI_ADListHorBig extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "ADListHorBig"));
        }
        onConstruct() {
            this.m_list = (this.getChild("list"));
            this.m_n4 = (this.getChild("n4"));
        }
    }
    WXFUI_ADListHorBig.URL = "ui://bq3h5insko37xup";

    class WXFUI_ADItemBig extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "ADItemBig"));
        }
        onConstruct() {
            this.m_n0 = (this.getChild("n0"));
            this.m_icon = (this.getChild("icon"));
            this.m_name = (this.getChild("name"));
        }
    }
    WXFUI_ADItemBig.URL = "ui://bq3h5insko37xuq";

    class WXFUI_OppoNativeADView extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "OppoNativeADView"));
        }
        onConstruct() {
            this.m_ctl = this.getController("ctl");
            this.m_see = (this.getChild("see"));
            this.m_pass = (this.getChild("pass"));
            this.m_n14 = (this.getChild("n14"));
            this.m_load = (this.getChild("load"));
            this.m_close = (this.getChild("close"));
            this.m_n20 = (this.getChild("n20"));
            this.m_n21 = (this.getChild("n21"));
        }
    }
    WXFUI_OppoNativeADView.URL = "ui://bq3h5inslpi5xxd";

    class WXFUI_sanBeiBtn extends fairygui.GButton {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "sanBeiBtn"));
        }
        onConstruct() {
            this.m_button = this.getController("button");
            this.m_n0 = (this.getChild("n0"));
        }
    }
    WXFUI_sanBeiBtn.URL = "ui://bq3h5inslpi5xxf";

    class WXFUI_nextBtn2 extends fairygui.GButton {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "nextBtn2"));
        }
        onConstruct() {
            this.m_button = this.getController("button");
            this.m_n1 = (this.getChild("n1"));
        }
    }
    WXFUI_nextBtn2.URL = "ui://bq3h5inslpi5xxg";

    class WXFUI_NativeADView extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "NativeADView"));
        }
        onConstruct() {
            this.m_ctl = this.getController("ctl");
            this.m_n14 = (this.getChild("n14"));
            this.m_load = (this.getChild("load"));
            this.m_close = (this.getChild("close"));
            this.m_n20 = (this.getChild("n20"));
            this.m_see = (this.getChild("see"));
            this.m_pass = (this.getChild("pass"));
            this.m_n19 = (this.getChild("n19"));
        }
    }
    WXFUI_NativeADView.URL = "ui://bq3h5insmnewxx9";

    class WXFUI_seeAdBtn extends fairygui.GButton {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "seeAdBtn"));
        }
        onConstruct() {
            this.m_button = this.getController("button");
            this.m_n0 = (this.getChild("n0"));
        }
    }
    WXFUI_seeAdBtn.URL = "ui://bq3h5insmnewxxb";

    class WXFUI_nativeClose extends fairygui.GButton {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "nativeClose"));
        }
        onConstruct() {
            this.m_button = this.getController("button");
            this.m_n0 = (this.getChild("n0"));
        }
    }
    WXFUI_nativeClose.URL = "ui://bq3h5insmnewxxc";

    class WXFUI_enemy1 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "enemy1"));
        }
        onConstruct() {
            this.m_en = (this.getChild("en"));
        }
    }
    WXFUI_enemy1.URL = "ui://bq3h5insoqgw9y";

    class WXFUI_enemy2 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "enemy2"));
        }
        onConstruct() {
            this.m_en = (this.getChild("en"));
        }
    }
    WXFUI_enemy2.URL = "ui://bq3h5insoqgwa0";

    class WXFUI_enemy3 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "enemy3"));
        }
        onConstruct() {
            this.m_en = (this.getChild("en"));
        }
    }
    WXFUI_enemy3.URL = "ui://bq3h5insoqgwa1";

    class WXFUI_enemy4 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "enemy4"));
        }
        onConstruct() {
            this.m_en = (this.getChild("en"));
        }
    }
    WXFUI_enemy4.URL = "ui://bq3h5insoqgwa2";

    class WXFUI_enemy extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "enemy"));
        }
        onConstruct() {
            this.m_enemy = (this.getChild("enemy"));
        }
    }
    WXFUI_enemy.URL = "ui://bq3h5insoqgwa5";

    class WXFUI_WarView extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "WarView"));
        }
        onConstruct() {
            this.m_bg = (this.getChild("bg"));
            this.m_bg2 = (this.getChild("bg2"));
        }
    }
    WXFUI_WarView.URL = "ui://bq3h5insoqgwam";

    class WXFUI_goodsView extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "goodsView"));
        }
        onConstruct() {
            this.m_load = (this.getChild("load"));
        }
    }
    WXFUI_goodsView.URL = "ui://bq3h5insqz5ukq";

    class WXFUI_enemy10 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "enemy10"));
        }
        onConstruct() {
            this.m_load = (this.getChild("load"));
        }
    }
    WXFUI_enemy10.URL = "ui://bq3h5insqz5ukr";

    class WXFUI_enemy_fire_11 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "enemy_fire_11"));
        }
        onConstruct() {
            this.m_tank = (this.getChild("tank"));
            this.m_fire = (this.getChild("fire"));
        }
    }
    WXFUI_enemy_fire_11.URL = "ui://bq3h5insqz5uks";

    class WXFUI_enemy_fire_12 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "enemy_fire_12"));
        }
        onConstruct() {
            this.m_tank = (this.getChild("tank"));
            this.m_fire = (this.getChild("fire"));
        }
    }
    WXFUI_enemy_fire_12.URL = "ui://bq3h5insqz5ukt";

    class WXFUI_obstacleView extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "obstacleView"));
        }
        onConstruct() {
            this.m_load = (this.getChild("load"));
        }
    }
    WXFUI_obstacleView.URL = "ui://bq3h5insqz5uku";

    class WXFUI_ADItem extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "ADItem"));
        }
        onConstruct() {
            this.m_n0 = (this.getChild("n0"));
            this.m_icon = (this.getChild("icon"));
            this.m_name = (this.getChild("name"));
        }
    }
    WXFUI_ADItem.URL = "ui://bq3h5inss2x8ir";

    class WXFUI_ADmove extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "ADmove"));
        }
        onConstruct() {
            this.m_ad = (this.getChild("ad"));
            this.m_ani_1 = this.getTransition("ani_1");
            this.m_ani_2 = this.getTransition("ani_2");
        }
    }
    WXFUI_ADmove.URL = "ui://bq3h5inss2x8xs4";

    class WXFUI_ADListVer extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "ADListVer"));
        }
        onConstruct() {
            this.m_list = (this.getChild("list"));
            this.m_n4 = (this.getChild("n4"));
        }
    }
    WXFUI_ADListVer.URL = "ui://bq3h5inss2x8xs5";

    class WXFUI_ADListHor extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "ADListHor"));
        }
        onConstruct() {
            this.m_list = (this.getChild("list"));
            this.m_n4 = (this.getChild("n4"));
        }
    }
    WXFUI_ADListHor.URL = "ui://bq3h5inss2x8xs6";

    class WXFUI_ADremen extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "ADremen"));
        }
        onConstruct() {
            this.m_n2 = (this.getChild("n2"));
            this.m_ani_1 = this.getTransition("ani_1");
            this.m_ani_2 = this.getTransition("ani_2");
        }
    }
    WXFUI_ADremen.URL = "ui://bq3h5inss2x8xs7";

    class WXFUI_GoodsItem extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "GoodsItem"));
        }
        onConstruct() {
            this.m_ctl = this.getController("ctl");
            this.m_icon = (this.getChild("icon"));
            this.m_info = (this.getChild("info"));
            this.m_coin = (this.getChild("coin"));
            this.m_n12 = (this.getChild("n12"));
            this.m_ani = this.getTransition("ani");
        }
    }
    WXFUI_GoodsItem.URL = "ui://bq3h5insso8uxx3";

    class WXFUI_blood extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "blood"));
        }
        onConstruct() {
            this.m_ctl = this.getController("ctl");
            this.m_n0 = (this.getChild("n0"));
            this.m_n1 = (this.getChild("n1"));
            this.m_n4 = (this.getChild("n4"));
        }
    }
    WXFUI_blood.URL = "ui://bq3h5instckhxvn";

    class WXFUI_enemy6 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "enemy6"));
        }
        onConstruct() {
            this.m_en = (this.getChild("en"));
        }
    }
    WXFUI_enemy6.URL = "ui://bq3h5instvmxxoo";

    class WXFUI_enemy13 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "enemy13"));
        }
        onConstruct() {
            this.m_load = (this.getChild("load"));
        }
    }
    WXFUI_enemy13.URL = "ui://bq3h5instvmxxot";

    class WXFUI_enemy14 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "enemy14"));
        }
        onConstruct() {
            this.m_load = (this.getChild("load"));
        }
    }
    WXFUI_enemy14.URL = "ui://bq3h5instvmxxou";

    class WXFUI_enemy_fire_13 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "enemy_fire_13"));
        }
        onConstruct() {
            this.m_n1 = (this.getChild("n1"));
        }
    }
    WXFUI_enemy_fire_13.URL = "ui://bq3h5instvmxxov";

    class WXFUI_volume extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "volume"));
        }
        onConstruct() {
            this.m_ctl = this.getController("ctl");
            this.m_n4 = (this.getChild("n4"));
            this.m_n5 = (this.getChild("n5"));
            this.m_n6 = (this.getChild("n6"));
        }
    }
    WXFUI_volume.URL = "ui://bq3h5insugvixpi";

    class WXFUI_abandon extends fairygui.GButton {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "abandon"));
        }
        onConstruct() {
            this.m_button = this.getController("button");
            this.m_n7 = (this.getChild("n7"));
        }
    }
    WXFUI_abandon.URL = "ui://bq3h5insunfjxqr";

    class WXFUI_hostage extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "hostage"));
        }
        onConstruct() {
            this.m_en = (this.getChild("en"));
        }
    }
    WXFUI_hostage.URL = "ui://bq3h5insvmpqxtc";

    class WXFUI_sandan extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "sandan"));
        }
        onConstruct() {
            this.m_zidan = (this.getChild("zidan"));
        }
    }
    WXFUI_sandan.URL = "ui://bq3h5insvmpqxud";

    class WXFUI_zidan extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "zidan"));
        }
        onConstruct() {
            this.m_zidan = (this.getChild("zidan"));
        }
    }
    WXFUI_zidan.URL = "ui://bq3h5insyqv7ax";

    class GameBinder {
        static bindAll() {
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_damageView.URL, WXFUI_damageView);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_addGold.URL, WXFUI_addGold);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_enemy_fire_14.URL, WXFUI_enemy_fire_14);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_star.URL, WXFUI_star);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_jumpBtn.URL, WXFUI_jumpBtn);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_fireBtn.URL, WXFUI_fireBtn);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_throwBtn.URL, WXFUI_throwBtn);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_enemyStay_5.URL, WXFUI_enemyStay_5);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_enemy_fire_5.URL, WXFUI_enemy_fire_5);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_enemy5.URL, WXFUI_enemy5);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_backHomeBtn.URL, WXFUI_backHomeBtn);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_restartBtn.URL, WXFUI_restartBtn);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_continueBtn.URL, WXFUI_continueBtn);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_BeforeWar.URL, WXFUI_BeforeWar);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_buyItem.URL, WXFUI_buyItem);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_enterBtn.URL, WXFUI_enterBtn);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_buyBtn.URL, WXFUI_buyBtn);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_freeBtn.URL, WXFUI_freeBtn);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_AfterWar.URL, WXFUI_AfterWar);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_backBtn.URL, WXFUI_backBtn);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_continueBtn2.URL, WXFUI_continueBtn2);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_continueBtn3.URL, WXFUI_continueBtn3);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_continueBtn4.URL, WXFUI_continueBtn4);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_ChapterView.URL, WXFUI_ChapterView);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_LevelItem.URL, WXFUI_LevelItem);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_lastChapter.URL, WXFUI_lastChapter);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_nextChapter.URL, WXFUI_nextChapter);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_share.URL, WXFUI_share);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_shareBtn1.URL, WXFUI_shareBtn1);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_shareBtn2.URL, WXFUI_shareBtn2);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_enemy11.URL, WXFUI_enemy11);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_enemy12.URL, WXFUI_enemy12);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_Bomb.URL, WXFUI_Bomb);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_PlayerInfoView.URL, WXFUI_PlayerInfoView);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_PlayerCtlView.URL, WXFUI_PlayerCtlView);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_PlayerDirView.URL, WXFUI_PlayerDirView);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_dirBtn.URL, WXFUI_dirBtn);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_susBtn.URL, WXFUI_susBtn);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_ADListHorBig2.URL, WXFUI_ADListHorBig2);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_ADItemBig2.URL, WXFUI_ADItemBig2);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_freeView.URL, WXFUI_freeView);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_videoBtn.URL, WXFUI_videoBtn);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_lingquBtn.URL, WXFUI_lingquBtn);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_fangqiBtn.URL, WXFUI_fangqiBtn);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_guanbiBtn.URL, WXFUI_guanbiBtn);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_nextBtn.URL, WXFUI_nextBtn);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_chaBtn.URL, WXFUI_chaBtn);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_BoomView.URL, WXFUI_BoomView);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_ADReMenList.URL, WXFUI_ADReMenList);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_ADremen2.URL, WXFUI_ADremen2);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_ADListHorBig.URL, WXFUI_ADListHorBig);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_ADItemBig.URL, WXFUI_ADItemBig);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_OppoNativeADView.URL, WXFUI_OppoNativeADView);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_sanBeiBtn.URL, WXFUI_sanBeiBtn);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_nextBtn2.URL, WXFUI_nextBtn2);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_NativeADView.URL, WXFUI_NativeADView);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_seeAdBtn.URL, WXFUI_seeAdBtn);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_nativeClose.URL, WXFUI_nativeClose);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_PopUpView.URL, WXFUI_PopUpView);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_SuspendView.URL, WXFUI_SuspendView);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_enemy1.URL, WXFUI_enemy1);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_enemy2.URL, WXFUI_enemy2);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_enemy3.URL, WXFUI_enemy3);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_enemy4.URL, WXFUI_enemy4);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_enemy.URL, WXFUI_enemy);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_WarView.URL, WXFUI_WarView);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_goodsView.URL, WXFUI_goodsView);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_enemy10.URL, WXFUI_enemy10);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_enemy_fire_11.URL, WXFUI_enemy_fire_11);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_enemy_fire_12.URL, WXFUI_enemy_fire_12);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_obstacleView.URL, WXFUI_obstacleView);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_ADItem.URL, WXFUI_ADItem);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_ADmove.URL, WXFUI_ADmove);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_ADListVer.URL, WXFUI_ADListVer);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_ADListHor.URL, WXFUI_ADListHor);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_ADremen.URL, WXFUI_ADremen);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_GoodsItem.URL, WXFUI_GoodsItem);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_blood.URL, WXFUI_blood);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_enemy6.URL, WXFUI_enemy6);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_enemy13.URL, WXFUI_enemy13);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_enemy14.URL, WXFUI_enemy14);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_enemy_fire_13.URL, WXFUI_enemy_fire_13);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_TipsPopView.URL, WXFUI_TipsPopView);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_volume.URL, WXFUI_volume);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_abandon.URL, WXFUI_abandon);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_hostage.URL, WXFUI_hostage);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_ADListView.URL, WXFUI_ADListView);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_sandan.URL, WXFUI_sandan);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_zidan.URL, WXFUI_zidan);
        }
    }

    class WXFUI_loadingBar extends fairygui.GProgressBar {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("loading", "loadingBar"));
        }
        onConstruct() {
            this.m_n0 = (this.getChild("n0"));
            this.m_bar = (this.getChild("bar"));
            this.m_title = (this.getChild("title"));
        }
    }
    WXFUI_loadingBar.URL = "ui://nr80du74n8quim";

    class loadingBinder {
        static bindAll() {
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_loadingView.URL, WXFUI_loadingView);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_loadingBar.URL, WXFUI_loadingBar);
        }
    }

    class Main {
        constructor() {
            Laya.init(1334, 750, Laya["WebGL"]);
            Laya["Physics"] && Laya["Physics"].enable();
            Laya["DebugPanel"] && Laya["DebugPanel"].enable();
            Laya.stage.scaleMode = Laya.Stage.SCALE_FIXED_HEIGHT;
            Laya.stage.screenMode = Laya.Stage.SCREEN_HORIZONTAL;
            Laya.stage.alignV = Laya.Stage.ALIGN_CENTER;
            Laya.stage.alignH = Laya.Stage.ALIGN_MIDDLE;
            Laya.URL.exportSceneToJson = GameConfig.exportSceneToJson;
            if (GameManager.instance.platform == moosnow.APP_PLATFORM.QQ)
                Config.useRetinalCanvas = true;
            if (GameConfig.debug || Laya.Utils.getQueryString("debug") == "true")
                Laya.enableDebugPanel();
            if (GameConfig.physicsDebug && Laya["PhysicsDebugDraw"])
                Laya["PhysicsDebugDraw"].enable();
            if (GameConfig.stat)
                Laya.Stat.show();
            Laya.ResourceVersion.enable("version.json", Laya.Handler.create(this, this.onVersionLoaded), Laya.ResourceVersion.FILENAME_VERSION);
            fairygui.UIConfig.packageFileExtension = "proto";
            GameBinder.bindAll();
            loadingBinder.bindAll();
            MooSnowSDK.login();
        }
        onVersionLoaded() {
            AssetsManager.instance.loadLoadingAssetsData();
        }
        onConfigLoaded() {
        }
    }
    new Main();

}());
