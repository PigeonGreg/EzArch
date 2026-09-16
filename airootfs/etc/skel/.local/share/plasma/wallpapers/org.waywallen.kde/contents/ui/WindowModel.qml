import QtQuick
import org.kde.taskmanager 0.1 as TaskManager

Item {
    id: wm

    // Wallpaper-local rect (set by parent). Drives `filterByScreen`
    // semantics — only windows whose centroid lies inside this rect
    // are counted.
    property var screenGeometry

    readonly property int flags: _flags
    property int _flags: 0

    // Debug-only snapshot of the windows that survived activity /
    // virtual-desktop / screen filtering. Consumed by the ShowDiagnostics
    // overlay; the daemon never sees this — it only gets the bitmask.
    readonly property var windows: _windows
    property var _windows: []

    TaskManager.ActivityInfo { id: activityInfo }
    TaskManager.VirtualDesktopInfo { id: vdInfo }

    TaskManager.TasksModel {
        id: tasksModel
        sortMode:               TaskManager.TasksModel.SortVirtualDesktop
        groupMode:              TaskManager.TasksModel.GroupDisabled
        filterByVirtualDesktop: true
        virtualDesktop:         vdInfo.currentDesktop
        filterByScreen:         true
        screenGeometry:         wm.screenGeometry

        onActiveTaskChanged: wm.recompute()
        onDataChanged:       wm.recompute()
        onCountChanged:      wm.recompute()
    }

    Component.onCompleted: recompute()
    onScreenGeometryChanged: recompute()

    function _role(idx, name) {
        return tasksModel.data(idx, TaskManager.AbstractTasksModel[name]);
    }

    function recompute() {
        let f = 0;
        const list = [];
        const act = activityInfo.currentActivity;
        for (let i = 0; i < tasksModel.count; i++) {
            const idx = tasksModel.makeModelIndex(i);
            if (_role(idx, "IsWindow") !== true)        continue;
            // Mirror old WindowModel.qml's activity scoping: drop
            // windows that explicitly list activities AND don't
            // include the current one. Windows with no activity list
            // are taken as "on every activity" and counted.
            const acts = _role(idx, "Activities");
            if (acts && acts.length && acts.indexOf(act) === -1) continue;
            const isMin  = _role(idx, "IsMinimized")  === true;
            const isAct  = _role(idx, "IsActive")     === true;
            const isFull = _role(idx, "IsFullScreen") === true;
            const isMax  = _role(idx, "IsMaximized")  === true;
            list.push({
                title:      tasksModel.data(idx, 0) || "",  // Qt::DisplayRole
                app:        _role(idx, "AppName")   || "",
                minimized:  isMin,
                active:     isAct,
                maximized:  isMax,
                fullscreen: isFull,
            });
            if (isMin) continue;
            f |= 1; // NON_MINIMIZED
            if (isAct)  f |= 2; // ACTIVE
            if (isFull) {
                f |= 8; // FULLSCREEN
            } else if (isMax) {
                f |= 4; // MAXIMIZED
            }
        }
        if (f !== _flags) _flags = f;
        _windows = list;
    }
}
