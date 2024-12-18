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

;;; Description: Convenience interface for loading Lisa from scratch.

(in-package :cl-user)

#-sbcl
(error "For now, this file is suitable only for SBCL 2.4.11 and later.")

#-asdf
(error "ASDF is required to use Lisa; please make it available within your Lisp.")

#-quicklisp
(error "Lisa requires Quicklisp for dependency resolution. Please set that up first.")

(defvar *install-root* (make-pathname :directory (pathname-directory *load-truename*)))

;;; There's a bug in Lisa that is creating a symbol in the COMMON-LISP package. I need
;;; to track that down. Until then, we unlock that package in SBCL.

(sb-ext:unlock-package :common-lisp)

(ql:quickload :log4cl)
(push :log4cl *features*)

(ql:quickload :alexandria)
(push :alexandria *features*)

(push *install-root* asdf:*central-registry*)
(asdf:operate 'asdf:load-op :lisa :force t)
(asdf:operate 'asdf:load-op :lisa/lisa-logger :force t)
