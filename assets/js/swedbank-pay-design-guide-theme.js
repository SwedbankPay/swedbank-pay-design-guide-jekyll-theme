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

    if (tocLinks.length == 0) {
        var tocLinks = document.querySelectorAll("nav.sidebar-nav .nav-group.active .nav-leaf");
    }

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
            var activeLeaf = document.querySelector("nav.sidebar-nav .nav-leaf.active");
            var buffer = document.body.clientHeight * 0.1;
            var currentPos = window.pageYOffset + buffer;
    
            // TODO: Probably a stupid way to compute "how far left can we scroll until
            //       we reach the bottom of the page", but it seems to work.
            var scrollDistanceFromBottom = document.documentElement.scrollHeight
                - document.documentElement.scrollTop
                - document.body.clientHeight
                - buffer;
                
            const scrollNumber = [...headings].filter(heading => getPosition(heading) <= currentPos).length - 1;

            activeLeaf && activeLeaf.classList.remove("active");
            
            
            if (scrollDistanceFromBottom > 0) {
                scrollNumber >= 0 && tocLinks[scrollNumber].classList.add("active");
            } else {
                tocLinks[tocLinks.length - 1].classList.add("active");
            }
        }
    });
})();

// Simple sidebar functionality while dg.js is loaded

function _handleSimpleSidebar (e) {
    const target = e.target.parentElement.parentElement;

    if (target.tagName === "LI") {
        if (target.classList.contains("active")) {
            target.classList.remove("active")
        } else {
            const sidebar = document.querySelector(".sidebar");
            const closeElement = sidebar.querySelector(`.${target.classList[0]}.active`);

            closeElement && closeElement.classList.remove("active");

            target.classList.add("active");
        }
    }
}

(function () {
    const sidebar = document.querySelector(".sidebar");

    sidebar.addEventListener("click", _handleSimpleSidebar);
})();

// Remove simple sidebar functionality when proper sidebar functionality is loaded
(function () {
    document.addEventListener("DOMContentLoaded", (e) => {
        const sidebar = document.querySelector(".sidebar");

        sidebar.removeEventListener("click", _handleSimpleSidebar);
    });
})();

// Initialize Tipue search
(function() {
    $(document).ready(function () {
        $("#tipue_search_input").tipuesearch();
    });
})();
