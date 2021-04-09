# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from libqtile.config import Key, Screen, Group, Drag, Click
from libqtile.lazy import lazy
from libqtile import layout, bar, widget

from typing import List  # noqa: F401


colores=open("/home/pob/.cache/wal/colors", "r")
d={}
for x in range(0, 15):
    d["color{0}".format(x)] = colores.readline()

mod = "mod4"

keys = [
    # Switch between windows in current stack pane
    Key([mod], "Down", lazy.layout.down()),
    Key([mod], "Up", lazy.layout.up()),
    Key([mod], "Right", lazy.layout.right()),
    Key([mod], "Left", lazy.layout.left()),

    # Move windows up or down in current stack
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "Up", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "Right", lazy.layout.shuffle_right()),
    Key([mod, "shift"], "Left", lazy.layout.shuffle_left()),


    Key([mod, "mod1"], "Down", lazy.layout.flip_down()),
    Key([mod, "mod1"], "Up", lazy.layout.flip_up()),
    Key([mod, "mod1"], "Left", lazy.layout.flip_left()),
    Key([mod, "mod1"], "Right", lazy.layout.flip_right()),
    Key([mod, "control"], "Down", lazy.layout.grow_down()),
    Key([mod, "control"], "Up", lazy.layout.grow_up()),
    Key([mod, "control"], "Left", lazy.layout.grow_left()),
    Key([mod, "control"], "Right", lazy.layout.grow_right()),
    Key([mod, "shift"], "n", lazy.layout.normalize()),



    # Switch window focus to other pane(s) of stack
    Key([mod], "space", lazy.layout.next()),

    # Swap panes of split stack
    Key([mod, "shift"], "space", lazy.layout.rotate()),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split()),
    Key([mod], "Return", lazy.spawn("kitty")),


    Key([mod], "f", lazy.spawn("firefox")),
    Key([mod], "t", lazy.spawn('emacs -e telega')),
    Key([mod], "p", lazy.spawn("emacsclient -c ~/org/pendientes.org")),
    Key([mod], "n", lazy.spawn("emacsclient -c")),
    Key([mod], "w", lazy.spawn("firefox -new-window web.whatsapp.com")),




    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout()),
    Key([mod, "shift"], "c", lazy.window.kill()),

    Key([mod, "shift"], "r", lazy.restart()),
    Key([mod, "shift"], "q", lazy.shutdown()),
    Key([mod], "d", lazy.spawn("rofi -modi drun -show drun -line-padding 0 -columns 1 -hide-scrollbar -show-icons -font \"Fira Code Retina 10\"")),
    Key([], "XF86AudioMute", lazy.spawn("amixer -q set Master toggle")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer -c 0 sset Master 1- unmute")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer -c 0 sset Master 1+ unmute")),
    Key([], "XF86AudioMicMute", lazy.spawn("amixer set Capture toggle")),
    Key([mod], "s", lazy.spawn("bash -c \"import png:- | xclip -selection clipboard -t image/png -i\"")),
]

#groups = [Group(i) for i in "123456789"]


#for i in groups:
#    keys.extend([
#        Key([mod], i.name, lazy.group[i.name].toscreen()),
#        Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True)),
#    ])


group_names = [
    ("一", {}),
    ("二", {}),
    ("三", {}),
    ("四", {}),
    ("五", {}),
    ("六", {}),
    ("七", {}),
    ("八", {}),
    ("九", {})
]

groups = [Group(name, **kwargs) for name, kwargs in group_names]

for i, (name, kwargs) in enumerate(group_names, 1):
    keys.append(
        Key([mod], str(i), lazy.group[name].toscreen())
    )
    keys.append(
        Key([mod, "shift"], str(i), lazy.window.togroup(name))
    )





layouts = [
    #layout.Tile(
    #    margin = 5,
    #    ratio = 0.5,
    #    add_after_last = True,
    #    shift_windows = False
    #),
    #layout.Stack(
    #    num_stacks= 2,
    #    margin = 5
    #    ),
    # Try more layouts by unleashing below layouts.
    layout.Bsp(
        margin = 3
    ),
    layout.Max(),
    # layout.Columns(),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(
    #    margin = 5
    #    ),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
    layout.Floating (),
]

widget_defaults = dict(
    font='Fira Code Retina',
    fontsize=10,
    padding=2,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.CurrentLayoutIcon(),
                widget.GroupBox(margin_x=0, margin_y=3, borderwidth=1, padding=3),
                widget.TextBox('┇', name="default"),
                #widget.Prompt(),
#                widget.WindowName(background=d["color2"]),
                widget.WindowName(format='{state}'),
                widget.TextBox('┇', name="default"),
                widget.Battery(format = '{char} {percent:2.0%} {hour:d}:{min:02d}', charge_char='', full_char='', discharge_char='', empty_char='', low_percentage=0.1),
#                widget.BatteryIcon(),
                widget.TextBox('┇', name="default"),
                widget.CPU(format=' {load_percent}%'),
                widget.TextBox('┇', name="default"),
                widget.TextBox('', name="default", padding = 0),
                widget.ThermalSensor(),
                widget.TextBox('┇', name="default"),
                widget.Memory(format=' {MemUsed}'),
                widget.TextBox('┇', name="default"),
                widget.Wlan(interface='wlp3s0', format=' {essid} {quality}/70', update_interval = 30),
                widget.TextBox('┇', name="default"),
                widget.TextBox('', name="default", padding = 0),
                widget.Volume(),
                widget.TextBox('┇', name="default"),
                widget.Clock(format='%a %d/%m %H:%M'),
                widget.TextBox('┇', name="default"),
                widget.Systray(icon_size=12),
              #  widget.QuickExit(),
            ],
            15,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    {'wmclass': 'confirm'},
    {'wmclass': 'dialog'},
    {'wmclass': 'download'},
    {'wmclass': 'error'},
    {'wmclass': 'file_progress'},
    {'wmclass': 'notification'},
    {'wmclass': 'splash'},
    {'wmclass': 'toolbar'},
    {'wmclass': 'confirmreset'},  # gitk
    {'wmclass': 'makebranch'},  # gitk
    {'wmclass': 'maketag'},  # gitk
    {'wname': 'branchdialog'},  # gitk
    {'wname': 'pinentry'},  # GPG key password entry
    {'wmclass': 'ssh-askpass'},  # ssh-askpass
])
auto_fullscreen = True
focus_on_window_activation = "smart"

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
