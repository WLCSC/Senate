function attachCollapsible(collapsible)
        {
            var div = $(collapsible);
            var heading = div.select('h2')[0];
            var contents = div.select('div')[0];

            // initially hide it
            div.addClassName('closed');
            contents.hide();

            // add an anchor at run time,
            // that way non-js users won't see anchor, but js users will
            // still be able to use their keyboard for it.
            heading.innerHTML =
                    '<a href="#">' + heading.innerHTML + '</a>';
            heading.firstDescendant().onclick =
                    collapsibleOnClick(div, heading, contents);
        }
		
function collapsibleOnClick(div, heading, contents)
{
    return function() {
        // clear the height; gets messy otherwise if
        // a blind is already in progress
        // not perfect, but simple and huffy enough,
        // and doesn't seem to be able to get into a bad state
        contents.style.height = '';

        // do we need to go up or down?
        if (div.hasClassName('closed')) {
            new Effect.BlindDown(contents,{duration:0.3, fps:100});
            Element.removeClassName(div,'closed');
        } else {
            new Effect.BlindUp(contents,{duration:0.3, fps:100});
            Element.addClassName(div,'closed');
        }

        // event has been dealt with.
        return false;
    };
}