_prechecks:
  -cargo hack 2> /dev/null

  if [ $? -eq 101 ]; then \
    cargo install cargo-hack; \
  fi

fmt:
 cargo fmt --all

check-fmt:
 cargo fmt --all -- --check

build: _prechecks
  cargo hack --feature-powerset build

tests:
 cargo test --all-features --no-run
 cargo test --all-features

docs:
 cargo doc --no-deps --document-private-items --keep-going --all-features

examples:
 cargo clippy --example=dyn_tokio --features=dynamic_output
 cargo clippy --example=msg-tokio --features=dynamic_output
 cargo clippy --example=static --features=static_output
 cargo clippy --example=less-rs --features=dynamic_output,search

lint: _prechecks
  cargo hack --feature-powerset clippy --all-targets

verify-all: check-fmt build tests examples lint docs
 @echo "Ready to go"
