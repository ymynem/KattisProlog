%Skyffla
skyffla([],[]). 
skyffla([Head],[Head]):- !. 
skyffla(Lista, Skyfflad):-
    varannan(Lista,Vlistan),
    [_|Tail]= Lista, 
    varannan(Tail, Rest), 
    skyffla(Rest, Hlistan), 
    append(Vlistan, Hlistan, Skyfflad).

varannan([],[]). 
varannan([H],[H]):- !. 
varannan([H,_|Lista], [H|Varannan]):- varannan(Lista, Varannan).