# grid content tab builder
window.grid_audio_builder = (panel, editor)->
  form = $('<form>'+
      '<div class="form-group"><label class="control-label">'+I18n.t("mvm_js.audio.media")+'</label>
       <div class="group-input-fields-content input-group">
          <input type="url" class="form-control url_file" />
          <span class="input-group-addon btn_upload"><i class="fa fa-upload"></i> </span>
      </div>
      </div>'+
      '</form>');
  form.find(".url_file").val(panel.attr("data-url"))

  form_callback = (modal)->
    form.find(".btn_upload").click ->
      $.fn.upload_filemanager({
        formats: "audio",
        selected: (file) ->
          form.find('.url_file').val(file.url);
      })
      return false

  submit_form_callback = (modal) ->
    panel.attr("data-url", modal.find(".url_file").val())
    url = modal.find(".url_file").val()
    res = ''
    if url
        res = '<audio width="100%" controls src="'+url+'"></audio>'
    panel.html(res)
    modal.modal("hide")
    editor.trigger("auto_save")

  open_modal({title: I18n.t('mvm_js.audio.audio_form'), modal_size: "modal-lg", modal_settings: { keyboard: false, backdrop: "static" }, content: form, callback: form_callback, on_submit: submit_form_callback })
