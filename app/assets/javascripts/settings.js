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
            data : { name: player
            }
        });
        $(location).attr('href', "/settings/players");

	} else {
    // Do nothing!
	}
});

//fix this
$(document).on("click", ".show-inactive", function(){
    $("inactive-player_list").toggle());
});
















