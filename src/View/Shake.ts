
export default class Shake {

    private _isShaking: boolean = false;
    private _startTime: number = 0;
    private _offsetPos: number[] = [0, 0];
    private shank_I: number = 0;
    private _target: Laya.Sprite;
    private _orgX: number = 0;
    private _orgY: number = 0;
    constructor() { }

    /**
     * 振动
     * @param intensity 振动频率(单位：毫秒)
     * @param duration 振动时间（单位：毫秒）
     * @param radius 振动半径
     *
     * @example
     * 振屏：Mgr.sceneMgr.sceneExt.jscene.camare.shake();
     */
    exe(target: Laya.Sprite, intensity: number, duration: number, radius: number) {
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

    private _pos(duration: number, radius: number) {
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