DOMAINS 
  simptom_t = simptom(string, real); t(real, real, real)
  simptoms_t = simptom_t*
  
  yes_no = yes;no
  fact_t = simptom(string, yes_no); t(real)
  
predicates
	check_simptom(simptom_t,real)
	calc_chance(simptoms_t,real)
	is_not_used(simptom_t)
	proper_sickness(string, real)
	unused_simptom(simptom_t)
	name(simptom_t, string)
	read_yes_no(yes_no)
	make_question(string)
	member(simptom_t, simptoms_t)
	clear
	consultation
	
DATABASE d1
  fact(fact_t)
  sickness(string, simptoms_t)
  
CLAUSES

  sickness("kor", [t(38, 40, 1), simptom("suhoi_kashel", 1),  
        simptom("nasmork", 1),  
        simptom("chihanie", 1), 
        simptom("golovnaya_bol", 1),
        simptom("otek_vek", 1),
        simptom("sip", 1),
        simptom("lihoradka", 0.1),
        simptom("mokrii_kashel", 0)
  ]).
  
  sickness("prostuda", [t(37, 42, 1), simptom("nasmork", 1),  
        simptom("zalozhennost_nosa", 1),  
        simptom("chihanie", 1), 
        simptom("bol_mishc", 0.1),
        simptom("snizhenie_obonyaniya", 0.1),
        simptom("mokrii_kashel", 0.3),
        simptom("hripota", 0.2),
        simptom("lihoradka", 0.05)
  ]).
  
  sickness("koronavirus", [t(37, 42, 1), simptom("suhoi_kashel", 1),  
        simptom("snizhenie_obonyaniya", 1),  
        simptom("bol_mishc", 0.5), 
        simptom("zalozhennost_nosa", 0.5),
        simptom("sip", 0.2),
        simptom("lihoradka", 0.1),
        simptom("bol_gorla", 0),
        simptom("uvelichenie_limfouzlov", 0)
  ]).
  
  sickness("vetryanka", [t(37, 42, 1), 
        simptom("rvota", 1),
        simptom("sip", 1),
        simptom("lihoradka", 1)
  ]).
  
  sickness("sifilis", [t(36.5, 36.7, 1), simptom("shakr", 1),  
        simptom("uvelichenie_limfouzlov", 0.5),  
        simptom("lihoradka", 0.5), 
        simptom("bol_gorla", 0.25)
  ]).
  
check_simptom(simptom(Name, Chance), SimChance):-
  Chance > 0, fact(simptom(Name, yes)), !, SimChance = Chance;
  Chance = 0, fact(simptom(Name, no)), !, SimChance = 1;
  NOT(fact(simptom(Name, _))), SimChance = 1, !.
  
check_simptom(t(Min, Max, Chance), SimChance):-
  Chance > 0, fact(t(Value)), Value >= Min, Value <= Max, !, SimChance = Chance;
  Chance = 0, fact(t(Value)), Value < Min, !, SimChance = 1;
  Chance = 0, fact(t(Value)), Value > Max, !, SimChance = 1;
  NOT(fact(t(_))), !, SimChance = 1.

calc_chance([], 1.0):-!.
calc_chance([Simptom|Tail], Chance):-
  check_simptom(Simptom, SimChance), !,
  calc_chance(Tail, TailChance),
  Chance = SimChance*TailChance.
calc_chance([Simptom|Tail], Chance):-
  check_simptom(Simptom, SimChance), !,
  calc_chance(Tail, TailChance), 
  Chance = SimChance*TailChance.
calc_chance(_, 0.0).

proper_sickness(Name, Chance):-
  sickness(Name, Simptoms),
  calc_chance(Simptoms, Chance),
  Chance > 0.
  
unused_simptom(SimptomName):-
  proper_sickness(Sikness, _), 
  sickness(Sikness, Simptoms),
  member(Simptom, Simptoms),
  is_not_used(Simptom),
  name(Simptom, SimptomName), !.
  
is_not_used(t(_, _, _)):-
  NOT(fact(t(_))).
is_not_used(simptom(Name, _)):-
  NOT(fact(simptom(Name, _))).
    
name(t(_, _, _), "temperatura"):-!.
  name(simptom(Name, _), Name):-!.
  
read_yes_no(Answer):-
    write("yes or no? : "),
    readln(String),
    /*string_to_yes_no(String, Answer),*/ !.
read_yes_no(Answer):-
    write("wrong answer"), nl,
    read_yes_no(Answer).
    
make_question("temperatura"):-
  write("vasha temperatura: "),
  readreal(T),
  assert(fact(t(T))), !.
make_question(Name):-
  write("u vas est "), write(Name), 
  read_yes_no(Answer),
  assert(fact(simptom(Name, Answer))).
  
clear:-
     retract(fact(_)), !,
     clear; !.
     
member(Elem, [Elem|_Tail]).
member(Elem, [_Head|Tail]):-
   member(Elem, Tail).

consultation:-
  NOT(proper_sickness(_, _)),
  write("i cant help you... "), nl, !.
consultation:-
  findall(Name, proper_sickness(Name, _), Names), Names = [_],
  proper_sickness(Name, Chance), Percent = Chance*100,
  write("your sikness is "), write(Name), write(" with "), write(Percent), write("%"), nl, !.
consultation:-
  proper_sickness(Name, Chance), Percent = Chance*100,
  write(Name), write(" with "), write(Percent), write("%"), nl, fail.
consultation:-
  unused_simptom(Name),
  make_question(Name),
  consultation.