(function() {
  $(function() {
    $("#fine-uploader").fineUploader({
      request: {
        endpoint: "/upload"
      }
    }).on('complete', function(event, id, name, response) {
      return $('#output').val(response.output);
    });
    return $('#form-convert').on('submit', function() {
      $.post('/convert', $(this).serialize(), function(data) {
        return $('#output').val(data);
      });
      return false;
    });
  });

}).call(this);
