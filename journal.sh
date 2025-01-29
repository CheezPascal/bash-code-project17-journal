#!/bin/bash

# This application is to store journals 

# Clear the screen 
clear

# Constants
LOG_FILE="journal.log.gpg"
TEMP_FILE="journal.tmp"
DATE_FORMAT="+%d/%m/%Y"

# Functions
encrypt_log() {
    gpg --batch --yes --symmetric --cipher-algo AES256 --passphrase "$PASSWORD" -o "$LOG_FILE" "$TEMP_FILE"
    rm -f "$TEMP_FILE"
}

decrypt_log() {
    gpg --batch --yes --decrypt --passphrase "$PASSWORD" -o "$TEMP_FILE" "$LOG_FILE" 2>/dev/null
}

initialize_log() {
    if [[ ! -f "$LOG_FILE" ]]; then
        touch "$TEMP_FILE"
        encrypt_log
    fi
}

view_entries() {
    decrypt_log
    echo "=== Journal Entries ==="
    cat "$TEMP_FILE"
    echo "======================="
    rm -f "$TEMP_FILE"
}

add_entry() {
    decrypt_log
    echo -n "Enter Title: "
    read -r title
    echo -n "Enter Entry: "
    read -r entry
    date=$(date "$DATE_FORMAT")
    echo "$date, $title, $entry" >>"$TEMP_FILE"
    encrypt_log
    echo "Entry added successfully."
}

delete_entry() {
    decrypt_log
    echo "=== Current Entries ==="
    nl -s ") " "$TEMP_FILE"
    echo "======================="
    echo -n "Enter the entry number to delete: "
    read -r entry_num
    if [[ "$entry_num" =~ ^[0-9]+$ ]]; then
        sed -i "${entry_num}d" "$TEMP_FILE"
        encrypt_log
        echo "Entry deleted successfully."
    else
        echo "Invalid entry number."
    fi
}

# Main Menu
main_menu() {
    echo "Welcome to the Journal"
    while true; do
        echo "1) View Entries"
        echo "2) Add New Entry"
        echo "3) Delete Entry"
        echo "4) Exit"
        echo -n "Choose an option: "
        read -r choice
        case $choice in
        1) view_entries ;;
        2) add_entry ;;
        3) delete_entry ;;
        4) exit 0 ;;
        *) echo "Invalid choice. Please try again." ;;
        esac
    done
}

# Initialize
echo -n "Enter your journal password: "
read -s PASSWORD
echo
initialize_log
main_menu
