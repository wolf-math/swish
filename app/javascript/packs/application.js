import "bootstrap";


import { setupInlineComments } from '../components/inline-comment'
if (document.querySelector('.post-container')) {
  setupInlineComments()
}

import { setupPlayerFollowFilter } from '../components/player-follow-filter'
if (document.getElementById('player-follow-filter')) {
  setupPlayerFollowFilter()
}



// import nba from 'nba-api-client'


// console.log(nba.getPlayerHeadshotURL({PlayerID: 201935, TeamID: 1610612745}));


