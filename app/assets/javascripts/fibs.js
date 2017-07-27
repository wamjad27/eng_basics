$(function () {
  $('#show_fib_container').hide();
  $('#new_fib_container').hide();
  $('#edit_fib_container').hide();

  // NEW
  $('#add_fib').on('click', function(event){
    event.preventDefault();
    clearNotifications()
    $('#new_fib_container').show();
    $('#show_fib_container').hide();
    $('#edit_fib_container').hide();
  });

  //CREATE
  $('#new_fib').on('click', function(event){
    event.preventDefault();
    clearNotifications();
    var space = $('#new_fib_space_input').val();

    $.ajax({
      type: "POST",
      url: "/fibs",
      data: {fib: {space: space}},
      dataType: "JSON"
    }).success(function(json){
      appendTable(json);
      $("#notice").html('Create success');
    }).error(function(response){
      var errorsContainer = $("#notice");
      $("<div/>", { text: response.responseText }).appendTo(errorsContainer);
    });

    return false;
  });

  //READ
  $(document).on('click', 'a.show-btn', function(event){
    event.preventDefault();
    clearNotifications()
    var fibId = $(this).data('id');

    $.ajax({
      type: "GET",
      url: "/fibs/"+fibId,
      dataType: "JSON"
    }).success(function(response){
      $('p#fib_id').text(response.id);
      $('p#fib_space').text(response.space);
      $('p#fib_sequence').text(response.fibs.replace(/\,/g,', ',));
      $('p#fib_sof').text(response.known_fibs_sum_of_squares);
      $('p#fib_created_at').text(response.created_at);
      $('#show_fib_container').show();
      $('#new_fib_container').hide();
      $('#edit_fib_container').hide();
    })
  });

  // EDIT
  $(document).on('click', 'a.edit-btn', function(event){
    event.preventDefault();
    clearNotifications()
    var fibId = $(this).data('fib-id');
    var fibSpace = $(this).data('fib-space');
    $('#edit_fib_space_input').val(fibSpace);
    $('#fib_id_hidden_input').val(fibId);
    $('#edit_fib_container').show();
    $('#new_fib_container').hide();
  });

  // UPDATE
  $('#update_fib').on('click', function(event){
    event.preventDefault();
    clearNotifications();
    var space = $('#edit_fib_space_input').val();
    var fibId = $('#fib_id_hidden_input').val();
    //TODO
    $.ajax({
      type: "PUT",
      url: "/fibs/"+fibId,
      data: {fib: {space: space}},
      dataType: "JSON"
    }).success(function(response){
      $('#fib_row_'+response.id).remove();
      appendTable(response);
      $("#notice").html('Update success');
    }).error(function(response){
      var errorsContainer = $("#notice");
      $("<div/>", { text: response.responseText }).appendTo(errorsContainer);
    });

    return false;
  });

  // DELETE
  $(document).on('click', 'a.delete-btn', function(event){
    event.preventDefault();
    clearNotifications();
    var rowId = $(this).data('id');
    $.ajax({
      type: "DELETE",
      url: "/fibs/"+rowId,
      dataType: "JSON"
    }).success(function(response){
      $('#fib_row_'+rowId).remove();
      $("#notice").html('Delete success');
    })
  });

  function appendTable(response) {
    var tableBody = $("#fibs_table tbody");
    var row = $("<tr id=fib_row_"+response.id+"/>");
    $("<td/>", { text: response.space }).appendTo(row);
    $("<td/>", { text: response.generated_fibs.join(', ') }).appendTo(row);
    $("<td/>", { text: response.known_fibs_sum_of_squares }).appendTo(row);
    $("<td/>", { html: '<a class="show-btn" data-id='+response.id+' href="#">Show</a>' }).appendTo(row);
    $("<td/>", { html: '<a class="edit-btn" data-fib-id='+response.id+' data-fib-space='+response.space+' href="#">Edit</a>' }).appendTo(row);
    $("<td/>", { html: '<a class="delete-btn" data-id='+response.id+' data-confirm="Are you sure?" href="#">Destroy</a>' }).appendTo(row);

    row.appendTo(tableBody);
  };

  function clearNotifications() {
    $("#notice").html('');
  };

  $('#cancel_form').on('click', function(event){
    event.preventDefault();
    clearNotifications()
    $('#edit_fib_container').hide();
    $('#new_fib_container').hide();
  });
});
