/**
 * Author: Eftakhairul Islam <eftakhairul@gmail.com>
 *
 */


$(function() {

    $('#shorten-button').click(function() {
        $('.short_url').hide();

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
                        $('.short_url').show().text(data.mgs);
                    }
                }
            });
        }
    });
});