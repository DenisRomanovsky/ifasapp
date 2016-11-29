setSubcategories = ->
  category_id = $('#auction_mechanism_category_id').val()
  $.post( "update_subcategories", {category_id: category_id}, (data) ->
    $("#auction_mechanism_subcategory_id option").remove();
    setEmptyOption();
    $.each(data, (key, value) ->
      $('#auction_mechanism_subcategory_id').append($("<option></option>").attr("value",value['id']).text(value['description']));
    );
  ).fail( ->
    alert( "Произошла ошибка. Попробуйте позже." );
  )


setEmptyOption = ->
  $("#auction_mechanism_subcategory_id").prepend("<option value='' ></option>");


setEmptyOption();
$('#auction_mechanism_category_id').change(setSubcategories);

