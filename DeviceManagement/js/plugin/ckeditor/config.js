/**
 * @license Copyright (c) 2003-2013, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.html or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function (config) {
    // Define changes to default configuration here. For example:
    // config.language = 'fr';
    // config.uiColor = '#AADC6E';

    // Referencing the new plugin
    config.extraPlugins = 'uploadfile,wordcount,popup,quicktable';

    //// Define the toolbar buttons you want to have available
    //config.toolbar = 'MyToolbar';
    //config.toolbar_MyToolbar =
    //   [
    //      ['uploadfile', 'Preview'],
    //      ['Cut', 'Copy', 'Paste', 'PasteText', 'PasteFromWord', '-', 'Scayt'],
    //      ['Undo', 'Redo', '-', 'Find', 'Replace', '-', 'SelectAll', 'RemoveFormat']
    //   ];
    config.wordcount = {

        // Whether or not you want to show the Word Count
        showWordCount: true,

        // Whether or not you want to show the Char Count
        showCharCount: true,

        // Whether or not to include Html chars in the Char Count
        countHTML: false
    };
    config.language = 'en-gb';
};
