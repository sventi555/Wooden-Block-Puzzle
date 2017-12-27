;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname blocks) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
(define black (list 'm 'c '= 'e 'm 'e))

(define dark (list '= 'm '= '= 'e 'c))

(define lighter (list '= 'c 'e '= 'm 'e))

(define lightest (list '= 'e 'c 'c 'm 'm))

(define (unique? sym1 sym2 sym3 sym4)
  (cond
    [(or (equal? sym1 sym2) (equal? sym1 sym3) (equal? sym1 sym4)
         (equal? sym2 sym3) (equal? sym2 sym4) (equal? sym3 sym4))
     false]
    [else true]))

(define (all-unique? list1 list2 list3 list4)
  (cond
    [(and (unique? (first list1) (first list2) (first list3) (first list4))
          (unique? (third list1) (third list2) (third list3) (third list4))
          (unique? (fifth list1) (fifth list2) (fifth list3) (fifth list4))
          (unique? (sixth list1) (sixth list2) (sixth list3) (sixth list4)))
     true]
    [else false]))

(define (rotate cube)
  (list (second cube) (third cube) (fourth cube)
        (first cube) (fifth cube) (sixth cube)))

(define (flip cube)
  (list (sixth cube) (second cube) (fifth cube)
        (fourth cube) (first cube) (third cube)))

(define (arrangement-wrapped cube1 cube2 cube3 cube4 count1 count2 count3 count4)
  (cond
    [(all-unique? cube1 cube2 cube3 cube4) (list cube1 cube2 cube3 cube4)]
    [(= count1 4) false]
    [(= count2 4) (arrangement-wrapped (rotate cube1) cube2 cube3 cube4
                               (add1 count1) 0 count3 count4)]
    [(= count3 4) (arrangement-wrapped cube1 (rotate cube2) cube3 cube4
                               count1 (add1 count2) 0 count4)]
    [(= count4 4) (arrangement-wrapped cube1 cube2 (rotate cube3) cube4
                               count1 count2 (add1 count3) 0)]
    [else (arrangement-wrapped cube1 cube2 cube3 (rotate cube4)
                       count1 count2 count3 (add1 count4))]))

(define (arrangement cube1 cube2 cube3 cube4)
  (arrangement-wrapped cube1 cube2 cube3 cube4 0 0 0 0))

(define (flippers-wrapped cube1 cube2 cube3 cube4 count1 count2 count3 count4)
  (cond
    [(not (equal? false (arrangement cube1 cube2 cube3 cube4))) (arrangement cube1 cube2 cube3 cube4)]
    [(= count1 4) "no valid arrangements"]
    [(= count2 4) (flippers-wrapped (flip cube1) cube2 cube3 cube4 (add1 count1) 0 count3 count4)]
    [(= count3 4) (flippers-wrapped cube1 (flip cube2) cube3 cube4 count1 (add1 count2) 0 count4)]
    [(= count4 4) (flippers-wrapped cube1 cube2 (flip cube3) cube4 count1 count2 (add1 count3) 0)]
    [else (flippers-wrapped cube1 cube2 cube3 (flip cube4) count1 count2 count3 (add1 count4))]))

(define (flippers cube1 cube2 cube3 cube4)
  (flippers-wrapped cube1 cube2 cube3 cube4 0 0 0 0))

(flippers black dark lighter lightest)