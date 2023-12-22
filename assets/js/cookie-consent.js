function OptanonWrapper() { }

function activateClarity() {
    (function(c,l,a,r,i,t,y){
        c[a]=c[a]||function(){(c[a].q=c[a].q||[]).push(arguments)};
        t=l.createElement(r);t.async=1;t.src="https://www.clarity.ms/tag/"+i;
        y=l.getElementsByTagName(r)[0];y.parentNode.insertBefore(t,y);
    })(window, document, "clarity", "script", "jd3awxna38");
}

function inactivateClarityCookies() {
    deleteCookie("_clck");
    deleteCookie("_clsk");
}

function getCookie(name) {
    if (document.cookie.split(';').some(c => c.trim().startsWith(name + '='))) {
      return document.cookie.split(';').find(c => c.trim().startsWith(name + '='));
    }
    else
      return false;
}

function deleteCookie(name) {
    if (getCookie(name)) {
        document.cookie = name + "=;domain=.swedbankpay.com;path=/;expires=Thu, 01 Jan 1970 00:00:01 GMT";
    }
}

window.addEventListener("OneTrustGroupsUpdated", event => {
    if (event.detail.indexOf("C0002") !== -1)
      activateClarity();
    else
      inactivateClarityCookies();
});
