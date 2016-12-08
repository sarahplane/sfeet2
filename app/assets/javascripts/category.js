var cancelEditCategory = function(category_id) {
  showCategory(category_id);
};

var editCategory = function(category_id) {
  setTimeout(function() {
      $('#category-row-' + category_id).find('.category-show').fadeOut(100);
  }, 200);
  setTimeout(function() {
    $('#category-row-'+ category_id).find('.category-edit').fadeIn(100);
  }, 400);
};

var showCategory = function(category_id) {
  setTimeout(function() {
      $('#category-row-' + category_id).find('.category-edit').fadeOut(100);
  }, 200);

  setTimeout(function() {
    $('#category-row-'+ category_id).find('.category-show').fadeIn(100);
  }, 400);
};
