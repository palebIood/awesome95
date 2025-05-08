# awesome95
My retro Win95 inspired theme for AwesomeWM and dotfiles for Alacritty.  
  
Im new to this whole sharing dotfiles and configs stuff so yeah, im just uploading the AwesomeWM theme here, all you gotta do is clone all files to your ~/.config/awesome directory. Have in mind this was made from scratch by me and some stuff might be broken on your setup, out of the box i think the disk tracker widget might be broken because i configured it to work with my main SSD and another partition. You can toy with the widget file at statusbar/default/lain.lua to make it work on your computer. Also, this uses lain for the widgets which has a ton of dependencies that i dont remember rn. You can do what i did which was ask chatgpt why certain widgets werent working and most of the time it was that i needed dependencies.
  
Please have in mind i made this for myself, it might not (probably wont) work out of the box for you and you might need to tweak stuff and download dependencies. I wasnt planning on sharing this, but since reddit folks asked for dotfiles, i will provide them. In any case, i cant stress this enough, CHatGPT is your friend lmao, it helped me build this from scratch and it will help you get it running on your system.  
## -- SCREENSHOTS --
  
Yeah, i dont know how to include images here, but you will find them in the main directory of the repo.  

## -- OTHER STUFF --

For the Alacritty theme (mostly color schemes from what i understand) i use chicago95 from: https://github.com/alacritty/alacritty-theme. Follow the instructions there.  
The ASCII art for neofetch is custom made, i will provide you my neofetch config file and ascii art file here.  
For the terminal font i used LessPerfectDOSVGA font from the Chicago95 theme at: https://github.com/grassmunk/Chicago95  
For the GTK theme, i also used the one provided by Chicago95.  
For Icon theme i use classic95, but the modified ones at: https://github.com/quadpixels/classic95  
For the UI font i used Inconsolata, which is part of google fonts. https://github.com/google/fonts. Ask chatGPT how to install it on your distro, at least on Arch its with AUR ttf-google-fonts-git  
  
## -- DEPENDENCIES --
A lot. Mostly for lain widgets, i dont remember almost any of them right out of the tip of my tongue but uhh you need amixer and alsamixer for the volume one, nmtui for the wifi one, playerctl for the spotify tracker one, acpi for battery and lm_sensors for temp. Im probably missing some.  
This theme uses Alacritty as default terminal, so you need that.  
This theme uses Inconsolata, from google fonts, so you need that.  
This theme uses Picom.
## -- SPECIAL THANKS -- 
To Epsi's AwesomeWM theme guide, it was thanks to that guide that i made this theme and all of its LUA files from scratch! I learned a lot. https://epsi-rns.github.io/desktop/2019/06/15/awesome-overview.html
