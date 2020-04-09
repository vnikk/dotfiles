// ==UserScript==
// @name         Workaround for Google I'm Feeling Lucky Redirect
// @namespace    http://qria.net/
// @version      0.1
// @description  Immediately redirects when google prompts 'redirection notice'. Used to circumvent google pestering you when querying with I'm Feeling Lucky feature.
// @author       Qria
// @include      https://www.google.com/url?*
// @grant        none
// ==/UserScript==

(function() {
    'use strict';

    function getJsonFromUrl() {
        // From: https://stackoverflow.com/a/8486188
        const url = location.search;
        const query = url.substr(1);
        const result = {};
        query.split("&").forEach(function(part) {
            var item = part.split("=");
            result[item[0]] = decodeURIComponent(item[1]);
        });
        return result;
    }

    window.location = getJsonFromUrl().q;
})();