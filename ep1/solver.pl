:- module(solver,
         [ solve_sudoku/1
         ]).

:- use_module(library(clpfd)).

% Resolver um tabuleiro de sudoku por CLP.
solve_sudoku(Board) :-
    % Valores possiveis em cada celula
    Board ins 1..9,
    % Restringir linhas
    row_constraint(Board),
    % Restringir colunas
    column_constraint(Board),
    % Restringir blocos
    block_constraint(Board).

% Retirar valores da linha atual e restringir.
row_constraint([A, B, C, D, E, F, G, H, I | T]) :-
    % Cada valor em cada linha deve ser diferente.
    all_distinct([A, B, C, D, E, F, G, H, I]),
    % Iterar pelas linhas restantes
    row_constraint(T).
% Fim das iteracoes; todas as linhas foram restringidas.
row_constraint([]).

% Recebido apenas tabuleiro; comecar a criar colunas.
column_constraint(Board) :-
    column_constraint(Board, [[], [], [], [], [], [], [], [], []]).
% Retirar elementos de cada linha e adicionar 'as colunas.
column_constraint([A, B, C, D, E, F, G, H, I | T], [CA, CB, CC, CD, CE, CF, CG, CH, CI]) :-
    % Adicionar valores em cada respectiva coluna e iterar.
    column_constraint(T, [[A | CA], [B | CB], [C | CC], [D | CD], [E | CE], [F | CF], [G | CG], [H | CH], [I | CI]]).
% Fim das iteracoes; todas as colunas estao formadas mas nao restringidas.
column_constraint([], [CA, CB, CC, CD, CE, CF, CG, CH, CI]) :-
    % Cada valor em cada coluna deve ser diferente.
    all_distinct(CA),
    all_distinct(CB),
    all_distinct(CC),
    all_distinct(CD),
    all_distinct(CE),
    all_distinct(CF),
    all_distinct(CG),
    all_distinct(CH),
    all_distinct(CI).

% Recebido apenas tabuleiro; comecar a criar blocos.
block_constraint(Board) :-
    block_constraint(Board, [[], [], []]).
% Retirar elementos de cada linha e adicionar aos blocos.
block_constraint([A, B, C, D, E, F, G, H, I | T], [BA, BB, BC]) :-
    % Verificar se os blocos atuais estao completos.
    (length(BA, 9) ->
        % Blocos completos; restringir e iterar com listas reiniciadas.
        all_distinct(BA),
        all_distinct(BB),
        all_distinct(BC),
        block_constraint(T, [[A, B, C], [D, E, F], [G, H, I]]) ;
        % Blocos incompletos; adicionar aos blocos e iterar.
        block_constraint(T, [[A, B, C | BA], [D, E, F | BB], [G, H, I | BC]])).
% Fim das iteracoes; ultimos blocos estao formados mas nao restringidos.
block_constraint([], [BA, BB, BC]) :-
    all_distinct(BA),
    all_distinct(BB),
    all_distinct(BC).
