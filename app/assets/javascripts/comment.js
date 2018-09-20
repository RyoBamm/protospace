$(function(){

  // HTMLを作成
  function buildHTML(comment){
    var html = `<div class = "comment_wrapper" >
                  <div class = "comment_left">
                    <img alt="profile_photo" class="media-object" style="width: 64px; height: 64px;" src="${comment.user_avatar}">
                    <a href="user_path(${comment.prototype_id})">${comment.user_name}</a>
                  </div>
                  <div class = "comment_right">
                    ${comment.content}
                    <a class="btn-default btn comment-edit" href="/prototypes/1/edit" >Edit</a>
                  </div>
                  <div class = "comment_bottom"></div>
                </div>`
    return html;
  }

  $('.redirect').on('click', function(e){
    e.preventDefault();
    window.location.href = new_user_session_path;
  })

  // コメント新規投稿
  $('#new_comment').on('submit', function(e){
    e.preventDefault();
    var formData = new FormData(this);
    var url = $(this).attr('action');
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(comment){
      var html = buildHTML(comment);
      $(html).insertBefore('.comment_wrapper:first');
      $('.comment_form').val('')
    })
    .fail(function(){
      alert('error');
    })
  })

  // 編集画面を表示
  $('.comment-edit').on('click', function(e){
    e.preventDefault();
    console.log(this);
  })


});
