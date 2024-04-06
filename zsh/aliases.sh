alias zshconfig="nano ~/.zshrc"
alias zshconf="nano ~/.zshrc"
alias zshcfg="nano ~/.zshrc"

alias ls="ls --color=auto"
alias ll="ls -alh --color=auto"

alias clipboard="xlip -selection clipboard"

# Sys maintenance
alias reload-waybar="killall waybar 2> /dev/null; (/usr/bin/waybar &> /dev/null &) && echo '\033[0;32m [INF] Waybar reloaded \033[0m'"
alias update-initramfs="mkinitcpio -P"
alias update-grub="grub-mkconfig -o /boot/grub/grub.cfg"
