#!/usr/bin/env swipl

:- use_module(library(main)).
:- use_module(file).
:- use_module(solver).

:- initialization(cli, main).

% Tratar entrada de nome de arquivo da linha de comando.
cli :-
    % Tentar ler argumentos da linha de comando.
    current_prolog_flag(argv, Argv),
    cli(Argv).
% Iterar arquivos
cli([File | T]) :-
    % Abrir arquivo.
    read_file(File, Board),
    % Ativar trace para debug
    (current_prolog_flag(generate_debug_info, true) ->
        write("Begin trace"), nl, trace;
        true),
    % Resolver por satisfacao de restricoes.
    solve_sudoku(Board),
    % Terminar trace,
    notrace,
    % Imprimir solucao.
    print_board(Board),
    cli(T).
cli([]).

% Imprimir primeira linha do tabuleiro de Sudoku.
print_board([H|T]) :-
    write("+---+---+---+"), nl, write("|"),
    print_board([H|T], 0).
print_board([H|T], Position) :-
    pretty_print(Position),
    % Nao imprimir valores zerados.
    (H == 0 -> write(" "); write(H)),
    % Iterar posicao e valor.
    NewPosition is Position + 1,
    print_board(T, NewPosition).
% Imprimir ultima linha do tabuleiro de Sudoku.
print_board([], _) :-
    write("|"), nl, write("+---+---+---+"), nl, nl.

% Adicionar caracteres especiais ao redor dos numeros do tabuleiro conforme posicao.
pretty_print(Position) :-
    % Nao adicionar antes da primeira e depois da última linhas.
    (Position =:= 80 ; Position =:= 0 -> true ; 
        % Verificar se e' nova linha.
        (Position mod 9 =:= 0 ->
            % Verificar se e' nova linha multipla de 3.
            (Position // 9 mod 3 =:= 0 ->
                % Se for nova linha multipla de 3, adicionar borda horizontal dos blocos.
                (write("|"), nl, write("+---+---+---+"), nl, write("|")) ;
                % Senao, so' adicionar bordas laterais.
                (write("|"), nl, write("|"))) ;
            % Se nao for nova linha, adicionar borda vertical do bloco nas colunas multiplas de 3.
            (Position mod 3 =:= 0 ->
                write("|"); true))).
