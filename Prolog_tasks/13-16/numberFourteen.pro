domains
     
    str=string
    strl=str*
    int=integer
    intl=int*
     
predicates
     
    nondeterm instr(str,char,int,int)
    nondeterm headstr(str,int,str)
    nondeterm tailstr(str,int,str)
    nondeterm split(str,strl)
    nondeterm join(strl,str)
    nondeterm lens(str,int)
    nondeterm swapw(str,str)
    nondeterm swapa(strl,strl)
    nondeterm task(str,str)
     
clauses
     
    instr("",_,_,0).
    instr(S,C,N,N1) :- frontchar(S,C,_), N1=N+1, !.
    instr(S,C,N,K)  :- frontchar(S,_,RS), N1=N+1, instr(RS,C,N1,K). 
     
    headstr(_,0,"").
    headstr(S,L,R) :- frontchar(S,B,RS), L1=L-1, headstr(RS,L1,RR), frontchar(R,B,RR).
     
    tailstr(S,0,S).
    tailstr(S,N,Q) :- frontchar(S,_,RS), N1=N-1, tailstr(RS,N1,Q).
     
    split("",[]).
    split(S,[S])   :- instr(S,' ',0,K), K=0,!.
    split(S,[H|T]) :- instr(S,' ',0,K), K>1, K1=K-1, headstr(S,K1,H), tailstr(S,K,RS), split(RS,T).
    split(S,Q)     :- frontchar(S,' ',RS), split(RS,Q).
     
    join([],"").
    join([H|T],R) :- join(T,RR), concat(H," ",H1), concat(H1,RR,R).
     
    lens("",0).
    lens(S,L) :- frontchar(S,_,RS), lens(RS,L1), L=L1+1.
     
    swapw(S,W) :- lens(S,LS),LS1=LS-1,tailstr(S,LS1,LAST), headstr(S,1,FIRST), frontchar(S,_,M),
                  lens(M,L), L1=L-1,  headstr(M,L1,MID),
                  concat(LAST,MID,TMP), concat(TMP,FIRST,W).
     
    swapa([],[]).              
    swapa([H|T],[HH|TT]) :- swapw(H,HH), swapa(T,TT).              
     
    task(S,R) :- split(S,LS), swapa(LS,RS), join(RS,R).

goal
	task("test tste tas",X).