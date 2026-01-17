#!/bin/bash
declare -A REPOS=(
    ["monitor-server"]="https://github.com/Filipedavila/monitor-server.git"
    ["AccessMonitor"]="https://github.com/Filipedavila/AccessMonitor.git"
    ["MyMonitor"]="https://github.com/Filipedavila/MyMonitor.git"
    ["observatory"]="https://github.com/Filipedavila/observatory.git"
    ["admin-monitor-suite"]="https://github.com/Filipedavila/admin-monitor-suite.git"
)
## check if exists folders, if not clone the git repos
for repo in "${!REPOS[@]}"; do
    if [ ! -d "$repo" ]; then
        echo "Cloning $repo..."
        git clone "${REPOS[$repo]}" "$repo"
        cd "$repo"
        git checkout develop
        cd ..
        if [ $? -ne 0 ]; then
            cd ..
            echo "Failed to clone $repo repository."
            exit 1
        fi
    fi
done
