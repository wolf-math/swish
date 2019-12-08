//= require rails-ujs
//= require_tree .

// nba.teamDetails({TeamID: 1610612745}).then(function(data){
//   console.log(data)
// })
// getDataFromNBA = (params, endpoint, options) => {
//   var headers = {
//     "Accept-Encoding": "Accepflate, sdch",
//     "Accept-Language": "he-IL,he;q=0.8,en-US;q=0.6,en;q=0.4",
//     "Cache-Control": "max-age=0",
//     Connection: "keep-alive",
//     Host: "stats.nba.com",
//     Referer: "http://stats.nba.com/",
//     "User-Agent":
//     "PostmanRuntime/7.4.0"
//   };

//   var url = generateURL(params, endpoint);

//   return new Promise(function(resolve, reject){
//     if(typeof window === 'undefined'){
//       axios.get(url, {headers}).then(function(res){
//         resolve(formatData(res.data, options))
//       }).catch(function(err){
//         reject(err)
//       });
//     } else {
//       jsonp(url, null, (err, data) => {
//         if(!err) resolve(formatData(data, options))
//           else reject(err)
//         });
//     }
//   });
