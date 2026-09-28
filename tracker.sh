#!/data/data/com.termux/files/usr/bin/bash

# Android Location Tracker
# Coded by Cyber Security Engineer Mr Sabaz Ali Khan
# For authorized devices only.

set -u

GREEN='\033[1;32m'
CYAN='\033[1;36m'
YELLOW='\033[1;33m'
RED='\033[1;31m'
NC='\033[0m'

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_DIR="$BASE_DIR/logs"
LOG_FILE="$LOG_DIR/location_history.csv"
mkdir -p "$LOG_DIR"

banner() {
  clear
  cat <<'BANNER'
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣶⣷⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⣿⣿⣿⣿⣿⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀⢀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⠀⠀⠀⠠⣖⡥⠤⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⠻⣆⠀⢀⣾⠥⢔⣲⣦⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣴⣿⠛⣶⣶⡦⡀⢀⣿⣿⣿⣿⡷⢿⣿⠿⣻⣿⡿⠿⣿⣿⣷⣽⣆⣹⣶⠟⠛⠛⠛⣻⣿⣿⣦⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⣻⢿⣿⣷⣿⣿⣟⣦⣸⣿⣿⣿⣶⣶⣶⣿⣶⢹⣿⣶⣶⣦⣿⣿⣿⣿⣻⡿⢿⣷⣀⣸⣿⠿⣿⣿⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⣲⣉⢈⠀⠀⠀⠀⠀⣼⣿⣿⣿⣿⡇⠘⢿⠟⢻⣿⣿⣿⡟⠋⠉⠀⣻⡿⠀⢯⠉⠉⠉⣿⣿⣿⣿⣿⣿⣶⡿⡟⠻⢿⣿⣿⣿⣿⡇⠠⠴⠶⠦⣄⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⣤⣾⡏⣭⣽⣿⠒⢶⣦⣴⣿⣷⣀⣠⣔⣠⣄⣘⢶⣼⣿⣿⣿⣿⣶⣖⣛⣿⣅⣠⣤⣀⣶⣾⣿⣿⣿⣿⣿⣿⣥⢔⢃⠀⣠⣄⣸⣿⣿⣇⣤⠹⢻⣿⣶⣭⡁⠀⠀⠀⠀
⠀⠀⠀⠀⢻⣿⣧⠀⠉⣉⣀⣀⠢⡄⢿⣿⣿⣧⠬⢽⣿⣮⣵⣿⠸⣿⣿⣿⣿⣿⢯⡿⣽⣶⠶⠖⣼⣿⣿⣿⣿⣿⣿⣿⣴⣮⣿⣯⣥⣼⣿⣿⣯⠉⡉⠀⠀⠉⠛⢛⡿⣦⠀⠀⠀
⠀⠀⠀⠀⠀⠙⢿⣿⣧⠭⠽⡶⠔⠂⠈⠻⣿⣿⡇⠉⣿⠁⢀⡞⢀⣿⣿⣿⣿⣿⡧⠈⢹⡟⠀⢞⣿⣿⣿⣿⣿⣿⣿⣿⣿⠉⢹⡏⢹⣿⡿⣫⣿⠈⢐⣶⣷⡃⢩⣿⣿⣿⠀⠀⠀
⠀⠀⠀⠀⠀⠀⢦⠹⣿⣆⣸⣿⠄⠀⠀⠀⠈⢫⡻⣶⣿⣶⣯⣷⣿⣿⣿⣿⣿⣿⣿⣶⣾⣧⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣽⡷⡾⢧⣾⣟⣵⣿⡇⠓⠤⣿⣯⠁⣻⣿⣷⠃⠀⠀⠀
⠀⠀⠀⠀⠀⢀⠀⣱⡽⠋⠉⠀⠀⠀⠀⠀⠀⢀⣵⣾⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣍⡻⣿⣿⡱⠆⠀⠀⠉⠐⠿⠟⠁⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠈⣹⠋⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠉⠁⠀⠀⠀⠀⠀⢀⠀⡀⠀⠀⠀⠀
BANNER
  echo -e "${CYAN}============================================================${NC}"
  echo -e "${GREEN}        ANDROID MOBILE LOCATION TRACKER (AUTHORIZED)${NC}"
  echo -e "${YELLOW}   Coded by Cyber Security Engineer Mr Sabaz Ali Khan${NC}"
  echo -e "${CYAN}============================================================${NC}"
}

need_cmd() {
  command -v "$1" >/dev/null 2>&1 || {
    echo -e "${RED}[!] Missing command: $1${NC}"
    return 1
  }
}

check_dependencies() {
  local missing=0
  need_cmd termux-location || missing=1
  need_cmd jq || missing=1
  if [[ "$missing" -eq 1 ]]; then
    echo
    echo "Install dependencies with:"
    echo "  pkg update"
    echo "  pkg install termux-api jq"
    echo
    echo "Also install the Termux:API Android companion app and allow Location permission."
    return 1
  fi
}

get_location_json() {
  # The command itself requires Android location permission.
  termux-location -p gps -r once 2>/dev/null
}

show_location() {
  local json lat lon acc alt speed bearing provider timestamp
  json="$(get_location_json)"

  if [[ -z "$json" ]] || ! echo "$json" | jq -e . >/dev/null 2>&1; then
    echo -e "${RED}[!] Could not read location.${NC}"
    echo "Enable GPS/Location, grant Termux:API location permission, then try again."
    return 1
  fi

  lat="$(echo "$json" | jq -r '.latitude // empty')"
  lon="$(echo "$json" | jq -r '.longitude // empty')"
  acc="$(echo "$json" | jq -r '.accuracy // "N/A"')"
  alt="$(echo "$json" | jq -r '.altitude // "N/A"')"
  speed="$(echo "$json" | jq -r '.speed // "N/A"')"
  bearing="$(echo "$json" | jq -r '.bearing // "N/A"')"
  provider="$(echo "$json" | jq -r '.provider // "gps"')"
  timestamp="$(date '+%Y-%m-%d %H:%M:%S')"

  if [[ -z "$lat" || -z "$lon" ]]; then
    echo -e "${RED}[!] GPS returned no coordinates.${NC}"
    return 1
  fi

  echo
  echo -e "${GREEN}[+] Current Location${NC}"
  echo "    Time      : $timestamp"
  echo "    Latitude  : $lat"
  echo "    Longitude : $lon"
  echo "    Accuracy  : $acc m"
  echo "    Altitude  : $alt m"
  echo "    Speed     : $speed m/s"
  echo "    Bearing   : $bearing"
  echo "    Provider  : $provider"
  echo "    Maps      : https://maps.google.com/?q=$lat,$lon"

  CURRENT_LAT="$lat"
  CURRENT_LON="$lon"
  CURRENT_ACC="$acc"
  CURRENT_ALT="$alt"
  CURRENT_SPEED="$speed"
  CURRENT_PROVIDER="$provider"
  CURRENT_TIME="$timestamp"
}

save_current() {
  if [[ -z "${CURRENT_LAT:-}" ]]; then
    show_location || return 1
  fi

  if [[ ! -f "$LOG_FILE" ]]; then
    echo 'timestamp,latitude,longitude,accuracy_m,altitude_m,speed_m_s,provider' > "$LOG_FILE"
  fi

  printf '"%s",%s,%s,%s,%s,%s,"%s"\n' \
    "$CURRENT_TIME" "$CURRENT_LAT" "$CURRENT_LON" "$CURRENT_ACC" \
    "$CURRENT_ALT" "$CURRENT_SPEED" "$CURRENT_PROVIDER" >> "$LOG_FILE"

  echo -e "${GREEN}[+] Saved to: $LOG_FILE${NC}"
}

continuous_log() {
  local interval
  read -rp "Interval in seconds [default 60, minimum 10]: " interval
  interval="${interval:-60}"
  if ! [[ "$interval" =~ ^[0-9]+$ ]] || (( interval < 10 )); then
    interval=60
  fi

  echo
  echo -e "${YELLOW}Logging your authorized device location every $interval seconds.${NC}"
  echo "Press Ctrl+C to stop."
  trap 'echo; echo "Stopped continuous logging."; trap - INT; return' INT

  while true; do
    if show_location; then
      save_current
    fi
    sleep "$interval"
  done
}

view_history() {
  if [[ ! -f "$LOG_FILE" ]]; then
    echo -e "${YELLOW}[!] No history yet.${NC}"
    return
  fi
  echo
  column -s, -t "$LOG_FILE" 2>/dev/null || cat "$LOG_FILE"
}

device_info() {
  echo
  echo -e "${GREEN}[+] Device / Environment Info${NC}"
  echo "Android : $(getprop ro.build.version.release 2>/dev/null || echo N/A)"
  echo "Model   : $(getprop ro.product.model 2>/dev/null || echo N/A)"
  echo "Brand   : $(getprop ro.product.brand 2>/dev/null || echo N/A)"
  echo "Termux  : ${TERMUX_VERSION:-N/A}"
}

main_menu() {
  check_dependencies || exit 1

  while true; do
    banner
    echo "1) Show current GPS location"
    echo "2) Show current location + save to CSV"
    echo "3) Start continuous local location log"
    echo "4) View saved location history"
    echo "5) Show device information"
    echo "6) Exit"
    echo
    read -rp "Select an option: " choice

    case "$choice" in
      1) show_location; read -rp "Press Enter to continue..." _ ;;
      2) show_location && save_current; read -rp "Press Enter to continue..." _ ;;
      3) continuous_log; read -rp "Press Enter to continue..." _ ;;
      4) view_history; read -rp "Press Enter to continue..." _ ;;
      5) device_info; read -rp "Press Enter to continue..." _ ;;
      6) echo "Goodbye."; exit 0 ;;
      *) echo "Invalid option."; sleep 1 ;;
    esac
  done
}

main_menu
