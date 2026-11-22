% test_q1.pl
% Run with: swipl -q -f code/53_q1.pl -g "consult('tests/test_q1.pl'),run_tests" -t halt

% ---------- helpers ----------

check(Description, Goal) :-
    (   catch(Goal, _, fail)
    ->  write('PASS: '), write(Description), nl
    ;   write('FAIL: '), write(Description), nl
    ).

% ---------- fully filled-in solutions ----------
% sol(Id, [p(Name, Dept, Lang, Project) x4])

sol(pass1, [p('Alex',design,java,'AI'),
            p('Ben',research,python,web),
            p('Carla',testing,'c++',data),
            p('Dana',development,javascript,embedded)]).
sol(fail1, [p('Alex',design,java,web),
            p('Ben',research,python,data),
            p('Carla',testing,'c++',embedded),
            p('Dana',development,javascript,'AI')]).

sol(pass2, [p('Alex',design,java,'AI'),
            p('Ben',research,python,web),
            p('Carla',testing,'c++',data),
            p('Dana',development,javascript,embedded)]).
sol(fail2, [p('Alex',development,'c++','AI'),
            p('Ben',research,python,web),
            p('Carla',testing,java,data),
            p('Dana',design,javascript,embedded)]).

sol(pass3, [p('Alex',testing,python,'AI'),
            p('Ben',research,java,web),
            p('Carla',design,'c++',data),
            p('Dana',development,javascript,embedded)]).
sol(fail3, [p('Alex',design,java,'AI'),
            p('Ben',research,python,web),
            p('Carla',testing,'c++',data),
            p('Dana',development,javascript,embedded)]).

sol(pass4, [p('Alex',design,java,'AI'),
            p('Ben',research,python,web),
            p('Carla',testing,'c++',data),
            p('Dana',development,javascript,embedded)]).
sol(fail4, [p('Alex',design,java,'AI'),
            p('Ben',testing,python,web),
            p('Carla',research,'c++',data),
            p('Dana',development,javascript,embedded)]).

sol(pass5, [p('Alex',design,java,'AI'),
            p('Ben',research,python,web),
            p('Carla',testing,'c++',data),
            p('Dana',development,javascript,embedded)]).
sol(fail5, [p('Alex',design,python,'AI'),
            p('Ben',research,java,web),
            p('Carla',testing,'c++',data),
            p('Dana',development,javascript,embedded)]).

sol(pass6, [p('Alex',design,java,'AI'),
            p('Ben',research,python,web),
            p('Carla',testing,'c++',data),
            p('Dana',development,javascript,embedded)]).
sol(fail6, [p('Alex',design,java,'AI'),
            p('Ben',research,python,web),
            p('Carla',testing,'c++',embedded),
            p('Dana',development,javascript,data)]).

sol(pass7, [p('Alex',design,java,'AI'),
            p('Ben',development,python,web),
            p('Carla',research,'c++',data),
            p('Dana',testing,javascript,embedded)]).
sol(fail7, [p('Alex',design,java,'AI'),
            p('Ben',research,python,web),
            p('Carla',testing,'c++',data),
            p('Dana',development,javascript,embedded)]).

sol(pass8, [p('Alex',design,java,'AI'),
            p('Ben',development,python,web),
            p('Carla',research,'c++',data),
            p('Dana',testing,javascript,embedded)]).
sol(fail8, [p('Alex',design,java,'AI'),
            p('Ben',development,python,web),
            p('Carla',research,javascript,data),
            p('Dana',testing,'c++',embedded)]).

sol(pass9, [p('Alex',design,python,'AI'),
            p('Ben',research,java,web),
            p('Carla',testing,'c++',data),
            p('Dana',development,javascript,embedded)]).
sol(fail9, [p('Alex',design,java,'AI'),
            p('Ben',research,python,web),
            p('Carla',testing,'c++',data),
            p('Dana',development,javascript,embedded)]).

% ---------- clue tests ----------

clue_range(1).
clue_range(2).
clue_range(3).
clue_range(4).
clue_range(5).
clue_range(6).
clue_range(7).
clue_range(8).
clue_range(9).

test_clue_pass(N) :-
    atomic_list_concat([pass, N], PassId),
    sol(PassId, S),
    atomic_list_concat(['clue ', N, ' accepts a valid solution'], Desc),
    check(Desc, clue(N, S)).

test_clue_fail(N) :-
    atomic_list_concat([fail, N], FailId),
    sol(FailId, S),
    atomic_list_concat(['clue ', N, ' rejects a violating solution'], Desc),
    check(Desc, \+ clue(N, S)).

% ---------- count tests ----------

test_count_8 :-
    check('count_solutions with clues 1-8 gives 3',
          ( count_solutions([1,2,3,4,5,6,7,8], N), N =:= 3 )).

test_count_9 :-
    check('count_solutions with clues 1-9 gives 1',
          ( count_solutions([1,2,3,4,5,6,7,8,9], N), N =:= 1 )).

% ---------- runner ----------

run_tests :-
    test_count_8,
    test_count_9,
    forall(clue_range(N), test_clue_pass(N)),
    forall(clue_range(N), test_clue_fail(N)).