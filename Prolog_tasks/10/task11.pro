predicates
	nondeterm sad(string)
	nondeterm teoria(integer, string, string, string)
	nondeterm findout(string, string, string)
clauses       
   	sad("Hitrec").
   	sad("Truer").
   	sad("Lier").
   	
   	teoria(1,A,B,C):-
   		A="Hitrec", B="Truer", C="Lier";
   		A="Lier".
   	teoria(2,A,B,C):-
   		B="Truer", A="Hitrec", C="Lier";
   		B="Hitrec", A="Lier", C="Truer";
   		B="Lier", C="Hitrec", A="Truer".
   	teoria(3,A,B,C):-
   		C="Truer", A="Lier", B="Hitrec";
   		C="Truer", A="Hitrec", B="Lier";
   		C="Hitrec".
   	
   	findout(A,B,C):-
   		sad(A),
   		sad(B),
   		sad(C),
   		teoria(1,A,B,C),
   		teoria(2,A,B,C),
   		teoria(3,A,B,C).
   		
goal
	findout(A,B,C).