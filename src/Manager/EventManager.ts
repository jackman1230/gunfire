
export class EventManager extends Laya.EventDispatcher {
    static eventDispatcher: Laya.EventDispatcher = new Laya.EventDispatcher();
    private static _instance: EventManager;

    public static get instance(): EventManager {
        if (this._instance == null)
            this._instance = new EventManager();
        return this._instance;
    }

    constructor() {
        super();
    }
    ///注册事件
    public dispatcherEvt(InName, agv?: any) {
        //派发事件
        // console.log("派发事件", InName);
        EventManager.eventDispatcher.event(InName, agv);
    }
    //侦听事件
    public addNotice(InName, caller, listener: Function, arg?: any[]): void {
        // console.log("侦听事件", InName);
        EventManager.eventDispatcher.on(InName, caller, listener, (arg == null) ? null : ([arg]));
    }

    //移除侦听事件
    public offNotice(InName, caller, listener: Function): void {
        // console.log("侦听事件", InName);
        EventManager.eventDispatcher.off(InName, caller, listener);
    }
}