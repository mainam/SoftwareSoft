CKEDITOR.plugins.add('uploadfile', {
    icons: 'uploadfile',
    init: function (editor) {
        editor.addCommand('insertImage', {
            exec: function (editor) {
                var now = new Date();
                ShowSelectPicture(editor, now);
            }
        });
        editor.ui.addButton('uploadfile', {
            label: 'Insert Image',
            command: 'insertImage',
            toolbar: 'insert'
        });
    }
});