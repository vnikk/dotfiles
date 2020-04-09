// ==UserScript==
// @name        unfix-all-the-toolbars
// @description Removes "position: fixed" style from elements, unfixing "toolbars" and the such.
// @namespace   http://inf.ufrgs.br/~vbuaraujo/
// @include     *
// @version     1.2
// @grant       none
// ==/UserScript==


/* 
Based on https://stackoverflow.com/questions/13696100/greasemonkey-script-to-make-fixed-positioned-elements-static

v1.0 2015-02-17: Original version.
v1.1 2016-05-01: Added the styleWidth threshold heuristic.
v1.2 2018-01-03: Adding removal of position property to override !important rules as well

The big problem here is we want to avoid unfixing *all* "position: fixed"
elements, because some of them are fake popup windows which become quite
unusable if you change them to "position: static". So we need some heuristic
to distinguish "legitimate" fixed elements from gratuitous ones like navbars.
*/

function numPixels(str) {
  if (str.endsWith("px"))
    return Number(str.slice(0, -2));
  else {
    console.log("unfix-all-the-toolbars: Computed width is not in pixels! " + width);
    return null;
  }
}

function unfixAll() {
  var bodyStyle = window.getComputedStyle(document.body);
  var pageWidth = numPixels(bodyStyle.width);
  var pageHeight= numPixels(bodyStyle.height);
  var toolbarWidthThreshold = 0.8 * pageWidth;
  
  Array.forEach(
    /* Assorted selection of likely fixed elements, to avoid querying all elements */
    document.querySelectorAll("h1, h2, ul, ol, li, div, nav, header, footer"),
    function (el) {
      var style = window.getComputedStyle(el);
      if (style.position === "fixed") {
        /* Avoid unfixing JavaScript popus like Twitter's "confirm retweet" window */
        if (style.display === "none" || style.visibility === "hidden") return;
        if (numPixels(style.width) < toolbarWidthThreshold) return;
        
        /* Remove the position attribute completely before moving on - this is to override !important rules which
        prevents simple attributes to be applied and used */
        el.style.removeProperty('position');

        // Try to select the best replacement for 'fixed'. Still breaks lots of things, though.
        if (numPixels(style.bottom) === 0 && numPixels(style.top) > 0)
          el.style.setProperty('position', 'static', 'important');    // Use static for footers.
        else
          el.style.setProperty('position', 'absolute', 'important');
      }
    });
}

window.addEventListener("load", unfixAll);
