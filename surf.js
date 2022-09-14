const {
    aceVimMap,
    mapkey,
    imap,
    imapkey,
    getClickableElements,
    vmapkey,
    map,
    unmap,
    vunmap,
    cmap,
    addSearchAlias,
    removeSearchAlias,
    tabOpenLink,
    readText,
    Clipboard,
    Front,
    Hints,
    Visual,
    RUNTIME
} = api;

map("K", "R");
map("J", "E");
map("H", "S");
map(">_t", "t");
map("t", "on");
map("sd", "se");
map("oo", ">_t");
map("``", "<Ctrl-6>");
map("L", "D");
map("<Alt-f>", "cf");
map("yf", "ya");
unmap("P");
map("P", "cc");
map('F', 'gf');
map('t', 'T');
//aceVimMap('jk', '<Esc>', 'insert');

map(":el", window.location.replace('https://www.google.com/maps/@50.0905824,14.4500945,14.5z'))


settings.hintAlign = "left";
settings.enableAutoFocus = false;
settings.modeAfterYank = 'Normal';
settings.blocklistPattern = /.*notion.so.*/i;
Hints.setCharacters('asdfgyuiopqwertnmzxcvb');
imap('jk', "<Esc>");

mapkey('<Space>gi', '#1get image link and google image search', function () {
    Hints.create("img, button", function (element) {
        Clipboard.write(element.src);
        searchSelectedWith('http://images.google.com/searchbyimage?image_url=', false, false, '');
    });
}, {domain: /^(?:(?!youtube).*)\.com/i});

// Google
mapkey('<Space>1', '#1get first google result', function () {
    document.querySelectorAll('.r')[0].children[0].click();
}, {domain: /google\.com/});
mapkey('<Space>2', '#1get first google result', function () {
    document.querySelectorAll('.r')[1].children[0].click();
}, {domain: /google\.com/});
mapkey('<Space>3', '#1get first google result', function () {
    document.querySelectorAll('.r')[2].children[0].click();
}, {domain: /google\.com/});
mapkey('<Space>4', '#1get first google result', function () {
    document.querySelectorAll('.r')[3].children[0].click();
}, {domain: /google\.com/});

// DuckDuckGo to Google
mapkey('<Space>g', '#get google result', function () {
    query = document.querySelector('#search_form_input').value
    window.location.replace('https://google.com/search?q=' + query)
}, {domain: /duckduckgo\.com/});

// Amazon to Goodreads
mapkey('<Space>g', '#get goodreads result', function () {
    query = document.querySelector('#productTitle').textContent
    window.location.replace('https://goodreads.com/search?q=' + query)
}, {domain: /amazon\.com/});

addSearchAlias('t', 'translate', 'https://translate.google.com/#view=home&op=translate&sl=auto&tl=ru&text=');

addSearchAlias('r', 'reddit', 'https://www.reddit.com/search?include_over_18=on&sort=relevance&t=all&q=');

mapkey('ot', '#8Open Search with alias t', function() {
    Front.openOmnibar({type: "SearchEngine", extra: "t"});
});

//addSearchAliasX('i', 'IDOS', 'https://idos.idnes.cz/pid/spojeni/vysledky/?f=' + address + '&t=')

addSearchAlias('l', 'feeling lucky', 'https://google.com/search?btnI&q=');

mapkey('ol', '#8Open Search with alias l', function() {
    Front.openOmnibar({type: "SearchEngine", extra: "l"});
});

addSearchAlias('w', 'thesaurus', 'https://thesaurus.com/browse/');

Hints.style('border: solid 1px #5f4b96; color: #000000; background: initial; background-color: #a3ffde; font-size: 12px; font-family: -apple-system,BlinkMacSystemFont,Segoe UI,Helvetica,Arial,sans-serif,Apple Color Emoji,Segoe UI Emoji;');

// from: https://github.com/brookhong/Surfingkeys/wiki/Color-Themes
// Tomorrow-Night
//Hints.style('border: solid 2px #373B41; color:#52C196; background: initial; background-color: #1D1F21;');
//Hints.style("border: solid 2px #373B41 !important; padding: 1px !important; color: #C5C8C6 !important; background: #1D1F21 !important;", "text");
Visual.style('marks', 'background-color: #52C19699;');
Visual.style('cursor', 'background-color: #81A2BE;');

// Nord
/* -- DELETE LINE TO ENABLE THEME
Hints.style('border: solid 2px #4C566A; color:#A3BE8C; background: initial; background-color: #3B4252;');
Hints.style("border: solid 2px #4C566A !important; padding: 1px !important; color: #E5E9F0 !important; background: #3B4252 !important;", "text");
Visual.style('marks', 'background-color: #A3BE8C99;');
Visual.style('cursor', 'background-color: #88C0D0;');
-- DELETE LINE TO ENABLE THEME */

// Doom One
/* -- DELETE LINE TO ENABLE THEME
Hints.style('border: solid 2px #282C34; color:#98be65; background: initial; background-color: #2E3440;');
Hints.style("border: solid 2px #282C34 !important; padding: 1px !important; color: #51AFEF !important; background: #2E3440 !important;", "text");
Visual.style('marks', 'background-color: #98be6599;');
Visual.style('cursor', 'background-color: #51AFEF;');
-- DELETE LINE TO ENABLE THEME */

// Monokai
/* -- DELETE LINE TO ENABLE THEME
Hints.style('border: solid 2px #2D2E2E; color:#F92660; background: initial; background-color: #272822;');
Hints.style("border: solid 2px #2D2E2E !important; padding: 1px !important; color: #A6E22E !important; background: #272822 !important;", "text");
Visual.style('marks', 'background-color: #A6E22E99;');
Visual.style('cursor', 'background-color: #F92660;');
-- DELETE LINE TO ENABLE THEME */


