/*
 * SPDX-License-Identifier: GPL-3.0-only
 * MuseScore-CLA-applies
 *
 * MuseScore
 * Music Composition & Notation
 *
 * Copyright (C) 2021 MuseScore BVBA and others
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
#ifndef MU_IPC_IPCCHANNEL_H
#define MU_IPC_IPCCHANNEL_H

#include <QString>
#include <QList>

#include "ipc.h"

#include "async/asyncable.h"
#include "async/channel.h"
#include "async/notification.h"

namespace mu::ipc {
//! NOTE Inter-Process Communication Channel
class IpcSocket;
class IpcServer;
class IpcChannel : public async::Asyncable
{
public:
    IpcChannel();
    ~IpcChannel();

    const ID& selfID() const;

    void connect();

    bool send(const Msg& msg);
    async::Channel<Msg> msgReceived() const;

    QList<Meta> instances() const;
    async::Notification instancesChanged() const;

private:

    void setupConnection();
    void onDisconected();

    IpcSocket* m_selfSocket = nullptr;
    IpcServer* m_server = nullptr;
};
}

#endif // MU_IPC_IPCCHANNEL_H
