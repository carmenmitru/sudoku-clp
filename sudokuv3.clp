(deffacts Sudoku
	(row A   1 3 *   * 7 *   * 8 *)
	(row B   2 7 4   9 * 8   * * 5)
	(row C   8 * 5   * 1 *   2 7 *)

	(row D   * 5 *   4 * *   * 6 7)
	(row E   * 1 2   * 8 *   * 5 4)
	(row F   7 4 *   5 * 3   9 * *)

	(row G   5 * 9   1 4 *   7 3 8)
	(row H   3 * 1   8 9 *   5 4 2)
	(row I   * 8 *   3 5 2   1 9 6)
	
	(column 1  1 2 8  * * 7  5 3 *)
	(column 2  3 7 *  5 1 4  * * 8)
	(column 3  * 4 5  * 2 *  9 1 *) 
 
	(column 4  * 9 *  4 * 5  1 8 3)
	(column 5  7 * 1  * 8 *  4 9 5)
	(column 6  * 8 *  * * 3  * * 2)   
 
	(column 7  * * 2  * * 9  7 5 1)  
	(column 8  8 * 7  6 5 *  3 4 9) 
	(column 9  * 5 *  7 4 *  8 2 6)
	
	(group A : 1  1 3 *  2 7 4  8 * 5 )
	(group A : 2  * 7 *  9 * 8  * 1 * )
	(group A : 3  * 8 *  * * 5  2 7 * )
 
	(group B : 1  * 5 *  * 1 2  7 4 * )
	(group B : 2  4 * *  * 8 *  5 * 3 )
	(group B : 3  * 6 7  * 5 4  9 * * )
 
	(group C : 1  5 * 9  3 * 1  * 8 * )
	(group C : 2  1 4 *  8 9 *  3 5 2 )
	(group C : 3  7 3 8  5 4 2  1 9 6 ) )

;Regulile C1, C2...C9 cauta celulele in care se alfa simbolul *
;astfel se creeaza in baza de fapte o lista cu celulele ce vor fi prelucrate
;regulile C1, C2,... C9 se vor executa la inceputul programului

(defrule C1 
(declare (salience 20))
	(column ?nume1 ?a&:(symbolp ?a) ? ? ? ? ? ? ? ?)
	;(not (cell A - ?nume1 A ?q&:(symbolp ?q) ))
	=>
	(assert (cell A - ?nume1 A :)))
(defrule C2 
(declare (salience 20))
	(column ?nume2 ? ?b&:(symbolp ?b) ? ? ? ? ? ? ?)
	;(not (cell B - ?nume2 A ?q&:(symbolp ?q))) 
	=>
	(assert (cell B - ?nume2 A :))) 
(defrule C3
(declare (salience 20))
	(column ?nume3 ? ? ?c&:(symbolp ?c) ? ? ? ? ? ?)
	;(not (cell C - ?nume3 A ?q&:(symbolp ?q)))
	=>
	(assert (cell C - ?nume3 A :)))
(defrule C4 
(declare (salience 20))
	(column ?nume4 ? ? ? ?d&:(symbolp ?d) ? ? ? ? ?)
	=>
	(assert (cell D - ?nume4 B :)))
(defrule C5
(declare (salience 20))
	 (column ?nume5 ? ? ? ? ?e&:(symbolp ?e) ? ? ? ?)
	 =>
	 (assert (cell E - ?nume5 B :)))
(defrule C6
(declare (salience 20))
	(column ?nume6 ? ? ? ? ? ?f&:(symbolp ?f) ? ? ?)
	=>
	(assert (cell F - ?nume6 B : )))
(defrule C7
	(declare (salience 20))
	(column ?nume7 ? ? ? ? ? ? ?g&:(symbolp ?g) ? ?)
	=>
	(assert (cell G - ?nume7 C : )))
(defrule C8 
(declare (salience 20))
	(column ?nume8 ? ? ? ? ? ? ? ?h&:(symbolp ?h) ?)
	=>
	(assert (cell H - ?nume8 C : )))
(defrule C9 
(declare (salience 20))
	(column ?nume9 ? ? ? ? ? ? ? ? ?i&:(symbolp ?i))
	=>
	(assert (cell I - ?nume9 C : )))
	
;in numbers se insereaza in BF lista 'numbers' care continea numere intregi de la 1 la 9
(defrule number
(not (numbers 1 2 3 4 5 6 7 8 9))
=>
(assert (numbers 1 2 3 4 5 6 7 8 9 )))
	;Regulile 'AssignGroup1', 'AssignGroup2' si 'AssignGroup3' adauga al doilea indice
	;al grupului indicator pentru fiecare celula
	;Se testeaza valoarea indicelui pentru coloana celulei 
(defrule AssignGroup1
(declare (salience 17))
;regula dedicata celulelor din grupele A:1 | B:1 | C:1 
	?a1 <- (cell ?nume1 - ?nume2 ?nume3 ?x&:(symbolp ?x))
	(test (> 4 ?nume2))
	=>
	(retract ?a1 )
	(assert (cell ?nume1 - ?nume2 ?nume3 : 1))
	(assert (R ?nume1 - ?nume2 ?nume3 : 1)))
	
(defrule AssignGroup2
;regula dedicata celulelor din grupele A:2 | B:2 | C:2
(declare (salience 16))
	?a2 <- (cell ?nume4 - ?nume5 ?nume6 ?x&:(symbolp ?x))
	(test (and(> 7 ?nume5) (< 3 ?nume5)))
	=>
	(retract ?a2 )
	(assert (cell ?nume4 - ?nume5 ?nume6 : 2))
	(assert (R ?nume4 - ?nume5 ?nume6 : 2)))
(defrule AssignGroup3
;regula dedicata celulelor din grupele A:3 | B:3 | C:3
(declare (salience 16))
	?a3 <- (cell ?nume7 - ?nume8 ?nume9 ?y&:(symbolp ?y))
	(test (and(> 10 ?nume8)(< 6 ?nume8)))
	(not (R ?nume7 - ?nume8 ?nume9 ?y))
	=>
	(retract ?a3)
	(assert (cell ?nume7 - ?nume8 ?nume9 : 3))
	(assert (R ?nume7 - ?nume8 ?nume9 : 3))
	)
	(defrule ReuniuneRow
	(declare (salience 15))
	(cell ?nume1 - ?nume2 ?nume3 ?q&:(symbolp ?q) ?nume4 )
	(row ?nume1 $? ?x&~:(symbolp ?x) $?)
	(column ?nume2 $? ?y&:(neq ?x ?y) $?)
	(test (not(symbolp ?y)))
	(not (R  ?nume1 - ?nume2   ?nume3 ?q ?nume4 $? ?x  $?))
	?a1 <- (R  ?nume1 - ?nume2   ?nume3 ?q ?nume4 $?elem)
	=>
	(retract ?a1)
    (assert (R ?nume1 - ?nume2 ?nume3 ?q ?nume4 $?elem ?x) )
)
(defrule ReuniuneCol
	(declare (salience 15))
	(cell ?nume1 - ?nume2 ?nume3 ?q&:(symbolp ?q) ?nume4 )
	(column ?nume2 $? ?x&~:(symbolp ?x) $?)
	(group ?nume3 ?q ?nume4 $? ?y&:(neq ?x ?y) $?)
	(test (not(symbolp ?y)))
	(not (R  ?nume1 - ?nume2   ?nume3 ?q ?nume4 $? ?x  $?))
	?a1 <- (R  ?nume1 - ?nume2   ?nume3 ?q ?nume4 $?elem)
	=>
	(retract ?a1)
    (assert (R ?nume1 - ?nume2 ?nume3 ?q ?nume4 $?elem ?x) )
)
	(defrule ReuniuneGr
(declare (salience 15))
	(cell ?nume1 - ?nume2 ?nume3 ?q&:(symbolp ?q) ?nume4 )
	;(column ?nume2 $? ?x&~:(symbolp ?x) $?)
	(group ?nume3 ?q ?nume4 $? ?x&~:(symbolp ?x) $?)
	
	(not (R  ?nume1 - ?nume2   ?nume3 ?q ?nume4 $? ?x  $?))
	?a1 <- (R  ?nume1 - ?nume2   ?nume3 ?q ?nume4 $?elem)
	=>
	(retract ?a1)
    (assert (R ?nume1 - ?nume2 ?nume3 ?q ?nume4 $?elem ?x) )
)

	
(defrule Diferenta
(declare (salience 14))
	?a1 <- (cell ?nume1 - ?nume2 ?nume3 ?q&:(symbolp ?q) ?nume4 $?elem1)
	?a2 <- (R ?nume1 - ?nume2 ?nume3 ?q ?nume4 $?elem2)
	(numbers $? ?x $? )
	(not(cell ?nume1 - ?nume2 ?nume3 ?q ?nume4 $? ?x $?))
	(not(R ?nume1 - ?nume2 ?nume3 ?q ?nume4 $? ?x $?))
	=>
	(retract ?a1 )
	(assert (cell ?nume1 - ?nume2 ?nume3 ?q ?nume4  $?elem1 ?x)))
;Regula SearchOne cauta o celula cu doar un numar de adaugat	
(defrule SearchOne
	(declare(salience 13))
	?a1 <- (cell ?nume1 - ?nume2 ?nume3 ?q&:(symbolp ?q) ?nume4 ?x)
	
	=>
	(undefrule Diferenta)
	(printout t "am gasit un numar (" ?x ") de adaugat in pozitia : " ?nume1 " - "?nume2" "  crlf)
	(assert (fill-row ?nume1 ?nume2 ?nume3 ?nume4 ?x))


)	

; ; completarea liniei cu valoarea ?x 
; ; pozitiile sunt indicate in (fill-row ?linie ?coloana ?gr ?numar_grup 	?pozitie_grup ?x)
; ; completarea pe linii se va face in functie de numarul coloanei 
(defrule FillRow1
;cell(i,1)
(declare (salience 11))
	?a1 <- (fill-row ?linie 1 ?gr ?nr  ?x) ; am sters pozitia pt grup!
	?a2 <- (row ?linie ?y&:(symbolp ?y) $?elem)
	?a3 <- (cell ?linie - 1 ?gr ?q&:(symbolp ?q) ?nr ?x)
	=>
	(retract ?a2 ?a1 ?a3 ) 
	(assert (row ?linie ?x $?elem)) ; assert actualizare !! 
	(assert (solution ?linie 1 ?x)) ; se va trimite in document .txt
	(printout t "Linia " ?linie " a fost completata pe prima pozitie cu elementul " ?x crlf))
(defrule FillRow2
;cell(i,2)
(declare (salience 11))
	?a1 <- (fill-row ?linie 2 ?gr ?nr ?x); 
	?a2 <- (row ?linie ?a ?y&:(symbolp ?y) $?elem)
	?a3 <- (cell ?linie - 2 ?gr ?q&:(symbolp ?q) ?nr ?x)
	=>
	(retract ?a1 ?a2 ?a3)
	(assert (row ?linie ?a ?x $?elem ));
	(assert (solution ?linie 2 ?x))
	(printout t  "Linia " ?linie " a fost completata pe a 2-a pozitie cu elementul " ?x crlf))
(defrule FillRow3
;cell(i,3)
(declare (salience 11))
	?a1 <- (fill-row ?linie 3 ?gr ?nr ?x)
	?a2 <- (row ?linie ?a ?b ?y&:(symbolp ?y) $?elem)
	?a3 <- (cell ?linie - 3 ?gr ?q&:(symbolp ?q) ?nr ?x)
	=>
	(retract ?a1 ?a2 ?a3)
	(assert (row ?linie ?a ?b ?x $?elem ));
	(assert (solution ?linie 3 ?x))
	(printout t  "Linia " ?linie " a fost completata pe a 3-a pozitie cu elementul " ?x crlf))
(defrule FillRow4
;cell(i,4)
(declare (salience 11))
	?a1 <- (fill-row ?linie 4 ?gr ?nr ?x)
	?a2 <- (row ?linie ?a ?b ?c ?y&:(symbolp ?y) $?elem)
	?a3 <- (cell ?linie - 4 ?gr ?q&:(symbolp ?q) ?nr ?x)
	=>
	(retract ?a1 ?a2 ?a3)
	(assert (row ?linie ?a ?b ?c ?x $?elem ));
	(assert (solution ?linie 4 ?x))
	(printout t  "Linia " ?linie " a fost completata pe a 4-a pozitie cu elementul " ?x crlf))
(defrule FillRow5
;cell(i,5)
(declare (salience 11))
	?a1 <- (fill-row ?linie 5 ?gr ?nr ?x)
	?a2 <- (row ?linie ?a ?b ?c ?d ?y&:(symbolp ?y) $?elem)
	?a3 <- (cell ?linie - 5 ?gr ?q&:(symbolp ?q) ?nr ?x)
	=>
	(retract ?a1 ?a2 ?a3)
	(assert (row ?linie ?a ?b ?c ?d ?x $?elem ));
	(assert (solution ?linie 5 ?x))
	(assert (R ?linie - 5 ?gr ?q ?nr $?elem ?x))
	(printout t  "Linia " ?linie " a fost completata pe a 5-a pozitie cu elementul " ?x crlf))
(defrule FillRow6
;cell(i,6)
(declare (salience 11))
	?a1 <- (fill-row ?linie 6 ?gr ?nr ?x)
	?a2 <- (row ?linie $?elem  ?y&:(symbolp ?y) ?a ?b ?c)
	?a3 <- (cell ?linie - 6 ?gr ?q&:(symbolp ?q) ?nr ?x)
	=>
	(retract ?a1 ?a2 ?a3)
	(assert (row ?linie $?elem ?x ?a ?b ?c ));
	(assert (solution ?linie 6 ?x))
	(printout t  "Linia " ?linie " a fost completata pe a 6-a pozitie cu elementul " ?x crlf))
(defrule FillRow7
;cell(i,7)
(declare (salience 11))
	?a1 <- (fill-row ?linie 7 ?gr ?nr ?x)
	?a2 <- (row ?linie $?elem  ?y&:(symbolp ?y) ?a ?b )
	?a3 <- (cell ?linie - 7 ?gr ?q&:(symbolp ?q) ?nr ?x)	
	=>
	(retract ?a1 ?a2 ?a3 )
	(assert (row ?linie $?elem ?x ?a ?b ));
	(assert (solution ?linie 7 ?x))
	(printout t  "Linia " ?linie " a fost completata pe a 7-a pozitie cu elementul " ?x crlf))
(defrule FillRow8
;cell(i,8)
(declare (salience 11))
	?a1 <- (fill-row ?linie 8 ?gr ?nr ?x)
	?a2 <- (row ?linie $?elem  ?y&:(symbolp ?y) ?a )
	?a3 <- (cell ?linie - 8 ?gr ?q&:(symbolp ?q) ?nr ?x)
	;?a4 <- (R ?linie - 8 ?gr ?q ?nr $?elem)	
	=>
	(retract ?a1 ?a2 ?a3 )
	(assert (row ?linie $?elem ?x ?a ));
	(assert (solution ?linie 8 ?x))
	;(assert (R ?linie - 8 ?gr ?q ?nr $?elem ?x))
	(printout t  "Linia " ?linie " a fost completata pe a 8-a pozitie cu elementul " ?x crlf))
(defrule FillRow9
;cell(i,9)
(declare (salience 11))
	?a1 <- (fill-row ?linie 9 ?gr ?nr ?x)
	?a2 <- (row ?linie $?elem  ?y&:(symbolp ?y)  )
	?a3 <- (cell ?linie - 9 ?gr ?q&:(symbolp ?q) ?nr ?x)
	;?a4 <- (R ?linie - 9 ?gr ?q ?nr $?elem)	
	=>
	(retract ?a1 ?a2 ?a3)
	(assert (row ?linie $?elem ?x  ));
	(assert (solution ?linie 9 ?x))
	;(assert (R ?linie - 9 ?gr ?q ?nr $?elem ?x))
	(printout t  "Linia " ?linie " a fost completata pe a 9-a pozitie cu elementul " ?x crlf))	
; Regula Erase va sterge celulele si multimile de reuniune dupa gasirea unei solutii
(defrule Erase1
(declare (salience 10))
	(solution ?linie ?coloana ?x)
	?a1 <- (cell ?l&:(neq ?linie ?l) - ?coloana ?g ?q&:(symbolp ?q) ?nr $?elem1  ?x $?elem)
	;?a2 <- (R ?linie - ?coloana ?gr ?q ?n $?elem )
	=>
	(retract ?a1 )
	;(assert (R ?linie - ?coloana ?gr ?q ?n $?elem ?x))
	(assert (cell ?l - ?coloana ?g ?q ?nr $?elem1 $?elem))
	(printout t " S-a sters elementul " ?x " din cell linia " ?l ", coloana " ?coloana crlf ))
; se va face remove ?x din celule dupa linie	
	(defrule Erase2
(declare (salience 10))
	(solution ?linie ?coloana ?x)
	?a1 <- (cell ?linie - ?c&:(neq ?coloana ?c) ?g ?q&:(symbolp ?q) ?nr $?elem1  ?x $?elem)
	
	=>
	(retract ?a1 )
	(assert (cell ?linie - ?c ?g ?q ?nr $?elem1 $?elem))
	(printout t " S-a sters elementul " ?x " din cell linia " ?linie ", coloana " ?c crlf ))
(defrule Solutions
 ?a1 <- (solution ?a ?b ?c)
=>
(open /Users/cmitru/Documents/ProiectSBC/fiesire.dat fdata "a")
(printout fdata ?a - ?b " " ?c crlf)
(retract ?a1)
(printout t "adaugat " ?a1 crlf)
(close fdata)
)

; (defrule AssertR
; (declare (salience 16))
	; ?a1 <- (solution ?linie ?coloana ?x)
	; ?a2 <- (R ?linie - ?coloana ?gr ?q&:(symbolp ?q) ?nr $?elem )
	; (not (R ?linie - ?coloana ?gr ?q ?nr $?elem1 ?x $?elem2))
	; =>
	; (retract ?a2 )
	; (assert (R ?linie - ?coloana ?gr ?q ?nr $?elem ?x))
	; (printout t "S-a adaugat la reuniune, cell(" ?linie "," ?coloana ") elementul " ?x crlf))
