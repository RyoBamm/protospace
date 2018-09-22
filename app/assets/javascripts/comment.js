$(function(){
$(document).on('turbolinks:load', function() {

  // 各種HTMLを作成
  function buildHTML(comment){
    var html = `<div class = "comment_wrapper" >
                  <div class = "comment_left">
                    <img alt="profile_photo" class="media-object" style="width: 64px; height: 64px;" src="${comment.user_avatar}">
                    <a href="user_path(${comment.prototype_id})">${comment.user_name}</a>
                  </div>
                  <div class = "comment_right" id = ${comment.id}>
                    <div class = "comment_text">
                      ${comment.content}
                    </div>
                    <a class="btn-default btn comment-edit" href="/prototypes/${comment.prototype_id}/comments/${comment.id}/edit">Edit</a>
                  </div>
                  <div class = "comment_bottom"></div>
                </div>`
    return html;
  }

  function buildEditHTML(comment){
    var html = `<textarea class="editCommentArea">${comment.content}</textarea>
                <a class="btn-default btn comment-cancel" href="/prototypes/${comment.prototype_id}/comments/${comment.id}">Cancel</a>
                <a class="btn-default btn comment-delete" href="/prototypes/${comment.prototype_id}/comments/${comment.id}">Delete</a>
                <a class="btn-default btn comment-update" href="/prototypes/${comment.prototype_id}/comments/${comment.id}">Update</a>`
    return html;
  }

  function buildUpdateHTML(comment){
    var html = `<div class = "comment_text">
                  ${comment.content}
                </div>
                <a class="btn-default btn comment-edit" href="/prototypes/${comment.prototype_id}/comments/${comment.id}/edit">Edit</a>`
    return html;
  }

  // 非ログインユーザーのフォーム送信時リダイレクト
  $('.redirect').on('click', function(e){
    e.preventDefault();
    window.location.href = '/users/sign_in';
  })

  // コメント新規投稿
  $('#new_comment').on('submit', function(e){
    e.preventDefault();
    var wordCount = $(".comment_form").val().length;
    if (wordCount != 0){
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
        $('.comments_area').animate({scrollTop:0},'slow')
      })
      .fail(function(){
        alert('エラーが発生しました');
      })
    } else {
      alert('1文字以上入力してください');
    }
  })

  // 編集画面を表示
  $(document).on('click', '.comment-edit', function(e){
    e.preventDefault();
    var url = $(this).attr('href');
    $.ajax({
      type: 'GET',
      url: url,
      dataType: 'json'
    })
    .done(function(comment){
      var comment_id = '#' + comment.id
      var edit_html = buildEditHTML(comment);
      $(comment_id).html(edit_html);
    })
  })

  // 編集をCANCEL
  $(document).on('click', '.comment-cancel',function(e){
    e.preventDefault();
    var url = $(this).attr('href');
    $.ajax({
      type: 'GET',
      url: url,
      dataType: 'json'
    })
    .done(function(comment){
      var comment_id = '#' + comment.id;
      var update_html = buildUpdateHTML(comment);
      $(comment_id).html(update_html);
    })
  })

  // 編集をUPDATE
  $(document).on('click', '.comment-update', function(e){
    e.preventDefault();
    var wordCount = $(".editCommentArea").val().length;
    if (wordCount != 0){
      var url = $(this).attr('href');
      var updateContent = $('.editCommentArea').val();
      $.ajax({
        type: 'PUT',
        url: url,
        data: {content: updateContent },
        dataType: 'json'
      })
      .done(function(comment){
        var comment_id = '#' + comment.id;
        var update_html = buildUpdateHTML(comment);
        $(comment_id).html(update_html);
      })
    } else {
      alert('1文字以上入力してください');
    }
  })

  // 編集をDELETE
  $(document).on('click', '.comment-delete',function(e){
    e.preventDefault();
    var url = $(this).attr('href');
    $.ajax({
      type: 'DELETE',
      url: url,
      dataType: 'json'
    })
    .done(function(comment){
      var comment_id = '#' + comment.id;
      var commentWrapper = $(comment_id).parent()
      $(commentWrapper).remove();
      alert('コメントを削除しました');
    })
  })
})
});
