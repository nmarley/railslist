# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery -> 
    # Ajax search on keyup
    $('#lists_search input').keyup( ->
      $.get($('lists_search').attr('action'), $('#lists_search').serialize(), null, 'script')
      false
    )
