<!---
This file is part of keyStream.

keyStream is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

keyStream is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with keyStream.  If not, see <http://www.gnu.org/licenses/>.
--->

keyStream
=========

keyStream is an open source media server under the GNU GPL license. keyStream allows you to share your favorite videos with any computer and device on your network.

Features
=========

- Admin interface that allows you to manage categories, genres, videos, and default rating.
- Able to set a default rating that limits standard users access to ratings above the default. To view all videos no matter the rating you can login as an admin.
- Compatiable with all computers, PCs, tabets, and mobile devices that support HTML5.
- Custom categories and genres under the categories.
- Easily upload large video files by copying to uploads folder.

Installation
=========

Install Railo to your home network and upload this application to the web directory. Point your browser to the applications index and it will install the data and upload folder.

Default Login:

Username: admin
Password: Password

Uploading
=========

There are two options to upload your videos. 

For large files (Over 200 MB) you simply place your video into the uploads folder. You will then need to login to the admin dashboard where it will prompt you to upload the files. Once uploaded you can see them in your video area.

For smaller uploads you can use the Quick Uploader in the admin dashboard.

Commercial Users
=========

This application is meant for home networks, the open source keyStream is does not have the best security for commercial use. I am working on a closed source solution specifically for commerical users. If you do decide to apply this to a commercial network, please use caution.

To do
=========

keyStream is now under very early release. There are still things that need to be completed.

- Default image when there is none uploaded.
- Restrict file types to videos with upload folder uploader.
- Enhance UX.
- Add version info xml.
- Add error handling to library and admin video list.
- Add error handling to video delete.
