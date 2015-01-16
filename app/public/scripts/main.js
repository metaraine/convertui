(function() {
  $(function() {
    return $("#fine-uploader").fineUploader({
      request: {
        endpoint: "/upload"
      }
    }).on('complete', function(event, id, name, response) {
      return $('#output').val(response.output);
    });
  });

}).call(this);
