// Initialize Mermaid.js
(function() {
    mermaid.initialize({
        startOnLoad: true,
        securityLevel: 'loose',
        htmlLabels: true,
        sequence: {
            useMaxWidth: false,
            width: 300
        },
        flowchart: {
            useMaxWidth: false
        }
    });

    mermaid.init(undefined, 'code.language-mermaid');
})();

// Initialize sidebar navigation scroll activation
(function() {
    var headings = document.querySelectorAll("h2");
    var tocLinks = document.querySelectorAll("nav.doc-toc ul li a");

    var getPosition = function(el) {
      if (el) {
        const bodyRect = document.body.getBoundingClientRect();
        const elemRect = el.getBoundingClientRect();

        return elemRect.top - bodyRect.top;
      }

      return null;
    };

    window.addEventListener("scroll", function() {
        var currentPos = window.pageYOffset + 150;

        for (var i = 0; i < headings.length; i++) {
            var heading = headings[i];
            var headingPos = getPosition(heading);
            var nextHeadingPos = getPosition(headings[i + 1]);

            if (currentPos > headingPos && currentPos < nextHeadingPos) {
                for (var link of tocLinks) {
                  link.parentElement.classList.remove("active");
                }

                tocLinks[i].parentElement.classList.add("active");
                return;
            }
        }
    });
})();

// Inititialize Prism.js
(function() {
    if (typeof self === 'undefined' || !self.Prism || !self.document || !document.querySelector) {
        return;
    }

    var preElements = document.querySelectorAll('.highlighter-rouge:not(.language-mermaid) pre.highlight, code[class*="language"]:not(.language-mermaid)');

    // TODO: Replace with https://github.com/PrismJS/prism/pull/2074 once it's in production.
    for (var preElement of preElements) {
        Prism.highlightElement(preElement, false);
    }
})();
