#!/bin/bash

# Define the Nginx sites-available and sites-enabled directories
SITES_AVAILABLE="/etc/nginx/sites-available"
SITES_ENABLED="/etc/nginx/sites-enabled"

# Get the name of the script itself (for exclusion when linking all)
SCRIPT_NAME=$(basename "$0")

# Function to restart Nginx and check its status
restart_nginx() {
    echo "Testing Nginx configuration..."
    sudo nginx -t
    if [ $? -eq 0 ]; then
        echo "Nginx configuration is valid. Reload Nginx..."
        sudo systemctl reload nginx
        if [ $? -eq 0 ]; then
            echo "Nginx restarted successfully."
        else
            echo "Error: Failed to restart Nginx. Please check system logs."
            exit 1
        fi
    else
        echo "Error: Nginx configuration test failed. Not restarting Nginx."
        exit 1
    fi
}

# Check if an argument (filename) was provided
if [ -n "$1" ]; then
    # A filename was provided, create a symbolic link for that specific file
    CONFIG_FILE="$1"
    SOURCE_PATH="$SITES_AVAILABLE/$CONFIG_FILE"
    TARGET_PATH="$SITES_ENABLED/$CONFIG_FILE"

    echo "Attempting to create symbolic link for: $CONFIG_FILE"

    # Check if the source file exists
    if [ ! -f "$SOURCE_PATH" ]; then
        echo "Error: Configuration file '$CONFIG_FILE' not found in $SITES_AVAILABLE."
        exit 1
    fi

    # Check if the symbolic link already exists
    if [ -L "$TARGET_PATH" ]; then
        echo "Warning: Symbolic link for '$CONFIG_FILE' already exists. Removing existing link."
        sudo rm "$TARGET_PATH"
        if [ $? -ne 0 ]; then
            echo "Error: Failed to remove existing symbolic link for '$CONFIG_FILE'."
            exit 1
        fi
    elif [ -e "$TARGET_PATH" ]; then
        echo "Error: A file or directory already exists at $TARGET_PATH that is not a symbolic link. Please resolve manually."
        exit 1
    fi

    # Create the symbolic link
    sudo ln -s "$SOURCE_PATH" "$TARGET_PATH"
    if [ $? -eq 0 ]; then
        echo "Symbolic link created: $TARGET_PATH -> $SOURCE_PATH"
    else
        echo "Error: Failed to create symbolic link for '$CONFIG_FILE'."
        exit 1
    fi

    # Restart Nginx
    restart_nginx

else
    # No filename was specified, link everything in sites-available except the script itself
    echo "No specific filename provided. Creating symbolic links for all available Nginx configurations (excluding the script itself)."

    # Get all files in sites-available
    for config_file in "$SITES_AVAILABLE"/*; do
        # Ensure it's a file and not the script itself
        if [ -f "$config_file" ] && [ "$(basename "$config_file")" != "$SCRIPT_NAME" ]; then
            FILE_NAME=$(basename "$config_file")
            SOURCE_PATH="$config_file"
            TARGET_PATH="$SITES_ENABLED/$FILE_NAME"

            echo "Processing: $FILE_NAME"

            # Check if the symbolic link already exists
            if [ -L "$TARGET_PATH" ]; then
                echo "  Symbolic link for '$FILE_NAME' already exists."
                continue # Skip to the next file
            elif [ -e "$TARGET_PATH" ]; then
                echo "  Error: A file or directory already exists at $TARGET_PATH that is not a symbolic link. Please resolve manually. Skipping."
                continue # Skip to the next file
            fi

            # Create the symbolic link
            sudo ln -s "$SOURCE_PATH" "$TARGET_PATH"
            if [ $? -eq 0 ]; then
                echo "  Symbolic link created: $TARGET_PATH -> $SOURCE_PATH"
            else
                echo "  Error: Failed to create symbolic link for '$FILE_NAME'. Skipping."
            fi
        fi
    done

    # Restart Nginx after linking all
    restart_nginx
fi

ls -la $SITES_ENABLED   # Display the finished folder

echo "Script finished."