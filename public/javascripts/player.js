$(document).ready(function() {
	buttons();
	ping_interval = false;
	slide = false;
	$("#tabs").tabs({
		ajaxOptions:{
			complete: function(){
				buttons();
				$("#playlist").sortable({
					start: function(event, ui){
						old_id = parseInt($(ui.item).find(".id").text());
					},
					stop: function(event, ui){
						new_id = parseInt($(ui.item).find("~p").first().find(".id").text());
						if(new_id > old_id){
							--new_id;
						}
						$.post("/playlist/move_song",{
							from: old_id, to: new_id },
							function(data){
								alert("post");
								$("#library_wrapper").replaceWith(data);
							}
						);
					}
				});
			},
			error: function(xhr, status, index, anchor){
				$(anchor.hash).html("Couldn't load this tab.");
			}
		}
	});

	$("#song_slider").slider({
		min: 0,
		max: parseInt($("#song_slider").attr("data-max")),
		value: parseInt($("#song_slider").attr("data-value")),
		slide: function(event, ui){
			clearInterval(ping_interval);
			slide = true;
		},
		change: function(event, ui){
			if(slide){
				$.ajax({
					url: "player/seek",
					type: "PUT",
					dataType: "script",
					data: {time: ui.value}
				});
				// ping_interval = setInterval("ping()",1000);
				slide = false;
			}
		}
	});

	$("body").delegate(".button", "click", function(e){
		$(this).attr('data-method') ? method = $(this).attr('data-method') : method = "GET";
		$.ajax({
		  url: $(this).attr('href'),
		  type: method,
		  dataType: "script",
		});
		e.preventDefault();
	});

	$("body").delegate(".delete_song", "click", function(e){
		$.ajax({
			url: $(this).attr("href"),
			type: "DELETE",
			dataType: "script",
			success: function(data) {
			    $("#library_wrapper").replaceWith(data);
			 }
		});
		e.preventDefault();
	});

	$("body").delegate("#song_search", "submit", function(e){
		$.post('/song_search',$(this).serialize(),
		 function(data){
			$("#results").html(data);
			buttons();
		});
		
		e.preventDefault();
	});

	$("body").delegate("#play_pause", "click", function(e){
		if($(this).text() == "Play"){
			button_text = "Pause";
			icon = "ui-icon-pause"
			$(this).attr("href","/player/pause");
		}
		else{
			button_text = "Play";
			icon = "ui-icon-play";
			$(this).attr("href","/player/play");
		}
		options = {
			text: false,
			label: button_text,
			icons:{
				primary: icon
			}
		};
		$(this).button('option', options);
		e.preventDefault();
	});
	//ping_interval = setInterval('ping()',1000);
});
function buttons(){
	$(".play").button({
		text: false,
		icons:{
			primary: "ui-icon-play"
		}
	});

	$(".delete_song").button({
		text: false,
		icons:{
			primary: "ui-icon-close"
		}
	});

	$("#play_pause").text() == "Play" ? icon = "ui-icon-play" : icon = "ui-icon-pause";

	options = {
		text: false,
		icons:{
			primary: icon
		}
	};

	$("#play_pause").button(options);

	$("#stop").button({
		text: false,
		icons:{
			primary: "ui-icon-stop"
		}
	});

	$("#prev").button({
		text: false,
		icons:{
			primary: "ui-icon-seek-prev"
		}
	});

	$("#next").button({
		text: false,
		icons:{
			primary: "ui-icon-seek-next"
		}
	});

	$("#volume_down").button({
		text: false,
		icons:{
			primary: "ui-icon-volume-off"
		}
	});
	
	$("#volume_up").button({
		text: false,
		icons:{
			primary: "ui-icon-volume-on"
		}
	});

	$("#clear_playlist").button({
		icons:{
			primary: "ui-icon-close"
		}
	});

	$("#song_search_submit").button({
		icons:{
			primary: "ui-icon-search"
		}
	});

	$(".add_to_playlist").button({
		icons:{
			primary: "ui-icon-plusthick"
		}
	});
}

function ping(){
	$.ajax({
	  url: '/player/ping',
	  type: "GET",
	  dataType: "script",
	});
}