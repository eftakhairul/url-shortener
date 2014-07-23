/**
 * Author: Eftakhairul Islam <eftakhairul@gmail.com>
 *
 */


$(function() {

    $('#shorten-button').click(function() {

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
                        $('#url').val(data.url);
                    } else {
                        $('#url').val(data.mgs);
                    }
                }
            });
        }
    });
});