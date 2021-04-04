function fixDeviceListIcons() {
    // on update, Main page > Device icons
    var clientsTable = jQuery('table[id$=Clients_table]');
    clientsTable.on('DOMNodeInserted', function(){
        batchReplaceImageWithDiv(clientsTable.find('img[src^="/bootstrap/img/wl_device"]'), /\d/i, 'comp');
    });

    // Main page > Device icons
    batchReplaceImageWithDiv(clientsTable.find('img[src^="/bootstrap/img/wl_device"]'), /\d/i, 'comp');

    // Admimistration > Work Mode icons
    fixImageSrc('div#Senario img[src^="bootstrap/img/wl_device"]', true);
}

function fixShareDirIcons() {
    // on update, USB page > Samba/FTP dir list
    jQuery('div.FdTemp').on('DOMNodeInserted', function() {
        batchReplaceImageWithDiv('div.FdTemp img[src^="/bootstrap/img/wl_device"]', /\d/i, 'comp');
        fixImageSrc('div.FdTemp img[src^="/images/Tree/vert_line_s"]', false); // collaplse node
    });

    // USB page > Share tab icons
    batchReplaceImageWithDiv('div#shareStatus img[src^="/images/AiDisk"]', /Folder\w*/i, '_0');
    batchReplaceImageWithDiv('div#shareStatus img[src^="/images/AiDisk"]', /User\w*/i);
}

function localizeItoggle() {
    console.log('hack: attempt to fix itoggle');
    var mainToggle = jQuery('div.main_itoggle');
    mainToggle.on('DOMNodeInserted', function() {
        var itoggle = mainToggle.find('label.itoggle');
        itoggle.addClass(localize('itoggle'));
    });
}

restoreLogo('xiaomi-big');
restoreBackground();
fixDeviceListIcons();
fixShareDirIcons();
localizeItoggle();
applyHighchartsDarkTheme();
fixIPTVTablesOnDarkTheme();