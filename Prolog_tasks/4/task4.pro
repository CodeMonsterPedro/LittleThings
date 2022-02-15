domains
	year_t, month_t, day_t, back, idBook = integer
	name, author, genre, familia = symbol 
	price = real
	
predicates
	nondeterm book(idBook, name,author,genre,price)
 	nondeterm reader(familia,idBook,year_t,month_t,day_t,back)
 	nondeterm readersWithBook(familia, name)
 	nondeterm fantasyOrDetectivePriceMore100(familia)
 	nondeterm readersDidntReadDetectives(familia)
 	nondeterm writerMoreOneBook(author)

clauses 
	book(1, "The Lord of the Rings", "J.R.R. Tolkien","Fantasy",50.0).
	book(2, "The Hobbit", "J.R.R. Tolkien","Fantasy",122.30).
	book(3, "Harry Potter and the Sorcerer's Stone", ". K. Rowling","Fantasy",35.0).
	book(4, "Romeo and Juliet", "W. Shakespeare","Shakespearean tragedy",75.0).
	book(5, "Fahrenheit 451", "R.Bradbury","Dystopian novel",118.0).
	book(6, "1984", "G. Orwell","Dystopian novel", 25.75).
	book(7, "Programming C", "V. Maers","Programming",10.0).
	book(8, "A Study in Scarlet", "A.C. Doyle","Detective",400.0).
	reader("Nosov",7,2021,1,15,0).
	reader("Savin",1,2018,5,27,1).
	reader("Nokiorov",4,2020,8,5,1).
	reader("Bezuglov",7,2021,2,3,1).
	reader("Kostusev",2,2021,4,25,0).
	reader("Olesheva",1,2021,4,7,0).
	reader("Tolkachov",7,2013,12,1,1).
	reader("Kozlov",5,2019,8,15,1).
	reader("Ivanchenko",6,2021,2,19,0).
	reader("Bush",2,2021,4,13,0).
	reader("Grigirivich",8,2021,4,17,0).
	
	readersWithBook(FAMILIA, BOOKNAME):-reader(FAMILIA,BOOKID,_,_,_,0),book(BOOKID,BOOKNAME,_,_,_).
	fantasyOrDetectivePriceMore100(FAMILIA):-reader(FAMILIA,BOOKID,_,_,_,_),book(BOOKID,_,_,GENRE,PRICE),PRICE>100,GENRE="Detective".
	fantasyOrDetectivePriceMore100(FAMILIA):-reader(FAMILIA,BOOKID,_,_,_,_),book(BOOKID,_,_,GENRE,PRICE),PRICE>100,GENRE="Fantasy".
	readersDidntReadDetectives(FAMILIA):-reader(FAMILIA,BOOKID,_,_,_,_),book(BOOKID,_,_,GENRE,_),GENRE<>"Detective".
	writerMoreOneBook(AUTHOR):-findall(book(_,_,AUTHOR1,_,_), AUTHOR1=AUTHOR, L),length(L, N), N>1.

goal
	/*readersWithBook(FAMILIA, BOOKNAME).
	fantasyOrDetectivePriceMore100(FAMILIA).
	readersDidntReadDetectives(FAMILIA).*/
	writerMoreOneBook(AUTHOR).