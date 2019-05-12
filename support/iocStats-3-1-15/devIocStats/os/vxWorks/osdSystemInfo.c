/*************************************************************************\
* Copyright (c) 2009 Helmholtz-Zentrum Berlin fuer Materialien und Energie.
* Copyright (c) 2002 The University of Chicago, as Operator of Argonne
*     National Laboratory.
* Copyright (c) 2002 The Regents of the University of California, as
*     Operator of Los Alamos National Laboratory.
* EPICS BASE Versions 3.13.7
* and higher are distributed subject to a Software License Agreement found
* in file LICENSE that is included with this distribution.
\*************************************************************************/

/* osdSystemInfo.c - System info strings: vxWorks implementation */

/*
 *  Author: Ralph Lange (HZB/BESSY)
 *
 *  Modification History
 *  2009-05-20 Ralph Lange (HZB/BESSY)
 *     Restructured OSD parts
 *
 */

#include <devIocStats.h>

int devIocStatsInitSystemInfo (void) { return 0; }

int devIocStatsGetBSPVersion (char **pval)
{
    *pval = sysBspRev();
    return 0;
}

int devIocStatsGetKernelVersion (char **pval)
{
    *pval = kernelVersion();
    return 0;
}
