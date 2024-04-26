


#ARGOCD_SERVER="192.168.67.2:32302"
read -p "Enter ARGOCD_SERVER: " ARGOCD_SERVER
echo "$ARGOCD_SERVER"
ADMIN_USERNAME="admin"
#ADMIN_PASSWORD="***********"
read -p "Enter ADMIN_PASSWORD: " ADMIN_PASSWORD
# Login as admin
argocd login $ARGOCD_SERVER --username $ADMIN_USERNAME --password $ADMIN_PASSWORD --insecure

# Read usernames from the file
usernames_file="user-names.txt"
users=($(cat "$usernames_file"))

# Set password for users
for user in "${users[@]}"
do
    # Add a condition to skip updating users based on a certain criteria
    if [[ "$user" == "user_to_skip" ]]; then
        echo "Skipping password update for user: $user"
        continue
    fi

    # Construct the new password for each user
    NEW_PASSWORD="student@${user}"

    # Update the password for the user
    argocd account update-password \
        --account "$user" \
        --current-password "$ADMIN_PASSWORD" \
        --new-password "$NEW_PASSWORD"

    # Check the exit status of the last command
    if [ $? -eq 0 ]; then
        echo "Password updated for user: $user"
    else
        echo "Failed to update password for user: $user"
    fi
done

echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
echo "Password update for users completed.***e.g [student@name] ***"





