function getIMessengerStatus(username) {
    var iMessengerStatusText;
    try {
        username = username + '@samsung.com';
        var comm = new ActiveXObject("Communicator.UIAutomation");
        var iMessenger = comm.GetContact(username, comm.MyServiceId);
        var iMessengerStatus = iMessenger.status;
        if (iMessengerStatus == 0)
            iMessengerStatusText = 'unknown';
        else if (iMessengerStatus == 1)
            iMessengerStatusText = 'offline';
        else if (iMessengerStatus == 2)
            iMessengerStatusText = 'available';
        else if (iMessengerStatus == 10)
            iMessengerStatusText = 'busy';
        else if (iMessengerStatus == 14)
            iMessengerStatusText = 'away';
        else if (iMessengerStatus == 34)
            iMessengerStatusText = 'away';
        else if (iMessengerStatus == 18)
            iMessengerStatusText = 'inactive';
        else iMessengerStatusText = 'unknown';
        return iMessengerStatusText;
    } catch (e) {
        // fails in case of FF/Netscape
        iMessengerStatusText = 'error';
    }
    return iMessengerStatusText;


}
function set_statuses() {
    var listimg = $(".statusMySingle");
    listimg.each(function (idx, img) {
        //var elid = link.attr('id');
        username = img['alt']
        var status = getIMessengerStatus(username);
        if (status != 'error') {
            src = img["src"].replace("unknown", status);
            img["src"] = src;
            img["title"] = status;
        }
    });
}