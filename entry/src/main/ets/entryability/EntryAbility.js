import hilog from '@ohos.hilog';
import UIAbility from '@ohos.app.ability.UIAbility';
export default class EntryAbility extends UIAbility {
    onCreate(want, launchParam) {
        hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
    }
    onDestroy() {
        hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
    }
    onWindowStageCreate(windowStage) {
        // Main window is created, set main page for this ability
        hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');
        let windowClass = null;
        windowStage.getMainWindow((err, data) => {
            if (err.code) {
                console.error('Failed to obtain the main window. Cause: ' + JSON.stringify(err));
                return;
            }
            windowClass = data;
            console.info('Succeeded in obtaining the main window. Data: ' + JSON.stringify(data));
            // 2.实现沉浸式效果：设置导航栏、状态栏不显示。
            let names = ['status'];
            windowClass.setWindowSystemBarEnable(names, (err) => {
                if (err.code) {
                    console.error('Failed to set the system bar to be visible. Cause:' + JSON.stringify(err));
                    return;
                }
                console.info('Succeeded in setting the system bar to be visible.');
            });
            windowClass.setWindowLayoutFullScreen(true);
        });
        globalThis.context = this.context;
        windowStage.loadContent('pages/start', (err, data) => {
            var _a, _b;
            if (err.code) {
                hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', (_a = JSON.stringify(err)) !== null && _a !== void 0 ? _a : '');
                return;
            }
            hilog.info(0x0000, 'testTag', 'Succeeded in loading the content. Data: %{public}s', (_b = JSON.stringify(data)) !== null && _b !== void 0 ? _b : '');
        });
    }
    onWindowStageDestroy() {
        // Main window is destroyed, release UI related resources
        hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
    }
    onForeground() {
        // Ability has brought to foreground
        hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
    }
    onBackground() {
        // Ability has back to background
        hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
    }
}
//# sourceMappingURL=EntryAbility.js.map