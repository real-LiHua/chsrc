#compdef _chsrc chsrc

_chsrc_list_target(){
    _values 'targets' ${(@f)$(chsrc list target 2>/dev/null | sed -n '/^[a-z]/p' | tr ' ' '\n' | grep -v '^$' | sort -u)}
}

_chsrc() {
    local curcontext="$curcontext" state line
    typeset -A opt_args
    local ret=1

    _arguments -C \
	'(-dry)--dry[Dry Run，模拟换源过程，命令仅打印并不运行]' \
	'(-local)--local[仅对本项目而非全局换源]' \
	'(-ipv6)--ipv6[使用IPv6测速]' \
	'(-en --english)'{-en,--english}'[使用英文输出]' \
	'(-no-color)--no-color[无颜色输出]' \
	'(-)'{-h,--help}'[打印此帮助]' \
	'1: :->command' \
	'*:: :->options' && ret=0

    case $state in
	(command)
	    local -a subcommands
	    subcommands=(
		'help:打印此帮助'
		'h:打印此帮助'
		'issue:查看相关issue'
		'i:查看相关issue'
		'list:列出可用镜像站和可换源目标'
		'ls:列出可用镜像站和可换源目标'
		'l:列出可用镜像站和可换源目标'
		'measure:对该目标所有源测速'
		'm:对该目标所有源测速'
		'cesu:对该目标所有源测速'
		'get:查看该目标当前源的使用情况'
		'g:查看该目标当前源的使用情况'
		'set:换源，自动测速后挑选最快源'
		's:换源，自动测速后挑选最快源'
		'reset:重置，使用上游默认使用的源'
	    )
	    _describe -t commands 'chsrc command' subcommands && ret=0
	    ;;

	(options)
	    case $words[1] in
		(list|ls|l)
		    local -a list_options
		    list_options=(
			'mirror:列出支持的镜像站'
			'target:列出支持的换源目标'
			'os:列出支持的操作系统'
			'lang:列出支持的编程语言'
			'ware:列出支持的软件'
			)
		    _describe -t list-options 'list options' list_options
		    _chsrc_list_target
		    ;;
		(measure|m|cesu|get|g|reset)
		    _chsrc_list_target
		    ;;
		(set|s)
		    if (( CURRENT == 2 )); then
			_chsrc_list_target
		    elif (( CURRENT == 3 )); then
		    fi
		    ;;
		esac
		;;
	esac
	return ret
    }
