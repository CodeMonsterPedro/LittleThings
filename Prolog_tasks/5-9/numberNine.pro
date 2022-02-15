domains     
    element=integer
    list=element*
predicates
    nondeterm gl( integer, list )
    is_prime(integer)
    factor(integer,integer)
clauses       
   
    is_prime(X):- 
        X>3, 
        X mod 2 = 1,
        not(factor(X,3)),
        !.
    is_prime(2). 
    is_prime(3). 
 
    factor(X,Y):- 
        X mod Y = 0,
        !.
    factor(X,Y):- 
        sqrt(X)>Y,Y1=Y+2,
        factor(X,Y1).
 
    gl( N, L ):-
        N <= 0, L = [];
        is_prime( N ),
        N - 1 = NN,
        gl( NN, LL ),
        L = [N|LL];
        NN = N - 1,
        gl( NN, L ),
        !.
goal
    gl( 50, L ).