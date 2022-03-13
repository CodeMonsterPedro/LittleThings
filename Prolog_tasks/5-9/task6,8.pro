domains
	list=integer*
predicates
	nondeterm append(list,list,list)
	first_sublist(list,list,integer)
	ins_in_pos(integer,list,integer,list)
	nondeterm sublist(integer,integer,list,list)
	dl(integer,list)
	
clauses
	append([],A,A).
	append([H|Tail],A,[H|NewTail]):-append(Tail,A,NewTail).
 
	first_sublist(List,SubList,1):-append(SubList,_,List),!.
	first_sublist([_|Tail],SubList,N):-first_sublist(Tail,SubList,N1), N = N1+1.
	
	ins_in_pos(_,[],N,[]) :- N>0, write("Error!"), nl, fail.
	ins_in_pos(X,T,0,[X|T]) :- !.
	ins_in_pos(X,[H|T],N,[H|Q]) :- N1=N-1, ins_in_pos(X,T,N1,Q).
	
	dl(0,[]):-!.
	dl(N,[_|T]):-dl(N1,T),N=N1+1.
	sublist(M,N,L,Newl):-M1=M-1,N1=N-M+1,append(L1,L2,L),dl(M1,L1),append(Newl,_,L2),dl(N1,Newl).
goal
	first_sublist([10,9,8,7,6],[8,7],N)./*6*/
	/*ins_in_pos(2,[10,9,8,7,6],1,X).*/
	/*sublist(2,5,[1,-4,3,660,43,-2,19,-50,16,19,45],Newlist).*//*8*/
	
