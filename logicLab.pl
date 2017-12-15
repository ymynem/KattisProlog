:- use_module(library(lists)).
% Load model, initial state and formula from file.
verify(Input) :-
	see(Input), read(T), read(L), read(S), read(F), seen,
	check(T, L, S, [], F).
% check(T, L, S, U, F)
% T - The transitions in form of adjacency lists
% L - The labeling
% S - Current state
% U - Currently recorded states
% F - CTL Formula to check.
%
% Should evaluate to true iff the sequent below is valid.
% (T,L), S |-F
% U

% To execute: consult('your_file.pl'). verify('input.txt').

% Literals
check(_, L, S, [], X) :-
	member([S, Y], L),
	member(X, Y).

% Neg
check(_, L, S, [], neg(X)) :-
	member([S, Y], L),
	\+ member(X, Y).

% And
check(T, L, S, [], and(F,G)) :-
	check(T, L, S, [], F),
	check(T, L, S, [], G).

% Or
check(T, L, S, [], or(F,_)) :-
	check(T, L, S, [], F).
check(T, L, S, [], or(_,G)) :-
	check(T, L, S, [], G).

% AX
check(T, L, S, [], ax(F)) :-
	member([S, List], T),
	forall(member(X, List), check(T, L, X, [], F)).

% EX
check(T, L, S, [], ex(F)) :-
	member([S, List], T),
	member(X, List),
	check(T, L, X, [], F).

% AG1
check(_, _, S, U, ag(_)) :-
	member(S, U).
% AG2
check(T, L, S, U, ag(F)) :-
	\+ member(S, U),
	check(T, L, S, [], F),
	member([S, List], T),
	forall(member(X, List), check(T, L , X, [S|U], ag(F))).

% EG1
check(_, _, S, U, eg(_)) :-
	member(S, U).
% EG2
check(T, L, S, U, eg(F)) :-
	\+ member(S, U),
	check(T, L, S, [], F),
	member([S, List], T),
	member(X, List),
	check(T, L, X, [S|U], eg(F)).

% EF1
check(T, L, S, U, ef(F)) :-
	\+ member(S, U),
	check(T, L, S, [], F).
% EF2
check(T, L, S, U, ef(F)) :-
	\+ member(S, U),
	member([S, List], T),
	member(X, List),
	check(T, L , X, [S|U], ef(F)).

% AF1
check(T, L, S, U, af(F)) :-
	\+ member(S, U),
	check(T, L, S, [], F).
% AF2
check(T, L ,S, U, af(F)) :-
	\+ member(S, U),
	member([S, List], T),
	forall(member(X, List), check(T, L , X, [S|U], af(F))).
