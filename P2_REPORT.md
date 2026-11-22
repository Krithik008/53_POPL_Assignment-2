# P2 Report: Arithmetic Equations

## Implementation

`code/53_q2.pl` builds expression trees over the input numbers without changing
their order. Division is accepted only for a nonzero divisor and an exact
integer quotient. Expressions are rendered with the assignment's precedence and
parenthesization rules. `generate_equation/2` checks every split between two
nonempty sides; `all_equations/2` collects, deduplicates, and sorts the results,
and `count_equations/2` returns their number.

## Verification

The test file is `tests/test_q2.pl`. Run it from the repository root with:

```text
swipl -q -f code/53_q2.pl -f tests/test_q2.pl -g run_tests -t halt
```

The checks cover all four `[4,2]` expression trees, the eight canonical string
examples, generation failure for inputs with no valid equation or fewer than
two numbers, and the three required `all_equations/2` examples. The expected
results include seven sorted equations for `[4,2,5,3]`, no equations for
`[2,3,4]`, and `["2*4=8"]` for `[2,4,8]`; the first input's count is 7.

Runtime verification was not completed in this environment. SWI-Prolog was not
installed; Windows Application Control blocked launching its official
installer. The command above should be run on a machine with SWI-Prolog 9.x to
confirm the tests pass.
