/**This class is automatically generated by LayaAirIDE, please do not make any modifications. */
import View=Laya.View;
import Dialog=Laya.Dialog;
import Scene=Laya.Scene;
var REG: Function = Laya.ClassUtils.regClass;
export module ui {
    export class BoardBodyUI extends Laya.View {
        public static  uiView:any ={"type":"View","props":{"width":350,"height":25},"compId":2,"child":[{"type":"Sprite","props":{"y":0,"x":0,"texture":"2460.png"},"compId":5},{"type":"Script","props":{"y":0,"x":0,"width":350,"label":"board","isSensor":false,"height":25,"friction":0,"density":0,"runtime":"laya.physics.BoxCollider"},"compId":3},{"type":"Script","props":{"type":"static","label":"board","gravityScale":0,"allowRotation":false,"runtime":"laya.physics.RigidBody"},"compId":4}],"loadList":["2460.png"],"loadList3D":[]};
        constructor(){ super()}
        createChildren():void {
            super.createChildren();
            this.createView(BoardBodyUI.uiView);
        }
    }
    REG("ui.BoardBodyUI",BoardBodyUI);
    export class BombBodyUI extends Laya.View {
        public static  uiView:any ={"type":"View","props":{"width":25,"height":25},"compId":2,"child":[{"type":"Script","props":{"y":0,"x":0,"width":25,"isSensor":true,"height":25,"friction":0,"runtime":"laya.physics.BoxCollider"},"compId":3},{"type":"Script","props":{"gravityScale":1.5,"allowRotation":false,"runtime":"laya.physics.RigidBody"},"compId":4}],"loadList":[],"loadList3D":[]};
        constructor(){ super()}
        createChildren():void {
            super.createChildren();
            this.createView(BombBodyUI.uiView);
        }
    }
    REG("ui.BombBodyUI",BombBodyUI);
    export class BoomBodyUI extends Laya.View {
        public static  uiView:any ={"type":"View","props":{"width":90,"mouseEnabled":false,"height":90},"compId":2,"child":[{"type":"Script","props":{"y":0,"x":0,"radius":45,"isSensor":true,"friction":0,"density":0,"runtime":"laya.physics.CircleCollider"},"compId":5},{"type":"Script","props":{"type":"dynamic","gravityScale":0,"runtime":"laya.physics.RigidBody"},"compId":6}],"loadList":[],"loadList3D":[]};
        constructor(){ super()}
        createChildren():void {
            super.createChildren();
            this.createView(BoomBodyUI.uiView);
        }
    }
    REG("ui.BoomBodyUI",BoomBodyUI);
    export class BulletUI extends Laya.View {
        public static  uiView:any ={"type":"View","props":{"width":30,"height":15},"compId":2,"child":[{"type":"Script","props":{"y":0,"x":0,"width":30,"isSensor":true,"height":15,"friction":0,"runtime":"laya.physics.BoxCollider"},"compId":3},{"type":"Script","props":{"gravityScale":0,"allowRotation":false,"runtime":"laya.physics.RigidBody"},"compId":4}],"loadList":[],"loadList3D":[]};
        constructor(){ super()}
        createChildren():void {
            super.createChildren();
            this.createView(BulletUI.uiView);
        }
    }
    REG("ui.BulletUI",BulletUI);
    export class BulletPanUI extends Laya.View {
        public static  uiView:any ={"type":"View","props":{"width":180,"height":80},"compId":2,"child":[{"type":"Script","props":{"y":0,"x":0,"width":180,"isSensor":true,"height":80,"friction":0,"runtime":"laya.physics.BoxCollider"},"compId":3},{"type":"Script","props":{"gravityScale":0,"allowRotation":false,"runtime":"laya.physics.RigidBody"},"compId":4}],"loadList":[],"loadList3D":[]};
        constructor(){ super()}
        createChildren():void {
            super.createChildren();
            this.createView(BulletPanUI.uiView);
        }
    }
    REG("ui.BulletPanUI",BulletPanUI);
    export class BulletRifleUI extends Laya.View {
        public static  uiView:any ={"type":"View","props":{"width":347,"height":197},"compId":2,"child":[{"type":"Script","props":{"y":0,"x":0,"width":347,"isSensor":true,"height":197,"friction":0,"density":0,"runtime":"laya.physics.BoxCollider"},"compId":3},{"type":"Script","props":{"gravityScale":0,"allowRotation":false,"runtime":"laya.physics.RigidBody"},"compId":4}],"loadList":[],"loadList3D":[]};
        constructor(){ super()}
        createChildren():void {
            super.createChildren();
            this.createView(BulletRifleUI.uiView);
        }
    }
    REG("ui.BulletRifleUI",BulletRifleUI);
    export class BulletRifleUpUI extends Laya.View {
        public static  uiView:any ={"type":"View","props":{"width":197,"height":347},"compId":2,"child":[{"type":"Script","props":{"y":0,"x":0,"width":197,"isSensor":true,"height":347,"friction":0,"density":0,"runtime":"laya.physics.BoxCollider"},"compId":3},{"type":"Script","props":{"gravityScale":0,"allowRotation":false,"runtime":"laya.physics.RigidBody"},"compId":4}],"loadList":[],"loadList3D":[]};
        constructor(){ super()}
        createChildren():void {
            super.createChildren();
            this.createView(BulletRifleUpUI.uiView);
        }
    }
    REG("ui.BulletRifleUpUI",BulletRifleUpUI);
    export class BulletSanUI extends Laya.View {
        public static  uiView:any ={"type":"View","props":{"width":28,"height":28},"compId":2,"child":[{"type":"Script","props":{"y":0,"x":0,"width":28,"isSensor":true,"height":28,"friction":0,"runtime":"laya.physics.BoxCollider"},"compId":3},{"type":"Script","props":{"gravityScale":0,"allowRotation":false,"runtime":"laya.physics.RigidBody"},"compId":4}],"loadList":[],"loadList3D":[]};
        constructor(){ super()}
        createChildren():void {
            super.createChildren();
            this.createView(BulletSanUI.uiView);
        }
    }
    REG("ui.BulletSanUI",BulletSanUI);
    export class BulletUpUI extends Laya.View {
        public static  uiView:any ={"type":"View","props":{"width":15,"height":30},"compId":2,"child":[{"type":"Script","props":{"y":0,"x":0,"width":15,"isSensor":true,"height":30,"friction":0,"runtime":"laya.physics.BoxCollider"},"compId":3},{"type":"Script","props":{"gravityScale":0,"allowRotation":false,"runtime":"laya.physics.RigidBody"},"compId":4}],"loadList":[],"loadList3D":[]};
        constructor(){ super()}
        createChildren():void {
            super.createChildren();
            this.createView(BulletUpUI.uiView);
        }
    }
    REG("ui.BulletUpUI",BulletUpUI);
    export class ChopperBodyUI extends Laya.View {
        public static  uiView:any ={"type":"View","props":{"width":332,"height":172},"compId":2,"child":[{"type":"Script","props":{"y":0,"x":0,"width":332,"label":"enemy","isSensor":true,"height":172,"friction":0,"density":0,"runtime":"laya.physics.BoxCollider"},"compId":3},{"type":"Script","props":{"label":"enemy","gravityScale":0,"allowRotation":false,"runtime":"laya.physics.RigidBody"},"compId":4}],"loadList":[],"loadList3D":[]};
        constructor(){ super()}
        createChildren():void {
            super.createChildren();
            this.createView(ChopperBodyUI.uiView);
        }
    }
    REG("ui.ChopperBodyUI",ChopperBodyUI);
    export class ChopperBombUI extends Laya.View {
        public static  uiView:any ={"type":"View","props":{"width":32,"height":67},"compId":2,"child":[{"type":"Script","props":{"y":0,"x":0,"width":32,"label":"enemyBomb","isSensor":true,"height":67,"friction":0,"runtime":"laya.physics.BoxCollider"},"compId":3},{"type":"Script","props":{"label":"enemyBomb","gravityScale":1.5,"allowRotation":false,"runtime":"laya.physics.RigidBody"},"compId":4},{"type":"Sprite","props":{"y":0,"x":0,"texture":"zhadan_3.png"},"compId":6}],"loadList":["zhadan_3.png"],"loadList3D":[]};
        constructor(){ super()}
        createChildren():void {
            super.createChildren();
            this.createView(ChopperBombUI.uiView);
        }
    }
    REG("ui.ChopperBombUI",ChopperBombUI);
    export class EnemyBodyUI extends Laya.View {
        public static  uiView:any ={"type":"View","props":{"width":91,"height":91},"compId":2,"child":[{"type":"Script","props":{"width":91,"label":"enemy","isSensor":true,"height":91,"friction":0,"density":0,"runtime":"laya.physics.BoxCollider"},"compId":3},{"type":"Script","props":{"label":"enemy","group":0,"gravityScale":0,"allowRotation":false,"runtime":"laya.physics.RigidBody"},"compId":4}],"loadList":[],"loadList3D":[]};
        constructor(){ super()}
        createChildren():void {
            super.createChildren();
            this.createView(EnemyBodyUI.uiView);
        }
    }
    REG("ui.EnemyBodyUI",EnemyBodyUI);
    export class GoodsBodyUI extends Laya.View {
        public static  uiView:any ={"type":"View","props":{"width":47,"height":47},"compId":2,"child":[{"type":"Script","props":{"y":0,"x":0,"width":47,"label":"goods","isSensor":false,"height":47,"friction":0,"density":10,"runtime":"laya.physics.BoxCollider"},"compId":3},{"type":"Script","props":{"type":"dynamic","linearDamping":1,"label":"goods","gravityScale":1,"allowRotation":false,"runtime":"laya.physics.RigidBody"},"compId":4}],"loadList":[],"loadList3D":[]};
        constructor(){ super()}
        createChildren():void {
            super.createChildren();
            this.createView(GoodsBodyUI.uiView);
        }
    }
    REG("ui.GoodsBodyUI",GoodsBodyUI);
    export class HostageBodyUI extends Laya.View {
        public static  uiView:any ={"type":"View","props":{"width":76,"height":130},"compId":2,"child":[{"type":"Script","props":{"y":0,"x":0,"width":76,"label":"hostage","isSensor":true,"height":130,"friction":0,"density":0,"runtime":"laya.physics.BoxCollider"},"compId":3},{"type":"Script","props":{"label":"hostage","group":0,"gravityScale":0,"allowRotation":false,"runtime":"laya.physics.RigidBody"},"compId":4}],"loadList":[],"loadList3D":[]};
        constructor(){ super()}
        createChildren():void {
            super.createChildren();
            this.createView(HostageBodyUI.uiView);
        }
    }
    REG("ui.HostageBodyUI",HostageBodyUI);
    export class map_1UI extends Laya.Scene {
        public static  uiView:any ={"type":"Scene","props":{"width":50,"height":50},"compId":2,"child":[{"type":"Script","props":{"y":579,"x":1872,"points":"-825,-335,-825,-16,-4,-16,138,-42,262,-89,555,-89,615,-102,676,-138,923,-138,1348,30,1560,69,1561,-30,1600,5,1960,7,2197,96,3133,96","label":"ground","friction":0,"runtime":"laya.physics.ChainCollider"},"compId":12},{"type":"Script","props":{"y":0,"x":-800,"type":"static","label":"ground","group":0,"runtime":"laya.physics.RigidBody"},"compId":13}],"loadList":[],"loadList3D":[]};
        constructor(){ super()}
        createChildren():void {
            super.createChildren();
            this.createView(map_1UI.uiView);
        }
    }
    REG("ui.map_1UI",map_1UI);
    export class map_2UI extends Laya.Scene {
        public static  uiView:any ={"type":"Scene","props":{"width":50,"height":50},"compId":2,"child":[{"type":"Script","props":{"y":338.75,"x":828,"points":"-828,-340,-827,-52,-385,-29,21,58,825,112,3030,112,4199,-191","label":"ground","friction":0,"runtime":"laya.physics.ChainCollider"},"compId":12},{"type":"Script","props":{"y":-178,"x":-1848,"type":"static","label":"ground","group":0,"runtime":"laya.physics.RigidBody"},"compId":13}],"loadList":[],"loadList3D":[]};
        constructor(){ super()}
        createChildren():void {
            super.createChildren();
            this.createView(map_2UI.uiView);
        }
    }
    REG("ui.map_2UI",map_2UI);
    export class map_3UI extends Laya.Scene {
        public static  uiView:any ={"type":"Scene","props":{"width":50,"height":50},"compId":2,"child":[{"type":"Script","props":{"y":343,"x":832,"points":"0,-340,0,250,4199,250","label":"ground","friction":0,"runtime":"laya.physics.ChainCollider"},"compId":12},{"type":"Script","props":{"y":-167,"x":-1848,"type":"static","label":"ground","group":0,"runtime":"laya.physics.RigidBody"},"compId":13}],"loadList":[],"loadList3D":[]};
        constructor(){ super()}
        createChildren():void {
            super.createChildren();
            this.createView(map_3UI.uiView);
        }
    }
    REG("ui.map_3UI",map_3UI);
    export class map_4UI extends Laya.Scene {
        public static  uiView:any ={"type":"Scene","props":{"width":50,"height":50},"compId":2,"child":[{"type":"Script","props":{"y":342.75,"x":829,"points":"-800,-340,-800,250,-147,247,-146,186,-66,186,441,75,850,180,1156,180,1384,119,1651,180,2163,57,2705,182,2707,59,2782,57,3099,107,3301,163,3674,163,4199,250","label":"ground","friction":0,"runtime":"laya.physics.ChainCollider"},"compId":12},{"type":"Script","props":{"y":-167,"x":-1848,"type":"static","label":"ground","group":0,"runtime":"laya.physics.RigidBody"},"compId":13}],"loadList":[],"loadList3D":[]};
        constructor(){ super()}
        createChildren():void {
            super.createChildren();
            this.createView(map_4UI.uiView);
        }
    }
    REG("ui.map_4UI",map_4UI);
    export class map_5UI extends Laya.Scene {
        public static  uiView:any ={"type":"Scene","props":{"width":50,"height":50},"compId":2,"child":[{"type":"Script","props":{"y":414,"x":608,"points":"0,-340,0,250,4500,250","label":"ground","friction":0,"runtime":"laya.physics.ChainCollider"},"compId":12},{"type":"Script","props":{"y":-167,"x":-1848,"type":"static","label":"ground","group":0,"runtime":"laya.physics.RigidBody"},"compId":13}],"loadList":[],"loadList3D":[]};
        constructor(){ super()}
        createChildren():void {
            super.createChildren();
            this.createView(map_5UI.uiView);
        }
    }
    REG("ui.map_5UI",map_5UI);
    export class map_6UI extends Laya.Scene {
        public static  uiView:any ={"type":"Scene","props":{"width":50,"height":50},"compId":2,"child":[{"type":"Script","props":{"y":424,"x":0,"points":"0,-340,0,250,5100,250","label":"ground","friction":0,"runtime":"laya.physics.ChainCollider"},"compId":12},{"type":"Script","props":{"y":-167,"x":-1848,"type":"static","label":"ground","group":0,"runtime":"laya.physics.RigidBody"},"compId":13}],"loadList":[],"loadList3D":[]};
        constructor(){ super()}
        createChildren():void {
            super.createChildren();
            this.createView(map_6UI.uiView);
        }
    }
    REG("ui.map_6UI",map_6UI);
    export class map_7UI extends Laya.Scene {
        public static  uiView:any ={"type":"Scene","props":{"width":50,"height":50},"compId":2,"child":[{"type":"Script","props":{"y":428,"x":0,"points":"0,-340,0,250,5200,250","label":"ground","friction":0,"runtime":"laya.physics.ChainCollider"},"compId":12},{"type":"Script","props":{"y":-167,"x":-1848,"type":"static","label":"ground","group":0,"runtime":"laya.physics.RigidBody"},"compId":13}],"loadList":[],"loadList3D":[]};
        constructor(){ super()}
        createChildren():void {
            super.createChildren();
            this.createView(map_7UI.uiView);
        }
    }
    REG("ui.map_7UI",map_7UI);
    export class map_8UI extends Laya.Scene {
        public static  uiView:any ={"type":"Scene","props":{"width":50,"height":50},"compId":2,"child":[{"type":"BoardBody","props":{"y":674,"x":854,"name":"board_1","runtime":"ui.BoardBodyUI"},"compId":67},{"type":"BoardBody","props":{"y":674,"x":1306,"name":"board_2","runtime":"ui.BoardBodyUI"},"compId":68},{"type":"BoardBody","props":{"y":674,"x":1768,"name":"board_3","runtime":"ui.BoardBodyUI"},"compId":69},{"type":"Script","props":{"y":425,"x":29,"points":"0,-340,0,250,780,250","label":"ground","friction":0,"runtime":"laya.physics.ChainCollider"},"compId":12},{"type":"Script","props":{"y":-167,"x":-1848,"type":"static","label":"ground","group":0,"runtime":"laya.physics.RigidBody"},"compId":13},{"type":"Script","props":{"y":280,"x":2221,"points":"50,540,50,400,2429,400,2429,-300","label":"ground","friction":0,"runtime":"laya.physics.ChainCollider"},"compId":73}],"loadList":[],"loadList3D":[]};
        constructor(){ super()}
        createChildren():void {
            super.createChildren();
            this.createView(map_8UI.uiView);
        }
    }
    REG("ui.map_8UI",map_8UI);
    export class ObstacleBoomBodyUI extends Laya.View {
        public static  uiView:any ={"type":"View","props":{"width":150,"mouseEnabled":false,"height":150},"compId":2,"child":[{"type":"Script","props":{"y":0,"x":0,"radius":75,"isSensor":true,"friction":0,"density":0,"runtime":"laya.physics.CircleCollider"},"compId":5},{"type":"Script","props":{"type":"dynamic","gravityScale":0,"runtime":"laya.physics.RigidBody"},"compId":6}],"loadList":[],"loadList3D":[]};
        constructor(){ super()}
        createChildren():void {
            super.createChildren();
            this.createView(ObstacleBoomBodyUI.uiView);
        }
    }
    REG("ui.ObstacleBoomBodyUI",ObstacleBoomBodyUI);
    export class ObstacleView_1UI extends Laya.Scene {
        public static  uiView:any ={"type":"Scene","props":{"width":182,"height":96},"compId":2,"child":[{"type":"Script","props":{"y":0,"x":0,"points":"55,17,116,17,185,97,-1,97","label":"obstacle","isSensor":false,"friction":0,"runtime":"laya.physics.PolygonCollider"},"compId":4},{"type":"Script","props":{"y":0,"x":0,"type":"static","label":"obstacle","gravityScale":1,"runtime":"laya.physics.RigidBody"},"compId":5}],"loadList":[],"loadList3D":[]};
        constructor(){ super()}
        createChildren():void {
            super.createChildren();
            this.createView(ObstacleView_1UI.uiView);
        }
    }
    REG("ui.ObstacleView_1UI",ObstacleView_1UI);
    export class ObstacleView_10UI extends Laya.Scene {
        public static  uiView:any ={"type":"Scene","props":{"width":394,"height":241},"compId":2,"child":[{"type":"Script","props":{"y":0,"x":0,"points":"0,165,41,165,44,27,355,28,353,174,394,174,394,240,0,239","label":"obstacle","friction":0,"runtime":"laya.physics.PolygonCollider"},"compId":4},{"type":"Script","props":{"y":0,"x":0,"type":"static","label":"obstacle","runtime":"laya.physics.RigidBody"},"compId":5}],"loadList":[],"loadList3D":[]};
        constructor(){ super()}
        createChildren():void {
            super.createChildren();
            this.createView(ObstacleView_10UI.uiView);
        }
    }
    REG("ui.ObstacleView_10UI",ObstacleView_10UI);
    export class ObstacleView_11UI extends Laya.Scene {
        public static  uiView:any ={"type":"Scene","props":{"width":131,"height":70},"compId":2,"child":[{"type":"Script","props":{"y":-3,"x":0,"points":"1,3,130,3,130,73,0,74","label":"obstacle","friction":0,"runtime":"laya.physics.PolygonCollider"},"compId":4},{"type":"Script","props":{"y":0,"x":0,"type":"static","label":"obstacle","runtime":"laya.physics.RigidBody"},"compId":5}],"loadList":[],"loadList3D":[]};
        constructor(){ super()}
        createChildren():void {
            super.createChildren();
            this.createView(ObstacleView_11UI.uiView);
        }
    }
    REG("ui.ObstacleView_11UI",ObstacleView_11UI);
    export class ObstacleView_2UI extends Laya.Scene {
        public static  uiView:any ={"type":"Scene","props":{"width":92,"height":119},"compId":2,"child":[{"type":"Script","props":{"y":0,"x":0,"points":"1,3,91,3,90,120,0,119","label":"obstacle","friction":0,"runtime":"laya.physics.PolygonCollider"},"compId":4},{"type":"Script","props":{"y":0,"x":0,"type":"static","label":"obstacle","runtime":"laya.physics.RigidBody"},"compId":5}],"loadList":[],"loadList3D":[]};
        constructor(){ super()}
        createChildren():void {
            super.createChildren();
            this.createView(ObstacleView_2UI.uiView);
        }
    }
    REG("ui.ObstacleView_2UI",ObstacleView_2UI);
    export class ObstacleView_3UI extends Laya.Scene {
        public static  uiView:any ={"type":"Scene","props":{"width":292,"height":145},"compId":2,"child":[{"type":"Script","props":{"y":-94,"x":0,"points":"0,165,41,165,43,121,260,121,260,170,291,170,290,239,0,239","label":"obstacle","friction":0,"runtime":"laya.physics.PolygonCollider"},"compId":4},{"type":"Script","props":{"y":0,"x":0,"type":"static","label":"obstacle","runtime":"laya.physics.RigidBody"},"compId":5}],"loadList":[],"loadList3D":[]};
        constructor(){ super()}
        createChildren():void {
            super.createChildren();
            this.createView(ObstacleView_3UI.uiView);
        }
    }
    REG("ui.ObstacleView_3UI",ObstacleView_3UI);
    export class ObstacleView_4UI extends Laya.Scene {
        public static  uiView:any ={"type":"Scene","props":{"width":781,"height":236},"compId":2,"child":[{"type":"Script","props":{"y":-94,"x":0,"points":"32,246,65,246,65,132,707,131,704,252,740,253,740,329,32,329","label":"obstacle","friction":0,"runtime":"laya.physics.PolygonCollider"},"compId":4},{"type":"Script","props":{"y":0,"x":0,"type":"static","label":"obstacle","runtime":"laya.physics.RigidBody"},"compId":5}],"loadList":[],"loadList3D":[]};
        constructor(){ super()}
        createChildren():void {
            super.createChildren();
            this.createView(ObstacleView_4UI.uiView);
        }
    }
    REG("ui.ObstacleView_4UI",ObstacleView_4UI);
    export class ObstacleView_5UI extends Laya.Scene {
        public static  uiView:any ={"type":"Scene","props":{"width":452,"height":236},"compId":2,"child":[{"type":"Script","props":{"y":0,"x":0,"points":"0,165,41,165,43,50,405,50,404,174,445,174,445,239,0,239","label":"obstacle","friction":0,"runtime":"laya.physics.PolygonCollider"},"compId":4},{"type":"Script","props":{"y":0,"x":0,"type":"static","label":"obstacle","runtime":"laya.physics.RigidBody"},"compId":5}],"loadList":[],"loadList3D":[]};
        constructor(){ super()}
        createChildren():void {
            super.createChildren();
            this.createView(ObstacleView_5UI.uiView);
        }
    }
    REG("ui.ObstacleView_5UI",ObstacleView_5UI);
    export class ObstacleView_6UI extends Laya.Scene {
        public static  uiView:any ={"type":"Scene","props":{"width":181,"height":230},"compId":2,"child":[{"type":"Script","props":{"y":-94,"x":0,"points":"0,91,180,93,178,324,50,324","label":"obstacle","friction":0,"runtime":"laya.physics.PolygonCollider"},"compId":4},{"type":"Script","props":{"y":0,"x":0,"type":"static","label":"obstacle","runtime":"laya.physics.RigidBody"},"compId":5}],"loadList":[],"loadList3D":[]};
        constructor(){ super()}
        createChildren():void {
            super.createChildren();
            this.createView(ObstacleView_6UI.uiView);
        }
    }
    REG("ui.ObstacleView_6UI",ObstacleView_6UI);
    export class ObstacleView_7UI extends Laya.Scene {
        public static  uiView:any ={"type":"Scene","props":{"width":295,"height":98},"compId":2,"child":[{"type":"Script","props":{"y":-140,"x":0,"points":"0,165,290,165,290,239,0,239","label":"obstacle","friction":0,"runtime":"laya.physics.PolygonCollider"},"compId":4},{"type":"Script","props":{"y":0,"x":0,"type":"static","label":"obstacle","runtime":"laya.physics.RigidBody"},"compId":5}],"loadList":[],"loadList3D":[]};
        constructor(){ super()}
        createChildren():void {
            super.createChildren();
            this.createView(ObstacleView_7UI.uiView);
        }
    }
    REG("ui.ObstacleView_7UI",ObstacleView_7UI);
    export class ObstacleView_8UI extends Laya.Scene {
        public static  uiView:any ={"type":"Scene","props":{"width":197,"height":73},"compId":2,"child":[{"type":"Script","props":{"y":-165,"x":0,"points":"0,183,14,222,182,222,196,181,196,238,0,238","label":"obstacle","friction":0,"runtime":"laya.physics.PolygonCollider"},"compId":4},{"type":"Script","props":{"y":0,"x":0,"type":"static","label":"obstacle","runtime":"laya.physics.RigidBody"},"compId":5}],"loadList":[],"loadList3D":[]};
        constructor(){ super()}
        createChildren():void {
            super.createChildren();
            this.createView(ObstacleView_8UI.uiView);
        }
    }
    REG("ui.ObstacleView_8UI",ObstacleView_8UI);
    export class ObstacleView_9UI extends Laya.Scene {
        public static  uiView:any ={"type":"Scene","props":{"width":92,"height":119},"compId":2,"child":[{"type":"Script","props":{"y":0,"x":0,"points":"1,3,87,3,87,120,0,119","label":"obstacle","friction":0,"runtime":"laya.physics.PolygonCollider"},"compId":4},{"type":"Script","props":{"y":0,"x":0,"type":"static","label":"obstacle","runtime":"laya.physics.RigidBody"},"compId":5}],"loadList":[],"loadList3D":[]};
        constructor(){ super()}
        createChildren():void {
            super.createChildren();
            this.createView(ObstacleView_9UI.uiView);
        }
    }
    REG("ui.ObstacleView_9UI",ObstacleView_9UI);
    export class PlayerBodyUI extends Laya.View {
        public static  uiView:any ={"type":"View","props":{"width":55,"height":105},"compId":2,"child":[{"type":"Script","props":{"y":0,"x":0,"width":55,"label":"player","isSensor":false,"height":105,"friction":0,"density":20,"runtime":"laya.physics.BoxCollider"},"compId":3},{"type":"Script","props":{"type":"dynamic","label":"player","group":0,"gravityScale":2.5,"allowRotation":false,"runtime":"laya.physics.RigidBody"},"compId":4}],"loadList":[],"loadList3D":[]};
        constructor(){ super()}
        createChildren():void {
            super.createChildren();
            this.createView(PlayerBodyUI.uiView);
        }
    }
    REG("ui.PlayerBodyUI",PlayerBodyUI);
    export class TankBody11UI extends Laya.View {
        public static  uiView:any ={"type":"View","props":{"width":227,"height":110},"compId":2,"child":[{"type":"Script","props":{"y":0,"x":0,"width":227,"label":"enemy","isSensor":true,"height":110,"friction":0,"density":0,"runtime":"laya.physics.BoxCollider"},"compId":3},{"type":"Script","props":{"label":"enemy","gravityScale":0,"allowRotation":false,"runtime":"laya.physics.RigidBody"},"compId":4}],"loadList":[],"loadList3D":[]};
        constructor(){ super()}
        createChildren():void {
            super.createChildren();
            this.createView(TankBody11UI.uiView);
        }
    }
    REG("ui.TankBody11UI",TankBody11UI);
    export class TankBody12UI extends Laya.View {
        public static  uiView:any ={"type":"View","props":{"width":256,"height":130},"compId":2,"child":[{"type":"Script","props":{"y":0,"x":0,"width":256,"label":"enemy","isSensor":true,"height":130,"friction":0,"density":0,"runtime":"laya.physics.BoxCollider"},"compId":3},{"type":"Script","props":{"label":"enemy","gravityScale":0,"allowRotation":false,"runtime":"laya.physics.RigidBody"},"compId":4}],"loadList":[],"loadList3D":[]};
        constructor(){ super()}
        createChildren():void {
            super.createChildren();
            this.createView(TankBody12UI.uiView);
        }
    }
    REG("ui.TankBody12UI",TankBody12UI);
    export class TankBody13UI extends Laya.View {
        public static  uiView:any ={"type":"View","props":{"width":298,"height":119},"compId":2,"child":[{"type":"Script","props":{"y":0,"x":0,"width":298,"label":"enemy","isSensor":true,"height":119,"friction":0,"density":0,"runtime":"laya.physics.BoxCollider"},"compId":3},{"type":"Script","props":{"label":"enemy","gravityScale":0,"allowRotation":false,"runtime":"laya.physics.RigidBody"},"compId":4}],"loadList":[],"loadList3D":[]};
        constructor(){ super()}
        createChildren():void {
            super.createChildren();
            this.createView(TankBody13UI.uiView);
        }
    }
    REG("ui.TankBody13UI",TankBody13UI);
    export class TankBody14UI extends Laya.View {
        public static  uiView:any ={"type":"View","props":{"width":253,"height":106},"compId":2,"child":[{"type":"Script","props":{"y":0,"x":0,"width":253,"label":"enemy","isSensor":true,"height":106,"friction":0,"density":0,"runtime":"laya.physics.BoxCollider"},"compId":3},{"type":"Script","props":{"label":"enemy","gravityScale":0,"allowRotation":false,"runtime":"laya.physics.RigidBody"},"compId":4}],"loadList":[],"loadList3D":[]};
        constructor(){ super()}
        createChildren():void {
            super.createChildren();
            this.createView(TankBody14UI.uiView);
        }
    }
    REG("ui.TankBody14UI",TankBody14UI);
}