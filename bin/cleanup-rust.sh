#!/bin/bash
# Rust build artifacts cleanup script
# Generated: 2025-11-10

echo "Rust Build Artifacts Cleanup"
echo "============================="
echo ""

# Calculate total size before cleanup
echo "Calculating current size..."
TOTAL_SIZE=$(du -sh /Users/ss/dev/Clients/Talisen/talisen-framing/node_modules/airbnb-js-shims/target /Users/ss/dev/Clients/DiscountTire/Vision/dt-cava-tools/dash/src-tauri/target /Users/ss/dev/coderats/design/products/cmdflow/target /Users/ss/dev/coderats/design/spikes/cmdflow/target /Users/ss/dev/coderats/design/spikes/tibet-ui-poc/target /Users/ss/dev/coderats/repos/coderats-sites/coderats-llc/server/target /Users/ss/dev/coderats/repos/coderats-platform/tools/linters/trlint/target /Users/ss/dev/coderats/repos/coderats-platform/tools/linters/trlint/examples/wasm-rules/no-panic/target /Users/ss/dev/coderats/repos/coderats-platform/tools/linters/trlint/examples/wasm-rules/no-todo/target /Users/ss/dev/coderats/repos/coderats-platform/tools/linters/trlint/examples/wasm-rules/no-unwrap/target /Users/ss/dev/coderats/repos/coderats-platform/target /Users/ss/dev/coderats/repos/coderats-platform/runtime/scabbard/bench/target /Users/ss/dev/coderats/repos/coderats-platform/runtime/scabbard/common/target /Users/ss/dev/coderats/repos/coderats-platform/runtime/scabbard/examples/hello-cli/target /Users/ss/dev/coderats/repos/coderats-platform/runtime/scabbard/slots/wasm/examples/hello-wasm/target /Users/ss/dev/coderats/repos/coderats-platform/runtime/scabbard/slots/gate/adapters/rats/target /Users/ss/dev/coderats/repos/coderats-platform/runtime/crux/archive/runtime-legacy/v8/target /Users/ss/dev/coderats/repos/coderats-platform/runtime/crux/archive/runtime-legacy/harness/target /Users/ss/dev/coderats/repos/coderats-platform/runtime/crux/archive/runtime-legacy/engine/target /Users/ss/dev/coderats/repos/coderats-platform/runtime/crux/archive/hosts-spike/rust/target /Users/ss/dev/coderats/repos/coderats-platform/engines/cmdflow/actors/funcs/wasmator/tests/wasm-modules/target /Users/ss/dev/coderats/repos/coderats-platform/engines/rats/rs/target /Users/ss/dev/coderats/repos/coderats-platform/engines/eventualdb/target /Users/ss/dev/coderats/repos/coderats-platform/parts/strings/opstring/rs/target /Users/ss/dev/coderats/repos/coderats-platform/parts/parsers/generic/tokenator/target /Users/ss/dev/coderats/repos/coderats-platform/parts/streams/seekerator/target /Users/ss/dev/coderats/repos/coderats-products/research/extension/workers/rust-research-worker/target /Users/ss/dev/coderats/repos/coderats-products/target /Users/ss/dev/coderats/spikes/research.wasm.oo/target /Users/ss/dev/coderats/spikes/research.wasm.oo/src/workers/wasm/rust-research-worker/target /Users/ss/dev/coderats/spikes/cmdflow.too.bundled/target /Users/ss/dev/coderats/parts/nats.rs/target /Users/ss/dev/coderats/parts/platforms/cmdflow/target /Users/ss/dev/coderats/parts/templates/cr-extension/target /Users/ss/dev/coderats/parts/templates/cr-extension/src/workers/wasm/rust-research-worker/target /Users/ss/dev/coderats/parts/apps/research/target /Users/ss/dev/coderats/parts/apps/research/src/workers/wasm/rust-research-worker/target /Users/ss/dev/Reference/nana/src-tauri/target /Users/ss/dev/Reference/rustlings/target /Users/ss/dev/Reference/axum-htmx-templates/target /Users/ss/dev/Reference/wry/target 2>/dev/null | tail -1)
echo "Total target directories: ~$TOTAL_SIZE"
echo ""

# Cargo cache size
CARGO_SIZE=$(du -sh ~/.cargo/registry ~/.cargo/git 2>/dev/null | tail -1 | awk '{print $1}')
echo "Cargo cache: ~$CARGO_SIZE"
echo ""

# Confirm before deletion
read -p "Delete all target directories? (y/n) " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Cleanup cancelled."
    exit 0
fi

echo ""
echo "Removing target directories..."

# Remove all target directories
rm -rf /Users/ss/dev/Clients/Talisen/talisen-framing/node_modules/airbnb-js-shims/target
rm -rf /Users/ss/dev/Clients/DiscountTire/Vision/dt-cava-tools/dash/src-tauri/target
rm -rf /Users/ss/dev/coderats/design/products/cmdflow/target
rm -rf /Users/ss/dev/coderats/design/spikes/cmdflow/target
rm -rf /Users/ss/dev/coderats/design/spikes/tibet-ui-poc/target
rm -rf /Users/ss/dev/coderats/repos/coderats-sites/coderats-llc/server/target
rm -rf /Users/ss/dev/coderats/repos/coderats-platform/tools/linters/trlint/target
rm -rf /Users/ss/dev/coderats/repos/coderats-platform/tools/linters/trlint/examples/wasm-rules/no-panic/target
rm -rf /Users/ss/dev/coderats/repos/coderats-platform/tools/linters/trlint/examples/wasm-rules/no-todo/target
rm -rf /Users/ss/dev/coderats/repos/coderats-platform/tools/linters/trlint/examples/wasm-rules/no-unwrap/target
rm -rf /Users/ss/dev/coderats/repos/coderats-platform/target
rm -rf /Users/ss/dev/coderats/repos/coderats-platform/runtime/scabbard/bench/target
rm -rf /Users/ss/dev/coderats/repos/coderats-platform/runtime/scabbard/common/target
rm -rf /Users/ss/dev/coderats/repos/coderats-platform/runtime/scabbard/examples/hello-cli/target
rm -rf /Users/ss/dev/coderats/repos/coderats-platform/runtime/scabbard/slots/wasm/examples/hello-wasm/target
rm -rf /Users/ss/dev/coderats/repos/coderats-platform/runtime/scabbard/slots/gate/adapters/rats/target
rm -rf /Users/ss/dev/coderats/repos/coderats-platform/runtime/crux/archive/runtime-legacy/v8/target
rm -rf /Users/ss/dev/coderats/repos/coderats-platform/runtime/crux/archive/runtime-legacy/harness/target
rm -rf /Users/ss/dev/coderats/repos/coderats-platform/runtime/crux/archive/runtime-legacy/engine/target
rm -rf /Users/ss/dev/coderats/repos/coderats-platform/runtime/crux/archive/hosts-spike/rust/target
rm -rf /Users/ss/dev/coderats/repos/coderats-platform/engines/cmdflow/actors/funcs/wasmator/tests/wasm-modules/target
rm -rf /Users/ss/dev/coderats/repos/coderats-platform/engines/rats/rs/target
rm -rf /Users/ss/dev/coderats/repos/coderats-platform/engines/eventualdb/target
rm -rf /Users/ss/dev/coderats/repos/coderats-platform/parts/strings/opstring/rs/target
rm -rf /Users/ss/dev/coderats/repos/coderats-platform/parts/parsers/generic/tokenator/target
rm -rf /Users/ss/dev/coderats/repos/coderats-platform/parts/streams/seekerator/target
rm -rf /Users/ss/dev/coderats/repos/coderats-products/research/extension/workers/rust-research-worker/target
rm -rf /Users/ss/dev/coderats/repos/coderats-products/target
rm -rf /Users/ss/dev/coderats/spikes/research.wasm.oo/target
rm -rf /Users/ss/dev/coderats/spikes/research.wasm.oo/src/workers/wasm/rust-research-worker/target
rm -rf /Users/ss/dev/coderats/spikes/cmdflow.too.bundled/target
rm -rf /Users/ss/dev/coderats/parts/nats.rs/target
rm -rf /Users/ss/dev/coderats/parts/platforms/cmdflow/target
rm -rf /Users/ss/dev/coderats/parts/templates/cr-extension/target
rm -rf /Users/ss/dev/coderats/parts/templates/cr-extension/src/workers/wasm/rust-research-worker/target
rm -rf /Users/ss/dev/coderats/parts/apps/research/target
rm -rf /Users/ss/dev/coderats/parts/apps/research/src/workers/wasm/rust-research-worker/target
rm -rf /Users/ss/dev/Reference/nana/src-tauri/target
rm -rf /Users/ss/dev/Reference/rustlings/target
rm -rf /Users/ss/dev/Reference/axum-htmx-templates/target
rm -rf /Users/ss/dev/Reference/wry/target

echo "Target directories removed!"
echo ""

# Ask about cargo cache
read -p "Clean cargo cache (~4GB)? (y/n) " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Cleaning cargo cache..."
    rm -rf ~/.cargo/registry
    rm -rf ~/.cargo/git
    echo "Cargo cache cleaned!"
fi

echo ""
echo "Cleanup complete!"
echo "Run 'cargo build' in projects to rebuild as needed."
