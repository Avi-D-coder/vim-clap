" Author: liuchengxu <xuliuchengxlc@gmail.com>
" Description: List the files.

let s:save_cpo = &cpoptions
set cpoptions&vim

let s:grep2 = {}

function! s:grep2.on_typed()
  if exists('g:__clap_forerunner_tempfile')
    call clap#filter#async#dyn#grep_from_tempfile(g:__clap_forerunner_tempfile)
  else
    call clap#filter#async#dyn#start_grep()
  endif
endfunction

function! s:grep2.init() abort
  if clap#maple#is_available()
    call clap#rooter#try_set_cwd()
    call clap#forerunner#start_subcommand(clap#maple#ripgrep_forerunner_subcommand())
  endif
endfunction

let s:grep2.sink = g:clap#provider#grep#.sink
let s:grep2['sink*'] = g:clap#provider#grep#['sink*']
let s:grep2.on_move = g:clap#provider#grep#.on_move
let s:grep2.enable_rooter = v:true
let s:grep2.support_open_action = v:true
let s:grep2.syntax = 'clap_grep'

let g:clap#provider#grep2# = s:grep2

let &cpoptions = s:save_cpo
unlet s:save_cpo
