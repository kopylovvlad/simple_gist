@CodeRedactor = 
  cm: null
  codemirror_redactor: (text_area, mode = 'ruby')->
    this.cm = CodeMirror.fromTextArea(text_area,
      lineNumbers: true
      mode: mode
    )
    self
  init_events: ()->
    _this = this
    $('#gist_lang_mode').on 'change', ()->
      _this.cm.toTextArea() if !!_this.cm
      _this.codemirror_redactor(
        document.getElementById('gist_body'),
        $(this).val()
      )

@CodeReader = 
  codemirror_reader: (text_area, mode = 'ruby')->
    this.cm = CodeMirror.fromTextArea(text_area,
      lineNumbers: true,
      readOnly: true,
      mode: mode
    )
    self

@Gists =
  init_all_gists: ()->
    elements = document.getElementsByClassName('gist_short_body')
    if elements.length > 0
      for elment in elements
        CodeReader.codemirror_reader(
          elment,
          elment.getAttribute('data-mode')
        )

$(document).ready ()->
  CodeRedactor.init_events()
  Gists.init_all_gists()