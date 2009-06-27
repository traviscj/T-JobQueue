Travis Johnson's Job Queue
==========================
Author: Travis C Johnson, University of Washington
Funded by NSF VIGRE

This software should enable you to utilize many computers to run many small
jobs, much like @HOME. 

Job Queue
=========
1. Setup
2. TODO


== Setup ==
===========
Server-Side Setup
-----------------
. Install a LAMP stack, complete with MySQL on Apache, along with PHP and Python
. Create database with default.sql (cat default.sql | mysql ...)
. Install post_job.php and queue.py to your website

Client-Side Setup
-----------------
. Distribute runJob.py to each machine and change hostnames appropriately.(ie, 'urllib.urlopen' and 'posturl'
. Ensure that python can load and execute httplib2

Job Setup
---------
. Insert more jobs into the queue table, and whatever codes they require into the 'codes' table
. Ensure that each client node has the necesary compilers, etc
. Start running runJob on all nodes you want to process

TODO:
   Rewrite queue.py in PHP to lower system requirements, or to not connect per request.
   Web interface for job specification
   rewrite runJob to require only httplib2
   update runJob to not require wget(OSX compatibility perk)
   system- and user-wide setup of runJob.py: /etc/runjob.conf ~/.runjob
   more modular write-out support on host-end(ie, a 'module' column that specifies what to do with what posted: insert into db, out to file, etc)
   installer script
   
