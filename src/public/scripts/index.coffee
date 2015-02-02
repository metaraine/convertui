$ ->
	$("#fine-uploader").fineUploader
		request:
			endpoint: "/upload"
	.on 'complete', (event, id, name, response)->
		$('#output').val(response.output)

	$('#form-convert').on 'submit', ()->
		$.post '/convert', $(this).serialize(), (data)->
			$('#output').val(data)
		false
