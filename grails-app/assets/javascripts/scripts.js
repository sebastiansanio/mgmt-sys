$(document).ready(function() {
  $('[data-toggle=offcanvas]').click(function() {
    $('.row-offcanvas').toggleClass('active');
  });
});

$(document).unbind('keydown').bind('keydown', function (event) {
    var doPrevent = false;
    if (event.keyCode === 8) {
        var d = event.srcElement || event.target;
        if ((d.tagName.toUpperCase() === 'INPUT' && 
             (
                 d.type.toUpperCase() === 'TEXT' ||
                 d.type.toUpperCase() === 'PASSWORD' || 
                 d.type.toUpperCase() === 'FILE' || 
                 d.type.toUpperCase() === 'SEARCH' || 
                 d.type.toUpperCase() === 'EMAIL' || 
                 d.type.toUpperCase() === 'NUMBER' || 
                 d.type.toUpperCase() === 'DATE' )
             ) || 
             d.tagName.toUpperCase() === 'TEXTAREA') {
            doPrevent = d.readOnly || d.disabled;
        }
        else {
            doPrevent = true;
        }
    }

    if (doPrevent) {
        event.preventDefault();
    }
});

const autoNumericOptions = {
	    digitGroupSeparator        : '.',
	    decimalCharacter           : ','
};

function thousandSep(val) {
    return String(val).replace('.',',').split("").reverse().join("")
                  .replace(/(\d{3}\B)/g, "$1.")
                  .split("").reverse().join("");
}

function safeParseFloat(inputString){
	var result = parseFloat(inputString.replace(/\./g, '').replace(/,/g,'.'));
	if(isNaN(result)){
		result = 0;
	}
	return result;
}

