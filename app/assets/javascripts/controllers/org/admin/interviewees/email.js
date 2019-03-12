//= require ./new
//= require mustache

$('#email_history_category, #email_history_email_template').dropdown();

$("#email_history_from, #email_history_cc").dropdown({
    apiSettings: {
        url: '/my/member/search?q={query}',
    },
    fields: {
        name: 'email',
        value: 'email'
    }
});

$('#email_history_category').on('change', function () {
   $.get('search',{category: $("#email_history_category option:selected").text()}, function(result){
       $('#email_history_email_template').empty();
       if (result.status == 'error') {
           $('#email_history_email_template').val('');
           $('#email_history_subject').val('');
           $('#email_history_body').val('');
       } else {
           $.each(result.data, function (k,e) {
               $('#email_history_email_template').append('<option value="'+ e.id +'">'+ e.name +'</option>');
           });
           $('#email_history_email_template').change();
       }
   })
});

$('#email_history_email_template').on('change', function () {
   $.get('search',{email_tpl_id: $(this).val()}, function(result){
       if (result.status == 'success') {
           $('#attach-show').find('#from_email_tpl').parent().remove();
           data_info = result.data;
           var json_data = JSON.parse($("#json_data").html());
           var subject = Mustache.render(data_info.subject, json_data);
           var body = Mustache.render(data_info.body, json_data);
           $('#email_history_body').val(body);
           $('#email_history_subject').val(subject);
           if (data_info.file != undefined && data_info.file != null) {
               html_content = "<input type='hidden' name='has_tpl' value='1'/>";
               $('#attach-show').prepend('<div>'+ html_content +'<span>'+ data_info.file +'</span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" class = "remove_attach" id="from_email_tpl">remove</a></div>');
           }
       }
   });
});

$("#email_history_attachments").fileupload({
    singleFileUploads: false,
    method:'post',
    url:"add_attach",
    progressall: function (e, data) {
        progress_value = parseInt(data.loaded / data.total * 100, 10);
        $('#progress').children(':last').css("width", progress_value + "%").text(progress_value + "%");
    },
    done: function(e, data){
        $.each($('#attach-show').children(), function () {
           if ($(this).find('a').data('blob-id') != undefined) {
               $(this).remove();
           }
        });
        $.each(data.result, function (index, file) {
            $('#attach-show').append('<div><span>'+ file.name +'</span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" class = "remove_attach" data-blob-id="'+ file.blob_id +'" data-id="'+ file.id +'">remove</a></div>');
        });
    }
});

$('.segment').on('click', '.remove_attach', function (e) {
    e.preventDefault();
    var $a = $(this);
    var blob_id = $a.data('blob-id');
    var id = $a.data('id');
    if (blob_id != undefined) {
        $.get('remove_attach', {blob_id: blob_id, id: id}, function (data) {
            if (data.result == 'ok') {
                $a.parent().remove();
            }
        });
    } else {
        $a.parent().remove();
    }
});

