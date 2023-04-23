:- use_module(library(clpfd)).
:- op(650, xfy, <).
:- op(650, xfy, >).


% predicate to solve futoshiki puzzle
solve_futoshiki(Grid, Constraints) :-
  length(Grid, Rows),
  maplist(same_length(Grid), Grid),
  append(Grid, Values), Values ins 1..Rows,
  maplist(all_distinct, Grid),
  transpose(Grid, Cols),
  maplist(all_distinct, Cols),
  % reduce inequalities
  maplist(decompose_ineqs, Constraints, IneqsList),
  append(IneqsList, Ineqs),
  maplist(constraint_holds(Grid), Ineqs).


% predicate to ensure inequalities hold
constraint_holds(Grid, (X1,Y1)>(X2,Y2)) :-
  nth1_matrix(X1, Y1, Grid, Elem1),
  nth1_matrix(X2, Y2, Grid, Elem2),
  Elem1 #> Elem2.
constraint_holds(Grid, (X1,Y1)<(X2,Y2)) :-
  nth1_matrix(X1, Y1, Grid, Elem1),
  nth1_matrix(X2, Y2, Grid, Elem2),
  Elem1 #< Elem2.


% predicate to index matrix
nth1_matrix(Row, Col, Matrix, Elem) :-
  nth1(Row, Matrix, MatRow),
  nth1(Col, MatRow, Elem).


% predicate to enable shorthand inequalities
decompose_ineqs(Expr, Dec) :- decompose_ineqs(Expr, [], Dec).
decompose_ineqs(Expr, Acc, Dec) :-
  ( Expr = A<B<C ->
    append(Acc, [A<B], Acc1),
    decompose_ineqs(B<C, Acc1, Dec)
  ; Expr = A>B<C ->
    append(Acc, [A>B], Acc1),
    decompose_ineqs(B<C, Acc1, Dec)
  ; Expr = A<B>C ->
    append(Acc, [A<B], Acc1),
    decompose_ineqs(B>C, Acc1, Dec)
  ; Expr = A>B>C ->
    append(Acc, [A>B], Acc1),
    decompose_ineqs(B>C, Acc1, Dec)
  ; Expr = A<B ->
    append(Acc, [A<B], Dec)
  ; Expr = A>B ->
    append(Acc, [A>B], Dec)
  ).
