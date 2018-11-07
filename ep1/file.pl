:- module(file,
         [ read_file/2
         ]).

% Ler arquivo do caminho passado, e salvar em Board
read_file(File, Board) :-
    open(File, read, Fs),
    read(Fs, Board).
