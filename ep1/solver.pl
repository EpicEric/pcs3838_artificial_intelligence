:- module(solver,
         [ solve_sudoku/2
         ]).

solve_sudoku(Board, Solution) :-
    Solution = Board.
