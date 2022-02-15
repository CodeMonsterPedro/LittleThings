domains
	treetype = tree(string, treetype, treetype); empty
predicates
	TREE(treetype)
	nondeterm gotree(treetype )
	nondeterm gotreeA(char,treetype)
clauses
	TREE(tree("Stebel drevesniy?", tree("Rastenie stoit pryamo?",
	tree("Rastenie imeet odin stebel?",
	tree("derevo", empty, empty ), tree( "kustarnik", empty, empty )),
	tree("lianovie", empty, empty )), tree( "travyanistie", empty, empty ))).
	gotree( tree( X, empty, empty )) :-write( "Tip rasteniya - ", X ).
	gotree( tree( X, LT, RT )):- write( X, " ?" ), nl, readchar( A ),
	gotreeA( A, tree( X, LT, RT )).
	gotreeA( 'y', tree( _ , LT, _ )) :- gotree( LT ).
	gotreeA( 'n', tree( _ , _ , RT )) :-gotree( RT ).
goal
	TREE(D),
	gotree(D).