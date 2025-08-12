set -l commands help h issue i list ls l measure m cesu get g set s reset

complete -c 'chsrc' -f

complete -c 'chsrc' -o 'dry'             -d 'Dry Run，模拟换源过程，命令仅打印并不运行'
complete -c 'chsrc' -o 'local'           -d '仅对本项目而非全局换源 (通过ls <target>查看支持情况)'
complete -c 'chsrc' -o 'ipv6'            -d '使用IPv6测速'
complete -c 'chsrc' -o 'en' -o 'english' -d '使用英文输出'
complete -c 'chsrc' -o 'no-color'        -d '无颜色输出'

complete -c 'chsrc' -n "not __fish_seen_subcommand_from $commands" -a 'help'    -a 'h' -s 'h' -l 'help' -d '打印帮助'
complete -c 'chsrc' -n "not __fish_seen_subcommand_from $commands" -a 'issue'   -a 'i'                  -d '查看相关issue'
complete -c 'chsrc' -n "not __fish_seen_subcommand_from $commands" -a 'list'    -a 'ls' -a 'l'          -d '列出可用镜像站和可换源目标'
complete -c 'chsrc' -n "not __fish_seen_subcommand_from $commands" -a 'measure' -a 'm'  -a 'cesu'       -d '对该目标所有源测速'
complete -c 'chsrc' -n "not __fish_seen_subcommand_from $commands" -a 'get'     -a 'g'                  -d '查看该目标当前源的使用情况'
complete -c 'chsrc' -n "not __fish_seen_subcommand_from $commands" -a 'set'     -a 's'                  -d '换源，自动测速后挑选最快源'
complete -c 'chsrc' -n "not __fish_seen_subcommand_from $commands" -a 'reset'                           -d '重置，使用上游默认使用的源'
