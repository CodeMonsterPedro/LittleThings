predicates
	nondeterm work(string)
	nondeterm teoria(integer, string, string, string)
	nondeterm findout(string, string, string)
clauses       
   	work("Mesit").
   	work("Pechot").
   	work("Nachinka").
   	
   	teoria(1,D,M,G):-
   		G="Mesit", D="Nachinka", M="Pechot";
   		G="Pechot";
   		G="Nachinka".
   	teoria(2,D,M,G):-
   		M="Pechot", D="Mesit", G="Nachinka";
   		M="Mesit";
   		M="Nachinka".
   	teoria(3,D,M,G):-
   		G="Nachinka", M="Pechot", D="Mesit";
   		G="Pechot";
   		G="Pechot".
   	teoria(4,D,M,G):-
   		D="Mesit", M="Pechot", G="Nachinka";
   		D="Pechot";
   		D="Nachinka".
   	teoria(5,D,M,G):-
   		G="Pechot", M="Mesit", D="Nachinka";
   		G="Mesit";
   		G="Nachinka".
   	
   	findout(D,M,G):-
   		work(D),
   		work(M),
   		work(G),
   		teoria(1,D,M,G),
   		teoria(2,D,M,G),
   		teoria(3,D,M,G),
   		teoria(4,D,M,G),
   		teoria(5,D,M,G).
   		
goal
	findout(D,M,G).
