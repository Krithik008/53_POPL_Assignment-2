# P1 Report

## P1.b: count_solutions for clues 1 to 8

N = 3

Command used:

    swipl -q -f code/53_q1.pl -g "count_solutions([1,2,3,4,5,6,7,8],N),write(N),nl" -t halt

## What this tells us about the puzzle

Clues 1 to 8 do not determine a single answer. Three different assignments of departments, languages and projects satisfy all eight clues, so the puzzle is under-constrained and does not have a unique solution as given. Ben is the same in all three (development, javascript, web). The three solutions differ only in how the bundles for Alex, Carla and Dana are assigned.

## P1.c: the repair

Clue 9 is added so that exactly one solution remains:

    % CLUE 9: The person who writes Python works on the AI project.

With clues 1 to 9, count_solutions([1,2,3,4,5,6,7,8,9], N) gives N = 1.

The clue mentions no friend by name. It is true in exactly one of the three solutions, the one we keep:

    Alex  = [design, java, embedded]
    Ben   = [development, javascript, web]
    Carla = [testing, python, AI]
    Dana  = [research, c++, data]

It is false in the other two, where the Python person works on the embedded project.