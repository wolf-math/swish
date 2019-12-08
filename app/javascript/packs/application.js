import "bootstrap";
import nba from 'nba-api-client'

console.log(nba.getPlayerHeadshotURL({PlayerID: 201935, TeamID: 1610612745}));
