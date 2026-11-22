---
name: prolog-dev
description: Skill file for SWI-Prolog 9.x development in CS F301 Assignment 2
---

# Prolog Dev Skill

## Environment
- SWI-Prolog 9.x
- Run main:  swipl -q -f file.pl -g main -t halt
- Run goal:  swipl -q -f file.pl -g "<goal>" -t halt

## Conventions
- snake_case for predicate names, CamelCase for variables
- Write a declarative reading as a comment above each predicate
- No assert/retract/global variables (b_setval, nb_setval)
- Allowed libraries: lists, apply, yall, aggregate ONLY

## Self-Review Checklist
- Compiles with zero warnings
- No top-level calls in the file
- No initialization directive
- No halt/0 called inside the file
- Edge cases handled

## Known AI Failure Modes
- Confusing unification (=) with arithmetic (is)
- Forgetting that member/2 backtracks
- Wrong operator precedence in arithmetic
- Using assert/retract when forbidden
- Writing initialization directives that are forbidden