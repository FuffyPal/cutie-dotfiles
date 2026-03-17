# Örnek Debloat listesi
bloatware=(
    "gnome-games"
    "gnome-weather"
    "gnome-maps"
    "evolution"
)

sudo zypper rm -u "${bloatware[@]}"