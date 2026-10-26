// ============================================================================
// range-iterate-set-handle-and-generic-reject — Checker corpus (issue #1105).
//
// PURPOSE: 2-variable iteration over `BorrowHandle` (`doc.array("users")?`),
// `OwnHandle("serde_json.value")`, non-literal / aliased `set[T]`, send-only
// channels unwrapped from `option[chan<- T]` or generic projections, and
// non-iterable generic field/call instantiations must be rejected with
// `HYB-E2009`.
//
// RULE CITATION: SPEC-LANGUAGE LX13 / T9 / O7 (GUARANTEES.md Row 5 & Row 13).
// ============================================================================

import "rust/serde_json"

fn leak(x any) {
    _ = x
}

fn main() {
    u := 0
    _ = u
    doc := serde_json.parse(`{"users":[]}`)?
    for i, u in doc.array("users")? {
        task leak(u)
        _ = i
    }
}

// EXPECTED-VERDICT: REJECT BUILDABLE
// EXPECTED-DIAGNOSTIC: HYB-E2009
