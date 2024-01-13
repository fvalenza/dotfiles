'use strict';

/* Logging
 * Written by Sergey
*/
let debug = false;
/**
 * If called with a false argument, log statements are suppressed.
 */
function setLoggingEnabled(enabled) {
    debug = enabled;
}
/**
 * Log logs the given message using the gnome shell logger (global.log) if the
 * debug variable is set to true.
 *
 * Debug messages may be viewed using the bash command `journalctl
 * /usr/bin/gnome-shell` and grepping the results for 'gSnap'.
 */
function log(message) {
    if (debug) {
        global.log("gSnap " + message);
    }
}

/* Determine if gnome-shell version newer than required
 * Written by Sergey
*/
function getConfig() {
    return imports.misc.config;
}
const VERSION_34 = { major: 3, minor: 34 };
const VERSION_36 = { major: 3, minor: 36 };
const VERSION_41 = { major: 41, minor: 0 };
/**
 * ShellVersion is used to parse the version string
 */
class ShellVersion {
    constructor(version) {
        const parts = version.split('.').map((part) => Number(part));
        if (parts.length < 2) {
            throw new Error(`invalid version supplied: ${version}`);
        }
        this.major = parts[0];
        this.minor = parts[1];
        // Tolerate "40.alpha.1" for example. See https://github.com/gSnap/gSnap/issues/187.
        if (isNaN(this.minor)) {
            this.minor = 0;
        }
        if (isNaN(this.major)) {
            throw new Error(`invalid version supplied: ${JSON.stringify(version)}; got major = ${this.major}, minor = ${this.minor}`);
        }
        this.rawVersion = version;
    }
    static defaultVersion() {
        return ShellVersion.parse(getConfig().PACKAGE_VERSION);
    }
    static parse(version) {
        return new ShellVersion(version);
    }
    version_at_least_34() {
        return versionGreaterThanOrEqualTo(this, VERSION_34);
    }
    version_at_least_36() {
        return versionGreaterThanOrEqualTo(this, VERSION_36);
    }
    version_at_least_41() {
        return versionGreaterThanOrEqualTo(this, VERSION_41);
    }
    print_version() {
        log("Init gnome-shell version " + this.rawVersion + " major " + this.major + " minor " + this.minor);
    }
}
/**
 * Returns true if a is >= b.
 */
function versionGreaterThanOrEqualTo(a, b) {
    return a.major > b.major || (a.major === b.major && a.minor >= b.minor);
}

// Library imports
const Main$3 = imports.ui.main;
const Meta = imports.gi.Meta;
const Shell = imports.gi.Shell;
// Extension imports
imports.misc.extensionUtils.getCurrentExtension();
const ExtensionUtils$2 = imports.misc.extensionUtils;
function bind(keyBindings) {
    // Globals
    let settings = ExtensionUtils$2.getSettings();
    log("Binding keys");
    keyBindings.forEach((callback, key) => {
        //const key = keyString as KeyBindingSettingName;
        if (Main$3.wm.addKeybinding && Shell.ActionMode) { // introduced in 3.16
            Main$3.wm.addKeybinding(key, settings, Meta.KeyBindingFlags.NONE, Shell.ActionMode.NORMAL, callback);
        }
        else if (Main$3.wm.addKeybinding && Shell.KeyBindingMode) { // introduced in 3.7.5
            Main$3.wm.addKeybinding(key, settings, Meta.KeyBindingFlags.NONE, Shell.KeyBindingMode.NORMAL | Shell.KeyBindingMode.MESSAGE_TRAY, callback);
        }
        else {
            global.display.add_keybinding(key, settings, Meta.KeyBindingFlags.NONE, callback);
        }
    });
}
function unbind(keyBindings) {
    log("Unbinding keys");
    for (let key of keyBindings.keys()) {
        if (Main$3.wm.removeKeybinding) { // introduced in 3.7.2
            Main$3.wm.removeKeybinding(key);
        }
        else {
            global.display.remove_keybinding(key);
        }
    }
}

/**
 * @fileoverview This file contains incomplete typings for gnome shell types.
 *
 * Probably the best source of definitive API documentation is here:
 * https://gjs-docs.gnome.org/
 *
 * However, there are also some ways the GJS works that make the API docs above
 * slightly incomplete.
 * https://wiki.gnome.org/Projects/GnomeShell/Extensions/StepByStepTutorial
 * mentions that constructors can take a property map as an argument. This file
 * does not correctly type the constructors for these types.
 */
/** From https://gjs-docs.gnome.org/meta8~8/meta.sizechange */
var MetaSizeChange;
(function (MetaSizeChange) {
    MetaSizeChange[MetaSizeChange["MAXIMIZE"] = 0] = "MAXIMIZE";
    MetaSizeChange[MetaSizeChange["UNMAXIMIZE"] = 1] = "UNMAXIMIZE";
    MetaSizeChange[MetaSizeChange["FULLSCREEN"] = 2] = "FULLSCREEN";
    MetaSizeChange[MetaSizeChange["UNFULLSCREEN"] = 3] = "UNFULLSCREEN";
})(MetaSizeChange || (MetaSizeChange = {}));
/**
 * From https://gjs-docs.gnome.org/meta4~4_api/meta.frametype.
 */
var FrameType;
(function (FrameType) {
    FrameType[FrameType["NORMAL"] = 0] = "NORMAL";
    FrameType[FrameType["DIALOG"] = 1] = "DIALOG";
    FrameType[FrameType["MODAL_DIALOG"] = 2] = "MODAL_DIALOG";
    FrameType[FrameType["UTILITY"] = 3] = "UTILITY";
    FrameType[FrameType["MENU"] = 4] = "MENU";
    FrameType[FrameType["BORDER"] = 5] = "BORDER";
    FrameType[FrameType["ATTACHED"] = 6] = "ATTACHED";
    FrameType[FrameType["LAST"] = 7] = "LAST";
})(FrameType || (FrameType = {}));
var WindowType;
(function (WindowType) {
    WindowType[WindowType["NORMAL"] = 0] = "NORMAL";
    WindowType[WindowType["DESKTOP"] = 1] = "DESKTOP";
    WindowType[WindowType["DOCK"] = 2] = "DOCK";
    WindowType[WindowType["DIALOG"] = 3] = "DIALOG";
    WindowType[WindowType["MODAL_DIALOG"] = 4] = "MODAL_DIALOG";
    WindowType[WindowType["TOOLBAR"] = 5] = "TOOLBAR";
    WindowType[WindowType["MENU"] = 6] = "MENU";
    WindowType[WindowType["UTILITY"] = 7] = "UTILITY";
    WindowType[WindowType["SPLASHSCREEN"] = 8] = "SPLASHSCREEN";
    WindowType[WindowType["DROPDOWN_MENU"] = 9] = "DROPDOWN_MENU";
    WindowType[WindowType["POPUP_MENU"] = 10] = "POPUP_MENU";
    WindowType[WindowType["TOOLTIP"] = 11] = "TOOLTIP";
    WindowType[WindowType["NOTIFICATION"] = 12] = "NOTIFICATION";
    WindowType[WindowType["COMBO"] = 13] = "COMBO";
    WindowType[WindowType["DND"] = 14] = "DND";
    WindowType[WindowType["OVERRIDE_OTHER"] = 15] = "OVERRIDE_OTHER";
})(WindowType || (WindowType = {}));
var MaximizeFlags;
(function (MaximizeFlags) {
    MaximizeFlags[MaximizeFlags["HORIZONTAL"] = 1] = "HORIZONTAL";
    MaximizeFlags[MaximizeFlags["VERTICAL"] = 2] = "VERTICAL";
    MaximizeFlags[MaximizeFlags["BOTH"] = 3] = "BOTH";
})(MaximizeFlags || (MaximizeFlags = {}));

// GENERATED CODE: DO NOT EDIT
//
// Run extract_settings_type_definitions instead.
class ParsedSettings {
    constructor() {
        /** Enable or disable animations when hovering and selecting zones */
        this["animations-enabled"] = true;
        /** Put debug lines into global.log. To see, run journalctl /usr/bin/gnome-shell -f in terminal */
        this["debug"] = false;
        /** Keyboard presets are always active (as opposed active only when tiling window is visible). */
        this["global-presets"] = true;
        /** Bottom gap around border of screen for primary monitor */
        this["insets-primary-bottom"] = 0;
        /** Left gap around border of screen for primary monitor */
        this["insets-primary-left"] = 0;
        /** Right gap around border of screen for primary monitor */
        this["insets-primary-right"] = 0;
        /** Top gap around border of screen for primary monitor */
        this["insets-primary-top"] = 0;
        /** Bottom gap around border of screen for secondary monitor */
        this["insets-secondary-bottom"] = 0;
        /** Left gap around border of screen for secondary monitor */
        this["insets-secondary-left"] = 0;
        /** Right gap around border of screen for secondary monitor */
        this["insets-secondary-right"] = 0;
        /** Top gap around border of screen for secondary monitor */
        this["insets-secondary-top"] = 0;
        /** Move focused window down */
        this["move-focused-down"] = ['<Super>Down'];
        /** Move focused window left */
        this["move-focused-left"] = ['<Super>Left'];
        /** Move focused window right */
        this["move-focused-right"] = ['<Super>Right'];
        /** Move focused window up */
        this["move-focused-up"] = ['<Super>Up'];
        /** Enables shortcuts for moving and resizing the current window. */
        this["moveresize-enabled"] = true;
        /** Preset resize 1. */
        this["preset-resize-1"] = ['<Super><Alt>KP_1'];
        /** Preset resize 1. */
        this["preset-resize-10"] = [''];
        /** Preset resize 11. */
        this["preset-resize-11"] = ['<Super><Control>KP_1'];
        /** Preset resize 12. */
        this["preset-resize-12"] = ['<Super><Control>KP_2'];
        /** Preset resize 13. */
        this["preset-resize-13"] = ['<Super><Control>KP_3'];
        /** Preset resize 14. */
        this["preset-resize-14"] = ['<Super><Control>KP_4'];
        /** Preset resize 15. */
        this["preset-resize-15"] = ['<Super><Control>KP_5'];
        /** Preset resize 16. */
        this["preset-resize-16"] = ['<Super><Control>KP_6'];
        /** Preset resize 17. */
        this["preset-resize-17"] = ['<Super><Control>KP_7'];
        /** Preset resize 18. */
        this["preset-resize-18"] = ['<Super><Control>KP_8'];
        /** Preset resize 19. */
        this["preset-resize-19"] = ['<Super><Control>KP_9'];
        /** Preset resize 2. */
        this["preset-resize-2"] = ['<Super><Alt>KP_2'];
        /** Preset resize 20. */
        this["preset-resize-20"] = [''];
        /** Preset resize 21. */
        this["preset-resize-21"] = ['<Super><Shift>KP_1'];
        /** Preset resize 22. */
        this["preset-resize-22"] = ['<Super><Shift>KP_2'];
        /** Preset resize 23. */
        this["preset-resize-23"] = ['<Super><Shift>KP_3'];
        /** Preset resize 24. */
        this["preset-resize-24"] = ['<Super><Shift>KP_4'];
        /** Preset resize 25. */
        this["preset-resize-25"] = ['<Super><Shift>KP_5'];
        /** Preset resize 26. */
        this["preset-resize-26"] = ['<Super><Shift>KP_6'];
        /** Preset resize 27. */
        this["preset-resize-27"] = ['<Super><Shift>KP_7'];
        /** Preset resize 28. */
        this["preset-resize-28"] = ['<Super><Shift>KP_8'];
        /** Preset resize 29. */
        this["preset-resize-29"] = ['<Super><Shift>KP_9'];
        /** Preset resize 3. */
        this["preset-resize-3"] = ['<Super><Alt>KP_3'];
        /** Preset resize 30. */
        this["preset-resize-30"] = [''];
        /** Preset resize 4. */
        this["preset-resize-4"] = ['<Super><Alt>KP_4'];
        /** Preset resize 5. */
        this["preset-resize-5"] = ['<Super><Alt>KP_5'];
        /** Preset resize 6. */
        this["preset-resize-6"] = ['<Super><Alt>KP_6'];
        /** Preset resize 7. */
        this["preset-resize-7"] = ['<Super><Alt>KP_7'];
        /** Preset resize 8. */
        this["preset-resize-8"] = ['<Super><Alt>KP_8'];
        /** Preset resize 9. */
        this["preset-resize-9"] = ['<Super><Alt>KP_9'];
        /** Show gSnap icon on a panel. */
        this["show-icon"] = true;
        /** Show tabs for windows in each zone. */
        this["show-tabs"] = true;
        /** Hold ALT to span multiple zones */
        this["span-multiple-zones"] = false;
        /** Hold CTRL to snap windows */
        this["use-modifier"] = false;
        /** Gaps between windows in the middle of screen */
        this["window-margin"] = 0;
    }
}
const ANIMATIONS_ENABLED = "animations-enabled";
const DEBUG = "debug";
const GLOBAL_PRESETS = "global-presets";
const INSETS_PRIMARY_BOTTOM = "insets-primary-bottom";
const INSETS_PRIMARY_LEFT = "insets-primary-left";
const INSETS_PRIMARY_RIGHT = "insets-primary-right";
const INSETS_PRIMARY_TOP = "insets-primary-top";
const INSETS_SECONDARY_BOTTOM = "insets-secondary-bottom";
const INSETS_SECONDARY_LEFT = "insets-secondary-left";
const INSETS_SECONDARY_RIGHT = "insets-secondary-right";
const INSETS_SECONDARY_TOP = "insets-secondary-top";
const MOVE_FOCUSED_DOWN = "move-focused-down";
const MOVE_FOCUSED_LEFT = "move-focused-left";
const MOVE_FOCUSED_RIGHT = "move-focused-right";
const MOVE_FOCUSED_UP = "move-focused-up";
const MOVERESIZE_ENABLED = "moveresize-enabled";
const PRESET_RESIZE_1 = "preset-resize-1";
const PRESET_RESIZE_10 = "preset-resize-10";
const PRESET_RESIZE_11 = "preset-resize-11";
const PRESET_RESIZE_12 = "preset-resize-12";
const PRESET_RESIZE_13 = "preset-resize-13";
const PRESET_RESIZE_14 = "preset-resize-14";
const PRESET_RESIZE_15 = "preset-resize-15";
const PRESET_RESIZE_16 = "preset-resize-16";
const PRESET_RESIZE_17 = "preset-resize-17";
const PRESET_RESIZE_18 = "preset-resize-18";
const PRESET_RESIZE_19 = "preset-resize-19";
const PRESET_RESIZE_2 = "preset-resize-2";
const PRESET_RESIZE_20 = "preset-resize-20";
const PRESET_RESIZE_21 = "preset-resize-21";
const PRESET_RESIZE_22 = "preset-resize-22";
const PRESET_RESIZE_23 = "preset-resize-23";
const PRESET_RESIZE_24 = "preset-resize-24";
const PRESET_RESIZE_25 = "preset-resize-25";
const PRESET_RESIZE_26 = "preset-resize-26";
const PRESET_RESIZE_27 = "preset-resize-27";
const PRESET_RESIZE_28 = "preset-resize-28";
const PRESET_RESIZE_29 = "preset-resize-29";
const PRESET_RESIZE_3 = "preset-resize-3";
const PRESET_RESIZE_30 = "preset-resize-30";
const PRESET_RESIZE_4 = "preset-resize-4";
const PRESET_RESIZE_5 = "preset-resize-5";
const PRESET_RESIZE_6 = "preset-resize-6";
const PRESET_RESIZE_7 = "preset-resize-7";
const PRESET_RESIZE_8 = "preset-resize-8";
const PRESET_RESIZE_9 = "preset-resize-9";
const SHOW_ICON = "show-icon";
const SHOW_TABS = "show-tabs";
const SPAN_MULTIPLE_ZONES = "span-multiple-zones";
const USE_MODIFIER = "use-modifier";
const WINDOW_MARGIN = "window-margin";

const ExtensionUtils$1 = imports.misc.extensionUtils;
const gridSettings = new ParsedSettings();
let settings;
let settingsConnection = null;
function getBoolSetting(settingName) {
    const value = settings.get_boolean(settingName);
    if (value === undefined) {
        log("Undefined settings " + settingName);
        return false;
    }
    return value;
}
function getIntSetting(settingsValue) {
    let iss = settings.get_int(settingsValue);
    if (iss === undefined) {
        log("Undefined settings " + settingsValue);
        return 0;
    }
    else {
        return iss;
    }
}
function initSettings(changed_settings) {
    settings = ExtensionUtils$1.getSettings();
    settingsConnection = settings.connect('changed', changed_settings);
    setLoggingEnabled(getBoolSetting(DEBUG));
    log("Init settings");
    gridSettings[SHOW_ICON] = getBoolSetting(SHOW_ICON);
    gridSettings[SHOW_TABS] = getBoolSetting(SHOW_TABS);
    gridSettings[WINDOW_MARGIN] = getIntSetting(WINDOW_MARGIN);
    gridSettings[ANIMATIONS_ENABLED] = getBoolSetting(ANIMATIONS_ENABLED);
    log("Init complete");
}
function deinitSettings() {
    settings.disconnect(settingsConnection);
}

var Side;
(function (Side) {
    Side["Top"] = "TOP";
    Side["Right"] = "RIGHT";
    Side["Bottom"] = "BOTTOM";
    Side["Left"] = "LEFT";
})(Side || (Side = {}));

const Main$2 = imports.ui.main;
// Getter for accesing "get_active_workspace" on GNOME <=2.28 and >= 2.30
const WorkspaceManager$1 = (global.screen || global.workspace_manager);
function areEqual(a, b) {
    return a.x == b.x
        && a.y == b.y
        && a.width == b.width
        && a.height == b.height;
}
function getMonitorTier(monitor) {
    return isPrimaryMonitor(monitor) ? 'primary' : 'secondary';
}
function getMonitorInsets(tier) {
    switch (tier) {
        case 'primary':
            return {
                top: getIntSetting(INSETS_PRIMARY_TOP),
                bottom: getIntSetting(INSETS_PRIMARY_BOTTOM),
                left: getIntSetting(INSETS_PRIMARY_LEFT),
                right: getIntSetting(INSETS_PRIMARY_RIGHT)
            }; // Insets on primary monitor
        case 'secondary':
            return {
                top: getIntSetting(INSETS_SECONDARY_TOP),
                bottom: getIntSetting(INSETS_SECONDARY_BOTTOM),
                left: getIntSetting(INSETS_SECONDARY_LEFT),
                right: getIntSetting(INSETS_SECONDARY_RIGHT)
            };
        default:
            throw new Error(`unknown monitor name ${JSON.stringify(tier)}`);
    }
}
function getWindowsOfMonitor(monitor) {
    let monitors = activeMonitors();
    let windows = WorkspaceManager$1
        .get_active_workspace()
        .list_windows()
        .filter(w => w.get_window_type() == WindowType.NORMAL
        && !w.is_hidden()
        && monitors[w.get_monitor()] == monitor);
    return windows;
}
function getTrackedWindowsOfMonitor(monitor) {
    const useModifier = getBoolSetting(USE_MODIFIER);
    const trackedWindows = global.trackedWindows;
    if (!useModifier)
        return getWindowsOfMonitor(monitor);
    return getWindowsOfMonitor(monitor)
        .filter(w => trackedWindows.includes(w));
}
function activeMonitors() {
    return Main$2.layoutManager.monitors;
}
/**
 * Determine if the given monitor is the primary monitor.
 * @param {Object} monitor The given monitor to evaluate.
 * @returns {boolean} True if the given monitor is the primary monitor.
 * */
function isPrimaryMonitor(monitor) {
    return Main$2.layoutManager.primaryMonitor.x == monitor.x && Main$2.layoutManager.primaryMonitor.y == monitor.y;
}
function getWorkAreaByMonitor(monitor) {
    const monitors = activeMonitors();
    for (let i = 0; i < monitors.length; i++) {
        let mon = monitors[i];
        if (mon.x == monitor.x && mon.y == monitor.y) {
            return getWorkArea(monitor);
        }
    }
    return null;
}
function getWorkArea(monitor) {
    const wkspace = WorkspaceManager$1.get_active_workspace();
    const work_area = wkspace.get_work_area_for_monitor(monitor.index);
    const insets = getMonitorInsets(getMonitorTier(monitor));
    const result = {
        x: work_area.x + insets.left,
        y: work_area.y + insets.top,
        width: work_area.width - insets.left - insets.right,
        height: work_area.height - insets.top - insets.bottom
    };
    log(`getWorkArea m:${monitor.index}, x: ${result.x} y:${result.y} w:${result.width} h:${result.height}`);
    return result;
}
function getCurrentMonitorIndex() {
    return global.display.get_current_monitor();
}

// Library imports
const St$1 = imports.gi.St;
const Main$1 = imports.ui.main;
const GLib$2 = imports.gi.GLib;
const GObject$1 = imports.gi.GObject;
const Clutter = imports.gi.Clutter;
const ModalDialog = imports.ui.modalDialog;
const ANIMATION_SPEED = 100; // animation speed of zones' fade-in, fade-out, position and size changes
class ZoneBase {
    constructor(layoutItem, parent) {
        this._x = 0;
        this._y = 0;
        this._width = 0;
        this._height = 0;
        this.parent = null;
        this.margin = 0;
        this.layoutItem = layoutItem;
        this.parent = parent;
    }
    contains(x, y, width = 1, height = 1) {
        return (this.x <= x &&
            this.y <= y &&
            this.x + this.width >= x + width &&
            this.y + this.height >= y + height);
    }
    get totalWidth() {
        return (this.margin * 2) + this.width;
    }
    get totalHeight() {
        return (this.margin * 2) + this.height;
    }
    get innerX() {
        return this.x + this.margin;
    }
    get innerY() {
        return this.y + this.margin;
    }
    get innerWidth() {
        return this.width - (this.margin * 2);
    }
    get innerHeight() {
        return this.height - (this.margin * 2);
    }
    get x() {
        return this._x;
    }
    set x(v) {
        if (this._x !== v) {
            this._x = v;
            this.positionChanged();
        }
    }
    get y() {
        return this._y;
    }
    set y(v) {
        if (this._y !== v) {
            this._y = v;
            this.positionChanged();
        }
    }
    get width() {
        return this._width;
    }
    set width(v) {
        if (this._width !== v) {
            this._width = v;
            this.sizeChanged();
        }
    }
    get height() {
        return this._height;
    }
    set height(v) {
        if (this._height !== v) {
            this._height = v;
            this.sizeChanged();
        }
    }
    get minWidth() {
        return 100 + this.margin * 2;
    }
    get minHeight() {
        return 100 + this.margin * 2;
    }
    applyPercentages() {
        if (this.parent) {
            if (this.parent.layoutItem.type == 0) {
                let factor = this.parent.width / this.width;
                this.layoutItem.length = 100 / factor;
            }
            else {
                let factor = this.parent.height / this.height;
                this.layoutItem.length = 100 / factor;
            }
        }
    }
    destroy() {
    }
    hide() {
    }
    show() {
    }
    positionChanged() {
    }
    sizeChanged() {
    }
    sizeLeft(delta) {
        this.x += delta;
        this.width -= delta;
    }
    sizeRight(delta) {
        this.width += delta;
    }
    sizeTop(delta) {
        this.y += delta;
        this.height -= delta;
    }
    sizeBottom(delta) {
        this.height += delta;
    }
    adjustWindows(windows) {
    }
}
class Zone extends ZoneBase {
    constructor(layoutItem, parent, stage) {
        super(layoutItem, parent);
        this._selected = false;
        this.createWidget();
        this.stage = stage;
        this.stage.add_child(this.widget);
    }
    // the CSS class "tile-preview" is declared by GNOME shell. It is used by
    // GNOME edge-tiling system. More info here: https://github.com/GNOME/gnome-shell/blob/7c4b1d4ae62cfc6c5b0637819d465ce8968bd944/js/ui/windowManager.js#L388
    createWidget(styleClass = 'tile-preview grid-preview') {
        this.widget = new St$1.BoxLayout({ style_class: styleClass });
        this.widget.visible = false;
    }
    positionChanged() {
        super.positionChanged();
        this.widget.x = Math.max(0, this.innerX);
        this.widget.y = Math.max(0, this.innerY);
    }
    sizeChanged() {
        super.sizeChanged();
        this.widget.height = Math.max(0, this.innerHeight);
        this.widget.width = Math.max(0, this.innerWidth);
    }
    hide() {
        this._selected = false;
        this.widget.ease({
            opacity: 0,
            duration: ANIMATION_SPEED,
            mode: Clutter.AnimationMode.EASE_OUT_QUAD,
            onComplete: () => this.widget.visible = false
        });
        this.widget.remove_style_pseudo_class('activate');
    }
    show() {
        this.widget.visible = true;
        this.widget.ease({
            opacity: 255,
            duration: ANIMATION_SPEED,
            mode: Clutter.AnimationMode.EASE_OUT_QUAD,
        });
        this.widget.add_style_pseudo_class('activate');
    }
    set selected(value) {
        this._selected = value;
    }
    get selected() {
        return this._selected;
    }
    destroy() {
        this.hide();
        this.stage.remove_child(this.widget);
    }
}
class SelectionZone extends Zone {
    constructor(layoutItem, parent, stage) {
        super(layoutItem, parent, stage);
        this.animationRunning = false;
        const color = this.widget.get_theme_node().get_background_color();
        let newAlpha = Math.min(color.alpha + 35, 255);
        // since an alpha value lower than 160 is not so much visible, enforce a minimum value of 160
        if (newAlpha < 160)
            newAlpha = 160;
        // The final alpha value is divided by 255 since CSS needs a value from 0 to 1, but ClutterColor expresses alpha from 0 to 255
        this.widget.set_style(`
            background-color: rgba(${color.red}, ${color.green}, ${color.blue}, ${newAlpha / 255}) !important;
        `);
    }
    move(newX, newY, newWidth, newHeight, ease = true) {
        if (this.animationRunning)
            return; // if the animation is still running, do not animate again
        // if both position and widths are not changed
        // then there is nothing to move o  r resize
        if (newX == this.x &&
            newY == this.y &&
            newWidth == this.width &&
            newHeight == this.height) {
            return;
        }
        // if the zone was never shown before, start the animation from cursor's coordinates
        if (this.innerWidth <= 0) {
            let [x, y] = global.get_pointer();
            this.widget.x = x;
            this.widget.y = y;
            this.widget.width = 0;
            this.widget.height = 0;
        }
        // update location
        this.x = newX;
        this.y = newY;
        // update sizes
        this.width = newWidth;
        this.height = newHeight;
        this.widget.visible = true;
        if (ease) { // animate with easing
            this.animationRunning = true;
            this.widget.ease({
                duration: ANIMATION_SPEED,
                x: Math.max(0, this.innerX),
                y: Math.max(0, this.innerY),
                width: Math.max(0, this.innerWidth),
                height: Math.max(0, this.innerHeight),
                opacity: 255,
                transition: Clutter.AnimationMode.EASE_OUT_QUAD,
                onComplete: () => this.animationRunning = false
            });
        }
        else { // do not animate
            this.widget.x = Math.max(0, this.innerX);
            this.widget.y = Math.max(0, this.innerY);
            this.widget.width = Math.max(0, this.innerWidth);
            this.widget.height = Math.max(0, this.innerHeight);
            this.widget.opacity = 255;
            this.animationRunning = false;
        }
    }
    // avoid updating position automatically. Call easeMove method instead
    positionChanged() {
    }
    // avoid updating sizes automatically. Call easeMove method instead
    sizeChanged() {
    }
}
class TabbedZone extends Zone {
    constructor() {
        super(...arguments);
        this.tabHeight = 50;
        this.tabWidth = 200;
        this.tabs = [];
    }
    get innerY() {
        if (this.tabs.length > 1) {
            return super.innerY + this.tabHeight;
        }
        return super.innerY;
    }
    get innerHeight() {
        if (this.tabs.length > 1) {
            return super.innerHeight - this.tabHeight;
        }
        return super.innerHeight;
    }
    // the CSS class "tile-preview" is declared by GNOME shell. It is used by
    // GNOME edge-tiling system. More info here: https://github.com/GNOME/gnome-shell/blob/7c4b1d4ae62cfc6c5b0637819d465ce8968bd944/js/ui/windowManager.js#L388
    createWidget(styleClass = 'tile-preview grid-preview') {
        this.widget = new St$1.BoxLayout({ style_class: styleClass });
        this.widget.visible = false;
    }
    layoutTabs() {
    }
    destroy() {
        super.destroy();
        while (this.tabs.length > 0) {
            this.tabs[0].destroy();
        }
    }
    adjustWindows(windows) {
        super.adjustWindows(windows);
        while (this.tabs.length > 0) {
            this.tabs[0].destroy();
        }
        this.tabs = [];
        let x = this.x + this.margin;
        for (let i = 0; i < windows.length; i++) {
            let metaWindow = windows[i];
            let outerRect = metaWindow.get_frame_rect();
            let midX = outerRect.x + (outerRect.width / 2);
            let midY = outerRect.y + (outerRect.height / 2);
            if (this.contains(midX, midY)) {
                let zoneTab = new ZoneTab(this, metaWindow);
                zoneTab.buttonWidget.height = this.tabHeight - (this.margin * 2);
                zoneTab.buttonWidget.width = this.tabWidth;
                zoneTab.buttonWidget.x = x;
                zoneTab.buttonWidget.y = this.y + this.margin;
                zoneTab.buttonWidget.visible = true;
                x += zoneTab.buttonWidget.width + this.margin;
            }
        }
        for (let i = 0; i < windows.length; i++) {
            let metaWindow = windows[i];
            let outerRect = metaWindow.get_frame_rect();
            let midX = outerRect.x + (outerRect.width / 2);
            let midY = outerRect.y + (outerRect.height / 2);
            if (this.contains(midX, midY)) {
                metaWindow.move_frame(true, this.innerX, this.innerY);
                metaWindow.move_resize_frame(true, this.innerX, this.innerY, this.innerWidth, this.innerHeight);
            }
        }
        if (this.tabs.length < 2) {
            while (this.tabs.length > 0) {
                this.tabs[0].destroy();
            }
            this.tabs = [];
        }
        log("Adjusted zone with " + this.tabs.length + " with window count " + windows.length);
    }
}
class ZoneTab {
    constructor(tabZone, metaWindow) {
        this.tabZone = tabZone;
        tabZone.tabs.push(this);
        this.window = metaWindow;
        this.buttonWidget = new St$1.Button({ style_class: 'tab-button' });
        this.buttonWidget.label = metaWindow.title;
        this.buttonWidget.connect('button-press-event', () => {
            Main$1.activateWindow(this.window);
        });
        Main$1.uiGroup.insert_child_above(this.buttonWidget, global.window_group);
    }
    destroy() {
        this.tabZone.tabs.splice(this.tabZone.tabs.indexOf(this), 1);
        this.buttonWidget.visible = false;
        Main$1.uiGroup.remove_child(this.buttonWidget);
    }
}
function toRoundedString(val, places = 0) {
    const factor = Math.pow(10, places);
    return (Math.round((val + Number.EPSILON) * factor) / factor).toFixed(places);
}
class EditableZone extends Zone {
    constructor(layoutItem, parent, stage) {
        super(layoutItem, parent, stage);
    }
    positionChanged() {
        super.positionChanged();
        this.widget.label = `${toRoundedString(this.innerWidth)}x${toRoundedString(this.innerHeight)}\n(${toRoundedString(this.layoutItem.length, 2)}%)`;
    }
    sizeChanged() {
        super.sizeChanged();
        this.widget.label = `${toRoundedString(this.innerWidth)}x${toRoundedString(this.innerHeight)}\n(${toRoundedString(this.layoutItem.length, 2)}%)`;
    }
    // the CSS class "tile-preview" is declared by GNOME shell. It is used by
    // GNOME edge-tiling system. More info here: https://github.com/GNOME/gnome-shell/blob/7c4b1d4ae62cfc6c5b0637819d465ce8968bd944/js/ui/windowManager.js#L388
    createWidget(styleClass = 'tile-preview grid-preview') {
        this.widget = new St$1.Button({ style_class: styleClass });
        this.widget.connect('button-press-event', (_actor, event) => {
            var _a, _b, _c;
            var btn = event.get_button();
            if (btn == 1) {
                log("Splitting");
                (_a = this.parent) === null || _a === void 0 ? void 0 : _a.split(this);
            }
            if (btn == 2) {
                (_b = this.parent) === null || _b === void 0 ? void 0 : _b.splitOtherDirection(this);
            }
            if (btn == 3) {
                (_c = this.parent) === null || _c === void 0 ? void 0 : _c.remove(this);
            }
        });
    }
}
class ZoneGroup extends ZoneBase {
    constructor(layoutItem, parent) {
        super(layoutItem, parent);
        this.children = [];
    }
    contains(x, y, width = 1, height = 1) {
        return false;
    }
    adjustWindows(windows) {
        super.adjustWindows(windows);
        for (var i = 0; i < this.children.length; i++) {
            this.children[i].adjustWindows(windows);
        }
    }
    remove(zone) {
        const index = this.layoutItem.items.indexOf(zone.layoutItem);
        if (index > -1) {
            if (index + 1 < this.layoutItem.items.length) {
                this.layoutItem.items[index + 1].length += zone.layoutItem.length;
                this.layoutItem.items.splice(index, 1);
            }
            else if (index - 1 > -1) {
                this.layoutItem.items[index - 1].length += zone.layoutItem.length;
                this.layoutItem.items.splice(index, 1);
            }
            if (this.layoutItem.items.length < 2) {
                if (this.layoutItem != this.root.layoutItem) {
                    this.layoutItem.items = [];
                }
            }
        }
        this.root.reinit();
    }
    splitOtherDirection(zone) {
        zone.layoutItem.items = [];
        const layoutType = this.layoutItem.type == 1 ? 0 : 1;
        if (layoutType === 0 && Math.floor(zone.width / 2) < zone.minWidth)
            return;
        if (layoutType === 1 && Math.floor(zone.height / 2) < zone.minHeight)
            return;
        zone.layoutItem.type = layoutType;
        zone.layoutItem.items.push({ type: 0, length: 50, items: [] });
        zone.layoutItem.items.push({ type: 0, length: 50, items: [] });
        log(JSON.stringify(this.root.layoutItem));
        this.root.reinit();
    }
    split(zone) {
        if (zone.layoutItem.type === 0 && Math.floor(zone.width / 2) < zone.minWidth)
            return;
        if (zone.layoutItem.type === 1 && Math.floor(zone.height / 2) < zone.minHeight)
            return;
        let index = this.children.indexOf(zone);
        this.layoutItem.items.splice(index, 0, {
            type: 0,
            length: zone.layoutItem.length / 2,
            items: []
        });
        zone.layoutItem.length = zone.layoutItem.length / 2;
        log(JSON.stringify(this.root.layoutItem));
        this.root.reinit();
    }
    adjustLayout(root) {
        this.root = root;
        let x = this.x;
        let y = this.y;
        for (let i = 0; i < this.children.length; i++) {
            let child = this.children[i];
            let item = child.layoutItem;
            let factor = this.layoutItem.type == 0 ? this.width : this.height;
            let length = (factor / 100) * item.length;
            let w = 0;
            let h = 0;
            if (this.layoutItem.type == 0) {
                w = length;
                h = this.height;
            }
            else {
                h = length;
                w = this.width;
            }
            if (child instanceof ZoneGroup) {
                child.layoutItem = item;
                child.x = x;
                child.y = y;
                child.width = w;
                child.height = h;
                child.adjustLayout(root);
            }
            else {
                child.x = x;
                child.y = y;
                child.width = w;
                child.height = h;
            }
            if (this.layoutItem.type == 0) {
                x += length;
            }
            else {
                y += length;
            }
        }
    }
    applyLayout(root) {
        this.root = root;
        for (let i = 0; i < this.children.length; i++) {
            this.children[i].destroy();
        }
        this.children = [];
        for (let i = 0; i < this.layoutItem.items.length; i++) {
            let item = this.layoutItem.items[i];
            if (item.items && item.items.length > 0) {
                let z = new ZoneGroup(item, this);
                this.children.push(z);
                z.applyLayout(root);
            }
            else {
                let zone = root.createZone(item, this);
                zone.margin = root.margin;
                this.children.push(zone);
                root.zoneCreated(zone);
            }
        }
        root.zoneGroupCreated(this);
    }
    zoneGroupCreated(z) {
    }
    zoneCreated(zone) {
    }
    destroy() {
        super.destroy();
        this.hide();
        for (let i = 0; i < this.children.length; i++) {
            this.children[i].destroy();
        }
        this.children = [];
    }
    sizeLeft(delta) {
        super.sizeLeft(delta);
        this.adjustLayout(this.root);
    }
    sizeRight(delta) {
        super.sizeRight(delta);
        this.adjustLayout(this.root);
    }
    sizeTop(delta) {
        super.sizeTop(delta);
        this.adjustLayout(this.root);
    }
    sizeBottom(delta) {
        super.sizeBottom(delta);
        this.adjustLayout(this.root);
    }
    hide() {
        super.destroy();
        for (let i = 0; i < this.children.length; i++) {
            this.children[i].hide();
        }
    }
    show() {
        super.destroy();
        for (let i = 0; i < this.children.length; i++) {
            this.children[i].show();
        }
    }
    recursiveChildren(list = []) {
        for (let i = 0; i < this.children.length; i++) {
            let item = this.children[i];
            if (item instanceof ZoneGroup) {
                item.recursiveChildren(list);
            }
            list.push(item);
        }
        return list;
    }
}
class ZoneAnchor {
    constructor(zoneGroup, zoneA, zoneB, margin, stage) {
        this.zoneGroup = zoneGroup;
        this.zoneA = zoneA;
        this.zoneB = zoneB;
        this.margin = margin;
        this.stage = stage;
        this.startX = 0;
        this.startY = 0;
        this.isMoving = false;
        this.motionConnection = null;
        this.widget = new St$1.Button({ style_class: 'size-button' });
        this.widget.label = " = ";
        this.widget.visible = true;
        this.adjustSizes();
        this.widget.connect('button-press-event', () => {
            let [x, y] = global.get_pointer();
            this.startX = Math.floor(x);
            this.startY = Math.floor(y);
            this.isMoving = !this.isMoving;
        });
        this.stage.add_child(this.widget);
    }
    adjustSizes() {
        if (this.zoneGroup.layoutItem.type == 0) {
            this.widget.x = Math.floor(this.zoneA.x + this.zoneA.width - (this.widget.width / 2));
            this.widget.y = Math.floor(this.zoneA.y + (this.zoneA.height / 2) - (this.widget.height / 2));
        }
        else {
            this.widget.y = Math.floor(this.zoneA.y + this.zoneA.height - (this.widget.height / 2));
            this.widget.x = Math.floor(this.zoneA.x + (this.zoneA.width / 2) - (this.widget.width / 2));
        }
    }
    hide() {
        this.widget.visible = false;
        this.widget.remove_style_pseudo_class('activate');
    }
    show() {
        this.widget.visible = true;
        this.widget.add_style_pseudo_class('activate');
    }
    destroy() {
        this.hide();
        this.stage.remove_child(this.widget);
    }
    mouseMoved(x, y) {
        if (this.isMoving) {
            if (this.zoneGroup.layoutItem.type == 0) {
                let delta = x - this.startX;
                if (delta < 0) {
                    if (this.zoneA.width + delta < this.zoneA.minWidth) {
                        return;
                    }
                }
                else {
                    if (this.zoneB.width - delta < this.zoneB.minWidth) {
                        return;
                    }
                }
                this.zoneA.sizeRight(delta);
                this.zoneB.sizeLeft(delta);
                this.startX = x;
            }
            else {
                let delta = y - this.startY;
                if (delta < 0) {
                    if (this.zoneA.height + delta < this.zoneA.minHeight) {
                        return;
                    }
                }
                else {
                    if (this.zoneB.height - delta < this.zoneB.minHeight) {
                        return;
                    }
                }
                this.zoneA.sizeBottom(delta);
                this.zoneB.sizeTop(delta);
                this.startY = y;
            }
        }
    }
}
class ZoneDisplay extends ZoneGroup {
    constructor(monitor, layout, margin) {
        super(layout, null);
        this.monitor = monitor;
        this.margin = margin;
        this.workArea = getWorkAreaByMonitor(this.monitor);
        this.stage = new Clutter.Actor({
            name: 'gsnap-stage',
            visible: false,
            width: 1000,
            height: 1000,
            x: 0,
            y: 0,
        });
        Main$1.uiGroup.insert_child_above(this.stage, global.window_group);
        this.init();
    }
    apply() {
        var c = this.recursiveChildren();
        for (var i = 0; i < c.length; i++) {
            c[i].applyPercentages();
        }
    }
    destroy() {
        super.destroy();
        if (Main$1.uiGroup.get_children().indexOf(this.stage) >= 0) {
            Main$1.uiGroup.remove_child(this.stage);
        }
    }
    createMarginItem() {
    }
    createZoneWidget() {
    }
    init() {
        if (!this.workArea) {
            log(`Could not get workArea for monitor ${this.monitor.index}`);
            return;
        }
        this.x = this.margin + this.workArea.x;
        this.y = this.margin + this.workArea.y;
        this.width = this.workArea.width - (this.margin * 2);
        this.height = this.workArea.height - (this.margin * 2);
        this.applyLayout(this);
        this.adjustLayout(this);
    }
    createZone(layout, parent) {
        return new Zone(layout, parent, this.stage);
    }
    reinit() {
        let wa = getWorkAreaByMonitor(this.monitor);
        if (!this.workArea || !wa) {
            log(`Could not get workArea for monitor ${this.monitor.index}`);
            return;
        }
        if (!areEqual(this.workArea, wa)) {
            this.workArea = wa;
            this.init();
        }
        else {
            this.applyLayout(this);
            this.adjustLayout(this);
        }
    }
    show() {
        super.show();
        this.stage.visible = true;
    }
    hide() {
        super.hide();
        this.stage.visible = false;
    }
}
class ZoneEditor extends ZoneDisplay {
    constructor(monitor, layout, margin) {
        super(monitor, layout, margin);
        this.layout = layout;
        this.motionConnection = null;
        this.isMoving = false;
        this.anchors = [];
    }
    createZone(layout, parent) {
        return new EditableZone(layout, parent, this.stage);
    }
    init() {
        if (this.anchors == null) {
            this.anchors = [];
        }
        super.init();
        this.motionConnection = global.stage.connect("motion-event", () => {
            let [x, y] = global.get_pointer();
            for (let i = 0; i < this.anchors.length; i++) {
                this.anchors[i].mouseMoved(x, y);
            }
            for (let i = 0; i < this.anchors.length; i++) {
                this.anchors[i].adjustSizes();
            }
            this.apply();
        });
    }
    destroy() {
        global.stage.disconnect(this.motionConnection);
        for (let i = 0; i < this.anchors.length; i++) {
            this.anchors[i].destroy();
        }
        this.anchors = [];
        super.destroy();
    }
    zoneCreated(zone) {
        super.zoneCreated(zone);
    }
    zoneGroupCreated(z) {
        super.zoneGroupCreated(z);
        //
        if (this.anchors == null) {
            this.anchors = [];
        }
        for (let i = 1; i < z.children.length; i++) {
            let before = z.children[i - 1];
            let after = z.children[i];
            if (before == null) {
                log("--- --- BEFORE IS NULL --- ---" + i);
                log(JSON.stringify(z.children));
            }
            if (after == null) {
                log("--- --- AFTER IS NULL --- ---" + i);
                log(JSON.stringify(z.children));
            }
            let zoneAnchor = new ZoneAnchor(z, before, after, this.margin, this.stage);
            this.anchors.push(zoneAnchor);
        }
    }
    applyLayout(root) {
        this.stage.remove_all_children();
        super.applyLayout(root);
    }
    hide() {
        super.hide();
        for (let i = 0; i < this.anchors.length; i++) {
            this.anchors[i].hide();
        }
    }
    show() {
        super.show();
        for (let i = 0; i < this.anchors.length; i++) {
            this.anchors[i].show();
        }
    }
}
class ZonePreview extends ZoneDisplay {
    constructor(monitor, layout, margin) {
        super(monitor, layout, margin);
    }
}
class ZoneManager extends ZoneDisplay {
    constructor(monitor, layout, margin, animationsEnabled) {
        super(monitor, layout, margin);
        this.trackCursorTimeoutId = null;
        this.isShowing = false;
        this._select_multiple_zones = false;
        this.animationsEnabled = true;
        this._last_selection_zone = new SelectionZone(layout, this.parent, this.stage);
        this._last_selection_zone.margin = this.margin;
        this.animationsEnabled = animationsEnabled;
    }
    adjustLayout(root) {
        super.adjustLayout(root);
        this.layoutWindows();
    }
    layoutWindows() {
        let windows = getTrackedWindowsOfMonitor(this.monitor);
        for (let c = 0; c < this.children.length; c++) {
            let child = this.children[c];
            child.adjustWindows(windows);
        }
    }
    getSelectionRect() {
        let [x, y] = global.get_pointer();
        // if the cursor is not inside the last selected zone,
        // then no zones have been selected since the last
        // selection were performed
        if (!this._last_selection_zone.contains(x, y))
            return undefined;
        return {
            x: this._last_selection_zone.innerX,
            y: this._last_selection_zone.innerY,
            width: this._last_selection_zone.innerWidth,
            height: this._last_selection_zone.innerHeight
        };
    }
    highlightZonesUnderCursor() {
        let [x, y] = global.get_pointer();
        let children = this.recursiveChildren();
        let smallestX = x, smallestY = y, biggestX = x, biggestY = y;
        for (let i = 0; i < children.length; i++) {
            let zone = children[i];
            let contained = zone.contains(x, y);
            zone.selected = contained || (this._select_multiple_zones && zone.selected);
            if (!zone.selected)
                continue;
            if (zone.x < smallestX)
                smallestX = zone.x;
            if (zone.y < smallestY)
                smallestY = zone.y;
            if (zone.x + zone.width > biggestX)
                biggestX = zone.x + zone.width;
            if (zone.y + zone.height > biggestY)
                biggestY = zone.y + zone.height;
        }
        if (biggestX - smallestX == 0 || biggestY - smallestY == 0) {
            return;
        }
        this._last_selection_zone.move(smallestX, smallestY, biggestX - smallestX, biggestY - smallestY, this.animationsEnabled);
    }
    reset_selection_zone() {
        this._last_selection_zone.x = 0;
        this._last_selection_zone.y = 0;
        this._last_selection_zone.width = 0;
        this._last_selection_zone.height = 0;
    }
    show() {
        this.isShowing = true;
        super.show();
        this.trackCursorUpdates();
    }
    hide() {
        this.isShowing = false;
        super.hide();
        this.cleanupTrackCursorUpdates();
    }
    destroy() {
        super.destroy();
        this.cleanupTrackCursorUpdates();
    }
    trackCursorUpdates() {
        this.trackCursorTimeoutId = GLib$2.timeout_add(GLib$2.PRIORITY_DEFAULT, 25, () => {
            if (!this.isShowing) {
                return GLib$2.SOURCE_REMOVE;
            }
            this.highlightZonesUnderCursor();
            return GLib$2.SOURCE_CONTINUE;
        });
    }
    cleanupTrackCursorUpdates() {
        if (this.trackCursorTimeoutId) {
            GLib$2.Source.remove(this.trackCursorTimeoutId);
            this.trackCursorTimeoutId = null;
            this.reset_selection_zone();
            this._last_selection_zone.hide();
        }
    }
    allow_multiple_zones_selection(value) {
        this._select_multiple_zones = value;
    }
}
class TabbedZoneManager extends ZoneManager {
    constructor(monitor, layout, margin, animationsEnabled) {
        super(monitor, layout, margin, animationsEnabled);
    }
    createZone(layout, parent) {
        return new TabbedZone(layout, parent, this.stage);
    }
}
class EntryDialogClass extends ModalDialog.ModalDialog {
    constructor(params) {
        super(params);
        log(JSON.stringify(params));
    }
    _onClose() {
        try {
            this.onOkay(this.entry.text);
        }
        catch (e) {
            throw e;
        }
    }
    _init() {
        super._init({});
        this.setButtons([{
                label: "OK",
                action: () => {
                    this.onOkay(this.entry.text);
                    this.close(global.get_current_time());
                },
                key: Clutter.Escape
            }]);
        let box = new St$1.BoxLayout({ vertical: true });
        this.contentLayout.add(box);
        // const MySelf = ExtensionUtils.getCurrentExtension();
        // let gicon = new Gio.FileIcon({file: Gio.file_new_for_path(MySelf.path + "/icons/icon.png")});
        // let icon = new St.Icon({gicon: gicon});
        // box.add(icon);
        this.label = new St$1.Label({ text: "" });
        box.add(this.label);
        box.add(this.entry = new St$1.Entry({ text: "" }));
    }
}
const EntryDialog = GObject$1.registerClass({
    GTypeName: 'EntryDialogClass',
}, EntryDialogClass);

function cloneLayoutItem(layoutItem) {
    var _a, _b;
    return {
        type: layoutItem.type,
        length: layoutItem.length,
        items: (_b = (_a = layoutItem.items) === null || _a === void 0 ? void 0 : _a.map(x => cloneLayoutItem(x))) !== null && _b !== void 0 ? _b : [],
    };
}
function cloneLayout(layout) {
    var _a, _b;
    return {
        name: layout.name,
        type: layout.type,
        length: layout.length,
        items: (_b = (_a = layout.items) === null || _a === void 0 ? void 0 : _a.map(x => cloneLayoutItem(x))) !== null && _b !== void 0 ? _b : [],
    };
}

const GLib$1 = imports.gi.GLib;
const Me$1 = imports.misc.extensionUtils.getCurrentExtension();
class LayoutsUtils {
    get configPath() {
        return GLib$1.build_pathv('/', [GLib$1.get_user_config_dir(), 'gSnap']);
    }
    get layoutsPath() {
        return GLib$1.build_filenamev([this.configPath, 'layouts.json']);
    }
    resetToDefault() {
        log('Resetting default LayoutSettings');
        const defaults = this._getDefaultLayoutsV1();
        this.saveSettings(defaults);
    }
    saveSettings(layouts) {
        log('Saving LayoutSettings');
        log(JSON.stringify(layouts));
        // 493 dec is 755 octal
        if (GLib$1.mkdir_with_parents(this.configPath, 493) === 0) {
            GLib$1.file_set_contents(this.layoutsPath, JSON.stringify(layouts));
        }
    }
    loadLayoutSettings() {
        log('Loading LayoutSettings');
        let layoutsv1 = this._loadLayoutsV1();
        if (layoutsv1)
            return layoutsv1;
        layoutsv1 = this._loadLayoutsV1FromExtensionDir();
        if (layoutsv1)
            return layoutsv1;
        layoutsv1 = this._getDefaultLayoutsV1();
        return layoutsv1;
    }
    _loadLayoutsV1() {
        return this._loadFromJsonFile(this.layoutsPath);
    }
    _loadLayoutsV1FromExtensionDir() {
        const oldLayoutsPath = GLib$1.build_filenamev([Me$1.path, 'layouts.json']);
        return this._loadFromJsonFile(oldLayoutsPath);
    }
    _loadFromJsonFile(filePath) {
        try {
            if (!GLib$1.file_test(filePath, GLib$1.FileTest.EXISTS))
                return null;
            let [ok, contents] = GLib$1.file_get_contents(filePath);
            if (ok) {
                log(`Found in ${filePath}`);
                let contentsString = '';
                if (ShellVersion.defaultVersion().version_at_least_41()) {
                    const decoder = new TextDecoder('utf-8');
                    contentsString = decoder.decode(contents);
                }
                else {
                    const ByteArray = imports.byteArray;
                    contentsString = ByteArray.toString(contents);
                }
                return JSON.parse(contentsString);
            }
        }
        catch (exception) {
            log(JSON.stringify(exception));
        }
        return null;
    }
    _getDefaultLayoutsV1() {
        log('Loading default layouts');
        return {
            workspaces: [[{ current: 2 }, { current: 3 }], [{ current: 2 }, { current: 3 }]],
            definitions: [
                {
                    name: "None", type: 0, length: 100, items: []
                },
                {
                    name: "1 Column", type: 0, length: 100,
                    items: [
                        { type: 1, length: 100, items: [] }
                    ]
                },
                {
                    name: "2 Column Split", type: 0, length: 100,
                    items: [
                        { type: 1, length: 50, items: [] },
                        { type: 1, length: 50, items: [] }
                    ]
                },
                {
                    name: "3 Column", type: 0, length: 100,
                    items: [
                        { type: 1, length: 33, items: [] },
                        { type: 1, length: 34, items: [] },
                        { type: 1, length: 33, items: [] }
                    ]
                },
                {
                    name: "3 Column (Focused)", type: 0, length: 100,
                    items: [
                        { type: 1, length: 25, items: [] },
                        { type: 1, length: 50, items: [] },
                        { type: 1, length: 25, items: [] }
                    ]
                },
                {
                    name: "3 Columns (Custom)", type: 0, length: 100,
                    items: [
                        { type: 1, length: 42, items: [] },
                        { type: 1, length: 16, items: [
                                { type: 0, length: 33, items: [] },
                                { type: 0, length: 34, items: [] },
                                { type: 0, length: 33, items: [] }
                            ] },
                        { type: 1, length: 42, items: [] }
                    ]
                }
            ]
        };
    }
}

const GLib = imports.gi.GLib;
var MODIFIERS_ENUM;
(function (MODIFIERS_ENUM) {
    MODIFIERS_ENUM[MODIFIERS_ENUM["SHIFT"] = 0] = "SHIFT";
    MODIFIERS_ENUM[MODIFIERS_ENUM["CONTROL"] = 2] = "CONTROL";
    MODIFIERS_ENUM[MODIFIERS_ENUM["ALT"] = 3] = "ALT";
    MODIFIERS_ENUM[MODIFIERS_ENUM["SUPER"] = 6] = "SUPER";
})(MODIFIERS_ENUM || (MODIFIERS_ENUM = {}));
const MODIFIERS = {
    0: MODIFIERS_ENUM.SHIFT,
    2: MODIFIERS_ENUM.CONTROL,
    3: MODIFIERS_ENUM.ALT,
    6: MODIFIERS_ENUM.SUPER
};
class ModifiersManager {
    constructor() {
        this.connected = {};
        this.modifiers = [];
        this.timeoutId = null;
    }
    enable() {
        this.timeoutId = GLib.timeout_add(GLib.PRIORITY_DEFAULT, 20, this.update.bind(this));
    }
    destroy() {
        if (this.timeoutId) {
            GLib.Source.remove(this.timeoutId);
            this.timeoutId = null;
        }
    }
    isHolding(modifier) {
        return this.modifiers.includes(modifier);
    }
    connect(name, callback) {
        if (this.connected[name] === undefined) {
            this.connected[name] = [];
        }
        return this.connected[name].push(callback);
    }
    update() {
        const [x, y, m] = global.get_pointer();
        if (m === undefined) {
            log('m === undefined');
            return GLib.SOURCE_REMOVE;
        }
        this.state = m;
        if (this.state === this.previousState) {
            return GLib.SOURCE_CONTINUE;
        }
        this.modifiers = [];
        for (let i = 0; i < 6; i++) {
            if (this.state & 1 << i && MODIFIERS[i] !== undefined) {
                this.modifiers.push(MODIFIERS[i]);
            }
        }
        for (const callback of this.connected["changed"]) {
            try {
                callback();
            }
            catch (e) {
                log(`error: ${e}`);
            }
        }
        this.previousState = this.state;
        return GLib.SOURCE_CONTINUE;
    }
}

const Gio = imports.gi.Gio;
const St = imports.gi.St;
const Gettext = imports.gettext;
const _ = Gettext.gettext;
/*****************************************************************

 This extension has been developed by micahosborne

 With the help of the gnome-shell community

 Edited by Kvis for gnome 3.8
 Edited by Lundal for gnome 3.18
 Edited by Sergey to add keyboard shortcuts and prefs dialog

 ******************************************************************/
/*****************************************************************
 CONST & VARS
 *****************************************************************/
// Library imports
const Main = imports.ui.main;
const GObject = imports.gi.GObject;
const PanelMenu = imports.ui.panelMenu;
const PopupMenu = imports.ui.popupMenu;
const ExtensionUtils = imports.misc.extensionUtils;
const Me = ExtensionUtils.getCurrentExtension();
// Getter for accesing "get_active_workspace" on GNOME <=2.28 and >= 2.30
const WorkspaceManager = (global.screen || global.workspace_manager);
let launcher;
let enabled = false;
let monitorsChangedConnect = false;
const trackedWindows = global.trackedWindows = [];
const SHELL_VERSION = ShellVersion.defaultVersion();
var MoveDirection;
(function (MoveDirection) {
    MoveDirection[MoveDirection["Up"] = 0] = "Up";
    MoveDirection[MoveDirection["Down"] = 1] = "Down";
    MoveDirection[MoveDirection["Left"] = 2] = "Left";
    MoveDirection[MoveDirection["Right"] = 3] = "Right";
})(MoveDirection || (MoveDirection = {}));
const keyBindings = new Map([
    [MOVE_FOCUSED_UP, () => {
            globalApp.moveFocusedWindow(MoveDirection.Up);
        }],
    [MOVE_FOCUSED_DOWN, () => {
            globalApp.moveFocusedWindow(MoveDirection.Down);
        }],
    [MOVE_FOCUSED_LEFT, () => {
            globalApp.moveFocusedWindow(MoveDirection.Left);
        }],
    [MOVE_FOCUSED_RIGHT, () => {
            globalApp.moveFocusedWindow(MoveDirection.Right);
        }],
]);
const key_bindings_presets = new Map([
    [PRESET_RESIZE_1, () => {
            globalApp.setLayout(0);
        }],
    [PRESET_RESIZE_2, () => {
            globalApp.setLayout(1);
        }],
    [PRESET_RESIZE_3, () => {
            globalApp.setLayout(2);
        }],
    [PRESET_RESIZE_4, () => {
            globalApp.setLayout(3);
        }],
    [PRESET_RESIZE_5, () => {
            globalApp.setLayout(4);
        }],
    [PRESET_RESIZE_6, () => {
            globalApp.setLayout(5);
        }],
    [PRESET_RESIZE_7, () => {
            globalApp.setLayout(6);
        }],
    [PRESET_RESIZE_8, () => {
            globalApp.setLayout(7);
        }],
    [PRESET_RESIZE_9, () => {
            globalApp.setLayout(8);
        }],
    [PRESET_RESIZE_10, () => {
            globalApp.setLayout(9);
        }],
    [PRESET_RESIZE_11, () => {
            globalApp.setLayout(10);
        }],
    [PRESET_RESIZE_12, () => {
            globalApp.setLayout(11);
        }],
    [PRESET_RESIZE_13, () => {
            globalApp.setLayout(12);
        }],
    [PRESET_RESIZE_14, () => {
        }],
    [PRESET_RESIZE_15, () => {
        }],
    [PRESET_RESIZE_16, () => {
        }],
    [PRESET_RESIZE_17, () => {
        }],
    [PRESET_RESIZE_18, () => {
        }],
    [PRESET_RESIZE_19, () => {
        }],
    [PRESET_RESIZE_20, () => {
        }],
    [PRESET_RESIZE_21, () => {
        }],
    [PRESET_RESIZE_22, () => {
        }],
    [PRESET_RESIZE_23, () => {
        }],
    [PRESET_RESIZE_24, () => {
        }],
    [PRESET_RESIZE_25, () => {
        }],
    [PRESET_RESIZE_26, () => {
        }],
    [PRESET_RESIZE_27, () => {
        }],
    [PRESET_RESIZE_28, () => {
        }],
    [PRESET_RESIZE_29, () => {
        }],
    [PRESET_RESIZE_30, () => {
        }],
]);
const keyBindingGlobalResizes = new Map([]);
class App {
    constructor() {
        this.isGrabbing = false;
        this.layouts = {
            // [workspaceindex][monitorindex]
            workspaces: [
                [{ current: 0 }, { current: 0 }],
                [{ current: 0 }, { current: 0 }]
            ],
            definitions: [
                {
                    type: 0,
                    name: "2 Column",
                    length: 100,
                    items: [
                        { type: 0, length: 50, items: [] },
                        { type: 0, length: 50, items: [] }
                    ]
                },
            ]
        };
        const monitors = activeMonitors().length;
        this.editor = new Array(monitors);
        this.preview = new Array(monitors);
        this.tabManager = new Array(monitors);
        this.currentLayoutIdxPerMonitor = new Array(monitors);
        this.modifiersManager = new ModifiersManager();
        this.layoutsUtils = new LayoutsUtils();
        this.minimizedWindows = new Array();
    }
    setLayout(layoutIndex, monitorIndex = -1) {
        var _a, _b;
        if (this.layouts.definitions.length <= layoutIndex) {
            return;
        }
        if (this.layouts.workspaces == null) {
            this.layouts.workspaces = [];
        }
        if (monitorIndex === -1) {
            monitorIndex = getCurrentMonitorIndex();
        }
        this.currentLayoutIdxPerMonitor[monitorIndex] = layoutIndex;
        let workspaceIndex = WorkspaceManager.get_active_workspace().index();
        this.trySetWorkspaceMonitorLayout(workspaceIndex, monitorIndex, layoutIndex);
        this.saveLayouts();
        (_a = this.tabManager[monitorIndex]) === null || _a === void 0 ? void 0 : _a.destroy();
        this.tabManager[monitorIndex] = null;
        const animationsEnabled = getBoolSetting(ANIMATIONS_ENABLED);
        if (gridSettings[SHOW_TABS]) {
            this.tabManager[monitorIndex] = new TabbedZoneManager(activeMonitors()[monitorIndex], this.layouts.definitions[layoutIndex], gridSettings[WINDOW_MARGIN], animationsEnabled);
        }
        else {
            this.tabManager[monitorIndex] = new ZoneManager(activeMonitors()[monitorIndex], this.layouts.definitions[layoutIndex], gridSettings[WINDOW_MARGIN], animationsEnabled);
        }
        (_b = this.tabManager[monitorIndex]) === null || _b === void 0 ? void 0 : _b.layoutWindows();
        this.reloadMenu();
    }
    showLayoutPreview(monitorIndex, layout) {
        var _a;
        (_a = this.preview[monitorIndex]) === null || _a === void 0 ? void 0 : _a.destroy();
        this.preview[monitorIndex] = null;
        this.preview[monitorIndex] = new ZonePreview(activeMonitors()[monitorIndex], layout, gridSettings[WINDOW_MARGIN]);
        this.preview[monitorIndex].show();
    }
    hideLayoutPreview() {
        activeMonitors().forEach(monitor => {
            var _a;
            (_a = this.preview[monitor.index]) === null || _a === void 0 ? void 0 : _a.destroy();
            this.preview[monitor.index] = null;
        });
    }
    /** Returns true if the settings allow to span multiple zones and
     *  the user is holding ALT. The user must enable it in the settings
     *  and it is not possible to span multiple zones in "tab" mode */
    canSpanMultipleZones() {
        return !getBoolSetting(SHOW_TABS) &&
            getBoolSetting(SPAN_MULTIPLE_ZONES) &&
            this.modifiersManager.isHolding(MODIFIERS_ENUM.ALT);
    }
    enable() {
        this.layouts = this.layoutsUtils.loadLayoutSettings();
        log(JSON.stringify(this.layouts));
        if (this.refreshLayouts()) {
            this.saveLayouts();
        }
        this.setToCurrentWorkspace();
        monitorsChangedConnect = Main.layoutManager.connect('monitors-changed', () => {
            activeMonitors().forEach(m => {
                var _a;
                (_a = this.tabManager[m.index]) === null || _a === void 0 ? void 0 : _a.layoutWindows();
            });
            this.reloadMenu();
        });
        const validWindow = (window) => window != null
            && window.get_window_type() == WindowType.NORMAL;
        global.display.connect('window-created', (_display, win) => {
            if (validWindow(win)) {
                activeMonitors().forEach(m => {
                    var _a;
                    (_a = this.tabManager[m.index]) === null || _a === void 0 ? void 0 : _a.layoutWindows();
                });
            }
        });
        global.display.connect('in-fullscreen-changed', (_display) => {
            if (global.display.get_monitor_in_fullscreen(0)) {
                activeMonitors().forEach(m => {
                    var _a;
                    (_a = this.tabManager[m.index]) === null || _a === void 0 ? void 0 : _a.destroy();
                    this.tabManager[m.index] = null;
                });
            }
            else {
                this.setToCurrentWorkspace();
            }
        });
        global.display.connect('grab-op-begin', (_display, win) => {
            // only start isGrabbing if is a valid window to avoid conflict 
            // with dash-to-panel/appIcons.js:1021 where are emitting a grab-op-begin
            // without never emitting a grab-op-end
            if (!validWindow(win))
                return;
            const spanMultipleZones = this.canSpanMultipleZones();
            const useModifier = getBoolSetting(USE_MODIFIER);
            this.isGrabbing = true;
            if (useModifier &&
                !this.modifiersManager.isHolding(MODIFIERS_ENUM.CONTROL))
                return;
            activeMonitors().forEach(m => {
                var _a, _b;
                (_a = this.tabManager[m.index]) === null || _a === void 0 ? void 0 : _a.allow_multiple_zones_selection(spanMultipleZones);
                (_b = this.tabManager[m.index]) === null || _b === void 0 ? void 0 : _b.show();
            });
        });
        global.display.connect('grab-op-end', (_display, win) => {
            const useModifier = getBoolSetting(USE_MODIFIER);
            this.isGrabbing = false;
            if (!validWindow(win)) {
                return;
            }
            let selection;
            activeMonitors().forEach(m => {
                var _a, _b, _c, _d;
                if (!useModifier || this.modifiersManager.isHolding(MODIFIERS_ENUM.CONTROL)) {
                    if (!trackedWindows.includes(win)) {
                        trackedWindows.push(win);
                    }
                    if (!selection) { // ensure window is moved one time only
                        selection = (_a = this.tabManager[m.index]) === null || _a === void 0 ? void 0 : _a.getSelectionRect();
                        // may be undefined if there are no zones selected in this monitor
                        if (selection) {
                            this.moveWindow(win, selection.x, selection.y, selection.width, selection.height);
                        }
                    }
                    (_b = this.tabManager[m.index]) === null || _b === void 0 ? void 0 : _b.hide(); // hide zones after the window was moved
                    (_c = this.tabManager[m.index]) === null || _c === void 0 ? void 0 : _c.layoutWindows();
                    return;
                }
                (_d = this.tabManager[m.index]) === null || _d === void 0 ? void 0 : _d.hide();
                if (useModifier && !this.modifiersManager.isHolding(MODIFIERS_ENUM.CONTROL) && trackedWindows.includes(win)) {
                    trackedWindows.splice(trackedWindows.indexOf(win), 1);
                }
            });
        });
        if (getBoolSetting(USE_MODIFIER) || getBoolSetting(SPAN_MULTIPLE_ZONES)) {
            // callback run when a modifier change state (e.g from not pressed to pressed)
            this.modifiersManager.connect("changed", () => {
                if (!this.isGrabbing) {
                    return;
                }
                const spanMultipleZones = getBoolSetting(SPAN_MULTIPLE_ZONES);
                if (spanMultipleZones) {
                    const allow_multiple_selections = this.canSpanMultipleZones();
                    activeMonitors().forEach(m => {
                        var _a;
                        (_a = this.tabManager[m.index]) === null || _a === void 0 ? void 0 : _a.allow_multiple_zones_selection(allow_multiple_selections);
                    });
                }
                if (!getBoolSetting(USE_MODIFIER))
                    return;
                if (this.modifiersManager.isHolding(MODIFIERS_ENUM.CONTROL)) {
                    activeMonitors().forEach(m => {
                        var _a;
                        (_a = this.tabManager[m.index]) === null || _a === void 0 ? void 0 : _a.show();
                    });
                }
                else {
                    activeMonitors().forEach(m => { var _a; return (_a = this.tabManager[m.index]) === null || _a === void 0 ? void 0 : _a.hide(); });
                }
            });
        }
        this.restackConnection = global.display.connect('restacked', () => {
            activeMonitors().forEach(m => {
                var _a;
                (_a = this.tabManager[m.index]) === null || _a === void 0 ? void 0 : _a.layoutWindows();
            });
        });
        this.workspaceSwitchedConnect = WorkspaceManager.connect('workspace-switched', () => {
            if (this.refreshLayouts()) {
                this.saveLayouts();
            }
            activeMonitors().forEach(m => {
                var _a;
                (_a = this.tabManager[m.index]) === null || _a === void 0 ? void 0 : _a.destroy();
                this.tabManager[m.index] = null;
            });
            this.setToCurrentWorkspace();
        });
        this.workareasChangedConnect = global.display.connect('workareas-changed', () => {
            activeMonitors().forEach(m => {
                var _a, _b;
                (_a = this.tabManager[m.index]) === null || _a === void 0 ? void 0 : _a.reinit();
                (_b = this.tabManager[m.index]) === null || _b === void 0 ? void 0 : _b.layoutWindows();
            });
        });
        launcher = new GSnapStatusButton('tiling-icon');
        launcher.label = "Layouts";
        if (gridSettings[SHOW_ICON]) {
            Main.panel.addToStatusArea("GSnapStatusButton", launcher);
            this.reloadMenu();
        }
        bind(keyBindings);
        if (gridSettings[GLOBAL_PRESETS]) {
            bind(key_bindings_presets);
        }
        if (gridSettings[MOVERESIZE_ENABLED]) {
            bind(keyBindingGlobalResizes);
        }
        this.modifiersManager.enable();
        enabled = true;
        log("Extension enable completed");
    }
    refreshLayouts() {
        let changed = false;
        // A workspace could have been added. Populate the layouts.workspace array
        let nWorkspaces = WorkspaceManager.get_n_workspaces();
        let nMonitors = activeMonitors().length;
        log(`refreshLayouts ${this.layouts.workspaces.length} ${nWorkspaces} ${nMonitors}`);
        while (this.layouts.workspaces.length < nWorkspaces) {
            let wk = new Array(nMonitors);
            wk.fill({ current: 0 });
            this.layouts.workspaces.push(wk);
            changed = true;
        }
        return changed;
    }
    moveFocusedWindow(direction) {
        var _a;
        let monitorIndex = getCurrentMonitorIndex();
        const monitor = activeMonitors()[monitorIndex];
        if (!monitor)
            return;
        let windows = getWindowsOfMonitor(monitor).filter(w => w.has_focus());
        if (windows.length <= 0)
            return;
        let focusedWindow = windows[0];
        log(`Move ${focusedWindow.title} ${direction}`);
        const useModifier = getBoolSetting(USE_MODIFIER);
        if (useModifier) {
            if (!trackedWindows.includes(focusedWindow)) {
                trackedWindows.push(focusedWindow);
            }
        }
        let zoneManager = this.tabManager[monitorIndex];
        if (!zoneManager)
            return;
        let frameRect = focusedWindow.get_frame_rect();
        // get window center position
        let x = frameRect.x + (frameRect.width / 2);
        let y = frameRect.y + (frameRect.height / 2);
        // add/remove 2 to avoid zone not being recognized due to rounding errors
        switch (direction) {
            case MoveDirection.Up:
                y = frameRect.y - (2 + zoneManager.margin);
                break;
            case MoveDirection.Down:
                y = frameRect.y + frameRect.height + (2 + zoneManager.margin);
                break;
            case MoveDirection.Left:
                x = frameRect.x - (2 + zoneManager.margin);
                break;
            case MoveDirection.Right:
                x = frameRect.x + frameRect.width + (2 + zoneManager.margin);
                break;
        }
        let layoutZones = zoneManager.recursiveChildren();
        for (let i = 0; i < layoutZones.length; i++) {
            let zone = layoutZones[i];
            log(`Zone: ${zone.x}/${zone.y}/${zone.width}/${zone.height} contains: ${x}, ${y}`);
            if (zone.contains(x, y)) {
                this.moveWindow(focusedWindow, zone.innerX, zone.innerY, zone.innerWidth, zone.innerHeight);
                (_a = this.tabManager[monitorIndex]) === null || _a === void 0 ? void 0 : _a.layoutWindows();
                return;
            }
        }
    }
    moveWindow(window, x, y, width, height) {
        log(`moveWindow moving to x:${x}, y:${y}`);
        if (getBoolSetting(ANIMATIONS_ENABLED)) {
            const windowActor = window.get_compositor_private();
            windowActor.remove_all_transitions();
            Main.wm._prepareAnimationInfo(global.window_manager, windowActor, window.get_frame_rect().copy(), MetaSizeChange.MAXIMIZE);
        }
        window.move_frame(true, x, y);
        window.move_resize_frame(true, x, y, width, height);
    }
    getWorkspaceMonitorSettings(workspaceIdx) {
        if (this.layouts.workspaces[workspaceIdx] === undefined) {
            let wk = new Array(activeMonitors().length);
            wk.fill({ current: 0 });
            this.layouts.workspaces[workspaceIdx] = wk;
        }
        return this.layouts.workspaces[workspaceIdx];
    }
    getWorkspaceMonitorCurrentLayoutOrDefault(workspaceIdx, monitorIdx) {
        let workspaceMonitorSettings = this.getWorkspaceMonitorSettings(workspaceIdx);
        return workspaceMonitorSettings[monitorIdx]
            ? workspaceMonitorSettings[monitorIdx].current
            : 0;
    }
    trySetWorkspaceMonitorLayout(workspaceIdx, monitorIdx, currentLayout) {
        let workspaceMonitorSettings = this.getWorkspaceMonitorSettings(workspaceIdx);
        if (workspaceMonitorSettings[monitorIdx]) {
            workspaceMonitorSettings[monitorIdx].current = currentLayout;
        }
    }
    minimizeAllWindows() {
        // we need to know what windows have been minimized by the user
        // so we don't accidentally restore them when calling unminimizeAllWindows()
        this.minimizedWindows = WorkspaceManager
            .get_active_workspace()
            .list_windows()
            .filter(x => !x.minimized);
        this.minimizedWindows.forEach(w => w.minimize());
    }
    unminimizeAllWindows() {
        this.minimizedWindows.forEach(w => w.unminimize());
        this.minimizedWindows = [];
    }
    reloadMenu() {
        if (launcher == null)
            return;
        launcher.menu.removeAll();
        let resetLayoutButton = new PopupMenu.PopupMenuItem(_("Reset Layout"));
        let editLayoutButton = new PopupMenu.PopupMenuItem(_("Edit Layout"));
        let saveLayoutButton = new PopupMenu.PopupMenuItem(_("Save Layout"));
        let cancelEditingButton = new PopupMenu.PopupMenuItem(_("Cancel Editing"));
        let newLayoutButton = new PopupMenu.PopupMenuItem(_("Create New Layout"));
        const currentMonitorLayoutIdx = this.currentLayoutIdxPerMonitor[getCurrentMonitorIndex()];
        const currentLayout = this.layouts.definitions[currentMonitorLayoutIdx];
        let renameLayoutButton = new PopupMenu.PopupMenuItem(_("Rename: " + currentLayout.name));
        let currentMonitorIndex = getCurrentMonitorIndex();
        if (this.editor[currentMonitorIndex] != null) {
            launcher.menu.addMenuItem(resetLayoutButton);
            launcher.menu.addMenuItem(saveLayoutButton);
            launcher.menu.addMenuItem(cancelEditingButton);
        }
        else {
            const monitorsCount = activeMonitors().length;
            for (let mI = 0; mI < monitorsCount; mI++) {
                if (monitorsCount > 1) {
                    let monitorName = new PopupMenu.PopupSubMenuMenuItem(_(`Monitor ${mI}`));
                    launcher.menu.addMenuItem(monitorName);
                    this.createLayoutMenuItems(mI).forEach(i => monitorName.menu.addMenuItem(i));
                }
                else {
                    this.createLayoutMenuItems(mI).forEach(i => launcher === null || launcher === void 0 ? void 0 : launcher.menu.addMenuItem(i));
                }
            }
            let sep = new PopupMenu.PopupSeparatorMenuItem();
            launcher.menu.addMenuItem(sep);
            launcher.menu.addMenuItem(editLayoutButton);
            launcher.menu.addMenuItem(renameLayoutButton);
            launcher.menu.addMenuItem(newLayoutButton);
            // Add an entry-point for more settings
            launcher.menu.addMenuItem(new PopupMenu.PopupSeparatorMenuItem());
            const settingsButton = launcher.menu.addAction('Settings', () => ExtensionUtils.openPrefs());
            launcher.menu.addMenuItem(settingsButton);
        }
        renameLayoutButton.connect('activate', () => {
            const currentMonitorLayoutIdx = this.currentLayoutIdxPerMonitor[getCurrentMonitorIndex()];
            const currentMonitorLayout = this.layouts.definitions[currentMonitorLayoutIdx];
            let dialog = new EntryDialog({
                label: "test"
            });
            dialog.label.text = "Rename Layout " + currentMonitorLayout.name;
            dialog.entry.text = currentMonitorLayout.name;
            dialog.onOkay = (text) => {
                currentMonitorLayout.name = text;
                this.saveLayouts();
                this.reloadMenu();
            };
            dialog.open(global.get_current_time());
        });
        newLayoutButton.connect('activate', () => {
            let dialog = new EntryDialog();
            dialog.label.text = "Create New Layout";
            dialog.onOkay = (text) => {
                this.layouts.definitions.push({
                    name: text,
                    type: 0,
                    length: 100,
                    items: [
                        {
                            type: 0,
                            length: 100,
                            items: []
                        }
                    ]
                });
                this.setLayout(this.layouts.definitions.length - 1);
                this.saveLayouts();
                this.reloadMenu();
            };
            dialog.open(global.get_current_time());
        });
        editLayoutButton.connect('activate', () => {
            activeMonitors().forEach(m => {
                var _a, _b, _c;
                const currentMonitorLayoutIdx = this.currentLayoutIdxPerMonitor[m.index];
                const currentMonitorLayout = this.layouts.definitions[currentMonitorLayoutIdx];
                const editLayout = cloneLayout(currentMonitorLayout);
                (_a = this.editor[m.index]) === null || _a === void 0 ? void 0 : _a.destroy();
                this.editor[m.index] = new ZoneEditor(activeMonitors()[m.index], editLayout, gridSettings[WINDOW_MARGIN]);
                (_b = this.editor[m.index]) === null || _b === void 0 ? void 0 : _b.init();
                (_c = this.editor[m.index]) === null || _c === void 0 ? void 0 : _c.show();
            });
            this.minimizeAllWindows();
            this.reloadMenu();
        });
        saveLayoutButton.connect('activate', () => {
            this.saveLayouts();
            this.setToCurrentWorkspace();
            this.reloadMenu();
        });
        resetLayoutButton.connect('activate', () => {
            activeMonitors().forEach(m => {
                let editor = this.editor[m.index];
                if (editor) {
                    editor.destroy();
                    editor.layoutItem = {
                        type: 0,
                        length: 100,
                        items: [
                            {
                                type: 0,
                                length: 100,
                                items: [],
                            }
                        ]
                    };
                    editor.applyLayout(editor);
                    this.reloadMenu();
                }
            });
        });
        cancelEditingButton.connect('activate', () => {
            activeMonitors().forEach(m => {
                var _a;
                (_a = this.editor[m.index]) === null || _a === void 0 ? void 0 : _a.destroy();
                this.editor[m.index] = null;
            });
            this.unminimizeAllWindows();
            this.reloadMenu();
        });
    }
    createLayoutMenuItems(monitorIndex) {
        let items = [];
        for (let i = 0; i < this.layouts.definitions.length; i++) {
            let item = new PopupMenu.PopupMenuItem(_(this.layouts.definitions[i].name == null ? "Layout " + i : this.layouts.definitions[i].name));
            item.connect('activate', () => {
                this.setLayout(i, monitorIndex);
                this.hideLayoutPreview();
            });
            item.actor.connect('enter-event', () => {
                this.showLayoutPreview(monitorIndex, this.layouts.definitions[i]);
            });
            item.actor.connect('leave-event', () => {
                this.hideLayoutPreview();
            });
            items.push(item);
        }
        return items;
    }
    saveLayouts() {
        activeMonitors().forEach(m => {
            const idx = this.currentLayoutIdxPerMonitor[m.index];
            const editor = this.editor[m.index];
            if (editor) {
                if (editor.layout) {
                    this.layouts.definitions[idx] = editor.layout;
                }
                editor.apply();
                editor.destroy();
            }
            this.editor[m.index] = null;
        });
        this.layoutsUtils.saveSettings(this.layouts);
        this.unminimizeAllWindows();
    }
    disable() {
        var _a, _b, _c;
        log("Extension disable begin");
        enabled = false;
        this.modifiersManager.destroy();
        (_a = this.preview) === null || _a === void 0 ? void 0 : _a.forEach(p => { p === null || p === void 0 ? void 0 : p.destroy(); p = null; });
        (_b = this.editor) === null || _b === void 0 ? void 0 : _b.forEach(e => { e === null || e === void 0 ? void 0 : e.destroy(); e = null; });
        (_c = this.tabManager) === null || _c === void 0 ? void 0 : _c.forEach(t => { t === null || t === void 0 ? void 0 : t.destroy(); t = null; });
        if (this.workspaceSwitchedConnect) {
            WorkspaceManager.disconnect(this.workspaceSwitchedConnect);
            this.workspaceSwitchedConnect = false;
        }
        if (this.restackConnection) {
            global.display.disconnect(this.restackConnection);
            this.restackConnection = false;
        }
        if (monitorsChangedConnect) {
            log("Disconnecting monitors-changed");
            Main.layoutManager.disconnect(monitorsChangedConnect);
            monitorsChangedConnect = false;
        }
        if (this.workareasChangedConnect) {
            global.display.disconnect(this.workareasChangedConnect);
            this.workareasChangedConnect = false;
        }
        unbind(keyBindings);
        unbind(key_bindings_presets);
        unbind(keyBindingGlobalResizes);
        launcher === null || launcher === void 0 ? void 0 : launcher.destroy();
        launcher = null;
    }
    /**
     * onFocus is called when the global focus changes.
     */
    onFocus() { }
    showMenu() { }
    setToCurrentWorkspace() {
        let currentWorkspaceIdx = WorkspaceManager.get_active_workspace().index();
        activeMonitors().forEach(m => {
            let currentLayoutIdx = this.getWorkspaceMonitorCurrentLayoutOrDefault(currentWorkspaceIdx, m.index);
            this.setLayout(currentLayoutIdx, m.index);
        });
    }
}
const globalApp = new App();
class GSnapStatusButtonClass extends PanelMenu.Button {
    _init() {
        super._init(0.0, "gSnap", false);
        this._icon = new St.Icon({ style_class: 'tiling-icon' });
        this._icon.gicon = Gio.icon_new_for_string(`${Me.path}/images/tray.svg`);
        this.add_actor(this._icon);
        this.connect('button-press-event', this._onButtonPress);
        log("GSnapStatusButton _init done");
    }
    _onButtonPress(_actor, _event) {
        log(`_onButtonPress Click Toggle Status on system panel ${this}`);
        globalApp.showMenu();
    }
}
const GSnapStatusButton = GObject.registerClass({
    GTypeName: 'GSnapStatusButton',
}, GSnapStatusButtonClass);
function changed_settings() {
    log("changed_settings");
    if (enabled) {
        disable();
        enable();
    }
    log("changed_settings complete");
}
function enable() {
    initSettings(changed_settings);
    log("Extension enable begin");
    SHELL_VERSION.print_version();
    globalApp.enable();
}
function disable() {
    deinitSettings();
    globalApp.disable();
}

