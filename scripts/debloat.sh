bloatware=(
    "gnome-games"
    "gnome-weather"
    "gnome-maps"
    "gnome-calculator"
    "evolution"
    "gnome-characters"
    "gnome-chess"
    "gnome-clocks"
    "gnome-contacts"
    "gnome-extensions-app"
    "gnome-mahjongg"
    "gnome-mines"
    "gnome-music"
    "gnome-sudoku"
    
)

sudo zypper rm -u "${bloatware[@]}"