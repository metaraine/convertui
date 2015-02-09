(function() {
  $(function() {
    var output, outputOuterHeight;
    output = $('#output');
    outputOuterHeight = output.height() + parseInt(output.css('padding-top')) * 2;
    $("#fine-uploader").fineUploader({
      request: {
        endpoint: "/upload"
      }
    }).on('submitted', function(id, name) {
      var inputHeight;
      inputHeight = $('#input-and-convert').height();
      console.log(inputHeight);
      $('#input-and-convert').slideUp();
      return $('#output').animate({
        height: outputOuterHeight + inputHeight
      });
    }).on('complete', function(event, id, name, response) {
      return $('#output').val(response.output);
    });
    $('#form-convert').on('submit', function() {
      $.post('/convert', $(this).serialize(), function(data) {
        return $('#output').val(data);
      });
      return false;
    });
    $('#reset').on('click', function() {
      $('#input-and-convert').slideDown();
      $('#output').animate({
        height: outputOuterHeight
      });
      $('#input').val('');
      $('#output').val('');
      return false;
    });
    return $('.dropdown [role="menuitem"]').on('click', function() {
      var button, dropdown, hidden, value;
      dropdown = $(this).closest('.dropdown');
      hidden = dropdown.find('.dropdown-value');
      button = dropdown.find('button');
      value = $(this).text();
      button.html(value + ' <span class="caret"></span>');
      hidden.val(value);
      button.dropdown('toggle');
      return false;
    });
  });

}).call(this);
