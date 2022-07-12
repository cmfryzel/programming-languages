;; structures for each type of employee to hold necessary information
(define-structure (salariedEmp keyword-constructor)
	type firstName lastName salary)
(define-structure (hourlyEmp keyword-constructor)
	type firstName lastName hours rate)
(define-structure (commEmp keyword-constructor)
	type firstName lastName minSal sales commRate)

(define (readFile inFile)
	(let loop
		((lines '())
		(next-line (read-line inFile)))
		; when we hit the end of file
  		(if (eof-object? next-line)
			; return the lines list
       		(reverse lines)
		; else loop, keeping this line
		(loop (cons next-line lines)
			; and move to next line
            (read-line inFile)))
	)
)

;; splits a string by given delimiter
;; returns list of strings making up original string
(define (str-split str ch)
  (let ((len (string-length str)))
    (letrec
      ((split
        (lambda (a b)
          (cond
            ((>= b len) (if (= a b) '() (cons (substring str a b) '())))
              ((char=? ch (string-ref str b)) (if (= a b)
                (split (+ 1 a) (+ 1 b))
                  (cons (substring str a b) (split b b))))
                (else (split a (+ 1 b)))))))
                  (split 0 0)))
)

; split hourly by line
(define (makeHourly hourlyString)
	(define _parsed (str-split hourlyString #\space))
	(make-hourlyEmp
		'type (first _parsed)
		'firstName (second _parsed)
		'lastName (third _parsed)
		'hours (string->number (fourth _parsed))
		'rate (string->number (fifth _parsed)))
)
; split comm by line

(define (makeCommission commString)
	(define _parsed (str-split commString #\space))
	(make-commEmp
		'type (first _parsed)
		'firstName (second _parsed)
		'lastName (third _parsed)
		'minSal (string->number (fourth _parsed))
		'sales (string->number (fifth _parsed))
		'commRate (string->number (sixth _parsed)))
)
; split salaried by line

(define (makeSalaried salString)
	(define _parsed (str-split salString #\space))
	(make-salariedEmp
		'type (first _parsed)
		'firstName (second _parsed)
		'lastName (third _parsed)
		'salary (string->number (fourth _parsed)))
)

(define (parseEmps lst)
	(let loop
		((workList lst) ;; assign passed list to var workList
		(empList (list))) ;; create empty list to put employee structs in
	(cond
		((null? workList) (reverse empList)) ; base case
		((eqv? (substring? "salaried" (first workList)) #t) ; if employee is salaried
			(loop (cdr workList) (cons (makeSalaried (first workList)) empList))) ; make salaried employee, add to list
		((eqv? (substring? "hourly" (first workList)) #t) ; if employee is hourly
			(loop (cdr workList) (cons (makeHourly (first workList)) empList))) ; make hourly employee, add to list
		((eqv? (substring? "commission" (first workList)) #t) ; if employee is commission
			(loop (cdr workList) (cons (makeCommission (first workList)) empList))) ; make commission employee, add to list
		(else (loop (cdr workList) empList)))) ; else loop
)



(define (getType emp)
	(cond
		((eqv? (hourlyEmp? emp) #t) 'hourly)
		((eqv? (salariedEmp? emp) #t) 'sal)
		(else 'comm))
)




(define (getEarning emp)
  ( cond
    ((eqv? (getType emp) 'sal)
      (salariedEmp-salary emp))
    ((eqv? (getType emp) 'comm)
      (let ((commissionWage (* (commEmp-sales emp) (commEmp-commRate emp) )))
        (if ( > commissionWage (commEmp-minSal emp) )
          commissionWage
          (commEmp-minSal emp))))
    ((eqv? (getType emp) 'hourly)
      (let ((total 0))
        ( do ((i (hourlyEmp-hours emp) (- i 1))) ((eq? i 0))
          (cond
            ((> i 50) (set! total (+ total (* (hourlyEmp-rate emp) 2))) )
            ((and (> i 40) (<= i 50)) (set! total (+ total (* (hourlyEmp-rate emp) 1.5))) )
            (else (set! total (+ total (hourlyEmp-rate emp))) )))
        total)))
  ) ;end get-earning
;; all the prints 

(define (printHourly emp)
	(display (string-append
		"Hourly employee: " (hourlyEmp-firstName emp) " " (hourlyEmp-lastName emp)))
	(newline)
	(display (string-append
		"hours worked: " (number->string (hourlyEmp-hours emp))
		", hourly rate: " (number->string (hourlyEmp-rate emp))))
	(newline)
	(display (string-append "earned $" (number->string (getEarning emp)) "\n"))
	(newline)
)

(define (printSalaried emp)
	(display (string-append
		"Salaried employee: " (salariedEmp-firstName emp) " " (salariedEmp-lastName emp)))
	(newline)
	(display (string-append
		"weekly salary: " (number->string (getEarning emp))))
	(newline)
	(display (string-append
		"earned $" (number->string (getEarning emp)) "\n"))
	(newline)
)

(define (printComm emp)
	(display (string-append
		"Commission employee: " (commEmp-firstName emp) " " (commEmp-lastName emp)))
	(newline)
	(display (string-append
		"min salary: " (number->string (commEmp-minSal emp))
		", sales amount: " (number->string (commEmp-sales emp))
		", commission rate: " (number->string (* (commEmp-commRate emp) 100)) "%"))
	(newline)
	(display (string-append "earned $" (number->string (getEarning emp)) "\n"))
	(newline)
)

;; the actual meat of the program
;; the actions the user requests
;; list passed has already been cut to include thresh emps only (if required)

(define (count readList)
	(display (string-append "There are " (number->string (length readList)) " employees\n\n"))
)

(define (minList lst)
	(let loop
		((workList lst)
		(minListEarning (getEarning (first lst)))
		(minEmp (first lst)))
	(cond
		((null? workList)
			(cond
			;	(printEmployee minEmp)
				((eqv? (getType minEmp) 'hourly) (printHourly minEmp))
				((eqv? (getType minEmp) 'sal) (printSalaried minEmp))
				((eqv? (getType minEmp) 'comm) (printComm minEmp))))
		((< (getEarning (first workList)) minListEarning)
			(loop (cdr workList) (getEarning (first workList)) (first workList)))
		(else
			(loop (cdr workList) minListEarning minEmp))))
)

(define (maxList lst)
	(let loop
		((workList lst)
		(maxListEarning (getEarning (first lst)))
		(maxListEmp (first lst)))
	(cond
		((null? workList)
			(cond
				;(printEmployee maxListEmp)
				((eqv? (getType maxListEmp) 'hourly) (printHourly maxListEmp))
				((eqv? (getType maxListEmp) 'sal) (printSalaried maxListEmp))
				((eqv? (getType maxListEmp) 'comm) (printComm maxListEmp))))
		((> (getEarning (first workList)) maxListEarning)
			(loop (cdr workList) (getEarning (first workList)) (first workList)))
		(else
			(loop (cdr workList) maxListEarning maxListEmp))))
)

(define (print lst)
	(let loop
		((workList lst))
	(cond
		((null? workList) 'done)
		((eqv? (getType (first workList)) 'hourly)
			(printHourly (first workList)) (loop (cdr workList)))
		((eqv? (getType (first workList)) 'sal)
			(printSalaried (first workList)) (loop (cdr workList)))
		((eqv? (getType (first workList)) 'comm)
			(printComm(first workList)) (loop (cdr workList)))
	;	(printEmployee(first workList)) (loop (cdr workList)))
		(else (loop (cdr workList)))))
)

(define (getTotal lst)
	(let loop
		((workList lst)
		(total 0.0))
	(cond
		((null? workList) (display (string-append
			"Total payment is $" (number->string total) "\n" "\n")))
		(else (loop (cdr workList) (+ total (getEarning (first workList)))))))
)

(define (getAvg lst)
	(define _size (length lst))
	(let loop
		((workList lst)
		(total 0.0))
	(cond
		((null? workList) (display (string-append
			"Average payment per employee is $" (number->string (/ total _size)) "\n" "\n")))
		(else (loop (cdr workList) (+ total (getEarning (first workList)))))))
)

(define threshold) ;; global variable for threshold
(define (_eq? emp) (= (getEarning emp) threshold))
(define (ne? emp) (not (= (getEarning emp) threshold)))
(define (gt? emp) (> (getEarning emp) threshold))
(define (ge? emp) (>= (getEarning emp) threshold))
(define (lt? emp) (< (getEarning emp) threshold))
(define (le? emp) (<= (getEarning emp) threshold))
(define (threshFilter lst op val)
	(set! threshold val)
	(cond
		((equal? op "ge") (filter ge? lst))
		((equal? op "eq") (filter _eq? lst))
		((equal? op "ne") (filter ne? lst))
		((equal? op "gt") (filter gt? lst))
		((equal? op "lt") (filter lt? lst))
		((equal? op "le") (filter le? lst))
	)
)

(define (check lst action)
	(cond
		((equal? action "max") (maxList lst))
		((equal? action "count") (count lst))
		((equal? action "print") (print lst))
		((equal? action "min") (minList lst))
		((equal? action "total") (getTotal lst))
		((equal? action "avg") (getAvg lst)))
)

;; main function
(define (perform . args)
	(if (and (not (= (length args) 2)) (not (= (length args) 4))) (display "\nUsage: (perform employee_file action)\nor\nUsage: (perform employee_file action operator threshold)\n\nValid actions: count print min max total avg\nValid operators: eq ne gt ge lt le\n\n"))
	;; _readList = list of strings, each string representing different employee
	(define _readList (call-with-input-file (first args) readFile))
	;; _empList =  list of employee structures
	(define _empList (parseEmps _readList))
	(if (= (length args) 2) (check _empList (second args)))
	(if (= (length args) 4)
		(check (threshFilter _empList (third args) (fourth args)) (second args)))
)