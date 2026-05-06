set -euo pipefail

info()    { echo -e "\e[38;2;180;200;255m[INFO]\e[0m    $*"; }
success() { echo -e "\e[38;2;150;255;150m[OK]\e[0m      $*"; }
warn()    { echo -e "\e[38;2;255;200;100m[WARN]\e[0m    $*"; }
error()   { echo -e "\e[38;2;255;100;100m[ERROR]\e[0m   $*" >&2; }
step()    { echo -e "\n\e[38;2;255;171;185m━━━ $* ━━━\e[0m\n"; }


ZAPRET_VERSION="v72.12"

get()
{
    info "get the zapret  $ZAPRET_VERSION"
    wget https://github.com/bol-van/zapret/releases/download/$ZAPRET_VERSION/zapret-$ZAPRET_VERSION.tar.gz -O zapret.tar.gz
    success "get"
}
extract()
{
    info "extract the zapret.tar.gz"
    tar -xvf zapret.tar.gz
    success "tar"
}
config()
{
    cp ./system/zapret_config.conf ./zapret-$ZAPRET_VERSION/config.default
}
manuel_setup()
{
    ./zapret-$ZAPRET_VERSION/install_easy.sh
}

get
extract
config
manuel_setup