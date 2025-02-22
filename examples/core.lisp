;; This file is part of Lisa, the Lisp-based Intelligent Software Agents platform.

;; MIT License

;; Copyright (c) 2000 David Young

;; Permission is hereby granted, free of charge, to any person obtaining a copy
;; of this software and associated documentation files (the "Software"), to deal
;; in the Software without restriction, including without limitation the rights
;; to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
;; copies of the Software, and to permit persons to whom the Software is
;; furnished to do so, subject to the following conditions:

;; The above copyright notice and this permission notice shall be included in all
;; copies or substantial portions of the Software.

;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
;; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
;; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
;; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
;; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
;; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
;; SOFTWARE.

(in-package :lisa-user)

(clear)

(deftemplate frodo ()
  (slot name)
  (slot has-ring)
  (slot age))

(deftemplate bilbo ()
  (slot name)
  (slot relative)
  (slot age))

(deftemplate gandalf ()
  (slot name)
  (slot age))

(deftemplate saruman ()
  (slot name))

(deftemplate samwise ()
  (slot name)
  (slot friend)
  (slot age))

(deftemplate hobbit ()
  (slot name))

(deftemplate pippin ()
  (slot name))

#+ignore
(defrule frodo ()
  (frodo (name ?name frodo))
  =>
  (format t "frodo fired: ~S~%" ?name))

#+ignore
(defrule not-frodo ()
  (frodo (name ?name (not frodo)))
  =>
  (format t "not-frodo fired: ~S~%" ?name))

#+ignore
(defrule simple-rule ()
  (frodo)
  =>
  (format t "simple-rule fired.~%"))

#+ignore
(defrule special-pattern ()
  ;;;(bilbo (name ?name) (relative ?name))
  (frodo (name ?fname) (has-ring ?ring (eq ?ring ?fname)))
  =>
  )

#+ignore
(defrule negated-slot-rule ()
  (frodo (name (not frodo)))
  =>
  )

#+ignore
(defrule shared-rule-a ()
  (frodo (name frodo))
  (gandalf (name gandalf) (age 100))
  =>
  )

#+ignore
(defrule shared-rule-b ()
  (frodo (name frodo))
  (gandalf (name gandalf) (age 200))
  =>
  )

#+ignore
(defrule constraints ()
  (frodo (name ?name))
  (samwise (name sam) (friend ?friend (not frodo)))
  =>
  (format t "constraints: ~S ~S~%" ?name ?friend))

#+ignore
(defrule variable-rule ()
  (frodo (name ?name))
  (?sam (samwise (name ?name) (friend ?name)))
  =>
  (format t "variable-rule fired: ~S~%" ?sam)
  (modify ?sam (name samwise)))

(defrule logical-1 ()
  (logical
   (frodo))
  =>
  (assert (bilbo)))

(defrule logical-2 ()
  (logical
   (bilbo))
  =>
  (assert (samwise)))

(defrule exists ()
  (frodo (name ?name))
  (exists (bilbo (name ?name)))
  =>
  (format t "exists fired.~%"))

#+ignore
(defrule respond-to-logical-rule ()
  (bilbo)
  =>
  (format t "Uh oh...~%"))

#+ignore
(defrule or-rule ()
  (frodo)
  (or (gandalf)
      (samwise))
  =>
  (format t "or-rule~%"))

#+ignore
(defrule or-rule ()
  (or (samwise (name sam))
      (gandalf (name gandalf)))
  (frodo (name ?name))
  (or (hobbit)
      (pippin))
  (saruman)
  =>
  (format t "or-rule fired.~%"))

#+ignore
(defrule samwise ()
  (samwise (name samwise))
  =>
  (format t "Rule samwise fired.~%"))

#+ignore
(defrule test-rule ()
  (frodo (name ?name))
  (samwise (friend ?name) (age ?age))
  (test (eq ?age 100))
  =>
  )

#+ignore
(defrule negated-variable ()
  (frodo (name ?name))
  (samwise (friend (not ?name)))
  =>
  )

#+ignore
(defrule simple ()
  (?f (gandalf (age 100)))
  =>
  (let ((?age 1000))
    (modify ?f (age ?age) (name (intern (make-symbol "gandalf"))))))

#+ignore
(defrule embedded-rule ()
  (gandalf (name gandalf) (age ?age))
  =>
  (defrule new-gandalf ()
    (gandalf (name new-gandalf) (age ?age))
    =>
    (format t "new-gandalf fired.~%")))

#|
(defparameter *frodo* (assert (frodo (name frodo))))
(defparameter *bilbo* (assert (bilbo (name bilbo))))
(defparameter *samwise* (assert (samwise (friend frodo) (age 100))))
(defparameter *gandalf* (assert (gandalf (name gandalf) (age 200))))
|#

(reset)
