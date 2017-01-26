setSubcategories = ->
  category_id = $('#auction_mechanism_category_id').val()
  $.post( "update_subcategories", {category_id: category_id}, (data) ->
    $("#auction_auction_subcategories option").remove();
    #setEmptyOption();
    $.each(data, (key, value) ->
      $('#auction_auction_subcategories').append($("<option></option>").attr("value",value['id']).text(value['description']));
    );
  ).fail( ->
    alert( "Произошла ошибка. Попробуйте позже." );
  )


setEmptyOption = ->
  $("#auction_auction_subcategories").prepend("<option value='' ></option>");

$('#auction_mechanism_category_id').change(setSubcategories);

