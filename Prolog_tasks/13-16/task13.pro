predicates
	nondeterm par_chk(string,integer)
 
clauses
	par_chk("",0) :- !.
	par_chk(S,C)  :- C>=0,frontchar(S,'(',RS), C1=C+1, par_chk(RS,C1).
	par_chk(S,C)  :- C>=0,frontchar(S,')',RS), C1=C-1, par_chk(RS,C1).
	par_chk(S,C)  :- C>=0,frontchar(S,Q,RS), Q<>'(', Q<> ')', par_chk(RS,C).

goal
   par_chk("(()())",0).
   /*par_chk(")()(",0).*/