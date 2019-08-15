globalias() {
   if [[ $LBUFFER =~ ' [A-Z0-9~]+$' ]]; then
       zle _expand_alias
       zle expand-word
   else
       zle self-insert
   fi
}

zle -N globalias

bindkey " " globalias
bindkey "^ " magic-space           # control-space to bypass completion
bindkey -M isearch " " magic-space # normal space during searches
