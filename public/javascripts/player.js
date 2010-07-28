$(document).ready(function() {
	$('.button').click(function() {
		$.ajax({
		  url: $(this).attr('href'),
		  type: "PUT",
		  dataType: "script",
		});
		return false;
	});
	$('#volume_toggle').click(function() {
		$('#volume_container').toggle('slow');
		return false;
	});
	$('#song_slider').slider();
	$("#volume_slider").slider({
		orientation: "vertical",
		range: "min",
		min: 0,
		max: 100,
		value: $('#volume_slider').attr('alt'),
		change: function(event, ui) {
			$.get('/player/volume?volume='+ui.value);
		}
	});
});