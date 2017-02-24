getBiddersCount = ->
  subcategories_ids = $('#auction_auction_subcategories').val()
  category_id = $('#mechanism_category_id').val()
  $.post( "get_bidders_counter", {category_id: category_id, subcategories_ids: subcategories_ids}, (data) ->
    $("#bidders-counter").empty().append(data['bidders-counter']);
  ).fail( ->
    $("#bidders-counter").empty();
    console.log( "Произошла ошибка. Попробуйте позже." );
  )

$('#auction_auction_subcategories').change(getBiddersCount);

