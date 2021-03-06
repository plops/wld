;;; This file was automatically generated by SWIG (http://www.swig.org).
;;; Version 2.0.9
;;;
;;; Do not make changes to this file unless you know what you are doing--modify
;;; the SWIG interface file instead.

;;;SWIG wrapper code starts here
(ql:quickload "cffi")

(cl:defmacro defanonenum (&body enums)
   "Converts anonymous enums to defconstants."
  `(cl:progn ,@(cl:loop for value in enums
                        for index = 0 then (cl:1+ index)
                        when (cl:listp value) do (cl:setf index (cl:second value)
                                                          value (cl:first value))
                        collect `(cl:defconstant ,value ,index))))

(cl:eval-when (:compile-toplevel :load-toplevel)
  (cl:unless (cl:fboundp 'swig-lispify)
    (cl:defun swig-lispify (name flag cl:&optional (package cl:*package*))
      (cl:labels ((helper (lst last rest cl:&aux (c (cl:car lst)))
                    (cl:cond
                      ((cl:null lst)
                       rest)
                      ((cl:upper-case-p c)
                       (helper (cl:cdr lst) 'upper
                               (cl:case last
                                 ((lower digit) (cl:list* c #\- rest))
                                 (cl:t (cl:cons c rest)))))
                      ((cl:lower-case-p c)
                       (helper (cl:cdr lst) 'lower (cl:cons (cl:char-upcase c) rest)))
                      ((cl:digit-char-p c)
                       (helper (cl:cdr lst) 'digit 
                               (cl:case last
                                 ((upper lower) (cl:list* c #\- rest))
                                 (cl:t (cl:cons c rest)))))
                      ((cl:char-equal c #\_)
                       (helper (cl:cdr lst) '_ (cl:cons #\- rest)))
                      (cl:t
                       (cl:error "Invalid character: ~A" c)))))
        (cl:let ((fix (cl:case flag
                        ((constant enumvalue) "+")
                        (variable "*")
                        (cl:t ""))))
          (cl:intern
           (cl:concatenate
            'cl:string
            fix
            (cl:nreverse (helper (cl:concatenate 'cl:list name) cl:nil cl:nil))
            fix)
           package))))))

;;;SWIG wrapper code ends here


(cl:defconstant WLD_USER_ID (ash #xff 24))

(defun wld-fourcc (a b c d)
  (logior (char-code a) (ash (char-code b) 8)
	  (ash (char-code c) 16) (ash (char-code d) 24)))
#+nil
(wld-fourcc #\X #\R #\2 #\4)

(cffi:defcenum wld_format
	(:WLD_FORMAT_XRGB8888 #.(wld-fourcc #\X #\R #\2 #\4))
	(:WLD_FORMAT_ARGB8888 #.(wld-fourcc #\A #\R #\2 #\4)))

(cffi:defcenum wld_flags
	(:WLD_FLAG_MAP #.(ash 1 16)))

(cffi:defcfun ("wld_lookup_named_color" wld_lookup_named_color) :pointer
  (name :string)
  (color :pointer))

(cffi:defcenum wld_object_type
	:WLD_OBJECT_DATA)

(cffi:defcunion wld_object
	(ptr :pointer)
	(u32 :pointer)
	(i :int))

(cffi:defcstruct wld_context
	(impl :pointer))

(cffi:defcfun ("wld_create_renderer" wld_create_renderer) :pointer
  (context :pointer))

(cffi:defcfun ("wld_create_buffer" wld_create_buffer) :pointer
  (context :pointer)
  (width :pointer)
  (height :pointer)
  (format :pointer)
  (flags :pointer))

(cffi:defcfun ("wld_import_buffer" wld_import_buffer) :pointer
  (context :pointer)
  (type :pointer)
  (object (:pointer (:union wld_object)))
  (width :pointer)
  (height :pointer)
  (format :pointer)
  (pitch :pointer))

(cffi:defcfun ("wld_create_surface" wld_create_surface) :pointer
  (context :pointer)
  (width :pointer)
  (height :pointer)
  (format :pointer)
  (flags :pointer))

(cffi:defcfun ("wld_destroy_context" wld_destroy_context) :void
  (context :pointer))

(cffi:defcstruct wld_extents
	(advance :pointer))

(cffi:defcstruct wld_font
	(ascent :pointer)
	(descent :pointer)
	(height :pointer)
	(max_advance :pointer))

(cffi:defcfun ("wld_font_create_context" wld_font_create_context) :pointer)

(cffi:defcfun ("wld_font_destroy_context" wld_font_destroy_context) :void
  (context :pointer))

(cffi:defcfun ("wld_font_open_pattern" wld_font_open_pattern) :pointer
  (context :pointer)
  (match :pointer))

(cffi:defcfun ("wld_font_open_name" wld_font_open_name) :pointer
  (context :pointer)
  (name :string))

(cffi:defcfun ("wld_font_close" wld_font_close) :void
  (font :pointer))

(cffi:defcfun ("wld_font_ensure_char" wld_font_ensure_char) :pointer
  (font :pointer)
  (character :pointer))

(cffi:defcfun ("wld_font_text_extents_n" wld_font_text_extents_n) :void
  (font :pointer)
  (text :string)
  (length :pointer)
  (extents :pointer))

(cffi:defcfun ("wld_font_text_extents" wld_font_text_extents) :void
  (font :pointer)
  (text :string)
  (extents :pointer))

(cffi:defcstruct wld_exporter
	(export :pointer)
	(next :pointer))

(cffi:defcstruct wld_destructor
	(destroy :pointer)
	(next :pointer))

(cffi:defcstruct wld_buffer
	(impl :pointer)
	(width :pointer)
	(height :pointer)
	(pitch :pointer)
	(format wld_format)
	(damage :pointer)
	(map :pointer))

(cffi:defcfun ("wld_map" wld_map) :pointer
  (buffer :pointer))

(cffi:defcfun ("wld_unmap" wld_unmap) :pointer
  (buffer :pointer))

(cffi:defcfun ("wld_export" wld_export) :pointer
  (buffer :pointer)
  (type :pointer)
  (object :pointer))

(cffi:defcfun ("wld_buffer_add_exporter" wld_buffer_add_exporter) :void
  (buffer :pointer)
  (exporter :pointer))

(cffi:defcfun ("wld_buffer_add_destructor" wld_buffer_add_destructor) :void
  (buffer :pointer)
  (destructor :pointer))

(cffi:defcfun ("wld_buffer_reference" wld_buffer_reference) :void
  (buffer :pointer))

(cffi:defcfun ("wld_buffer_unreference" wld_buffer_unreference) :void
  (buffer :pointer))

(cffi:defcstruct wld_surface
	(impl :pointer))

(cffi:defcfun ("wld_surface_damage" wld_surface_damage) :pointer
  (surface :pointer)
  (new_damage :pointer))

(cffi:defcfun ("wld_surface_take" wld_surface_take) :pointer
  (surface :pointer))

(cffi:defcfun ("wld_surface_release" wld_surface_release) :void
  (surface :pointer)
  (buffer :pointer))

(cffi:defcfun ("wld_swap" wld_swap) :pointer
  (surface :pointer))

(cffi:defcfun ("wld_destroy_surface" wld_destroy_surface) :void
  (surface :pointer))

(cffi:defcstruct wld_renderer
	(impl :pointer)
	(target :pointer))

(cffi:defcenum wld_capability
	(:WLD_CAPABILITY_READ #.(cl:ash 1 0))
	(:WLD_CAPABILITY_WRITE #.(cl:ash 1 1)))

(cffi:defcfun ("wld_destroy_renderer" wld_destroy_renderer) :void
  (renderer :pointer))

(cffi:defcfun ("wld_capabilities" wld_capabilities) :pointer
  (renderer :pointer)
  (buffer :pointer))

(cffi:defcfun ("wld_set_target_buffer" wld_set_target_buffer) :pointer
  (renderer :pointer)
  (buffer :pointer))

(cffi:defcfun ("wld_set_target_surface" wld_set_target_surface) :pointer
  (renderer :pointer)
  (surface :pointer))

(cffi:defcfun ("wld_fill_rectangle" wld_fill_rectangle) :void
  (renderer :pointer)
  (color :pointer)
  (x :pointer)
  (y :pointer)
  (width :pointer)
  (height :pointer))

(cffi:defcfun ("wld_fill_region" wld_fill_region) :void
  (renderer :pointer)
  (color :pointer)
  (region :pointer))

(cffi:defcfun ("wld_copy_rectangle" wld_copy_rectangle) :void
  (renderer :pointer)
  (buffer :pointer)
  (dst_x :pointer)
  (dst_y :pointer)
  (src_x :pointer)
  (src_y :pointer)
  (width :pointer)
  (height :pointer))

(cffi:defcfun ("wld_copy_region" wld_copy_region) :void
  (renderer :pointer)
  (buffer :pointer)
  (dst_x :pointer)
  (dst_y :pointer)
  (region :pointer))

(cffi:defcfun ("wld_draw_text_n" wld_draw_text_n) :void
  (renderer :pointer)
  (font :pointer)
  (color :pointer)
  (x :pointer)
  (y :pointer)
  (text :string)
  (length :pointer)
  (extents :pointer))

(cffi:defcfun ("wld_draw_text" wld_draw_text) :void
  (renderer :pointer)
  (font :pointer)
  (color :pointer)
  (x :pointer)
  (y :pointer)
  (text :string)
  (extents :pointer))

(cffi:defcfun ("wld_flush" wld_flush) :void
  (renderer :pointer))


