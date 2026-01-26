#!/bin/bash
REPOS_NAMES=("monitor-server" "AccessMonitor" "MyMonitor" "observatory" "admin-monitor-suite")

REPOS_URLS=(
    "https://github.com/Filipedavila/monitor-server.git"
    "https://github.com/Filipedavila/AccessMonitor.git"
    "https://github.com/Filipedavila/MyMonitor.git"
    "https://github.com/Filipedavila/observatory.git"
    "https://github.com/Filipedavila/admin-monitor-suite.git"
)



for i in "${!REPOS_NAMES[@]}"; do
    repo="${REPOS_NAMES[$i]}"
    url="${REPOS_URLS[$i]}"
    if [ ! -d "$repo" ]; then
        echo "Cloning $repo..."
        git clone "$url" "$repo"
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
