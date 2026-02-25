function attachMermaidDialogEvents() {
  document.querySelectorAll('svg[id^="mermaid-"]').forEach(function(svg) {
    if (!svg.classList.contains('mermaid-dialog-ready')) {
      svg.classList.add('mermaid-dialog-ready');
      svg.style.cursor = 'zoom-in';
      svg.addEventListener('click', function() {
        var dialogDiagram = document.getElementById('mermaidDialogDiagram');
        dialogDiagram.innerHTML = svg.outerHTML;
        // Öppna dialogen direkt
        var dialog = document.getElementById('mermaid-dialog');
        if (dialog && typeof dialog.showModal === 'function') {
          dialog.showModal();
        } else {
          // Fallback: toggla 'open' attribut om design-guide hanterar det
          dialog.setAttribute('open', '');
        }
      });
    }
  });
}

document.addEventListener('DOMContentLoaded', function() {
  if(window.mermaid) {
    mermaid.init(undefined, '.mermaid');
    setTimeout(attachMermaidDialogEvents, 500);
  } else {
    attachMermaidDialogEvents();
  }
});

const observer = new MutationObserver(function() {
  attachMermaidDialogEvents();
});
observer.observe(document.body, { childList: true, subtree: true });
