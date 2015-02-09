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

	$('#form-convert').on 'submit', ->
		$.post '/convert', $(this).serialize(), (data)->
			$('#output').val(data)
		false

	$('#reset').on 'click', ->
		$('#input-and-convert').slideDown()
		$('#output').animate
			height: outputOuterHeight
		$('#input').val('')
		$('#output').val('')
		false

	# dropdowns
	$('.dropdown [role="menuitem"]').on 'click', ->

		# get elements
		dropdown = $(this).closest('.dropdown')
		hidden = dropdown.find('.dropdown-value')
		button = dropdown.find('button')

		# get the value of the selected item
		value = $(this).text()

		# set the value of the button to the selected item's text
		button.html(value + ' <span class="caret"></span>')

		# set the value of the hidden input to the selected item's text
		hidden.val(value)

		# disable the dropdown
		button.dropdown('toggle')

		false

