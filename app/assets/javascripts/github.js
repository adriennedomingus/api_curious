$(document).ready(function(){
  renderRepos();
  renderMyCommits();
  renderFollowingCommits();
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

var renderMyCommits = function() {
  $.ajax({
    url: '/commits',
    success: function(data) {
      var items = [];
      $.each(data, function(key, commit) {
         items.push("<tr>")
         items.push( "<td>" + commit.table.repo + "</td>" );
         items.push( "<td>" + commit.table.message + "</td>" );
         items.push("</tr>")
      })
      $('#my_commits').html(items.join(""));
      $('.spinning-wheel').addClass('hidden');
    }
  });
}

var renderFollowingCommits = function() {
  $.ajax({
    url: '/following/commits',
    success: function(data) {
      var items = [];
      $.each(data, function(key, commit) {
         items.push("<tr>")
         items.push( "<td>" + commit.table.repo + "</td>" );
         items.push( "<td>" + commit.table.message + "</td>" );
         items.push("</tr>")
      })
      $('#following_commits').html(items.join(""));
      $('.spinning-wheel').addClass('hidden');
    }
  });
}
