// ============================================================================
// range-iterate-set-handle-and-generic-accept — Checker corpus (issue #1105).
//
// PURPOSE: 1-variable iteration over non-literal and aliased `set[T]` bindings
// and 2-variable iteration over generic struct fields / generic calls
// instantiated with slices are valid and accepted cleanly.
//
// RULE CITATION: SPEC-LANGUAGE LX13 / T9.
// ============================================================================

type int_set = set[int]

struct bag {
    seen set[int]
}

struct box[t any] {
    val t
}

fn make_seen() set[int] {
    return set[int]{}
}

fn id[t any](x t) t {
    return x
}

fn walk(s set[int], b bag) {
    for v in s { _ = v }
    for v in b.seen { _ = v }
    for v in make_seen() { _ = v }
    s2 := int_set{}
    for v in s2 { _ = v }
}

fn main() {
    walk(set[int]{}, bag{seen: set[int]{}})
    bx := box[[]int]{val: []int{1, 2, 3}}
    for i, v in bx.val {
        _ = i
        _ = v
    }
    for i, v in id([]int{4, 5}) {
        _ = i
        _ = v
    }
}

// EXPECTED-VERDICT: ACCEPT
