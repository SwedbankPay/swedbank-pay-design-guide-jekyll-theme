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
    // From https://css-tricks.com/sticky-smooth-active-nav/
    var mainNavLinks = document.querySelectorAll('nav.doc-toc ul li a');
    var mainSections = document.querySelectorAll('.doc-container');

    var lastId;
    var cur = [];

    window.addEventListener('scroll', event => {
        let fromTop = window.scrollY;

        mainNavLinks.forEach(link => {
            let section = document.querySelector(link.hash);

            if (section.offsetTop <= fromTop &&
                section.offsetTop + section.offsetHeight > fromTop) {
                link.parentElement.classList.add('active');
            } else {
                link.parentElement.classList.remove('active');
            }
        });
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
});
