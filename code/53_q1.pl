solve(Solution) :-
    permutation([research,development,design,testing], [D1,D2,D3,D4]),
    permutation([python,java,'c++',javascript],        [L1,L2,L3,L4]),
    permutation(['AI',web,embedded,data],              [P1,P2,P3,P4]),
    Solution = [
        p('Alex',  D1, L1, P1),
        p('Ben',   D2, L2, P2),
        p('Carla', D3, L3, P3),
        p('Dana',  D4, L4, P4)
    ],
    clue(1, Solution),
    clue(2, Solution),
    clue(3, Solution),
    clue(4, Solution),
    clue(5, Solution),
    clue(6, Solution),
    clue(7, Solution),
    clue(8, Solution).

% Clue 1: The friend who prefers 'AI' does not work in research AND is not 'Dana'.
clue(1, Solution) :-
    member(p(Name, Dept, _, 'AI'), Solution),
    Dept \= research,
    Name \= 'Dana'.

% Clue 2: 'Alex' does not work in development AND does not prefer 'c++'.
clue(2, Solution) :-
    member(p('Alex', Dept, Lang, _), Solution),
    Dept \= development,
    Lang \= 'c++'.

% Clue 3: The friend in testing likes python.
clue(3, Solution) :-
    member(p(_, testing, python, _), Solution).

% Clue 4: 'Ben' prefers web AND does not work in testing.
clue(4, Solution) :-
    member(p('Ben', Dept, _, web), Solution),
    Dept \= testing.

% Clue 5: The friend whose language is java works in design.
clue(5, Solution) :-
    member(p(_, design, java, _), Solution).

% Clue 6: Carla's project is not embedded AND her department is not development.
clue(6, Solution) :-
    member(p('Carla', Dept, _, Project), Solution),
    Project \= embedded,
    Dept \= development.

% Clue 7: Dana's language is not java AND she works in research or testing.
clue(7, Solution) :-
    member(p('Dana', Dept, Lang, _), Solution),
    Lang \= java,
    (Dept = research ; Dept = testing).

% Clue 8: The friend who prefers data works in research AND does not use javascript.
clue(8, Solution) :-
    member(p(_, research, Lang, data), Solution),
    Lang \= javascript.