# -*- coding: utf-8 -*-

"""
    CentralReport - Date module
        Contains useful functions to working with dates

    https://github.com/miniche/CentralReport/
"""

import cr.log as crLog
import time


def datetimeToTimestamp(datetime):
    """
        Converts a datetime to Unix timestamp.
    """

    timestamp = 0

    try:
        # Uses the local timestamp
        timestamp = int(time.mktime(datetime.timetuple()))
    except:
        crLog.writeError('Error convert datetime to timestamp')

    return timestamp
