:- ensure_loaded('code/53_q2.pl').

% run_tests/0 runs the P2 acceptance checks and reports each result.
run_tests :-
    run_case("build_expr/3 enumerates all [4,2] expressions",
             check_two_number_expressions),
    run_case("formats (4+2)*3", format_case(e(*, e(+, 4, 2), 3), "(4+2)*3")),
    run_case("formats 4+2*3", format_case(e(+, 4, e(*, 2, 3)), "4+2*3")),
    run_case("formats 8/4*2", format_case(e(*, e(/, 8, 4), 2), "8/4*2")),
    run_case("formats 8/(4*2)", format_case(e(/, 8, e(*, 4, 2)), "8/(4*2)")),
    run_case("formats 1-2-3", format_case(e(-, e(-, 1, 2), 3), "1-2-3")),
    run_case("formats 1-(2-3)", format_case(e(-, 1, e(-, 2, 3)), "1-(2-3)")),
    run_case("formats 1+(2+3)", format_case(e(+, 1, e(+, 2, 3)), "1+(2+3)")),
    run_case("formats 1+2+3", format_case(e(+, e(+, 1, 2), 3), "1+2+3")),
    run_case("generates a valid equation for [4,2,5,3]",
             (generate_equation([4,2,5,3], Equation), string(Equation))),
    run_case("generation fails for [2,3,4]",
             \+ generate_equation([2,3,4], _)),
    run_case("generation fails for an empty list",
             \+ generate_equation([], _)),
    run_case("generation fails for a one-number list",
             \+ generate_equation([9], _)),
    run_case("all_equations/2 returns the seven sorted examples",
             all_equations([4,2,5,3],
                           ["4*2-5=3", "4*2=5+3", "4-2=5-3", "4/2=5-3",
                            "4=2*(5-3)", "4=2+(5-3)", "4=2+5-3"])),
    run_case("all_equations/2 returns [] when none exist",
             all_equations([2,3,4], [])),
    run_case("all_equations/2 returns the [2,4,8] example",
             all_equations([2,4,8], ["2*4=8"])),
    run_case("count_equations/2 returns seven for [4,2,5,3]",
             count_equations([4,2,5,3], 7)).

% run_case(Description, Goal) prints PASS or FAIL according to Goal.
run_case(Description, Goal) :-
    (   call(Goal)
    ->  format("PASS: ~w~n", [Description])
    ;   format("FAIL: ~w~n", [Description])
    ).

% check_two_number_expressions holds when build_expr/3 returns the four
% specified operator trees and values, in operator enumeration order.
check_two_number_expressions :-
    findall(Expr-Value, build_expr([4,2], Expr, Value), Results),
    Results == [e(+,4,2)-6, e(-,4,2)-2, e(*,4,2)-8, e(/,4,2)-2].

% format_case(Expr, Expected) holds when Expr has its specified rendering.
format_case(Expr, Expected) :-
    expr_to_string(Expr, Actual),
    Actual == Expected.
