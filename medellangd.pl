%Medellängd
medellangd([],0). 
medellangd(Text, AvgLen):- 
            analysera(Text, N, W), 
            AvgLen is N/W, 
            !. % don´t backtrack

analysera([], 0, 0).
analysera([H|Text], N, W) :- 
    char_type(H, alpha),
    ordLangd(Text, Word),
    drop(Word, Text, Rest),
    analysera(Rest, N1, W1),
    N is N1+Word+1,
    W is W1+1.

analysera([H|Text], N, W):-
    not(char_type(H,alpha)), analysera(Text, N, W).

ordLangd([],0).
ordLangd([H|T], N) :-
    char_type(H, alpha),
    ordLangd(T, N1),
    N is N1+1.
ordLangd([H|_], 0):-
    not(char_type(H, alpha)).

drop(_, [], []).
drop(0, List, List).
drop(N, [_|List], Rest) :- N1 is N-1, drop(N1, List, Rest).
