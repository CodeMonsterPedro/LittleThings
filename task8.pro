domains
	list=integer*
predicates
	nondeterm append(list,list,list)
	nondeterm sublist(integer,integer,list,list)
	dl(integer,list)
	
clauses
	append([],A,A).
	append([H|Tail],A,[H|NewTail]):-append(Tail,A,NewTail).
	
	dl(0,[]):-
		!.
		
	dl(N,[_|T]):-
		dl(N1,T),
		N=N1+1.
		
	sublist(M,N,L,Newl):-
		M1=M-1,
		N1=N-M+1,
		append(L1,L2,L),
		dl(M1,L1),
		append(Newl,_,L2),
		dl(N1,Newl).
goal
	sublist(2,5,[1,-4,3,660,43,-2,19,-50,16,19,45],Newlist).