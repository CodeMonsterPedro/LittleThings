domains
	list=integer*
predicates
	nondeterm append(list,list,list)
	first_sublist(list,list,integer)
	
clauses
	append([],A,A).
	append([H|Tail],A,[H|NewTail]):-
		append(Tail,A,NewTail).
 
	first_sublist(List,SubList,1):-
		append(SubList,_,List),
		!.
	first_sublist([_|Tail],SubList,N):-
		first_sublist(Tail,SubList,N1), 
		N = N1+1.
goal
	first_sublist([10,9,8,7,6],[8,7],N).
