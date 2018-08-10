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
        $(location).attr('href', "/settings/players");

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
var groupName = "";

$(document).on("click", ".edit_group", function(){
    
    var groupName = ($.trim($(this).parent().siblings().text()));
    var groups = $('.temp_information').data('temp')
    var groupSize = groups.length;

    for(var i=0; i<groupSize; i++){
        if(groupName == groups[i][0]){
            currentPlayers = groups[i][1];
            availablePlayers = groups[i][2];
        }
    
    generateCurrentPlayersHTML(currentPlayers);
    generateAvailablePlayersHTML(availablePlayers);

    }

    //$(alert(generateCurrentPlayersHTML(currentPlayers)));
    //$(alert(group));
    // if (confirm('Are you sure you want to remove ' + group + '?')) {
    //     $.ajax({
    //         url : "/settings/groups",
    //         type : "delete",
    //         data : { 
    //             name: group
    //         }
    //     });
    //     $(location).attr('href', "/settings/groups");

    // } else {
    // // Do nothing!
    // }
});

function generateCurrentPlayersHTML(currentPlayers) {
    var htmlString = "";
    for(var i=0; i<currentPlayers.length; i++){
        htmlString += "<div class=\"highlight-blue blue-bordered\">";
        htmlString += "<div class=\"left\">";
        htmlString += currentPlayers[i];
        htmlString += "</div>";
        htmlString += "<div class=\"right\">";
        htmlString += "<span class=\"glyphicon glyphicon-remove remove_item_icon\"> </span>";
        htmlString += "</div>"; 
        htmlString += "<br>";
        htmlString += "</div>";
        
    }
    document.getElementById("current-players").innerHTML = htmlString;
 }

function generateAvailablePlayersHTML(availablePlayers) {
    var htmlString = "";
    for(var i=0; i<availablePlayers.length; i++){
        htmlString += "<div class=\"highlight-blue blue-bordered\">";
        htmlString += "<div class=\"left\">";
        htmlString += availablePlayers[i];
        htmlString += "</div>";
        htmlString += "<div class=\"right\">";
        htmlString += "<span class=\"glyphicon glyphicon-plus add_item_icon\"> </span>";
        htmlString += "</div>"; 
        htmlString += "<br>";
        htmlString += "</div>";
    }
    document.getElementById("available-players").innerHTML = htmlString;
 }







