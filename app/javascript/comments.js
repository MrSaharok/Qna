$(document).on('turbolinks:load', function () {
    $('.new-comment').on('ajax:success', function (e) {
        let resourceName = e.detail[0]['commentable_type'].toLowerCase(),
            resourceId = e.detail[0]['commentable_id'],
            resourceContent = e.detail[0]['body'];

        $('textarea').val('');
        $(`#${resourceName}_${resourceId} .comments`).append('<div class="comment"><p>'+
            resourceContent + '</p></div>');
    })
        .on('ajax:error', function (e) {
            let errors = e.detail[0];

            $.each(errors, function (index, value) {
                $('.comment-errors').append('<p>' + index + ' ' + value + '<p>');
            })
        })
});
