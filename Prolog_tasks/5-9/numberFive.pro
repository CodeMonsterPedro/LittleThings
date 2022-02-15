domains
list=integer*
pair=p(integer,integer)
plist=pair*
 
predicates
culc(list,plist)
into(integer,plist,plist)
 
clauses
culc([],[]):-
	!.
culc([X],[p(X,1)]):-
	!.
culc([H|T],L):-
	culc(T,T1),
	into(H,T1,L).
  
into(X,[],[p(X,1)]):-
	!.
into(X,[p(Y,N)|T],[p(Y,N1)|T]):-
	X=Y,
	!,
	N1=N+1.
into(X,[H|T],[H|T1]):-
	into(X,T,T1).
 
goal
	culc([1,2,3,2,3,3,3,3,3,3],L).