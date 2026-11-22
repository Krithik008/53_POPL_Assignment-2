---
name: scheme-dev
description: Skill file for Racket 8.x in #lang racket/base for CS F301 Assignment 2
---

# Scheme Dev Skill

## Environment
- Racket 8.x, file must start with: #lang racket/base
- Run: racket filename.rkt
- Grader appends its own calls — NEVER call functions at top level in solution files

## Allowed Built-ins ONLY
define, lambda, let, let*, letrec, named let, if, cond (with else),
and, or, not, begin, quote ('), cons, car, cdr, list,
every car/cdr composition up to 4 levels (cadr cddr caddr cdddr cadddr cddddr etc),
null?, pair?, eq?, assq, assoc,
arithmetic: + - * < > <= >= =, max,
display, newline
S2 additionally: read

## FORBIDDEN (do NOT use)
set!, vectors, hash-tables, strings, do, for,
length, append, reverse, map, filter, member, memq, list-ref, list-tail
If you need these write your own: my-length, my-map, etc.

## Known AI Failure Modes
- Using map/filter/length instead of writing helpers
- Using set! for state
- Writing (display ...) at top level which prints on load
- Forgetting #lang racket/base header
- Non-tail-recursive functions causing stack overflow on large inputs