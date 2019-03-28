// document.getElementByID('update_players').onclick = (alert("hi"));

$(document).on("click", "#update_password", function(){
    $(location).attr('href', "/settings/password");
});

$(document).on("click", "#update_name", function(){
    $(location).attr('href', "/settings/name");
});

$(document).on("click", "#update_players", function(){
    $(location).attr('href', "/settings/players");
});

$(document).on("click", "#update_groups", function(){
    $(location).attr('href', "/settings/groups");
});

$(document).on("click", "#settings", function(){
    $(location).attr('href', "/settings");
});

$(document).on("click", ".remove_player", function(){
	var player = ($.trim($(this).parent().siblings().text()));
	if (confirm('Are you sure you want to remove ' + player + '?')) {
    	$.ajax({
            url : "/settings/players",
            type : "patch",
            data : { 
                name: player,
                active: false
            }
        });
        //$(location).attr('href', "/settings/players");

	} else {
    // Do nothing!
	}
});

$(document).on("click", ".add_player", function(){
    var player = ($.trim($(this).parent().siblings().text()));
    $.ajax({
        url : "/settings/players",
        type : "patch",
        data : { 
            name: player,
            active: true
        }
    });
    $(location).attr('href', "/settings/players");
});


$(document).on("click", ".show-inactive", function(){
    var seeDiv = $("#inactive_player_list").is(":visible");
    var expand = "Show inactive players <span class=\"glyphicon glyphicon-chevron-down show-inactive\"></span>";
    var contract = "Show inactive players <span class=\"glyphicon glyphicon-chevron-right show-inactive\"></span>";

    if(seeDiv){
        $("#show_inactive_message").html(contract);    
    }
    else{
        $("#show_inactive_message").html(expand);   
    }
    $("#inactive_player_list").slideToggle();
    
});

$(document).on("click", ".remove_group", function(){
    
    var group = ($.trim($(this).parent().siblings().text()));
    if (confirm('Are you sure you want to remove ' + group + '?')) {
        $.ajax({
            url : "/settings/groups",
            type : "delete",
            data : { 
                name: group
            }
        });
        $(location).attr('href', "/settings/groups");

    } else {
    // Do nothing!
    }
});

var currentPlayers = [];
var availablePlayers = [];
var groups = [];
var groupName = "";
var selectedPlayers = [];
var selectedExpansions = [];

$(document).on("click", ".edit_group", function(){
    groupName = ($.trim($(this).parent().siblings().text()));
    groups = $('.temp_information').data('temp')
    var groupSize = groups.length;

    for(var i=0; i<groupSize; i++){
        if(groupName == groups[i][0]){
            currentPlayers = groups[i][1];
            availablePlayers = groups[i][2];
        }
    }
    generateCurrentPlayersHTML(currentPlayers, "edit");
    generateAvailablePlayersHTML(availablePlayers);

});

//send the edited group to the controller to be saved to the db
$(document).on("click", ".save_group", function(){
    if (confirm('Are you sure you want to save changes to ' + groupName + '?')) {
        $.ajax({
            url : "/settings/groups",
            type : "patch",
            data : { 
                name: groupName,
                players: currentPlayers
            }
        });
        generateCurrentPlayersHTML(currentPlayers, "edit");
        generateAvailablePlayersHTML(availablePlayers);

    } else {
    // Do nothing!
    }
});

$(document).on("click", ".remove-player-from-group", function(){
    var playerName = ($.trim($(this).parent().siblings().text()));
    updatePlayer(playerName, "remove");
});

$(document).on("click", ".add-player-to-group", function(){
    var playerName = ($.trim($(this).parent().siblings().text()));
    updatePlayer(playerName, "add");
});

//selects a group on the player select screen
$(document).on("click", ".select-group", function(){
    $("#all-expansions").hide();
    selectedPlayers = [];
    groups = $('.temp_information').data('temp')
    groupName = ($.trim($(this).text()));
    groupSize = groups.length;
    selectedExpansions = [];
    for(var i=0; i<groupSize; i++){
        if(groupName == groups[i][0]){
            currentPlayers = groups[i][1];
        }
    }
    generateCurrentPlayersHTML(currentPlayers, "select")
});

//moves selected players to the selectedPlayers array for games and highlights accordingly
$(document).on("click", ".individual-player",function(){
    player = $.trim($(this).text());
    if ($(this).hasClass('orange-background')){
        $(this).removeClass('orange-background');
        $(this).addClass('highlight-blue');
        i = (selectedPlayers.indexOf(player));
        selectedPlayers.splice(i,1);
    }
    else{
        $(this).addClass('orange-background');
        $(this).removeClass('highlight-blue');
        selectedPlayers.push(player);
    }
    var seeDiv = $("#all-expansions").is(":visible");
    if(selectedPlayers.length > 1){
         if(!seeDiv){
            $("#all-expansions").slideToggle();
        }
    }
    else if(selectedPlayers.length < 2){
        if(seeDiv){
            $("#all-expansions").slideToggle();
        }
    }
});

$(document).on("click", ".select-expansion", function(){
    var expansion = $.trim($(this).text());
    if ($(this).hasClass('orange-background')){
        $(this).removeClass('orange-background');
        $(this).addClass('highlight-blue');
        i = (selectedExpansions.indexOf(expansion));
        selectedExpansions.splice(i,1);
    }
    else{
        $(this).addClass('orange-background');
        $(this).removeClass('highlight-blue');
        selectedExpansions.push(expansion);
    }
    if(selectedExpansions.length < 1){
        $(".confirm-expansions").hide();
    }
    else{
        $(".confirm-expansions").show();   
    }
});

$(document).on("click", ".confirm-expansions", function(){
    var gameName = $('.temp_information').data('game');
    $.ajax({
        url : "/games/setup",
        type : "post",
        data : { 
            game: gameName,
            players: selectedPlayers,
            finalExpansions: selectedExpansions
        }
    });
});

//stats
$(document).on("click", ".select-stat-group", function(){
    allStats = $('.stat-info').data('stats');
    records = $('.stat-info').data('records');
    groupNames = allStats[0];
    groupPlayers = allStats[1];
    columns = allStats[2];
    groupName = $.trim($(this).text());
    selectedGroup = -1;
    for(var i=0; i<groupNames.length; i++){
        if (groupName == groupNames[i]){
            selectedGroup = i;
        }
    }
    generateStatsHTML(groupNames[selectedGroup], groupPlayers[selectedGroup], columns);
    generateRecordsHTML(records[selectedGroup]);
    generateHistoryHTML(history);
});

//used to show the players assigned to a group
//status "edit" is used on the settings screen to add or remove players from groups
//status "select" is used on the players select screen of the games, does not add the edit buttons
function generateCurrentPlayersHTML(currentPlayers, status) {
    var htmlString = "Group: <b>" + groupName + "</b>";
    for(var i=0; i<currentPlayers.length; i++){
        if (status == "edit"){
            htmlString += "<div class=\"highlight-blue blue-bordered\">";
        }
        else if(status == "select"){
            htmlString += "<div class=\"highlight-blue blue-bordered individual-player\">";
        }
        htmlString += "<div class=\"left\">";
        htmlString += currentPlayers[i];
        htmlString += "</div>";
        if (status == "edit"){
            htmlString += "<div class=\"right\">";
            htmlString += "<span class=\"glyphicon glyphicon-remove remove_item_icon remove-player-from-group\"> </span>";
            htmlString += "</div>";
        } 
        htmlString += "<br>";
        htmlString += "</div>";
        
    }
    document.getElementById("current-players").innerHTML = htmlString;
 }

function generateStatsHTML(groupName, players, columns){
    var htmlString = "<table style=\"width: 100%\"><tr>";
    for(c=0; c<columns.length; c++){
        htmlString += "<th style=\"text-align: center;\">";
        htmlString += columns[c];
        htmlString += "</th>"
    }    
    for(p=0; p<players.length; p++){
        htmlString += "<tr>"
        for(d=0; d<columns.length; d++){
            htmlString += "<td>"
            htmlString += players[p][d]
            htmlString += "</td>"
        }
        htmlString += "</tr>"
    }
    htmlString += "</tr></table>"

    document.getElementById("player-stats").innerHTML = htmlString;
}

function generateRecordsHTML(records){
    var htmlString = "";
    for(i=0; i<records.length; i++){
        htmlString += records[i][2] + " " + records[i][0] + " - " + records[i][1];
        htmlString += "<br>"
    }
    document.getElementById("player-records").innerHTML = htmlString;   
}


//used to show the available players not currently assigned to a group
function generateAvailablePlayersHTML(availablePlayers) {
    var htmlString = "";
    for(var i=0; i<availablePlayers.length; i++){
        htmlString += "<div class=\"highlight-blue blue-bordered\">";
        htmlString += "<div class=\"left\">";
        htmlString += availablePlayers[i];
        htmlString += "</div>";
        htmlString += "<div class=\"right\">";
        htmlString += "<span class=\"glyphicon glyphicon-plus add_item_icon add-player-to-group\"> </span>";
        htmlString += "</div>"; 
        htmlString += "<br>";
        htmlString += "</div>";
    }
    document.getElementById("available-players").innerHTML = htmlString;
 }

//remove or add a player to the current players array
function updatePlayer(player, status) {

    var i = -1;

    if(status == "remove"){
        i = (currentPlayers.indexOf(player));
        currentPlayers.splice(i,1);
        availablePlayers.push(player);
        generateCurrentPlayersHTML(currentPlayers, "edit");
        generateAvailablePlayersHTML(availablePlayers);       
    }
    else if(status == "add"){
        i = (availablePlayers.indexOf(player));
        availablePlayers.splice(i,1);
        currentPlayers.push(player);
        generateCurrentPlayersHTML(currentPlayers, "edit");
        generateAvailablePlayersHTML(availablePlayers);  
    }

}

//SevenWonders



