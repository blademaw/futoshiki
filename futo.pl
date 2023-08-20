:- use_module(library(clpfd)).
:- op(650, xfy, <).
:- op(650, xfy, >).


%% solve_futoshiki(+Grid, +Constraints)
%
% Solves a Futoshiki board where the grid is a square 2D array of arrays, and
% constraints to satisfy are supplied as an array.

solve_futoshiki(Grid, Constraints) :-
  % rows
  length(Grid, Rows),
  maplist(same_length(Grid), Grid), % square grid

  append(Grid, Values), Values ins 1..Rows, % all values between [1,n]
  maplist(all_distinct, Grid), % rows all different

  % cols
  transpose(Grid, Cols),
  maplist(all_distinct, Cols), % cols all different

  % ensure inequalities are satisfied
  maplist(decompose_ineqs, Constraints, IneqsList),
  append(IneqsList, Ineqs),
  maplist(constraint_holds(Grid), Ineqs),
  maplist(label, Grid).


%% constraint_holds(+Grid, +Constraint)
%
% Holds if Constraint, indicated by (Row1,Col1)<|>(Row2,Col2), is true
% within the Grid.

constraint_holds(Grid, (R1,C1)>(R2,C2)) :-
  nth1_matrix(R1, C1, Grid, Elem1),
  nth1_matrix(R2, C2, Grid, Elem2),
  Elem1 #> Elem2.
constraint_holds(Grid, (R1,C1)<(R2,C2)) :-
  nth1_matrix(R1, C1, Grid, Elem1),
  nth1_matrix(R2, C2, Grid, Elem2),
  Elem1 #< Elem2.


%% nth1_matrix(?Row, ?Col, +Matrix, ?Elem)
%
% Way to access Row-th row and Col-th column of Matrix. Holds if
% Matrix[Row][Col] is Elem.
nth1_matrix(Row, Col, Matrix, Elem) :-
  nth1(Row, Matrix, MatRow),
  nth1(Col, MatRow, Elem).


%% decompose_ineqs(+Expr, -Dec)
%
% Decomposes a string of inequalities (in the form (Row1,Col1)(<|>)(Row2,Col2))
% into a list of separate inequalities, e.g. A<B>C -> [A<B, B>C].
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
