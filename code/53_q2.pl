% split(List, Left, Right) holds when Left is a non-empty prefix of List
% and Right is the non-empty suffix that follows it.
split([First, Second | Rest], [First], [Second | Rest]).
split([First | Rest], [First | Left], Right) :-
    split(Rest, Left, Right).

% build_expr(Numbers, Expr, Value) holds when Expr uses Numbers in order
% and evaluates to the integer Value under exact integer arithmetic.
build_expr([Number], Number, Number) :-
    integer(Number),
    Number >= 0.
build_expr(Numbers, e(Operator, LeftExpr, RightExpr), Value) :-
    split(Numbers, LeftNumbers, RightNumbers),
    build_expr(LeftNumbers, LeftExpr, LeftValue),
    build_expr(RightNumbers, RightExpr, RightValue),
    combine_expr(Operator, LeftValue, RightValue, Value).

% combine_expr(Operator, LeftValue, RightValue, Value) holds when the
% operator combines its integer operands to produce Value.
combine_expr(+, Left, Right, Value) :-
    Value is Left + Right.
combine_expr(-, Left, Right, Value) :-
    Value is Left - Right.
combine_expr(*, Left, Right, Value) :-
    Value is Left * Right.
combine_expr(/, Left, Right, Value) :-
    Right =\= 0,
    Left mod Right =:= 0,
    Value is Left // Right.
