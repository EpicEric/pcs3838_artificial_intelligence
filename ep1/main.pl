#!/usr/bin/env swipl

:- use_module(library(main)).
:- use_module(file).
:- use_module(solver).

:- initialization(cli, main).

cli :-
    % Tentar ler primeiro argumento da linha de comando
    current_prolog_flag(argv, Argv),
    (nth0(0, Argv, File) ->
        true;
        write("Please specify the file containing a sudoku board"), false),
    % Abrir arquivo
    read_file(File, Board),
    % Imprimir tabuleiro
    print_board(Board),
    % Resolver por satisfacao de restricoes
    solve_sudoku(Board, Solution),
    % Imprimir solucao
    print_board(Solution).

% Imprimir primeira linha do tabuleiro de Sudoku
print_board([H|T]) :-
    write("+---+---+---+"), nl, write("|"),
    print_board([H|T], 0).
print_board([H|T], Position) :-
    pretty_print(Position),
    % Nao imprimir valores zerados
    (H == 0 -> write(" "); write(H)),
    % Iterar posicao e valor
    NewPosition is Position + 1,
    print_board(T, NewPosition).
% Imprimir ultima linha do tabuleiro de Sudoku
print_board([], _) :-
    write("|"), nl, write("+---+---+---+"), nl, nl.

% Adicionar caracteres ao redor dos numeros
pretty_print(Position) :-
    % Nao adicionar antes da primeira e depois da última linhas
    (Position =:= 80 ; Position =:= 0 -> true ; 
        % Nova linha
        (Position mod 9 =:= 0 ->
            % Verificar se e' linha multipla de 3
            (Position // 9 mod 3 =:= 0 ->
                % Se for, adicionar separador
                (write("|"), nl, write("+---+---+---+"), nl, write("|")) ;
                % Senao, so' adicionar bordas laterais
                (write("|"), nl, write("|"))) ;
            % Se nao for nova linha, adicionar borda vertical interna nos multiplos de 3
            (Position mod 3 =:= 0 ->
                write("|"); true))).
