$(function(){
  function buildHTML(comment){
    var html = `<div class = "comment_wrapper">
                  <div class = "comment_left">
                    <%= image_tag( ${@comment.user.avatar.thumb}, alt = "profile_photo", class = "media-object", style = "width: 64px; height: 64px;") %>
                    <%= link_to "${comment.user.name}", user_path(${comment.user}) %>
                  </div>

                  <div class = "comment_right">
                    <%= ${comment.content}%>
                    <% if current_user.id == ${comment.user_id} %>
                      <%= link_to 'Edit', "/prototypes/${comment.prototype_id}/edit", class = 'btn-default btn' %>
                    <% end %>
                  </div>
                  <div class = "comment_bottom"></div>
                </div>`
    return html;
  }
  $('#new_comment').on('submit', function(e){
    e.preventDefault();
    var formData = new FormData(this);
    var url = $(this).attr('action')
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(comment){
      console.log(comment);
      var html = buildHTML(comment);
      $('.comments_area').append(html)
      $('.comment_form').val('')
    })
    .fail(function(){
      alert('error');
    })
  })
});
