domains
	treetype = tree(string, treetype, treetype); empty
	
predicates
	TREE(treetype)
	nondeterm gotree(treetype )
	nondeterm gotreeA(char,treetype)
	
clauses
	TREE(tree("Sobaka bol'shaia?", 
		tree("Sobaka s dlinoi sherst'u?", tree("Chau-Chau", empty, empty), tree( "Dog", empty, empty)),
		tree("Sobaka s dlinoi sherst'u?", tree("Shpic", empty, empty), tree( "ChiHuaHua", empty, empty))
	)).
	
	gotree( tree( X, empty, empty)):-
		write( "Tip rasteniya - ", X )
	.
	gotree( tree( X, LT, RT )):- write( X, " ?" ), nl, readchar( A ),
	
	gotreeA( A, tree( X, LT, RT )).
	gotreeA( 'y', tree( _ , LT, _ )):- gotree( LT ).
	gotreeA( 'n', tree( _ , _ , RT )):- gotree( RT ).
goal
	TREE(D),
	gotree(D).