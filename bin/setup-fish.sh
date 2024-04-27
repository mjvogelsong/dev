#!/usr/bin/env fish

echo "Installing fisher ..."
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
fisher install jorgebucaran/fisher

echo "Installing tide ..."
fisher install IlanCosman/tide@v6
tide configure \
    --auto \
    --style='Rainbow' \
    --prompt_colors='True color' \
    --show_time='12-hour format' \
    --rainbow_prompt_separators='Angled' \
    --powerline_prompt_heads='Sharp' \
    --powerline_prompt_tails='Flat' \
    --powerline_prompt_style='Two lines, character' \
    --prompt_connection='Dotted' \
    --powerline_right_prompt_frame='No' \
    --prompt_connection_andor_frame_color='Dark' \
    --prompt_spacing='Compact' \
    --icons='Many icons' \
    --transient='No'

echo "Adding custom aliases to fish config ..."
set fish_config_path ~/.config/fish/config.fish

# Check if the fish config file exists, if not create it
if not test -f $fish_config_path
    touch $fish_config_path
end

# Alias for 'l'
if not grep -q "alias l='ls -lhtra'" $fish_config_path
    echo "alias l='ls -lhtra'" >> $fish_config_path
    echo "Added alias 'l' to fish config."
end

# Alias for 'hgrep'
if not grep -q "alias hgrep='history | grep'" $fish_config_path
    echo "alias hgrep='history | grep'" >> $fish_config_path
    echo "Added alias 'hgrep' to fish config."
end

echo "Setting fish as default shell ..."
sudo chsh ubuntu -s /usr/bin/fish

echo "🐟 Fish success!"
