/*global mermaid*/
// Initialize Mermaid.js
(function () {
    var configObject = {
        startOnLoad: true,
        securityLevel: "loose",
        htmlLabels: true,
        sequence: {
            useMaxWidth: false,
            width: 300
        },
        flowchart: {
            useMaxWidth: false
        }
    };
    mermaid.initialize(configObject);

    mermaid.init(undefined, "code.language-mermaid");
})();

// Initialize sidebar navigation scroll activation
(function () {
    var headings = document.querySelectorAll("h2");
    var tocLinks = document.querySelectorAll("nav.sidebar-nav .nav-subgroup.active .nav-leaf");
    
    var getPosition = function (el) {
        if (el) {
            var bodyRect = document.body.getBoundingClientRect();
            var elemRect = el.getBoundingClientRect();
            
            return elemRect.top - bodyRect.top;
        }
        
        return null;
    };
    
    window.addEventListener("scroll", function () {
        if (tocLinks.length > 0) {
            var activeLeaf = document.querySelector("nav.sidebar-nav .nav-leaf.active")
            var buffer = document.body.clientHeight * 0.1;
            var currentPos = window.pageYOffset + buffer;
    
            // TODO: Probably a stupid way to compute "how far left can we scroll until
            //       we reach the bottom of the page", but it seems to work.
            var scrollDistanceFromBottom = document.documentElement.scrollHeight
                - document.documentElement.scrollTop
                - document.body.clientHeight
                - buffer;
                
            const scrollNumber = [...headings].filter(heading => getPosition(heading) <= currentPos).length - 1;

            activeLeaf && activeLeaf.classList.remove("active")
    
            if (scrollNumber >= 0) {
                tocLinks[scrollNumber].classList.add("active");
            }
    
    
            if (scrollDistanceFromBottom <= 0) {
                activeLeaf && activeLeaf.classList.remove("active")
    
                tocLinks[tocLinks.length - 1].classList.add("active");
            }
        }
    });
})();

// Initialize Tipue search
(function() {
    $(document).ready(function () {
        $("#tipue_search_input").tipuesearch();
    });
})();
