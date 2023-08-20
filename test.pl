test(1) :-
Grid = [
  [_, _, _, 7, _, _, _, _, _],
  [_, 7, _, _, _, _, _, _, _],
  [1, _, _, 2, _, _, _, _, 6],
  [_, _, _, _, _, _, _, _, _],
  [_, _, _, _, _, 9, _, _, 7],
  [_, _, _, 1, _, 5, _, _, _],
  [_, _, _, _, _, _, _, _, _],
  [9, _, _, 3, _, _, _, _, _],
  [_, _, _, _, _, _, _, _, _]
],
Constraints = [
  (1,4)>(2,4)>(2,3),
  (1,9)>(2,9)>(2,8),
  (2,5)<(2,6)>(3,6)>(3,7)<(4,7),
  (3,8)>(3,9),
  (4,2)>(4,3),
  (4,5)>(4,4)<(5,4)<(5,3)>(6,3),
  (5,1)>(6,1)>(7,1),
  (6,8)<(5,8)>(5,9)>(6,9),
  (6,2)>(7,2)>(7,3), (7,2)>(8,2)>(8,3),
  (7,5)<(7,6)>(8,6)>(9,6),
  (7,7)<(7,8)<(8,8)<(8,7)<(9,7), (8,8)>(8,9),
  (9,8)<(9,9)
],
solve_futoshiki(Grid, Constraints),
write(Grid).

test(2) :-
  length(Grid, 7),
  maplist(same_length(Grid), Grid),
  nth1_matrix(3, 2, Grid, 1),
  nth1_matrix(3, 4, Grid, 3),
  nth1_matrix(3, 5, Grid, 5),
  nth1_matrix(4, 1, Grid, 5),
  nth1_matrix(7, 7, Grid, 5),
  Constraints = [
    (2,2)>(2,3),
    (2,4)>(2,5)>(2,6)>(2,7)>(3,7),
    (2,6)>(1,6),
    (2,7)>(1,7),
    (3,1)>(4,1)>(5,1)<(6,1),
    (5,1)>(5,2), (3,5)<(3,6),
    (4,4)>(4,5)>(4,6)<(4,7),
    (5,5)>(6,5), (5,7)<(6,7),
    (6,3)<(7,3)<(7,4)<(7,5)
  ],
  solve_futoshiki(Grid, Constraints),
  write(Grid).


test(3) :-
  length(Grid, 4),
  maplist(same_length(Grid), Grid),
  nth1_matrix(2, 1, Grid, 2),
  nth1_matrix(4, 4, Grid, 4),
  Constraints = [
    (2,2)>(1,2)>(1,3)<(1,4),
    (4,2)>(3,2)
  ],
  solve_futoshiki(Grid, Constraints),
  write(Grid).

test(4) :-
  length(Grid, 5),
  maplist(same_length(Grid), Grid),
  nth1_matrix(2, 1, Grid, 4),
  nth1_matrix(2, 5, Grid, 2),
  nth1_matrix(3, 3, Grid, 4),
  nth1_matrix(4, 5, Grid, 4),
  Constraints = [
    (1,1)>(1,2), (1,3)>(1,4)>(1,5),
    (4,4)<(4,5),
    (5,1)<(5,2)<(5,3)
  ],
  solve_futoshiki(Grid, Constraints),
  write(Grid).
