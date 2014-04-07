/*  This file is part of the KDE project
    Copyright (C) 2007 Matthias Kretz <kretz@kde.org>

    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Library General Public
    License version 2 as published by the Free Software Foundation.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Library General Public License for more details.

    You should have received a copy of the GNU Library General Public License
    along with this library; see the file COPYING.LIB.  If not, write to
    the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
    Boston, MA 02110-1301, USA.

*/

#ifndef PHONON_KIOMEDIASTREAM_H
#define PHONON_KIOMEDIASTREAM_H

#include <Phonon/AbstractMediaStream>
#include <KIO/Job>

class QUrl;

namespace Phonon
{

class KioMediaStreamPrivate;

class KioMediaStream : public AbstractMediaStream
{
    Q_OBJECT
    Q_DECLARE_PRIVATE(KioMediaStream)
    public:
        explicit KioMediaStream(const QUrl &url, QObject *parent = 0);
        ~KioMediaStream();

    protected:
        void reset();
        void needData();
        void enoughData();
        void seekStream(qint64);

        KioMediaStreamPrivate *d_ptr;

    private:
        Q_PRIVATE_SLOT(d_func(), void _k_bytestreamData(KIO::Job *, const QByteArray &))
        Q_PRIVATE_SLOT(d_func(), void _k_bytestreamResult(KJob *))
        Q_PRIVATE_SLOT(d_func(), void _k_bytestreamTotalSize(KJob *, qulonglong))
        Q_PRIVATE_SLOT(d_func(), void _k_bytestreamFileJobOpen(KIO::Job *))
        Q_PRIVATE_SLOT(d_func(), void _k_bytestreamSeekDone(KIO::Job *, KIO::filesize_t))
        Q_PRIVATE_SLOT(d_func(), void _k_read())
};

} // namespace Phonon
#endif // PHONON_KIOMEDIASTREAM_H
