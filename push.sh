#!/bin/bash

# Variables
TEST_COMMAND="pytest"
TEST_DIR="./tests"
ERROR_LOG="error.log"
DEVELOP_BRANCH="develop"
STAGING_BRANCH="staging"

# Animation de chargement (spinner)
spinner() {
    local pid=$1
    local delay=0.1
    # shellcheck disable=SC1003
    local spinstr='|/-\'
    # shellcheck disable=SC2143
    while [ "$(ps a | awk '{print $1}' | grep "$pid")" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\r"
    done
    printf "    \r"
}

# Fonction pour enregistrer une erreur
log_error() {
    local error_message="$1"
    # shellcheck disable=SC2155
    local timestamp=$(date "+%Y-%m-%d %H:%M:%S")

    if [ ! -f "$ERROR_LOG" ]; then
        touch "$ERROR_LOG"
    fi

    # shellcheck disable=SC2129
    echo "[$timestamp]" >> "$ERROR_LOG"
    echo "$error_message" >> "$ERROR_LOG"
    echo "" >> "$ERROR_LOG"
}

# Fonction pour simuler une animation "chargement" texte
loading_message() {
    local message="$1"
    local duration=$2
    printf "%s" "$message"
    for i in $(seq 1 "$duration"); do
        printf "."
        sleep 0.5
    done
    printf "\n"
}

loading_message "Running tests" 3
echo "Tests in progress..."
$TEST_COMMAND "$TEST_DIR" > /dev/null 2>&1
# shellcheck disable=SC2181
if [ $? -eq 0 ]; then
    printf "✅ Tests passed successfully.\n\n"

    loading_message "Preparing to push to $DEVELOP_BRANCH" 3
    loading_message "Pushing to $DEVELOP_BRANCH branch" 3
    git push origin "$DEVELOP_BRANCH" &
    spinner $!
    if [ $? -eq 0 ]; then
        printf "✅ Push to %s completed successfully.\n\n" $DEVELOP_BRANCH
    else
        printf "❌ Push to %s failed. Please check your git configuration.\n\n" $DEVELOP_BRANCH
        exit 1
    fi
    loading_message "Preparing to push to $STAGING_BRANCH" 3
    loading_message "Pushing to $STAGING_BRANCH branch" 3
    git checkout "$STAGING_BRANCH"
    git merge "$DEVELOP_BRANCH"
    git push origin "$STAGING_BRANCH" &
    spinner $!
    git checkout "$DEVELOP_BRANCH"
    if [ $? -eq 0 ]; then
      printf "✅ Push to %s completed successfully.\n\n" $STAGING_BRANCH
    else
      printf "❌ Push to %s failed. Please check your git configuration.\n\n" $STAGING_BRANCH
      exit 1
    fi
else
    echo " ❌ Tests failed."

    last_error=$($TEST_COMMAND "$TEST_DIR" 2>&1)

    log_error "$last_error"
    echo "🚨 Error logged to $ERROR_LOG."
fi
