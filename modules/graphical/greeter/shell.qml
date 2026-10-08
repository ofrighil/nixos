pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Services.Greetd
import qs

ShellRoot {
    id: root

    readonly property string sessionCmd: Quickshell.env("QSGREET_CMD") ?? ""

    property string errorMessage: Greetd.available ? "" : "greetd is not available"
    property bool busy: false

    function login() {
        if (busy || !Greetd.available || username.text === "")
            return;
        busy = true;
        errorMessage = "";
        Greetd.createSession(username.text);
    }

    function fail(message) {
        errorMessage = message;
        password.text = "";
        busy = false;
        password.forceActiveFocus();
    }

    Connections {
        target: Greetd

        function onAuthMessage(message, error, responseRequired, echoResponse) {
            if (responseRequired)
                Greetd.respond(password.text);
            else if (error)
                root.errorMessage = message;
        }

        function onAuthFailure(message) {
            root.fail(message || "Authentication failed");
        }

        function onError(error) {
            Greetd.cancelSession();
            root.fail(error);
        }

        function onReadyToLaunch() {
            Greetd.launch(["sh", "-c", root.sessionCmd]);
        }
    }

    FloatingWindow {
        color: Assets.bg

        Column {
            anchors.centerIn: parent
            spacing: 24
            width: 320

            Field {
                id: username
                placeholder: "username"
                focus: true
                KeyNavigation.tab: password
            }

            Field {
                id: password
                placeholder: "password"
                echoMode: TextInput.Password
                KeyNavigation.tab: username
            }

            Text {
                width: parent.width
                text: root.errorMessage
                color: Assets.error
                font.family: Assets.monoFont
                wrapMode: Text.Wrap
            }
        }
    }

    component Field: TextInput {
        id: field

        property string placeholder

        width: parent.width
        color: Assets.fg
        font.family: Assets.monoFont
        font.pixelSize: 18
        enabled: !root.busy
        onAccepted: root.login()

        Rectangle {
            anchors.fill: parent
            anchors.margins: -8
            z: -1
            radius: 6
            color: Qt.lighter(Assets.bg, 1.3)
            border.width: 1
            border.color: field.activeFocus ? Assets.accent : Assets.dim
        }

        Text {
            anchors.fill: parent
            visible: field.text === ""
            text: field.placeholder
            color: Assets.dim
            font: field.font
        }
    }
}
