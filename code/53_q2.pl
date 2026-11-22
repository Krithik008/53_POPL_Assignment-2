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

% expr_to_string(Expr, String) holds when String is the canonical,
% no-space rendering of the expression tree Expr.
expr_to_string(Expr, String) :-
    expr_str(Expr, 0, root, String).

% expr_str(Expr, ParentPrec, Side, String) holds when String renders Expr
% with parentheses chosen for its position under ParentPrec.
expr_str(Number, _, _, String) :-
    integer(Number),
    with_output_to(string(String), write(Number)).
expr_str(e(Operator, Left, Right), ParentPrec, Side, String) :-
    operator_precedence(Operator, Prec),
    expr_str(Left, Prec, left, LeftString),
    expr_str(Right, Prec, right, RightString),
    with_output_to(string(OperatorString), write(Operator)),
    string_concat(LeftString, OperatorString, LeftAndOperator),
    string_concat(LeftAndOperator, RightString, Body),
    (   needs_parentheses(Prec, ParentPrec, Side)
    ->  string_concat("(", Body, OpenBody),
        string_concat(OpenBody, ")", String)
    ;   String = Body
    ).

% operator_precedence(Operator, Precedence) holds for the specified
% arithmetic precedence levels.
operator_precedence(+, 1).
operator_precedence(-, 1).
operator_precedence(*, 2).
operator_precedence(/, 2).

% needs_parentheses(ChildPrec, ParentPrec, Side) holds when the child
% expression must be parenthesized under the canonical formatting rules.
needs_parentheses(ChildPrec, ParentPrec, left) :-
    ChildPrec < ParentPrec.
needs_parentheses(ChildPrec, ParentPrec, right) :-
    ChildPrec =< ParentPrec.

% generate_equation(List, Equation) holds when Equation divides List at
% one boundary and its two ordered expressions have equal integer values.
generate_equation(List, Equation) :-
    split(List, LeftNumbers, RightNumbers),
    build_expr(LeftNumbers, LeftExpr, LeftValue),
    build_expr(RightNumbers, RightExpr, RightValue),
    LeftValue =:= RightValue,
    expr_to_string(LeftExpr, LeftString),
    expr_to_string(RightExpr, RightString),
    string_concat(LeftString, "=", LeftAndEquals),
    string_concat(LeftAndEquals, RightString, Equation).
