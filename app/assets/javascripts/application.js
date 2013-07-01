// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

function onBlur(el) {
    if (el.value == '') {
        el.value = el.defaultValue;
    }
}
function onFocus(el) {
    if (el.value == el.defaultValue) {
        el.value = '';
    }
}


$(document).ready(function(){
    var mouse_in_side = false;

    $('#resss').hover(function(){
        mouse_in_side=true;
    }, function(){
        mouse_in_side=false;
    });

    $(document).click(function(){
        if(mouse_in_side == false){
            $("#ajaxcity").hide();
        }
    });
});


$(document).ready(function(){
    var mouse_in_side = false;

    $('#searchContainer').hover(function(){
        mouse_in_side=true;
    }, function(){
        mouse_in_side=false;
    });

    $(document).click(function(){
        if(mouse_in_side == false){
            $("#ajaxresults").hide();
        }
    });
});

