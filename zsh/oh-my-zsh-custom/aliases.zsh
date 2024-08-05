# Replacement commands
alias cat='bat'

# Avoid accidental deletion
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

# Shortcuts
alias aria='aria2c --file-allocation=none -c -x 10 -s 10 -d "$HOME/Downloads" '      # aria2c
alias yt-audio='yt-dlp --config-location ~/.config/yt-dlp/yt-dlp-audio.conf'            # yt-dlp audio

# Streamrip
alias srip='~/.pyenv/versions/3.12.2/bin/rip'