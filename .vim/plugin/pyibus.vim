" vim:set sts=2 sw=2 tw=0 et:

"scriptencoding utf-8
"
"function! s:IsEnable()
"  " Check version (and patch)
"  if !(v:version == 703 && has('patch1248') || v:version >= 704)
"    return 0
"  end
"  " Check python
"  if !(has('python') || has('python3'))
"    return 0
"  end
"  return 1
"endfunction
"
"if !s:IsEnable()
"  finish
"end
"
"if has('python3')
"
"python << END
"import ibus
"class PyIbus:
"    BUS = ibus.Bus()
"    @staticmethod
"    def get():
"        ic = ibus.InputContext(PyIbus.BUS, PyIbus.BUS.current_input_contxt())
"        if ic.is_enabled():
"            return 1
"        else:
"            return 0
"    @staticmethod
"    def set(v):
"        ic = ibus.InputContext(PyIbus.BUS, PyIbus.BUS.current_input_contxt())
"        if v:
"            ic.enable()
"        else:
"            ic.disable()
"        return 0
"END
"
"  function! PyIbusGet()
"    return py3eval('PyIbus.get()')
"  endfunction
"
"  function! PyIbusSet(active)
"    return py3eval('PyIbus.set('.a:active.')')
"  endfunction
"
"elseif has('python')
"
"python << END
"import ibus
"class PyIbus:
"    BUS = ibus.Bus()
"    @staticmethod
"    def get():
"        ic = ibus.InputContext(PyIbus.BUS, PyIbus.BUS.current_input_contxt())
"        if ic.is_enabled():
"            return 1
"        else:
"            return 0
"    @staticmethod
"    def set(v):
"        ic = ibus.InputContext(PyIbus.BUS, PyIbus.BUS.current_input_contxt())
"        if v:
"            ic.enable()
"        else:
"            ic.disable()
"        return 0
"END
"
"  function! PyIbusGet()
"    return pyeval('PyIbus.get()')
"  endfunction
"
"  function! PyIbusSet(active)
"    return pyeval('PyIbus.set('.a:active.')')
"  endfunction
"endif
"
"function! s:PyIbusInit()
"  set imactivatefunc=PyIbusSet
"  set imstatusfunc=PyIbusGet
"endfunction
"
"augroup PyIbus
"  autocmd!
"  autocmd GUIEnter * call <SID>PyIbusInit()
"augroup END
"
