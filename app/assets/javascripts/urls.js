/**
 * Author: Eftakhairul Islam <eftakhairul@gmail.com>
 *
 */


//Send request for shortening the URL
$(function() {

    $('#shorten-button').click(function() {
        $('.short_url, .short_url_error').hide();

        if($('#url_url').val() == '') {
            $('#url_url').popover('toggle');
        } else {

            $.ajax({
                url: $('#new_url').attr('action') ,
                dataType: "json",
                type: 'POST',
                data: $('#new_url').serialize(),
                success: function(data) {
                    if(data.status == 'success') {
                        $('.short_url').show();
                        $('#short_url_input').val(data.mgs).focus().select();
                    } else {
                        $('.short_url_error').show().text(data.mgs);
                    }
                }
            });
        }
    });
});