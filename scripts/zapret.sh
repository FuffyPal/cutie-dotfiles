set -euo pipefail

log()  { echo -e "\e[38;2;255;200;100m[nvidia]\e[0m $*"; }
warn() { echo -e "\e[38;2;255;100;100m[nvidia]\e[0m $*"; }

ZAPRET_VERSION="v72.12"
