domains
	strings=string*
	
facts - graph
    	arc (string City1, string City2).

predicates
    	nondeterm depthFirst (string, string, strings, integer)
    	nondeterm path (string, string, strings, strings, integer, integer)
    	nondeterm edge (string, string)
    
clauses
	arc("Odessa", "Kiev").
	arc("Kiev", "Lvov").
	arc("Lvov", "Doneck").
	arc("Odessa", "Lvov").
	arc("Doneck", "Nikolaev").
	
	edge(X, Y):-
        	arc(X, Y).

    	depthFirst(Start, G, P, E):-
    		E1 = E-1,
        	path(Start, G, [Start], P, 0, E1).

    	path(G, G, P, P, _, _):- 
    		!.
    	path(V, G, CP, P, K, E):-
        	edge(V, NextV),
        	K1 = K+1,
        	K1 <= E,
        	path(NextV, G, [NextV | CP], P, K1, E).
   		
goal
	depthFirst("Odessa", "Doneck", Path, 10).