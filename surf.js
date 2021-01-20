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
aceVimMap('jk', '<Esc>', 'insert');


settings.hintAlign = "left";
settings.enableAutoFocus = false;
Hints.characters = 'asdfgqwercv';
imap('jk', "<Esc>");

mapkey('<Space>gi', '#1get image link and google image search', function () {
    Hints.create("img, button", function (element) {
        Clipboard.write(element.src);
        searchSelectedWith('http://images.google.com/searchbyimage?image_url=', false, false, '');
    });
});

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

addSearchAliasX('t', 'translate', 'https://translate.google.com/#view=home&op=translate&sl=auto&tl=ru&text=');

addSearchAliasX('l', 'feeling lucky', 'https://google.com/search?btnI&q=');

mapkey('ol', '#8Open Search with alias l', function() {
    Front.openOmnibar({type: "SearchEngine", extra: "l"});
});

addSearchAliasX('w', 'thesaurus', 'https://thesaurus.com/browse/');

Hints.style('border: solid 1px #5f4b96; color: #000000; background: initial; background-color: #a3ffde; font-size: 12px; font-family: -apple-system,BlinkMacSystemFont,Segoe UI,Helvetica,Arial,sans-serif,Apple Color Emoji,Segoe UI Emoji;');

// from: https://github.com/brookhong/Surfingkeys/wiki/Color-Themes
settings.theme = `
.sk_theme {
	background: #100a14dd;
	color: #4f97d7;
}
.sk_theme tbody {
	color: #292d;
}
.sk_theme input {
	color: #d9dce0;
}
.sk_theme .url {
	color: #2d9574;
}
.sk_theme .annotation {
	color: #a31db1;
}
.sk_theme .omnibar_highlight {
	color: #333;
	background: #ffff00aa;
}
.sk_theme #sk_omnibarSearchResult ul>li:nth-child(odd) {
	background: #5d4d7a55;
}
.sk_theme #sk_omnibarSearchResult ul>li.focused {
	background: #5d4d7aaa;
}
.sk_theme #sk_omnibarSearchResult .omnibar_folder {
	color: #a31db1;
}
`;
