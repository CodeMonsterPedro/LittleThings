domains
	person = symbol

predicates
	nondeterm testo(person)
	nondeterm nachinka(person)
	nondeterm duhovka(person)
	nondeterm cooking(person,person,person)

clauses
	testo(glasha):-nachinka(dasha).
	testo(dasha):-nachinka(masha).
	duhovka(masha):-testo(dasha).
	duhovka(glasha):-testo(masha).
	nachinka(glasha):-duhovka(masha).
	cooking(X,Y,Z):-testo(X),nachinka(Y),duhovka(Z).
	
goal
	cooking(X,Y,Z).