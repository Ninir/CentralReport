# CentralReport - Indev version
# Project by Charles-Emmanuel CAMUS - Avril 2012

import cherrypy
from collectors.Collector import Collector
from threads.ThreadMac import ThreadMac

class WebHomePages:

    def __init__(self,lookupTemplate):
        self.lookup = lookupTemplate

    @cherrypy.expose
    def index(self):
        tmpl = self.lookup.get_template("index.tpl")

        tmpl_vars = dict()

        if Collector.host_current == Collector.host_MacOS:
            tmpl_vars['hostname'] = ThreadMac.dict_machine['hostname']

            tmpl_vars['cpu_percent'] = 100 - int(ThreadMac.last_check_cpu.idle)
            tmpl_vars['memory_percent'] = ((int(ThreadMac.last_check_memory.total) - int(ThreadMac.last_check_memory.free))*100)/int(ThreadMac.last_check_memory.total)
            tmpl_vars['loadaverage'] = ThreadMac.last_check_loadAverage.last1m

            tmpl_vars['loadaverage_percent'] = (float(ThreadMac.last_check_loadAverage.last1m)*100)/int(ThreadMac.dict_machine['ncpu'])

        return tmpl.render(**tmpl_vars)

    @cherrypy.expose
    def dashboard(self):

        if Collector.host_current == Collector.host_MacOS:
            # It's a mac

            tmpl = self.lookup.get_template("dashboard_mac.tpl")

            tmpl_vars = dict()

            # Host informations
            tmpl_vars['hostname'] = ThreadMac.dict_machine['hostname']


            # CPU informations
            last_check = ThreadMac.last_dict_cpu['date']
            tmpl_vars['kernel'] = ThreadMac.dict_machine['kernel']
            tmpl_vars['kernel_version'] = ThreadMac.dict_machine['kernel_v']
            tmpl_vars['mac_model'] = ThreadMac.dict_machine['model']
            tmpl_vars['ncpu'] = ThreadMac.dict_machine['ncpu']

            tmpl_vars['cpu_date'] = ThreadMac.last_dict_cpu['date'].strftime("%Y-%m-%d %H:%M:%S")
            tmpl_vars['cpu_model'] = ThreadMac.dict_machine['modelcpu']
            tmpl_vars['cpu_idle'] = ThreadMac.last_dict_cpu['idle']
            tmpl_vars['cpu_system'] = ThreadMac.last_dict_cpu['system']
            tmpl_vars['cpu_user'] = ThreadMac.last_dict_cpu['user']

            # Memory informations
            tmpl_vars['mem_date'] = ThreadMac.last_dict_memory['date'].strftime("%Y-%m-%d %H:%M:%S")
            tmpl_vars['mem_free'] = ThreadMac.last_dict_memory['mem_free']
            tmpl_vars['mem_active'] = ThreadMac.last_dict_memory['mem_active']
            tmpl_vars['mem_inactive'] = ThreadMac.last_dict_memory['mem_inactive']
            tmpl_vars['mem_resident'] = ThreadMac.last_dict_memory['mem_resident']
            tmpl_vars['mem_total'] = ThreadMac.last_dict_memory['mem_size']
            tmpl_vars['mem_swap'] = ThreadMac.last_dict_memory['mem_swap']

            # Load average informations
            tmpl_vars['load_date'] = ThreadMac.last_dict_loadavg['date'].strftime("%Y-%m-%d %H:%M:%S")
            tmpl_vars['load_1m'] = ThreadMac.last_dict_loadavg['load1m']
            tmpl_vars['load_5m'] = ThreadMac.last_dict_loadavg['load5m']
            tmpl_vars['load_15m'] = ThreadMac.last_dict_loadavg['load15m']

            tmpl_vars['disks'] = ThreadMac.last_list_disk
            tmpl_vars['disks_test'] = ThreadMac.last_list_disk

            return tmpl.render(**tmpl_vars)

    def error_page_404(status, message, traceback, version):
        """
        Our 404 error.
        """
        return "Oups... Error %s - Well, I'm very sorry but this page doesn't really exist!" % status
    cherrypy.config.update({'error_page.404': error_page_404})


    @cherrypy.expose
    def test(self):
        return '<h1>This is a test</h1> ... and it works!'