predicates
	nondeterm pow(integer,integer,integer)
	pow(integer,integer)
	
	nondeterm oddSumm(integer,integer, integer)
	oddSumm(integer, integer)
	
	nod(integer,integer,integer)
 
clauses
	pow(_,0,1).
	pow(P,N,R):- N1=N-1, pow(P,N1,R1), R=R1*P,!.
	pow(P,N):-pow(P,N,R),write(R),nl,!.
	
	oddSumm(I,N,0):-I>N,!.
	oddSumm(I,N,S):-I1=I+2,oddSumm(I1,N,S1),S=S1+I.
	oddSumm(N,S):-oddSumm(1,N,S),!.
	
	nod(N,M,M):-N mod M=0,!.
	nod(N,M,R):-M1=N mod M,N1=M,nod(N1,M1,R).


goal
write("Stepen chisla= "),pow(2,8),nl
write("Summa nechentih = "),oddSumm(11,S),nl.
write("Nod: "),nod(8,12,R),nl.

