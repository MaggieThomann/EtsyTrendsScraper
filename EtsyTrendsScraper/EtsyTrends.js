var EtsyTrends = (function() {
				  function assertEtsyTitle() {
				  return document.title == "Etsy.com | Shop for anything from creative people everywhere";
				  }
				  function checkTrends() {
				  document.getElementById("search-query").focus();
				  document.getElementById("search-query").select();
				  var trendingList = document.querySelectorAll('[data-is-trending=true]');
				  
				  var trends = [];
				  for (i = 0; i < trendingList.length; ++i) {
				  trendHTML=trendingList[i].innerText;
				  try{
				  trends.push(trendHTML);
				  }
				  catch(err){
				  trends.push("error")
				  continue;
				  }
				  }
				  return trends;
				  }
				  function getTrendResults() {
				  print(document)
				  var lis = document.getElementById("search-suggestions")
				  print(lis)
				  return lis
				  }
				  return {
				  assertEtsyTitle: assertEtsyTitle,
				  checkTrends: checkTrends,
				  getTrendResults : getTrendResults
				  };
})()
