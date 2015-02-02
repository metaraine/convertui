$ ->
	output = $('#output')
	outputOuterHeight = output.height() + parseInt(output.css('padding-top')) * 2

	$("#fine-uploader").fineUploader
		request:
			endpoint: "/upload"

	.on 'submitted', (id, name)->
		inputHeight = $('#input-and-convert').height()
		console.log inputHeight
		$('#input-and-convert').slideUp()
		$('#output').animate
			height: outputOuterHeight + inputHeight

	.on 'complete', (event, id, name, response)->
		$('#output').val(response.output)

	$('#form-convert').on 'submit', ()->
		$.post '/convert', $(this).serialize(), (data)->
			$('#output').val(data)
		false

	$('#reset').on 'click', ()->
		$('#input-and-convert').slideDown()
		$('#output').animate
			height: outputOuterHeight
		$('#input').val('')
		$('#output').val('')
		false
