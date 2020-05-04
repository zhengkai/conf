键盘键位调整
============

方法
----

很长一段时间里我都用的是 `xmodmap`，但是从 Ubuntu 某个版本起，打开输入法会重置键位，相当于执行了不带参数的 `setxkbmap`

xkb 系列命令要比 xmodmap 更强大，但也更复杂，有兴趣可以看看文件 `/usr/share/X11/xkb/symbols/us` 或者执行命令 `xkbcomp $DISPLAY -`

所以我的解决思路是，用 `xmodmap` 临时达到自己的目的，通过对比 `xkbcomp` 所 dump 下来的文件，知道相应的 xkb 格式应该怎么写，最终加上去

最终效果
--------

执行 `install/install.sh`

该脚本做了三件事：

1. 将不同的改动分别起名，以便组合调用
2. 所有改动必须加到 rules 里，类似于注册
3. 设定当前用户在 GNOME 启动时调用这些改动（永久的，重启后依然生效）

调试过程
--------

见 `debug` 目录文件

先说 `xmodmap` 的使用，具体配置见 `default.xmodmap`，执行的话直接 `xmodmap default.xmodmap`

而 `*.xmodmap` 文件里 keycode，可以用单独开一个终端窗口，命令 `xev | grep keycode`，这时会启动一个小方块窗口，这时按任何键都可以捕获到 keycode

了解当前所有的键位是如何作用的，查看命令 `xmodmap -pke`，注意那些 `XF86` 开头的键名都是微软后来加的多媒体键，我的自定义键喜欢用这些键，因为几乎不会冲突。另外有一些是 GNOME 已经支持的（如静音 `XF86AudioMute`），如果不是多媒体键盘也可以改键位来一键关音箱

`setxkbmap` 不带任何参数时，会重置 `xmodmap` 设置，所以我通过

1. 执行 `./reset.sh`
2. 执行 `xmodmap default.xmodmap`
3. 执行 `./diff.sh`

来对比前后变化（第二步也可能换成别的）

以上是 `xmodmap` 介绍，下面说 xkb 系列

所有的配置在 `/usr/share/X11/xkb/` 下，例如 `symbols/ctrl` 文件就是个很好的例子，有注释

通过上面 `diff.sh` 得到的对比，可以照猫画虎写自己的配置，<br>
我自己写好的是 `install/zhengkai` 文件，里面有命名了三段内容 `base`、`esc` 和 `hhkb_esc`<br >
拷贝到 `/usr/share/X11/xkb/symbols/zhengkai`

这些配置需要注册，也就是编辑文件 `/usr/share/X11/xkb/rules/evdev`

找到 `ctrl:`

添加如下字段

    zhengkai:base     = +zhengkai(base)
    zhengkai:esc      = +zhengkai(esc)
    zhengkai:hhkb_esc = +zhengkai(hhkb_esc)

最后整个区域类似

    caps:none          = +capslock(none)
    caps:ctrl_modifier = +capslock(ctrl_modifier)
    zhengkai:base      = +zhengkai(base)
    zhengkai:esc       = +zhengkai(esc)
    zhengkai:hhkb_esc  = +zhengkai(hhkb_esc)
    ctrl:nocaps        = +ctrl(nocaps)
    ctrl:lctrl_meta    = +ctrl(lctrl_meta)
    ctrl:swapcaps      = +ctrl(swapcaps)

改完后可以先用测试是否正确生效

    setxkbmap -option ctrl:nocaps -option zhengkai:esc

确认没问题了，可以用这个命令让重启后也生效

    gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:nocaps','zhengkai:esc']"

如果希望全局生效，修改 `/etc/default/keyboard` 里的 `XKBOPTIONS=""`，例如

	XKBOPTIONS="ctrl:nocaps,zhengkai:esc"

已有个人设置的，需要 reset 才会读取全局设置

    gsettings reset org.gnome.desktop.input-sources xkb-options

取当前用户可以使用 `gsettings` 命令（或者 `dconf-editor` 也可以）查看设置，例如

    gsettings list-recursively  | grep org.gnome.desktop.input

用 `setxkbmap -print` 可以得到当前的配置，上面这个命令是看的开机启动时的配置






***

一些有用的链接
--------------

https://github.com/Chunlin-Li/Chunlin-Li.github.io/blob/master/blogs/linux/ubuntu-xkb-keyboard-remap.md

https://askubuntu.com/questions/122209/how-do-i-modify-or-disable-the-huds-use-of-the-alt-key/122232

http://blog.csdn.net/kl28978113/article/details/48809077
