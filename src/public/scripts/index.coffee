$ ->
	$("#fine-uploader").fineUploader
		request:
			endpoint: "/upload"
	.on 'complete', (event, id, name, response)->
		$('#output').val(response.output)

	$('#form-convert').on 'submit', ()->
		false
