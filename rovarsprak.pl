 %Rövarspråk
 rovarsprak([],[]).
 rovarsprak([H|Listan], [H|RovarText]) :- 
            not(vocal(H)), 
            [111, H |Rest] = RovarText,
            rovarsprak(Listan, Rest). 

 rovarsprak([H|Listan], [H|RovarText]) :- 
            vocal(H), 
            rovarsprak(Listan, RovarText).

 vocal(A):- memb(A, [97, 111, 117, 101, 105, 121]). 
 memb([],[]).
 memb(A,[A|_]). 
 memb(A,[_|Tail]):- memb(A, Tail). 