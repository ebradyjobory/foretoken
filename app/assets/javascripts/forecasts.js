// $(document)
//   .delegate('#new-forecast-link, #new-forecast-attachment-link', 'ajax:success', function(e, data, status, xhr){
//     var $this = $(this),
//         $container = $('#new-forecast-links'),
//         $responseText = $(xhr.responseText),
//         $cancelButton = $responseText.find('#cancel-button');
//     $container.replaceWith($responseText)
//     $cancelButton.click(function(e){
//       $cancelButton.parent().replaceWith($container);
//       e.preventDefault();
//     });
//   })
//   .delegate('form[data-remote]', 'ajax:aborted:required', function(){
//     var $form = $(this),
//         errorDivId = 'ajax-validation-errors',
//         $errorDiv = $form.find('#' + errorDivId);
//     if ( ! $errorDiv.length ) {
//       $errorDiv = $('<div>', { id: errorDivId});
//       $form.prepend($errorDiv)
//     }
//     $errorDiv.html($('<h2>', {
//       text: 'You must fill in all required fields!'
//     }));
//   });

