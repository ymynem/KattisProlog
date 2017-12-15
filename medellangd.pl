%Medellängd
medellangd([],0). 
medellangd(Text, AvgLen):- 
            analyse(Text, N, W), 
            AvgLen is N/W, 
            !. % don´t backtrack

analyse([], 0, 0).
analyse([H|Text], N, W) :- 
    char_type(H, alpha),
    wordLength(Text, Word),
    drop(Word, Text, Rest),
    analyse(Rest, N1, W1),
    N is N1+Word+1,
    W is W1+1.

analyse([H|Text], N, W):-
    not(char_type(H,alpha)), analyse(Text, N, W).

wordLength([],0).
wordLength([H|T], N) :-
    char_type(H, alpha),
    wordLength(T, N1),
    N is N1+1.
wordLength([H|_], 0):-
    not(char_type(H, alpha)).

drop(_, [], []).
drop(0, List, List).
drop(N, [_|List], Rest) :- N1 is N-1, drop(N1, List, Rest).