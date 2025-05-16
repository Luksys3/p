#!/bin/bash

# Determine the package manager based on the lock file present in the current or parent directories
determine_package_manager() {
    if [[ -f "bun.lockb" || -f "../bun.lockb" || -f "../../bun.lockb" ]]; then
        echo "bun"
    elif [[ -f "package-lock.json" || -f "../package-lock.json" || -f "../../package-lock.json" ]]; then
        echo "npm"
    elif [[ -f "yarn.lock" || -f "../yarn.lock" || -f "../../yarn.lock" ]]; then
        echo "yarn"
    elif [[ -f "pnpm-lock.yaml" || -f "../pnpm-lock.yaml" || -f "../../pnpm-lock.yaml" ]]; then
        echo "pnpm"
    else
        echo "none"
    fi
}

# Check if the command is a script in package.json
is_script_in_package_json() {
    local script_name="$1"
    if [[ -f "package.json" ]]; then
        if grep -q "\"$script_name\":" "package.json"; then
            return 0
        fi
    fi
    return 1
}

# Main function to process commands
p() {
    local package_manager=$(determine_package_manager)

    if [[ $package_manager == "none" ]]; then
        echo "No recognized package manager lock file found."
        return 1
    fi

    # Handle the --dev flag and script detection
    local args=("$@")
    for i in "${!args[@]}"; do
        if [[ ${args[$i]} == "--dev" ]]; then
            if [[ $package_manager == "npm" || $package_manager == "pnpm" ]]; then
                args[$i]="--save-dev"
            fi
            # Yarn and Bun use --dev, so no change is needed for them
        elif [[ $i -eq 0 ]] && is_script_in_package_json "${args[$i]}"; then
            args=("${args[@]:0:$i}" "run" "${args[@]:$i}")
        fi
    done

    # Print the command that will be executed
    echo -e "\033[1m> $package_manager ${args[*]}\033[0m"

    # Pass the modified arguments to the determined package manager
    $package_manager "${args[@]}"
}

# Call main function with all script arguments
p "$@"
