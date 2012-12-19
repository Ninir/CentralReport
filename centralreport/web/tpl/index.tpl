{% extends "layout/page.layout.tpl" %}

{% block title %}CentralReport dashboard{% endblock %}

{% block header_title %}CentralReport host dashboard{% endblock %}
{% block header_subtitle %}{{ hostname }}{% endblock %}

{% block content %}

<div class="alert">
    <strong>Indev Version</strong><br />
    This is an indev version. Only for developers right now. You can meet bug everywhere, say hello to them ;-)
</div>

<div class="headhand">
    Last check : <span id="last_check_date">{{ last_check }}</span>
    <small id="ajax_enabled"></small>
</div>

<div class="row">
    <div class="span4">

        <div class="dashboard-box">

            <div class="dashboard-box-headhand">
                {% if cpu_alert is defined %}
                <div id="div_cpu_status" class="dashboard-box-status-alert"></div>
                {% elif cpu_warning is defined %}
                <div id="div_cpu_status" class="dashboard-box-status-warning"></div>
                {% elif cpu_ok is defined %}
                <div id="div_cpu_status" class="dashboard-box-status-ok"></div>
                {% else %}
                <div id="div_cpu_status" class="dashboard-box-status"></div>
                {% endif %}
                <div class="dashboard-box-title">
                    CPU (used)
                </div>
            </div>

            <div class="dashboard-box-datas" id="div_cpu_box">
                {% if cpu_percent is undefined %}
                <div class="title">
                    Not checked
                </div>
                {% else %}
                <div class="title">
                    <span id="span_cpu_percent_value">{{ cpu_percent }}</span> %
                </div>
                <div class="subtitle">
                    <span id="span_cpu_user_value">{{ cpu_user }}</span> % user - <span id="span_cpu_system_value">{{ cpu_system }}</span> % system
                </div>

                {% if cpu_alert is defined %}
                <div id="div_cpu_progress" class="progress progress-striped progress-danger">
                    {% elif cpu_warning is defined %}
                    <div id="div_cpu_progress" class="progress progress-striped progress-warning">
                        {% elif cpu_ok is defined %}
                        <div id="div_cpu_progress" class="progress progress-striped progress-success">
                        {% else %}
                        <div id="div_cpu_progress" class="progress progress-striped">
                            {% endif %}

                            <div id="bar_cpu_percent" class="bar" style="width:{{ cpu_percent }}%;"></div>
                        </div>

                        {% endif %}
                    </div>

                </div>
            </div>

    <div class="span4">
        <div class="dashboard-box">
            <div class="dashboard-box-headhand">

                {% if memory_alert is defined %}
                <div id="div_memory_status" class="dashboard-box-status-alert"></div>
                {% elif memory_warning is defined %}
                <div id="div_memory_status" class="dashboard-box-status-warning"></div>
                {% elif memory_ok is defined %}
                <div id="div_memory_status" class="dashboard-box-status-ok"></div>
                {% else %}
                <div id="div_memory_status" class="dashboard-box-status"></div>
                {% endif %}

                <div class="dashboard-box-title">
                    Memory (used)
                </div>
            </div>
            <div class="dashboard-box-datas" id="div_memory_box">
                {% if memory_percent is undefined %}
                <div class="title">
                    Not checked
                </div>
                {% else %}
                <div class="title">
                    <span id="span_memory_percent_value">{{ memory_percent }}</span> %
                </div>
                <div class="subtitle">
                     <span id="span_memory_used_value">{{ memory_used }}</span> used and <span id="span_memory_free_value">{{ memory_free }}</span> free
                </div>

                {% if memory_alert is defined %}
                <div id="div_memory_progress" class="progress progress-striped progress-danger">
                    {% elif memory_warning is defined %}
                    <div id="div_memory_progress" class="progress progress-striped progress-warning">
                        {% elif memory_ok is defined %}
                        <div id="div_memory_progress" class="progress progress-striped progress-success">
                            {% else %}
                            <div id="div_memory_progress" class="progress progress-striped">
                            {% endif %}

                            <div id="bar_memory_percent" class="bar" style="width:{{ memory_percent }}%;"></div>
                        </div>
                        {% endif %}
                    </div>
                </div>
            </div>

    <div class="span4">
        <div class="dashboard-box">
            <div class="dashboard-box-headhand">
                {% if swap_alert is defined %}
                <div class="dashboard-box-status-alert"></div>
                {% elif swap_warning is defined %}
                <div class="dashboard-box-status-warning"></div>
                {% elif swap_ok is defined %}
                <div class="dashboard-box-status-ok"></div>
                {% else %}
                <div class="dashboard-box-status"></div>
                {% endif %}
                <div class="dashboard-box-title">
                    Swap
                </div>
            </div>
            <div class="dashboard-box-datas" id="div_swap_box">
                {% if swap_percent is undefined %}
                <div class="title">
                    Not checked
                </div>
                {% else %}
                <div class="title">
                    <span id="span_swap_used_value">{{ swap_used }}</span>
                </div>
                <div class="subtitle">
                    <span id="span_swap_percent_value">{{ swap_percent }}</span> % of physical memory
                </div>
                {% endif %}

            </div>
        </div>
    </div>

</div>

<div class="row">
    <div class="span4">
        <div class="dashboard-box">
            <div class="dashboard-box-headhand">
                {% if load_alert is defined %}
                <div id="div_load_status" class="dashboard-box-status-alert"></div>
                {% elif load_warning is defined %}
                <div id="div_load_status" class="dashboard-box-status-warning"></div>
                {% elif load_ok is defined %}
                <div id="div_load_status" class="dashboard-box-status-ok"></div>
                {% else %}
                <div id="div_load_status" class="dashboard-box-status"></div>
                {% endif %}
                <div class="dashboard-box-title">
                    Load Average
                </div>
            </div>
            <div class="dashboard-box-datas" id="div_load_box">
                {% if loadaverage is undefined %}
                <div class="title">
                    Not checked
                </div>
                {% else %}
                <div class="title">
                    <span id="span_load_value">{{ loadaverage }}</span>
                </div>
                <div class="subtitle">
                    <span id="span_load_percent_value">{{ loadaverage_percent }}</span> % of {{ cpu_count }} cores
                </div>

                {% if load_alert is defined %}
                    <div id="div_load_progress" class="progress progress-striped progress-danger">
                {% elif load_warning is defined %}
                    <div id="div_load_progress" class="progress progress-striped progress-warning">
                {% elif load_ok is defined %}
                    <div id="div_load_progress" class="progress progress-striped progress-success">
                {% else %}
                    <div id="div_load_progress" class="progress progress-striped">
                {% endif %}

                        <div id="bar_load_percent" class="bar" style="width:{{ loadaverage_percent }}%;"></div>
                    </div>
                {% endif %}
                </div>
            </div>
        </div>

    <div class="span8">
        <div class="dashboard-box">
            <div class="dashboard-box-headhand">
                <div class="dashboard-box-status-ok">

                </div>
                <div class="dashboard-box-title">
                    Uptime
                </div>
            </div>
            <div class="dashboard-box-text" id="div_uptime_box">
                {% if loadaverage is undefined %}
                <div class="title">
                    Not checked
                </div>
                {% else %}
                <div class="title">
                    <span id="span_uptime_full_text">{{ uptime }}</span> <small>(<span id="span_uptime_seconds_value">{{ uptime_seconds }}</span> seconds)</small>
                </div>
                <div class="subtitle">
                    Boot date : <span id="span_uptime_start_date_value">{{ start_date }}</span>
                </div>
                {% endif %}
            </div>
        </div>
    </div>

</div>

<div class="row">
    <div class="span12">
        <div id="div_disks_box" class="dashboard-box">
            <div class="dashboard-box-headhand">
                <div class="dashboard-box-status-ok">

                </div>
                <div class="dashboard-box-title">
                    Disks
                </div>
            </div>
            <div class="dashboard-box-text">
                {% if disks is undefined %}
                <div class="title">
                    Not checked
                </div>
                {% else %}
                <table class="table table-striped">
                    <tbody>
                    {% for disk in disks %}
                    <tr>
                        <td width="33%"><strong>{{ disk.name }}</strong></td>
                        <td width="33%">{{ disk.free }} free / {{ disk.total }} total ({{ disk.percent }} % used)</td>
                        <td width="33%">
                            <div class="progress progress-striped progress-success">
                                <div class="bar" style="width:{{ disk.percent }}%;"></div>
                            </div>
                        </td>
                    </tr>
                    {% endfor %}
                    </tbody>
                </table>
                {% endif %}
            </div>
        </div>
    </div>

</div>

<div class="headhand headhand-center">
    <a href="dashboard">Go to old full report</a>
</div>



{% endblock %}

{% block bottom_javascript %}
    <script type="text/javascript" src="js/cr.ajax.js"></script>
{% endblock %}

{% block footer_version %}CentralReport Unix/Linux {{ CR_version }} - {{ CR_version_name }}{% endblock %}
