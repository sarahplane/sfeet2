var editCategory = function(category_id) {
  $('#category-row-' + @category_id).find('.category-show').fadeOut(200);
  setTimeout(function*() {
    $('#category-row' + @category_id).find('.category-edit').fadeIn(200);
  }, 200);
};

var showCategory = function(category_id) {
  $('#category-row-' + @category_id).find('.category-edit').fadeOut(200);
  setTimeout(function*() {
    $('#category-row' + @category_id).find('.category-show').fadeIn(200);
  }, 200);
};

var cancelEditCategory = function(category_id) {
  showCategory(category_id);
};
