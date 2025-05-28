#!/bin/bash

# Check if foundry.toml exists
if [ ! -f "foundry.toml" ]; then
    echo "foundry.toml not found. Initializing Foundry project..."
    
    # Initialize Foundry project
    forge init --no-git --force .
    
    echo "Foundry project initialized!"
else
    echo "foundry.toml found. Skipping Foundry initialization."
fi

# Always create/overwrite foundry.toml with custom contents
echo "Setting up custom foundry.toml configuration..."

cat > foundry.toml << 'EOF'
[profile.default]
src = "src"
out = "out"
libs = ["dependencies"]
auto_detect_remappings = true
solc_version = "0.8.29"
optimizer = true
optimizer_runs = 200
bytecode_hash = "none"
cbor_metadata = false
dynamic_test_linking = true
fs_permissions = [{ access = "read-write", path = "./deployments/"}]
ffi = true  # used to log hostname when deploying

[dependencies]
forge-std = "1.9.7"

[soldeer]
remappings_version = false
recursive_deps = true

[fmt]
bracket_spacing = true
int_types = "long"
line_length = 120
multiline_func_header = "all"
number_underscore = "thousands"
quote_style = "double"
tab_width = 4
wrap_comments = true
EOF

echo "Custom foundry.toml configuration applied!"