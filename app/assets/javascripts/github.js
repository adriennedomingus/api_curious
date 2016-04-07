$(document).ready(function(){
  renderRepos();

});

var renderRepos = function() {
  $.ajax({
    url: '/repositories',
    success: function(data) {
      var items = [];
      $.each(data, function(key, repository) {
         items.push( "<p>" + repository.table.name + "</p>" );
      })
      $('#all_repos').html(items.join(""));
      $('.spinning-wheel').addClass('hidden');
    }
  });
}
