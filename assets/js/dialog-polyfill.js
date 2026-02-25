// Adds support for [data-dialog-close] buttons for native and polyfilled dialogs
(function() {
  document.addEventListener('click', function(e) {
    var target = e.target;
    if (target && target.closest('[data-dialog-close]')) {
      var dialog = target.closest('dialog');
      if (dialog && typeof dialog.close === 'function') {
        dialog.close();
      } else if (dialog) {
        dialog.removeAttribute('open');
      }
    }
  });
})();
