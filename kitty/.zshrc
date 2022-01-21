#### CUSTOM SHELL SCRIPTS ####
source ~/.vim_tips.sh  # type vimtips


#### CUSTOM TERMINAL ####

# Create name highlight 
PROMPT="%{%F{blue}%n%F{white}@%F{cyan}%m %F{white}%(5~|%-1~/.../%3~|%4~)%}
%{%F{white}► %F{reset}%} "
HOUR=$(expr $(date +%H) - "0")

# Generative ASCII Banner
apple_file=~/kitty_custom/kitty_banners/apple.txt
night_file=~/kitty_custom/kitty_banners/night.txt
morning_file=~/kitty_custom/kitty_banners/morning.txt
saturn_file=~/kitty_custom/kitty_banners/saturn.txt
cpu_file=~/kitty_custom/kitty_banners/cpu.txt
star_file=~/kitty_custom/kitty_banners/star.txt
affirmations_file=~/kitty_custom/kitty_text/affirmations.txt

# Populate affirmations array
affirmations=()
while IFS= read -r line; do
   affirmations+=("$line")
done < "$affirmations_file"

greeting() { 
   if [[ $HOUR -lt 7 && $HOUR -gt 1 ]]
   then 
      echo "Take a pause now"
   elif [[ $HOUR -lt 12 && $HOUR -gt 6 ]]
   then
      echo "Good morning"
   elif [[ $HOUR -lt 17 && $HOUR -gt 11 ]]
   then 
      echo "Good afternoon"
   elif [[ $HOUR -lt 21 && $HOUR -gt 16 ]]
   then
      echo "Good evening"
   elif [[ $HOUR -lt 23 && $HOUR -gt 20 ]]
   then
      echo "Good night"
   else
      echo "Hello"
   fi
}

key_symbol() {
   echo "\e[0;$(jot -r 1 31 34)m$1\e[0m"
}

draw_txt() {
   i=0
   len=$((10#$(wc -l < "$1")))
   mlen=$((($len + 2 - 1)/2))
   randind=$(jot -r 1 1 ${#affirmations[@]})
   while IFS= read -r line; do
      ((i++))
      if [ "$i" -eq "$(($mlen - 1))" ]  
      then
         echo "\t$line\t$(greeting), $(whoami)."
      elif [ "$i" -eq "$(($mlen + 1))" ]
      then 
         echo "\t$line\t${affirmations[$randind]} $(key_symbol "♥")"
      else
         echo "\t$line"
      fi
   done < "$1"
}

files=("$apple_file" "$saturn_file" "$cpu_file" "$star_file")
randind2=$(jot -r 1 1 ${#files[@]})

if [[ $HOUR -lt 21 && $HOUR -gt 11 ]]
then
   draw_txt "${files[$randind2]}" 
elif [[ $HOUR -lt 12 && $HOUR -gt 6 ]]
then
   draw_txt "$morning_file"
else
   draw_txt "$night_file"
fi

