import "bootstrap";


import { setupInlineComments } from '../components/inline-comment'
if (document.querySelector('.post-container')) {
  setupInlineComments()
}

import nba from 'nba-api-client'

console.log(nba.getPlayerHeadshotURL({PlayerID: 201935, TeamID: 1610612745}));


