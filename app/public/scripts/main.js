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
    return $('#reset').on('click', function() {
      $('#input-and-convert').slideDown();
      $('#output').animate({
        height: outputOuterHeight
      });
      $('#input').val('');
      $('#output').val('');
      return false;
    });
  });

}).call(this);
