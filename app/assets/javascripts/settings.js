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
















