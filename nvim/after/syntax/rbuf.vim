" ---------------------------------------------------------------------
" Vim syntax file
" Language: rbuf (Ark serialization IDL)
" Author: Cameron Brown
" ---------------------------------------------------------------------

if exists('b:current_syntax')
  finish
endif

" ---------------------------------------------------------------------
" 1. Inherit C++ highlighting for comments, numbers, etc.
" ---------------------------------------------------------------------
runtime! syntax/cpp.vim

" ---------------------------------------------------------------------
" 2. Core keywords
" ---------------------------------------------------------------------
syn keyword rbufStructure           schema enum bitmask
syn keyword rbufKeyword             namespace group const
syn keyword rbufInclude             include

" ---------------------------------------------------------------------
" 3. Namespace-qualified types (ns::Type)
" ---------------------------------------------------------------------
" 3.1 - Match namespace-qualified types (ns::Type)
syn match   rbufIncludedNamespace   /\v(\w+::)+/

" 3.2 - Match scoped types (e.g., Type, MyType)
syn match   rbufScopedType          /\([A-Z]\+[a-z0-9]*\)/

" ---------------------------------------------------------------------
" 4. Types
" ---------------------------------------------------------------------
" 4.1 – Primitives
syn keyword rbufPrimitiveType       bool int8 int16 int32 int64 uint8 uint16 uint32 uint64 float double

" 4.2 – Built-ins beyond primitives
syn keyword rbufBuiltinType         string guid duration steady_time_point system_time_point byte_buffer

" 4.3 – Container / generic helpers
syn keyword rbufContainerType       arraylist dictionary array variant

" 4.4 - Enum members (named by UPPER_CASE)
syn match rbufEnumMember            /\([A-Z]\+[A-Z0-9_]\+\)/

" ---------------------------------------------------------------------
" 5. Attributes ([[removed]], [[optional]], [[final]], …)
" ---------------------------------------------------------------------
" 5.1 - Specific attributes
syn match   rbufAttrOptional        /\[\[optional\]\]/
syn match   rbufAttrFinal           /\[\[final\]\]/

" ---------------------------------------------------------------------
" 6. Special case: entire lines with [[removed]] → comment style
" ---------------------------------------------------------------------
" 6.1 - Match lines with [[removed]] and highlight them as comments
syn match   rbufRemovedLine         /^\s*\[\[removed.*\]\].*/

" ---------------------------------------------------------------------
" Highlight links
" ---------------------------------------------------------------------
" 2 - Core keywords
hi def link rbufStructure           Structure
hi def link rbufKeyword             Keyword
hi def link rbufInclude             Include

" 3 - Namespace-qualified types
hi def link rbufIncludedNamespace   Include
hi def link rbufScopedType          Type

" 4 - Types
hi def link rbufPrimitiveType       @type.builtin " If using Vim, replace this with "Type"
hi def link rbufBuiltinType         Type
hi def link rbufContainerType       Type
hi def link rbufEnumMember          Constant

" 5 - Attributes
hi def link rbufAttrOptional        Keyword
hi def link rbufAttrFinal           Keyword

" 6 - Special case: lines with [[removed]] → comment style
hi def link rbufRemovedLine         Comment

" ---------------------------------------------------------------------
" Finish
" ---------------------------------------------------------------------
let b:current_syntax = 'rbuf'
