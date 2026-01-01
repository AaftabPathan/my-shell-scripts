#!/bin/bash

# --- Variables ---
LOG_FILE="/var/log/user_management.log"
BACKUP_DIR="/backups"

# --- Functions ---

# Log message function
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

# --- 1. Root Check ---
if [[ $EUID -ne 0 ]]; then
   echo "Error: Yeh script root (sudo) se chalana zaroori hai."
   exit 1
fi

# Backup directory create karna agar nahi hai
mkdir -p "$BACKUP_DIR"

# --- 2. User Input ---
read -p "Naya username enter karein: " USERNAME

# Check if user already exists
if id "$USERNAME" &>/dev/null; then
    log_message "User '$USERNAME' pehle se hi exist karta hai."
else
    # User create karna
    read -sp "User ke liye password enter karein: " PASSWORD
    echo
    
    useradd -m -s /bin/bash "$USERNAME"
    echo "$USERNAME:$PASSWORD" | chpasswd
    
    if [ $? -eq 0 ]; then
        log_message "User '$USERNAME' successfully create ho gaya."
    else
        log_message "Error: User create karne mein dikkat aayi."
        exit 1
    fi
fi

# --- 3. Directory Backup ---
SOURCE_DIR="/home/$USERNAME"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="$BACKUP_DIR/${USERNAME}_backup_$TIMESTAMP.tar.gz"

log_message "Directory $SOURCE_DIR ka backup start ho raha hai..."

if [ -d "$SOURCE_DIR" ];
then
    tar -czf "$BACKUP_FILE" "$SOURCE_DIR" 2>>"$LOG_FILE"
    
    if [ $? -eq 0 ]; then
        log_message "Backup success! File yahan hai: $BACKUP_FILE"
    else
        log_message "Error: Backup fail ho gaya."
    fi
else
    log_message "Error: Source directory $SOURCE_DIR nahi mili."
fi

echo "--- Process Complete ---"

