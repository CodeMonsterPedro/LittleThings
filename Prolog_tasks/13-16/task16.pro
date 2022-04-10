DOMAINS
i=integer
s=string
c=char
li=i*
FACTS - knowledge
cond(i,s)
rule(s,li)
FACTS - dialog
cond_is(i,c)
PREDICATES
start
nondeterm SportExpert
nondeterm check(li)
nondeterm test_cond(i)
nondeterm update
nondeterm add_cond(li) 
nondeterm print_cond(i,li,li) 
read_cond(c,li,li)
nondeterm ex_cond(i,li,li,i) 
nondeterm wr_cond(c,i,li,li)
new_cond(i,li,li)
read_true_char(c)
test(c,c)
CLAUSES
start:-
       consult("test.dba",knowledge),
       write("Probuem poniat' "),nl,
       SportExpert,
       retractall(_,dialog),
       retractall(_,knowledge),
       nl,nl,write("Probuem snovo (1 - Da, 2 - Net)"),
       read_true_char(C),
       C='1',!,start. 
start:-
       nl,nl,write("Use"),
       readchar(_).
SportExpert:-
        rule(X,L),
        check(L),
        nl,write("Otvet ",X),
        nl,write("Verno? (1 - Da, 2 - Net)"),
        read_true_char(C),C='1',!.
SportExpert:-
        nl,write("Mimo"),nl, 
        nl,write("Nugno obnovlenie."),nl,
        update.
update:-
        nl,write("Vvedite otvet: "),
        readln(S),
        add_cond(L), 
        assert(rule(S,L),knowledge),
        save("test.dba",knowledge). 
add_cond(L):-
             cond_is(_,'1'),!, 
             nl,write("Izvestno: "),
             print_cond(1,[],L1), 
             nl,write("Izvestno bolshe? (1 - Da, 2 - Net)"),
             read_true_char(C),
             read_cond(C,L1,L).
add_cond(L):-
             read_cond('1',[],L).
print_cond(H,L,L):-
        not(cond(H,_)),!.
print_cond(H,L,L1):-
         cond_is(H,'1'),!,
         cond(H,T),
         H1=H+1,
         nl,write(T),
         print_cond(H1,[H|L],L1).
print_cond(H,L,L1):-
         H1=H+1,
         print_cond(H1,L,L1).
read_cond('1',L,L2):-
          ex_cond(1,L,L1,N),
          new_cond(N,L1,L2),!. 
read_cond(_,L,L):-!.
ex_cond(N,L,L,N):-
       not(cond(N,_)),!.
ex_cond(N,L,L1,N2):-
         cond_is(N,_),!,
         N1=N+1,
         ex_cond(N1,L,L1,N2).
ex_cond(N,L,L1,N2):-
         cond(N,S),
         nl,write("Pravilo ",S," verno? (1 - Da, 2 - Net)"),
         read_true_char(A),
         wr_cond(A,N,L,L2),
         N1=N+1,
         ex_cond(N1,L2,L1,N2).
wr_cond('1',N,L,[N|L]):-!.
wr_cond('2',_,L,L):-!.
new_cond(N,L,L1):-
       nl,write("Est eshe pravila? (1 - Da, 2- Net)"),
       read_true_char(A),
       A='1',!,
       nl,write("Vvedite novoe pravilo"),
       nl,write("V vide 'pravilo <opisanie>'"), readln(S),
       assertz(cond(N,S)), 
       N1=N+1,
       new_cond(N1,[N|L],L1).
new_cond(_,L,L).
check([H|T]):-
              test_cond(H), 
              check(T).
check([]).
test_cond(H):-
              cond_is(H,'1'),!. 

test_cond(H):-
              cond_is(H,'2'),!,
              fail. 
test_cond(H):- 
              cond(H,S),
              nl,write(" ",S,"? (1 - Da, 2 - Net)"),
              read_true_char(A),
              assert(cond_is(H,A)),
              test_cond(H).
read_true_char(C):-
        readchar(C1),
        test(C1,C).
test(C,C):-
           '1'<=C,C<='2',!.
test(_,C):-
           write("NET! 1 ili 2"),nl,
           readchar(C1),
           test(C1,C). 
GOAL
start.
