import "bootstrap";
import nba from 'nba-api-client'

console.log(nba.getPlayerHeadshotURL({PlayerID: 1629606, TeamID: 1610612766}));
