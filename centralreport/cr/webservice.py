# -*- coding: utf-8 -*-

# CentralReport - Indev version
# Project by Charles-Emmanuel CAMUS - Avril 2012

#
# Warning: Not used. Only for testing purposes.
#

import urllib
import urllib2

import cr.log as crLog


class Speaker:

    """
        PS: This class is not used for the moment.
        It has been created for testing purpose only.
    """

    WEBSERVICE_URL_TEST = 'http://127.0.0.1/mypage.php'

    @staticmethod
    def sendStats(data):
        url = 'http://%s/CentralReport/%s'

        # DEBUG
        crLog.writeDebug('Webservice URL:' + str(Speaker.WEBSERVICE_URL_TEST))

        try:
            data = urllib.urlencode(data)
            req = urllib2.Request(url, data)
            response = urllib2.urlopen(req)
            result_page = response.read()

            return result_page

        except Exception as inst:
            crLog.writeError('Error when connecting to the server: ' + str(inst.message))
