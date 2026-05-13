function attachMermaidDialogEvents() {
  document.querySelectorAll('svg[id^="mermaid-"]').forEach(function(svg) {
    if (!svg.classList.contains('mermaid-dialog-ready')) {
      svg.classList.add('mermaid-dialog-ready');
      svg.style.cursor = 'zoom-in';

      // Center the mermaid title text element in the inline diagram
      var titleTextEl = Array.from(svg.querySelectorAll('text')).find(function(t) {
        return parseFloat(t.getAttribute('y')) < 0;
      });
      if (titleTextEl) {
        var vb = svg.viewBox && svg.viewBox.baseVal;
        var midX = vb && vb.width ? (vb.x + vb.width / 2) : parseFloat(svg.getAttribute('width') || 0) / 2;
        titleTextEl.setAttribute('x', midX);
      }

      svg.addEventListener('click', function() {
        var dialogDiagram = document.getElementById('mermaidDialogDiagram');
        dialogDiagram.innerHTML = svg.outerHTML;

        var dialogTitle = document.getElementById('mermaid-dialog-title');

        // Check for mermaid title: rendered as <text> with negative y above the diagram
        var titleTextEl = Array.from(svg.querySelectorAll('text')).find(function(t) {
          return parseFloat(t.getAttribute('y')) < 0;
        });

        var diagramTitle = (titleTextEl && titleTextEl.textContent.trim())
          ? titleTextEl.textContent.trim()
          : null;

        dialogTitle.textContent = (diagramTitle) ? diagramTitle : 'Sequence diagram';

        // Open dialog directly
        var dialog = document.getElementById('mermaid-dialog');
        if (dialog && typeof dialog.showModal === 'function') {
          dialog.showModal();
        } else {
          // Fallback: toggle 'open' attribute if design-guide handles it
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
