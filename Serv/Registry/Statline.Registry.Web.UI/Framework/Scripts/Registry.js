function moveToTopOfPage(ctrlid) {
    if (document.getElementById(ctrlid)) {
        document.getElementById(ctrlid).focus();
    }
}

function disableControlById(ctrlid) {
    if (document.getElementById(ctrlid)) {
        document.getElementById(ctrlid).disabled=true;
    }
     
}

function registerDisableControl_OnClickEvent(ctrlid, additionaljs) {
    if (document.getElementById(ctrlid)) {
        document.getElementById(ctrlid).onclick = function (ctrlid, additionaljs) { disableControlById(ctrlid); additionaljs; };
    }
    
}

function initSignaturePageMoveToTopOfPage() {
    window.onload = function () { moveToTopOfPage('pageTop'); }
}