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

clue(1, Solution) :-
    member(p(Name, Dept, _, 'AI'), Solution),
    Dept \= research,
    Name \= 'Dana'.

clue(2, Solution) :-
    member(p('Alex', Dept, Lang, _), Solution),
    Dept \= development,
    Lang \= 'c++'.

clue(3, Solution) :-
    member(p(_, testing, python, _), Solution).

clue(4, Solution) :-
    member(p('Ben', Dept, _, web), Solution),
    Dept \= testing.

clue(5, Solution) :-
    member(p(_, design, java, _), Solution).

clue(6, Solution) :-
    member(p('Carla', Dept, _, Project), Solution),
    Project \= embedded,
    Dept \= development.

clue(7, Solution) :-
    member(p('Dana', Dept, Lang, _), Solution),
    Lang \= java,
    (Dept = research ; Dept = testing).

clue(8, Solution) :-
    member(p(_, research, Lang, data), Solution),
    Lang \= javascript.

base_solution(Solution) :-
    permutation([research,development,design,testing], [D1,D2,D3,D4]),
    permutation([python,java,'c++',javascript],        [L1,L2,L3,L4]),
    permutation(['AI',web,embedded,data],              [P1,P2,P3,P4]),
    Solution = [
        p('Alex',  D1, L1, P1),
        p('Ben',   D2, L2, P2),
        p('Carla', D3, L3, P3),
        p('Dana',  D4, L4, P4)
    ].

satisfies_all([], _).
satisfies_all([H|T], Solution) :-
    clue(H, Solution),
    satisfies_all(T, Solution).

count_solutions([], N) :-
    findall(Solution, base_solution(Solution), Solutions),
    length(Solutions, N).
count_solutions(Active, N) :-
    Active \= [],
    findall(Solution,
            (base_solution(Solution), satisfies_all(Active, Solution)),
            Solutions),
    length(Solutions, N).

main :-
    once(solve(Solution)),
    member(p('Alex',  DA, LA, PA), Solution),
    member(p('Ben',   DB, LB, PB), Solution),
    member(p('Carla', DC, LC, PC), Solution),
    member(p('Dana',  DD, LD, PD), Solution),
    atomic_list_concat([DA, LA, PA], ', ', SA),
    atomic_list_concat([DB, LB, PB], ', ', SB),
    atomic_list_concat([DC, LC, PC], ', ', SC),
    atomic_list_concat([DD, LD, PD], ', ', SD),
    format('Alex = [~w]~n',  [SA]),
    format('Ben = [~w]~n',   [SB]),
    format('Carla = [~w]~n', [SC]),
    format('Dana = [~w]~n',  [SD]).