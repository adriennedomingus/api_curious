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
      showHide('#all_repos', '#repo-wheel', items);
    }
  });
}

var renderMyCommits = function() {
  $.ajax({
    url: '/commits',
    success: function(data) {
      var items = eachCommit(data);
      showHide('#my_commits', '#commits-wheel', items);
    }
  });
}

var renderFollowingCommits = function() {
  $.ajax({
    url: '/following/commits',
    success: function(data) {
      var items = eachCommit(data);
      showHide('#following_commits', '#following-wheel', items);
    }
  });
}

var showHide = function(divId, wheelId, items) {
  $(divId).html(items.join(""));
  $(wheelId).addClass('hidden');
}

var eachCommit = function(data) {
  var items = [];
  $.each(data, function(key, commit) {
    items.push( "<tr> <td>" + commit.table.repo + "</td>" );
    items.push( "<td>" + commit.table.message + "</td> </tr>" );
  })
  return items;
}
