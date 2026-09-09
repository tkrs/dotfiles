function gcd
    #set dir (ghq list -p | fzf --preview 'cd {} && eza --tree --level=2 --color=always | head -100')
    set dir (ghq list -p | fzf --preview 'cd {} && git br --remote | head -100')
    test -n "$dir"; and cd $dir; and commandline -f repaint
end
