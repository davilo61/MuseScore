/*
 * SPDX-License-Identifier: GPL-3.0-only
 * MuseScore-Studio-CLA-applies
 *
 * MuseScore Studio
 * Music Composition & Notation
 *
 * Copyright (C) 2025 MuseScore Limited
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 3 as
 * published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */
import QtQuick 2.15

import Muse.Ui 1.0
import Muse.UiComponents 1.0

import "../../internal"

BaseSection {
    id: root

    property alias playNotesWhenEditing: playNotesToggle.checked
    property alias playPreviewNotesInInputByDuration: playPreviewNotesInInputByDurationBox.checked
    property alias playChordWhenEditing: playChordBox.checked
    property alias playChordSymbolWhenEditing: playChordSymbolBox.checked
    property alias notePlayDurationMilliseconds: notePlayDurationControl.currentValue

    signal playNotesWhenEditingChangeRequested(bool play)
    signal playPreviewNotesInInputByDurationChangeRequested(bool play)
    signal playChordWhenEditingChangeRequested(bool play)
    signal playChordSymbolWhenEditingChangeRequested(bool play)
    signal notePlayDurationChangeRequested(int duration)

    title: qsTrc("appshell/preferences", "Note preview")

    Row {
        width: parent.width
        height: playNotesToggle.height

        spacing: 6

        ToggleButton {
            id: playNotesToggle

            navigation.name: "PlayNotesToggle"
            navigation.panel: root.navigation
            navigation.row: 0

            onToggled: {
                root.playNotesWhenEditingChangeRequested(!checked)
            }
        }

        StyledTextLabel {
            height: parent.height

            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter

            text: qsTrc("appshell/preferences", "Hear playback when adding, editing, and selecting notes")
        }
    }

    CheckBox {
        id: playPreviewNotesInInputByDurationBox
        width: parent.width

        text: qsTrc("appshell/preferences", "Include preview notes in playback (input by duration only)")

        enabled: root.playNotesWhenEditing

        navigation.name: "PlayPreviewNotesInInputByDurationBox"
        navigation.panel: root.navigation
        navigation.row: 1

        onClicked: {
            root.playPreviewNotesInInputByDurationChangeRequested(!checked)
        }
    }

    IncrementalPropertyControlWithTitle {
        id: notePlayDurationControl

        title: qsTrc("appshell/preferences", "Playback duration:")

        enabled: root.playNotesWhenEditing

        columnWidth: root.columnWidth
        spacing: root.columnSpacing

        //: Abbreviation of "milliseconds"
        measureUnitsSymbol: qsTrc("global", "ms")

        navigation.name: "NotePlayDurationControl"
        navigation.panel: root.navigation
        navigation.row: 2

        onValueEdited: function(newValue) {
            root.notePlayDurationChangeRequested(newValue)
        }
    }

    CheckBox {
        id: playChordBox
        width: parent.width

        text: qsTrc("appshell/preferences", "Play chord when editing")

        enabled: root.playNotesWhenEditing

        navigation.name: "PlayChordBox"
        navigation.panel: root.navigation
        navigation.row: 3

        onClicked: {
            root.playChordWhenEditingChangeRequested(!checked)
        }
    }

    CheckBox {
        id: playChordSymbolBox
        width: parent.width

        text: qsTrc("appshell/preferences", "Play chord symbols and Nashville numbers")

        enabled: root.playNotesWhenEditing

        navigation.name: "PlayChordSymbolBox"
        navigation.panel: root.navigation
        navigation.row: 4

        onClicked: {
            root.playChordSymbolWhenEditingChangeRequested(!checked)
        }
    }
}
