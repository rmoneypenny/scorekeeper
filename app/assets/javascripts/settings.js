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
