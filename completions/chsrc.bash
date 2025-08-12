# chsrc completion

_comp_cmd_chsrc__parse_targets()
{
    "$1" list target 2>/dev/null | \
        command sed -n '/^[a-z]/p' | \
        command tr ' ' '\n' | \
        command grep -v '^$' | \
        command sort -u
}

_comp_cmd_chsrc__get_mirrors()
{  
    local target=$2
    [[ $target ]] || return 1

    "$1" list "$target" 2>/dev/null | \
        command sed -n '/^[[:space:]]*[a-z]/p' | \
        command awk '{print $1}' | \
        command grep -v '^$'
}

_comp_cmd_chsrc()
{
    local cur prev words cword comp_args
    _comp_initialize -- "$@" || return

    if [[ $cur == -* ]]; then
        _comp_compgen -- -W '-dry -local -ipv6 -english -no-color --help'
        return
    fi

    case $prev in
        -local)
            _comp_compgen_split -- "$(_comp_cmd_chsrc__parse_targets "$1")"
            return
            ;;
    esac  

    if [[ $cword -ge 3 && (${words[1]} == "set" || ${words[1]} == "s") ]]; then
        if [[ $cword -ge 4 && ${words[2]} == "-local" ]]; then
            local target=${words[3]}
            if [[ $cword -eq 4 ]]; then
                _comp_compgen -- -W 'first'
                _comp_compgen -a split -- "$(_comp_cmd_chsrc__get_mirrors "$1" "$target")"
                if [[ $cur == http* ]]; then
                    _comp_compgen -a -- -W 'https://'
                fi
            fi
            return
        fi

        local target=${words[2]}
        if [[ $cword -eq 3 ]]; then
            _comp_compgen -- -W 'first'
            _comp_compgen -a split -- "$(_comp_cmd_chsrc__get_mirrors "$1" "$target")"
            if [[ $cur == http* ]]; then
                _comp_compgen -a -- -W 'https://'
            fi
        fi
        return
    fi

    case $prev in
        list|ls|l)
            if [[ $cword -eq 2 ]]; then
                _comp_compgen -- -W 'mirror target os lang ware'
                _comp_compgen -a split -- "$(_comp_cmd_chsrc__parse_targets "$1")"
            fi
            return
            ;;
        measure|m|cesu|get|g|reset)
            _comp_compgen_split -- "$(_comp_cmd_chsrc__parse_targets "$1")"
            return
            ;;
        set|s)
            if [[ $cword -eq 2 ]]; then
                _comp_compgen -- -W '-local'
                _comp_compgen -a split -- "$(_comp_cmd_chsrc__parse_targets "$1")"
            fi
            return
        ;;
    esac

    _comp_compgen -- -W 'help issue list measure get set reset'
} && complete -F _comp_cmd_chsrc chsrc
