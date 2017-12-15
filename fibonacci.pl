%fibonacci
 fib(0,0). 
 fib(N,F):- N>0, fib(N,F,_). 
 fib(1,1,0). 
 fib(N,F,F1):- 
    N>1, 
    N1 is N-1, 
    fib(N1, F1, F2), 
    F is F1+F2.