'use strict';

// GENERATED CODE: DO NOT EDIT
const ANIMATIONS_ENABLED = "animations-enabled";
const DEBUG = "debug";
const MOVE_FOCUSED_DOWN = "move-focused-down";
const MOVE_FOCUSED_LEFT = "move-focused-left";
const MOVE_FOCUSED_RIGHT = "move-focused-right";
const MOVE_FOCUSED_UP = "move-focused-up";
const MOVERESIZE_ENABLED = "moveresize-enabled";
const PRESET_RESIZE_1 = "preset-resize-1";
const PRESET_RESIZE_10 = "preset-resize-10";
const PRESET_RESIZE_11 = "preset-resize-11";
const PRESET_RESIZE_12 = "preset-resize-12";
const PRESET_RESIZE_2 = "preset-resize-2";
const PRESET_RESIZE_3 = "preset-resize-3";
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

const GObject = imports.gi.GObject;
const Gtk = imports.gi.Gtk;
const Gio = imports.gi.Gio;
// Globals
const pretty_names = {
    [PRESET_RESIZE_1]: 'Layout 1',
    [PRESET_RESIZE_2]: 'Layout 2',
    [PRESET_RESIZE_3]: 'Layout 3',
    [PRESET_RESIZE_4]: 'Layout 4',
    [PRESET_RESIZE_5]: 'Layout 5',
    [PRESET_RESIZE_6]: 'Layout 6',
    [PRESET_RESIZE_7]: 'Layout 7',
    [PRESET_RESIZE_8]: 'Layout 8',
    [PRESET_RESIZE_9]: 'Layout 9',
    [PRESET_RESIZE_10]: 'Layout 10',
    [PRESET_RESIZE_11]: 'Layout 11',
    [PRESET_RESIZE_12]: 'Layout 12',
    [MOVE_FOCUSED_UP]: 'Move focused window up',
    [MOVE_FOCUSED_DOWN]: 'Move focused window down',
    [MOVE_FOCUSED_LEFT]: 'Move focused window left',
    [MOVE_FOCUSED_RIGHT]: 'Move focused window right',
};
function set_child(widget, child) {
    if (Gtk.get_major_version() >= 4) {
        widget.set_child(child);
    }
    else {
        widget.add(child);
    }
}
function box_append(box, child) {
    if (Gtk.get_major_version() >= 4) {
        box.append(child);
    }
    else {
        box.add(child);
    }
}
class PrefsBuilder {
    accel_tab(notebook) {
        let settings = imports.misc.extensionUtils.getSettings();
        let ks_grid = new Gtk.Grid({
            column_spacing: 10,
            orientation: Gtk.Orientation.VERTICAL,
            row_spacing: 10,
        });
        ks_grid.set_margin_start(24);
        ks_grid.set_margin_top(24);
        let model = new Gtk.ListStore();
        model.set_column_types([
            GObject.TYPE_STRING,
            GObject.TYPE_STRING,
            GObject.TYPE_INT,
            GObject.TYPE_INT
        ]);
        for (let key in pretty_names) {
            this.append_hotkey(model, settings, key, pretty_names[key]);
        }
        let treeview = new Gtk.TreeView({
            'model': model,
            'hexpand': true
        });
        let col;
        let cellrend;
        cellrend = new Gtk.CellRendererText();
        col = new Gtk.TreeViewColumn({
            'title': 'Keybinding',
            'expand': true
        });
        col.pack_start(cellrend, true);
        col.add_attribute(cellrend, 'text', 1);
        treeview.append_column(col);
        cellrend = new Gtk.CellRendererAccel({
            'editable': true,
            'accel-mode': Gtk.CellRendererAccelMode.GTK
        });
        cellrend.connect('accel-cleared', function (_rend, str_iter) {
            let [success, iter] = model.get_iter_from_string(str_iter);
            if (!success) {
                throw new Error("Something be broken, yo.");
            }
            let name = model.get_value(iter, 0);
            model.set(iter, [3], [0]);
            settings.set_strv(name, ['']);
        });
        cellrend.connect('accel-edited', function (rend, str_iter, key, mods) {
            let value = Gtk.accelerator_name(key, mods);
            let [success, iter] = model.get_iter_from_string(str_iter);
            if (!success) {
                throw new Error("Something be broken, yo.");
            }
            let name = model.get_value(iter, 0);
            model.set(iter, [2, 3], [mods, key]);
            settings.set_strv(name, [value]);
        });
        col = new Gtk.TreeViewColumn({
            'title': 'Accel'
        });
        col.pack_end(cellrend, false);
        col.add_attribute(cellrend, 'accel-mods', 2);
        col.add_attribute(cellrend, 'accel-key', 3);
        treeview.append_column(col);
        let text = "Keyboard shortcuts. Arrows are used to move window and are not re-assignable.";
        ks_grid.attach_next_to(new Gtk.Label({
            label: text,
            halign: Gtk.Align.START,
            justify: Gtk.Justification.LEFT,
            use_markup: false,
            wrap: true,
        }), null, Gtk.PositionType.BOTTOM, 1, 1);
        ks_grid.attach_next_to(treeview, null, Gtk.PositionType.BOTTOM, 1, 1);
        let ks_window = new Gtk.ScrolledWindow({ 'vexpand': true });
        set_child(ks_window, ks_grid);
        let ks_label = new Gtk.Label({
            label: "Accelerators",
            halign: Gtk.Align.START,
            use_markup: false,
        });
        notebook.append_page(ks_window, ks_label);
    }
    basics_tab(notebook) {
        let settings = imports.misc.extensionUtils.getSettings();
        let bs_grid = new Gtk.Grid({
            column_spacing: 10,
            orientation: Gtk.Orientation.VERTICAL,
            row_spacing: 10,
        });
        bs_grid.set_margin_start(24);
        bs_grid.set_margin_top(24);
        this.add_check("Show icon", SHOW_ICON, bs_grid, settings);
        const show_tabs_check = this.add_check("Show tabs", SHOW_TABS, bs_grid, settings);
        this.add_label("This feature is not supported if you have the \"Hold ALT to span multiple zones\" feature enabled", bs_grid);
        this.add_check("Enable accelerators for moving and resizing windows", MOVERESIZE_ENABLED, bs_grid, settings);
        this.add_check("Hold CTRL to snap windows", USE_MODIFIER, bs_grid, settings);
        const span_multiple_zones_check = this.add_check("Hold ALT to span multiple zones", SPAN_MULTIPLE_ZONES, bs_grid, settings);
        this.add_label("This feature is not supported if you have the \"Show tabs\" feature enabled", bs_grid);
        // disable "Span multiple zones" setting if "Show tabs" setting was already enabled
        if (settings.get_boolean(SHOW_TABS)) {
            span_multiple_zones_check.set_sensitive(false);
            // disable "Show tabs" setting if "Span multiple zones" setting was already enabled
        }
        else if (settings.get_boolean(SPAN_MULTIPLE_ZONES)) {
            show_tabs_check.set_sensitive(false);
        }
        this.add_check("Enable animations", ANIMATIONS_ENABLED, bs_grid, settings);
        this.add_check("Debug", DEBUG, bs_grid, settings);
        this.add_label("To see debug messages, in terminal run journalctl /usr/bin/gnome-shell -f", bs_grid);
        let bs_window = new Gtk.ScrolledWindow({ 'vexpand': true });
        set_child(bs_window, bs_grid);
        let bs_label = new Gtk.Label({
            label: "Basic",
            halign: Gtk.Align.START,
            use_markup: false,
        });
        notebook.append_page(bs_window, bs_label);
        // Watch for changes to the setting SETTINGS.SHOW_TABS
        settings.connect(`changed::${SHOW_TABS}`, (settings, changed_key) => {
            // disable "Span multiple zones" setting if "Show tabs" setting is enabled by the user
            span_multiple_zones_check.set_sensitive(!settings.get_boolean(changed_key));
        });
        // Watch for changes to the setting SETTINGS.SPAN_MULTIPLE_ZONES
        settings.connect(`changed::${SPAN_MULTIPLE_ZONES}`, (settings, changed_key) => {
            // disable "Show tabs" setting if "Span multiple zones" setting is enabled by the user
            show_tabs_check.set_sensitive(!settings.get_boolean(changed_key));
        });
    }
    margins_tab(notebook) {
        let settings = imports.misc.extensionUtils.getSettings();
        let mg_grid = new Gtk.Grid({
            column_spacing: 10,
            orientation: Gtk.Orientation.VERTICAL,
            row_spacing: 10,
        });
        mg_grid.set_margin_start(24);
        mg_grid.set_margin_top(24);
        let text = "Window margins and invisible borders around screen.";
        mg_grid.attach_next_to(new Gtk.Label({
            label: text,
            halign: Gtk.Align.START,
            justify: Gtk.Justification.LEFT,
            use_markup: false,
            wrap: true,
        }), null, Gtk.PositionType.BOTTOM, 1, 1);
        this.add_int("Window margin", WINDOW_MARGIN, mg_grid, settings, 0, 240, 1, 10);
        let mg_window = new Gtk.ScrolledWindow({ 'vexpand': true });
        set_child(mg_window, mg_grid);
        let mg_label = new Gtk.Label({
            label: "Margins",
            halign: Gtk.Align.START,
            use_markup: false,
        });
        notebook.append_page(mg_window, mg_label);
    }
    help_tab(notebook) {
        let weblink = 'https://github.com/micahosborne/gSnap/blob/master/README.md';
        let hl_link = new Gtk.LinkButton({
            label: weblink,
            uri: weblink,
            halign: Gtk.Align.CENTER,
            valign: Gtk.Align.CENTER,
        });
        let hl_label = new Gtk.Label({
            label: "Help",
            halign: Gtk.Align.START,
            use_markup: false,
        });
        notebook.append_page(hl_link, hl_label);
    }
    build() {
        let notebook = new Gtk.Notebook();
        this.basics_tab(notebook);
        this.accel_tab(notebook);
        //presets_tab(notebook);
        this.margins_tab(notebook);
        this.help_tab(notebook);
        let main_vbox = new Gtk.Box({
            orientation: Gtk.Orientation.VERTICAL,
            spacing: 10
        });
        if (Gtk.get_major_version() >= 4) {
            main_vbox.prepend(notebook, true, true, 0);
        }
        else {
            main_vbox.pack_start(notebook, true, true, 0);
            main_vbox.show_all();
        }
        return main_vbox;
    }
    add_check(check_label, SETTINGS, grid, settings) {
        let check = new Gtk.CheckButton({ label: check_label, margin_top: 6 });
        settings.bind(SETTINGS, check, 'active', Gio.SettingsBindFlags.DEFAULT);
        grid.attach_next_to(check, null, Gtk.PositionType.BOTTOM, 1, 1);
        return check;
    }
    add_int(int_label, SETTINGS, grid, settings, minv, maxv, incre, page) {
        let item = new IntSelect(int_label);
        item.set_args(minv, maxv, incre, page);
        settings.bind(SETTINGS, item.spin, 'value', Gio.SettingsBindFlags.DEFAULT);
        grid.attach_next_to(item.actor, null, Gtk.PositionType.BOTTOM, 1, 1);
    }
    add_text(text_label, SETTINGS, grid, settings, width) {
        let item = new TextEntry(text_label);
        item.set_args(width);
        settings.bind(SETTINGS, item.textentry, 'text', Gio.SettingsBindFlags.DEFAULT);
        grid.attach_next_to(item.actor, null, Gtk.PositionType.BOTTOM, 1, 1);
    }
    add_label(label, grid) {
        let gtk_label = new Gtk.Label({
            label: label,
            halign: Gtk.Align.START,
            justify: Gtk.Justification.LEFT,
            use_markup: false,
            wrap: true,
        });
        grid.attach_next_to(gtk_label, null, Gtk.PositionType.BOTTOM, 1, 1);
        return gtk_label;
    }
    append_hotkey(model, settings, name, pretty_name) {
        let _ok, key, mods;
        if (Gtk.get_major_version() >= 4) {
            // ignore ok as failure treated as disabled
            [_ok, key, mods] = Gtk.accelerator_parse(settings.get_strv(name)[0]);
        }
        else {
            [key, mods] = Gtk.accelerator_parse(settings.get_strv(name)[0]);
        }
        let row = model.insert(-1);
        model.set(row, [0, 1, 2, 3], [name, pretty_name, mods, key]);
    }
}
// grabbed from sysmonitor code
class IntSelect {
    constructor(name) {
        this.label = new Gtk.Label({
            label: name + ":",
            halign: Gtk.Align.START
        });
        this.spin = new Gtk.SpinButton({
            halign: Gtk.Align.END
        });
        this.actor = new Gtk.Box({ orientation: Gtk.Orientation.HORIZONTAL, spacing: 10 });
        this.actor.set_homogeneous(true);
        box_append(this.actor, this.label);
        box_append(this.actor, this.spin);
        this.spin.set_numeric(true);
    }
    set_args(minv, maxv, incre, page) {
        this.spin.set_range(minv, maxv);
        this.spin.set_increments(incre, page);
    }
    set_value(value) {
        this.spin.set_value(value);
    }
}
class TextEntry {
    constructor(name) {
        this.label = new Gtk.Label({ label: name + ":" });
        this.textentry = new Gtk.Entry();
        this.actor = new Gtk.Box({ orientation: Gtk.Orientation.HORIZONTAL, spacing: 10 });
        this.actor.set_homogeneous(true);
        box_append(this.actor, this.label);
        box_append(this.actor, this.textentry);
        this.textentry.set_text("");
    }
    set_args(width) {
        this.textentry.set_width_chars(width);
    }
    set_value(value) {
        this.textentry.set_text(value);
    }
}
function init() {
}
function buildPrefsWidget() {
    let builder = new PrefsBuilder();
    return builder.build();
}

